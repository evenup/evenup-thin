What is it?
===========

A puppet module that installs ruby thin, sets up site configurations, and
an init script for managing services.


Usage:
------

Generic thin install
<pre>
  class { 'thin': }
</pre>

Adding a thin site
<pre>
  thin::site { 'coolapp':
    chdir       => '/usr/share/coolapp',
    log         => '/var/log/coolapp/coolapp.log',
    port        => 3200,
    user        => 'coolapp',
    group       => 'coolapp',
    servers     => 1,
    environment => 'production';
  }
</pre>


Known Issues:
-------------
Only tested on CentOS 6

TODO:
____
[ ] Allow disabling creating of user/group

License:
_______

Released under the Apache 2.0 licence


Contribute:
-----------
* Fork it
* Create a topic branch
* Improve/fix (with spec tests)
* Push new topic branch
* Submit a PR
