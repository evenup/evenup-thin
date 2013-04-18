# Class: thin
#
# This module installs the thin rubygem
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
# === Copyright
#
# Copyright 2013 EvenUp.
#
class thin {

  require ruby

  package { 'rubygem-thin':
    ensure    => installed;
  }

  service { 'thin':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Package['rubygem-thin'];
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
    owner   => root,
    group   => root,
    mode    => '0555',
    source  => 'puppet:///modules/thin/thin.init',
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
    ensure  => 'present',
    system  => true,
  }

}
