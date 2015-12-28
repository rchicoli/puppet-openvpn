# == Class: openvpn
#
# This module installs the openvpn service, configures vpn endpoints, generates
# client certificates, and generates client config files
#
#
# === Examples
#
# * Installation:
#     class { 'openvpn': }
#
#
# === Authors
#
# * Rafael Chicoli <mailto:rafael_chicoli@yahoo.com.br>
# * Raffael Schmid <mailto:raffael@yux.ch>
# * John Kinsella <mailto:jlkinsel@gmail.com>
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
# === License
#
# Copyright 2013 Rafael Chicoli, <rafael_chicoli@yahoo.com.br>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
class openvpn (
    $additional_packages = $openvpn::params::additional_packages,
    $openvpn_default_dir = $openvpn::params::openvpn_default_dir,
    $openvpn_dir_ensure  = $openvpn::params::openvpn_dir_ensure,
    $openvpn_dir_keys    = $openvpn::params::openvpn_dir_keys,
    $openvpn_root_dir    = $openvpn::params::openvpn_root_dir,
    $package_name        = $openvpn::params::package_name,
    $service_enable      = $openvpn::params::service_enable,
    $service_ensure      = $openvpn::params::service_ensure,
    $service_hasrestart  = $openvpn::params::service_hasrestart,
    $service_hasstatus   = $openvpn::params::service_hasstatus,
    $service_name        = $openvpn::params::service_name,
) inherits openvpn::params {

  # to do
  # validate_

  anchor { 'openvpn::begin': } ->
  class { 'openvpn::install': } ->
  class { 'openvpn::config': } ~>
  class { 'openvpn::service': } ->
  # Class['openvpn']
  anchor { 'openvpn::end': }

}
