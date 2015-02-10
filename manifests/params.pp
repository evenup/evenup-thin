# Class params
#
# Sets default class parameters
#
#
class thin::params {
  $package_name = 'thin'
  $package_version = 'latest'
  $package_provider = 'gem'
  $thin_bin = '/usr/local/bin/thin'

  case $::osfamily {
    'RedHat': {
      case $::operatingsystemmajrelease {
        '7': {
          $lockdir = '/var/run/lock/subsys'
          $systemd = true
          $additional_packages = [ 'ruby-devel', 'gcc-c++' ]
        }
        default: {
          $lockdir = '/var/lock/subsys'
          $systemd = false
          $additional_packages = []
        }
      }
    }
    default: {
      fail("${::osfamily} is not supported")
    }
  }
}
