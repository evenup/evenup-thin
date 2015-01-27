# Class params
#
# Sets default class parameters
#
#
class thin::params {
  $package_name = 'thin'
  $package_version = 'latest'
  $package_provider = 'gem'

  case $::operatingsystemmajrelease {
    '7': {
      $lockdir = '/var/run/lock/subsys'
    }
    default: {
      $lockdir = '/var/lock/subsys'
    }
  }
}