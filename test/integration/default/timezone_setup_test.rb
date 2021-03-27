# InSpec test for recipe bootstrap_a_node::timezone_setup.rb

# The InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

describe service('chronyd') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe bash('timedatectl status | grep Tokyo') do
  its('stdout') { should include 'Time zone: Asia/Tokyo' }
  its('stderr') { should eq '' }
  its('exit_status') { should eq 0 }
end
