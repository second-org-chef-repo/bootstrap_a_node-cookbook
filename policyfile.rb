# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile/

# A name that describes what the system you're building with Chef does.
name 'bootstrap_a_node'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'bootstrap_a_node::default'

# Specify a custom source for a single cookbook:
cookbook 'bootstrap_a_node', path: '.'
cookbook 'slack_handler', '~> 1.0.0', :supermarket
cookbook 'chef_client_updater', '~> 3.11.1', :supermarket
cookbook 'chef-client', '~> 12.3.3', :supermarket
