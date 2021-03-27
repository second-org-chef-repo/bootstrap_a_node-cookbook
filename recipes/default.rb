#
# Cookbook:: bootstrap_a_node
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

# THe very first CCR Failure before Automate will be notified on Slack. See https://supermarket.chef.io/cookbooks/slack_handler for detail.
include_recipe 'slack_handler::default' if node['chef_client']['handler']['slack']['enabled']
include_recipe 'bootstrap_a_node::timezone_setup'
include_recipe 'chef-client::default'
include_recipe 'bootstrap_a_node::client_setup'
