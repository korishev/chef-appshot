#
# Cookbook Name:: appshot
# Recipe:: appshot
#
# Copyright 2012, Morgan Nelson
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

directory "/etc/appshot" do
  action :create
  group "root"
  owner "root"
  mode "0640"
end

databases = []
node['appshot']['databases'].each do |key, value|
  if value['snapshot'] == true
    options = []
    options << %Q(name: "#{value['name']}") if value['name']
    options << %Q(port: "#{value['port']}") if value['port']
    options << %Q(database_command: "#{value['command']}") if value['command']
    options << %Q(save_before_snapshot: "#{value['save_before_snapshot']}") if value['save_before_snapshot']
    options << %Q(username: "#{value['username']}") if value['username']
    options << %Q(password: "#{value['password']}") if value['password']
    databases << "#{key} " + options.join(", ")
  end
end

template "/etc/appshot/appshot.cfg" do
  mode '0640'
  owner "root"
  group "root"
  source "appshot.cfg.erb"
  variables(
    :appshot_name           => node['appshot']['name'],
    :databases              => databases,
    :filesystem_type        => node['appshot']['filesystem']['type'],
    :filesystem_mountpoint  => node['appshot']['filesystem']['mount_point'],
    :aws_access_key_id      => node['appshot']['aws']['aws_access_key_id'],
    :aws_secret_access_key  => node['appshot']['aws']['aws_secret_access_key'],
    :snapshots_to_keep      => node['appshot']['ebs_prune']['snapshots_to_keep'],
    :minimum_retention_days => node['appshot']['ebs_prune']['minimum_retention_days'],
  )
end

rvm_environment node['appshot']['rvm_ruby_string']


rvm_gem "appshot" do
  package_name "appshot"
  ruby_string node['appshot']['rvm_ruby_string']
  version node['appshot']['version']
end

node['appshot']['gem_packages'].each do |gem_name, gem_version|
  rvm_gem gem_name do
    ruby_string node['appshot']['rvm_ruby_string']
    version gem_version if gem_version && gem_version.length > 0
  end
end

cron "appshot" do
  hour    node['appshot']['crontab']['hour']
  minute  node['appshot']['crontab']['minute']
  command node['appshot']['crontab']['command']
end

rvm_wrapper "run" do
  binary "appshot"
  ruby_string node['appshot']['rvm_ruby_string']
end
