#
# Cookbook:: bootstrap_a_node
# Recipe:: timezone_setup.rb
#
# Copyright:: 2021, The Authors, All Rights Reserved.

case node['platform']
when 'ubuntu' || 'debian'
  apt_update do
    not_if { ::File.exist?('/etc/chrony.conf') }
  end
when 'centos' || 'redhat'
  execute 'yum -y update' do
    not_if { ::File.exist?('/etc/chrony.conf') }
  end
end

timezone "Set TZ to #{node['bootstrap_a_node']['timezone']}" do
  timezone "#{node['bootstrap_a_node']['timezone']}"
end

package 'chrony'

service 'chronyd' do
  action :start
end
service 'chronyd' do
  action :enable
end
