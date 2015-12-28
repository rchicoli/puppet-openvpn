# == Definition openvpn::service
#
# This class maintains the openvpn service.
#
#
# === Examples
#
# This class should not be directly invoked
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
class openvpn::service inherits openvpn {

  service {
    "${service_name}":
      ensure     => $service_ensure,
      enable     => $service_enable,
      hasrestart => $service_hasrestart,
      hasstatus  => $service_hasstatus,
  }
}
