#
# Cookbook Name:: cdap
# Recipe:: repo
#
# Copyright (C) 2013-2014 Continuuity, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_family']
when 'rhel'
  include_recipe 'yum'
  yum_repository 'cdap' do
    description 'CDAP YUM repository'
    url node['cdap']['repo']['url']
    ### TODO: remove this once we get packages signing configured
    gpgcheck false
    action :add
  end
when 'debian'
  include_recipe 'apt'
  apt_repository 'cdap' do
    uri node['cdap']['repo']['url']
    distribution node['lsb']['codename']
    components node['cdap']['repo']['components']
    action :add
    arch 'amd64'
    trusted true
    key "#{node['cdap']['repo']['url']}/pubkey.gpg"
  end
end