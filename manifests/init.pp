# Class: thin
#
# This module installs the thin rubygem
#
#
# === Parameters
#
# [*package_name*]
#   String.  Name of the thin package to install
#   Default: thin
#
# [*package_version*]
#   String.  Version of thin to install
#   Default: latest
#
# [*package_provider*]
#   String.  Provider to use when installing package_name
#   Default: gem
#
#
# === Examples
#
# * Installation:
#     class { 'thin': }
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
#
class thin (
  $package_name     = $::thin::params::package_name,
  $package_version  = $::thin::params::package_version,
  $package_provider = $::thin::params::package_provider,
) inherits thin::params {

  package { $package_name:
    ensure   => $package_version,
    provider => $package_provider,
  }

  service { 'thin':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Package[$package_name];
  }

  file { '/etc/thin':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0555',
    purge   => true,
    recurse => true,
    force   => true,
  }

  file { '/etc/init.d/thin':
    owner  => root,
    group  => root,
    mode   => '0555',
    source => 'puppet:///modules/thin/thin.init',
  }

  user { 'thin':
    ensure  => 'present',
    system  => true,
    gid     => 'thin',
    home    => '/etc/thin',
    shell   => '/bin/bash',
    require => Group['thin'],
  }

  group { 'thin':
    ensure => 'present',
    system => true,
  }

}
