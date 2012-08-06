DESCRIPTION
===========

Installs and configures Appshot.

REQUIREMENTS
============

Platform
--------

Tested on Ubuntu 12.04

ATTRIBUTES
==========

appshot
-------

* `node[appshot][crontab][hour]`           - The hour of the day to run the nightly appshot
* `node[appshot][crontab][minute]`         - The minute of the hour to run the appshot
* `node[apphost][command]`                 - The command used to invoke appshot, defaults to 'appshot'
* `node[appshot][database][type]`          - The type of the database that must be flushed before the appshot,
                                             currently only 'mysql' is valid
* `node[appshot][database][name]`          - The name of the database that must be flushed before the appshot
* `node[appshot][filesystem][type]`        - The type of filesystem that must be frozen before the appshot,
                                             one of "xfs", "jfs", "reiserfs", "ext3", or "ext4"
* `node[appshot][filesystem][mount_point]` - Where the filesystem to be appshotted is mounted


RECIPES
=======

default
-------

Installs the appshot gem, copies one config file into place, and sets up a crontab to run the backup every night.
