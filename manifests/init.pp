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
  $package_name        = $::thin::params::package_name,
  $package_version     = $::thin::params::package_version,
  $package_provider    = $::thin::params::package_provider,
  $additional_packages = $::thin::params::additional_packages,
  $thin_bin            = $::thin::params::thin_bin,
) inherits thin::params {

  if $additional_packages {
    package { $additional_packages:
      ensure => 'installed',
      before => Package[$package_name],
    }
  }

  package { $package_name:
    ensure   => $package_version,
    provider => $package_provider,
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

  if $::thin::params::systemd {
    include ::systemd

    file { '/usr/lib/systemd/system/thin@.service':
      owner   => root,
      group   => root,
      mode    => '0555',
      content => template('thin/thin.service.erb'),
      notify  => Exec['systemctl-daemon-reload'],
    }
  } else {
    file { '/etc/init.d/thin':
      owner   => root,
      group   => root,
      mode    => '0555',
      content => template('thin/thin.init.erb'),
    }
  }

}
