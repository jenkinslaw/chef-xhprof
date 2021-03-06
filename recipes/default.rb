#
# Cookbook Name:: xhprof
# Recipe:: default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "php"
include_recipe "apt"

case node[:platform]
when "debian","ubuntu"
  %w{python-software-properties pkg-config}.each do |pkg|
    package pkg
  end

  apt_repository "xhprof" do
    uri "http://ppa.launchpad.net/brianmercer/php5-xhprof/ubuntu"
    distribution node['lsb']['codename']
    components ["main"]
    keyserver "keyserver.ubuntu.com"
    key "8D0DC64F"
    not_if { node["platform_version"] >= "14.04" }
  end

  package "php5-xhprof"

when "mac_os_x"
  package "xhprof"

  template "/usr/local/etc/php5/conf.d/xhprof.ini" do
    source "xhprof.ini.erb"
  end
end

