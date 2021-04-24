#
# Cookbook:: bootstrap_a_node
# Recipe:: client_setup.rb
#
# Copyright:: 2021, The Authors, All Rights Reserved.

###########
# Setup client.rb with Chef Server access credentials
###########

chef_client_config 'client.rb' do
  chef_server_url "https://#{node['bootstrap_a_node']['chef_server']['fqdn']}/organizations/#{node['bootstrap_a_node']['org_name']}"
  chef_license 'accept'
  log_location 'STDOUT'
  additional_config "environment \"#{node['bootstrap_a_node']['environment']}\"\nvalidation_key \"/etc/chef/#{node['bootstrap_a_node']['org_validation_key_file']}\"\ntrusted_certs_dir \"/etc/chef/trusted_certs\""
end

directory '/etc/chef/trusted_certs' do
  mode '755'
end

cookbook_file 'Place SSL certificate to /etc/chef/trusted_certs' do
  source "automate.cl.crt"
  mode '644'
  owner 'root'
  path "/etc/chef/trusted_certs/automate.cl.crt"
end

###########
# Create client.pem and delete org-validator after first CCR
###########

cookbook_file "Place validator key for Org:#{node['bootstrap_a_node']['org_name']}" do
  not_if { ::File.exist?('/etc/chef/client.pem') }
  source "#{node['bootstrap_a_node']['org_validation_key_file']}" # Watch out for the file name
  mode '0755'
  owner 'root'
  path "/etc/chef/#{node['bootstrap_a_node']['org_validation_key_file']}" # Watch out for the file name
  sensitive
end

file 'Delete org validator key' do
  only_if { ::File.exist?('/etc/chef/client.pem') }
  path "/etc/chef/#{node['bootstrap_a_node']['org_validation_key_file']}"
  action :delete
end

###########
# Control chef-client version with `chef_client_updater` cookbook 'https://github.com/chef-cookbooks/chef_client_updater'
###########

chef_client_updater "up or down grade Chef Infra version to #{node['bootstrap_a_node']['chef_client']['version']}" do
  version "#{node['bootstrap_a_node']['chef_client']['version']}"
end

###########
# Run the initial Chef Client check-in to generate `client.pem`. If `client.pem` already exists, no CCR wil be executed.
# `--why-run` is used as the initial CCR is just for `client.pem` generation. This way `chef-run` finishes a lot faster.
###########

ruby_block 'Run chef-client' do
  not_if { ::File.exist?('/etc/chef/client.pem') }
  block do
    system '/usr/bin/chef-client --why-run'
  end
end

ruby_block 'Checking if initial CCR succesfully completed...' do
  notifies :run, 'ruby_block[Run chef-client]', :before
  not_if { ::File.exist?('/etc/chef/client.pem') }
  block do
    raise "\n [WARN] No client.pem found and no trace of check-in. You might want to login the node and run chef-client manually and check its status. Possibly chef-client failed to check-in Chef Server for some reason."
  end
end
