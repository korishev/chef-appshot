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

* `node[appshot][aws][aws_access_key_id]`      - Your Amazon AWS access key id
* `node[appshot][aws][aws_secret_access_key]`  - Your Amazon AWS secret access key
* `node[appshot][aws][snapshots_to_keep]`      - The maximum number of snapshots to keep
* `node[appshot][aws][minimum_retention_days]` - The the minimum retention time to keep snapshots,
                                                 overrides snapshots_to_keep
* `node[appshot][aws][volume_id]`              - The Amazon EBS volume id of the volume you want to snapshot

* `node[apphost][crontab][command]`            - The command used to invoke appshot, defaults to 'appshot'
* `node[appshot][crontab][hour]`               - The hour of the day to run the nightly appshot
* `node[appshot][crontab][minute]`             - The minute of the hour to run the appshot

* `node[appshot][database][name]`              - The name of the database that must be flushed before the appshot
* `node[appshot][database][password]`          - The password to use for the db user
* `node[appshot][database][port]`              - The port your database listens on. Probably "3306"
* `node[appshot][database][type]`              - The type of the database that must be flushed before the appshot,
                                                 currently only 'mysql' is valid
* `node[appshot][database][username]`          - The db user to connect as

* `node[appshot][filesystem][type]`            - The type of filesystem that must be frozen before the appshot,
                                                 one of "xfs", "jfs", "reiserfs", "ext3", or "ext4"
* `node[appshot][filesystem][mount_point]`     - Where the filesystem to be appshotted is mounted

RECIPES
=======

default
-------

Installs the appshot gem, copies one config file into place, and sets up a crontab to run the backup every night.

