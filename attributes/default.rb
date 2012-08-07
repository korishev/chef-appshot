default['appshot']['crontab']['hour']                     = 1
default['appshot']['crontab']['minute']                   = 1
default['apphsot']['crontab']['command']                  = "appshot"

default['appshot']['database']['type']                    = "mysql"
default['appshot']['database']['name']                    = "mysql"
default['appshot']['database']['password']                = "password"
default['appshot']['database']['port']                    = 3306
default['appshot']['database']['username']                = "username"

default['appshot']['filesystem']['type']                  = "xfs"
default['appshot']['filesystem']['mount_point']           = "/data/mysql"

default['appshot']['aws']['access_key_id']                = "your_aws_access_key"
default['appshot']['aws']['secret_access_key']            = "your_aws_secret_access"
default['appshot']['ebs_prune']['snapshots_to_keep']      = 5
default['appshot']['ebs_prune']['minimum_retention_days'] = 3
default['appshot']['ebs_snapshot']['volume_id']           = "vol-some_id"

