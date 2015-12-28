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
class openvpn::params {

  $openvpn_default_dir = '/etc/default/openvpn'
  $openvpn_dir_ensure  = 'directory'
  $openvpn_dir_keys    = 'keys'
  $openvpn_root_dir    = '/etc/openvpn'
  $package_name        = ['openvpn']
  $service_enable      = true
  $service_ensure      = 'running'
  $service_hasrestart  = true
  $service_hasstatus   = true
  $service_name        = 'openvpn'

  $group = $::osfamily ? {
    'RedHat' => 'nobody',
    default  => 'nogroup'
  }

  case $::osfamily {
    'RedHat': {
      # Redhat/Centos >= 6
      if($::operatingsystemmajrelease >= 6) {
        # http://docs.puppetlabs.com/references/latest/function.html#versioncmp
        if(versioncmp($::operatingsystemrelease, '6.4') < 0) { # Version < 6.4
          $easyrsa_source = '/usr/share/openvpn/easy-rsa/2.0'
        } else { # Version >= 6.4
          $additional_packages = ['easy-rsa', 'openvpn-auth-ldap']
          $easyrsa_source = '/usr/share/easy-rsa/2.0'
          $ldap_auth_plugin_location = '/usr/lib64/openvpn/plugin/lib/openvpn-auth-ldap.so'
        }
      } else { # Redhat/CentOS < 6
        $easyrsa_source = '/usr/share/doc/openvpn/examples/easy-rsa/2.0'
      }
    }
    'Debian': { # Debian/Ubuntu
      case $::lsbdistid {
        'Debian': {
          # Version > 8.0.0, jessie
          if(versioncmp($::lsbdistrelease, '8.0.0') >= 0) {
            $additional_packages = ['easy-rsa', 'openvpn-auth-ldap']
            $easyrsa_source = '/usr/share/easy-rsa/'
            $ldap_auth_plugin_location = '/usr/lib/openvpn/openvpn-auth-ldap.so'

          # Version > 7.0.0, wheezy
          } elsif(versioncmp($::lsbdistrelease, '7.0.0') >= 0) {
            $additional_packages = ['openvpn-auth-ldap']
            $easyrsa_source = '/usr/share/doc/openvpn/examples/easy-rsa/2.0'
            $ldap_auth_plugin_location = '/usr/lib/openvpn/openvpn-auth-ldap.so'
          } else {
            $easyrsa_source = '/usr/share/doc/openvpn/examples/easy-rsa/2.0'
          }
        }
        'Ubuntu': {
          # Version > 13.10, saucy
          if(versioncmp($::lsbdistrelease, '13.10') >= 0) {
            $additional_packages = ['easy-rsa', 'openvpn-auth-ldap']
            $easyrsa_source = '/usr/share/easy-rsa/'
            $ldap_auth_plugin_location = '/usr/lib/openvpn/openvpn-auth-ldap.so'
          } else {
            $easyrsa_source = '/usr/share/doc/openvpn/examples/easy-rsa/2.0'
          }
        }
        default: {
          fail("Not supported OS / Distribution: ${::osfamily}/${::lsbdistid}")
        }
      }
    }
    default: {
      fail("Not supported OS family ${::osfamily}")
    }
  }

  $link_openssl_cnf = $::osfamily ? {
    /(Debian|RedHat)/ => true,
    default           => false
  }

}
