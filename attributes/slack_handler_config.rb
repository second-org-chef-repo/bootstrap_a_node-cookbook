###
# These attributes are to be adjusted in the policy group accordingly.
###

# Add `webhook1` URL
default['chef_client']['handler']['slack']['webhooks']['name'].push('webhook1')
default['chef_client']['handler']['slack']['webhooks']['webhook1']['url'] = ''
default['chef_client']['handler']['slack']['enabled'] = true

## Customizations for Slack WebHook config
## See https://api.slack.com/incoming-webhooks#customizations_for_custom_integrations

# The username of the Slack message, defaults to Slack WebHook config (i.e. nil)
default['chef_client']['handler']['slack']['username'] = 'The very first CCR just executed.Check the results on Automate'
# Icon URL, defaults to Slack WebHook config (i.e. nil)
default['chef_client']['handler']['slack']['icon_url'] = 'https://avatars1.githubusercontent.com/u/29740'
# Emoji for the Slack call, defaults to Slack WebHook config (i.e. nil)
default['chef_client']['handler']['slack']['icon_emoji'] = ':fork_and_knife:'

# Only report when runs fail as opposed to every single occurrence, defaults to false
default['chef_client']['handler']['slack']['fail_only'] = false
# Send a message when the run starts, defaults to false
default['chef_client']['handler']['slack']['send_start_message'] = true
# The level of detail in the message. Valid options are 'basic', 'elapsed' and 'resources', defaults to 'basic'
default['chef_client']['handler']['slack']['message_detail_level'] = 'basic'
# The level of detail about the cookbook used in the message. Valid options are 'off' and 'all', defaults to 'off'
default['chef_client']['handler']['slack']['cookbook_detail_level'] = 'off'

# Send the organization from /etc/chef/client.rb, defaults to false
default['chef_client']['handler']['slack']['send_organization'] = true
