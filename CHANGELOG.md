## 5.3.13 2022-10-04 <dave at tiredofit dot ca>

   ### Changed
      - Switch to clone_git_repo function


## 5.3.12 2022-08-17 <dave at tiredofit dot ca>

   ### Changed
      - Switch to using exec statements


## 5.3.11 2022-06-23 <dave at tiredofit dot ca>

   ### Added
      - Support tiredofit/nginx:6.0.0 and tiredofit/nginx-php-fpm:7.0.0 changes


## 5.3.10 2022-05-24 <dave at tiredofit dot ca>

   ### Changed
      - Switch to using secure CPAN mirror when installing Net::FTP


## 5.3.9 2022-05-24 <dave at tiredofit dot ca>

   ### Added
      - Alpine 3.16 base


## 5.3.8 2022-02-10 <dave at tiredofit dot ca>

   ### Changed
      - Update to support upstream base image features


## 5.3.7 2022-01-13 <dave at tiredofit dot ca>

   ### Added
      - Add perl-date-parsetime package


## 5.3.6 2021-12-22 <dave at tiredofit dot ca>

   ### Changed
      - Fix for BackuPC Zabbix template not appearing


## 5.3.5 2021-12-15 <dave at tiredofit dot ca>

   ### Changed
      - Cleanup for Zabbix Auto agent registration


## 5.3.4 2021-12-12 <dave at tiredofit dot ca>

   ### Changed
      - Alpine 3.15 base
      - Rework Zabbix Templates


## 5.3.3 2021-12-07 <dave at tiredofit dot ca>

   ### Added
      - Add Zabbix auto register support for templates


## 5.3.2 2021-10-20 <dave at tiredofit dot ca>

   ### Added
      - Add perl packages to support metrics export


## 5.3.1 2021-07-30 <dave at tiredofit dot ca>

   ### Added
      - Update to Alpine 3.14 base


## 5.3.0 2021-04-28 <dave at tiredofit dot ca>

   ### Added
      - Add ed25519 SSH client key

   ### Changed
      - Add smoke test for testing if smtp is enabled/disabled


## 5.2.5 2021-04-28 <dave at tiredofit dot ca>

   ### Changed
      - Permissions fix on script execution


## 5.2.4 2021-04-28 <dave at tiredofit dot ca>

   ### Changed
      - Permissions fix on script


## 5.2.3 2021-03-26 <dave at tiredofit dot ca>

   ### Added
      - Alpine 3.13 Base


## 5.2.2 2020-11-03 <dave at tiredofit dot ca>

   ### Added
      - Update rsync-bpc to 3.13.0


## 5.2.1 2020-07-08 <dave at tiredofit dot ca>

   ### Added
      - BackupPC 4.40
      - BackupPC_XS 0.62
      - Rsync BPC 3.12.2
      - Alpine 3.12


## 5.2.0 2020-06-08 <dave at tiredofit dot ca>

   ### Added
      - Change to support tiredofit/alpine base image


## 5.1.5 2020-03-16 <dave at tiredofit dot ca>

   ### Changed
      - Update msmtp configuration


## 5.1.4 2020-03-09 <dave at tiredofit dot ca>

   ### Added
      - BackupPC 4.3.2


## 5.1.3 2020-01-20 <dave at tiredofit dot ca>

   ### Added
      - Add ttf-dejavu package to properly generate graphs

## 5.1.2 2020-01-13 <dave at tiredofit dot ca>

   ### Changed
      - Change to allow BackupPC process to execute properly


## 5.1.1 2020-01-02 <dave at tiredofit dot ca>

   ### Changed
      - Additional changes to support new tiredofit/backuppc image


## 5.1.0 2019-12-29 <dave at tiredofit dot ca>

   ### Added
      - Changes to support new tiredofit/alpine base

## 5.0.0 2019-12-12 <dave at tiredofit dot ca>

   ### Added
      - Refactored entire image to use tiredofit/nginx as a base

   ### Changed
      - Reworked authentication mechanisms
      - Cleaned up code


## 4.6 - 2019-07-25 <dave at tiredofit dot ca>

* BackupPC 4.3.1
* BackupPCXS 0.59
* BackupPC Rsync 3.1.2.1

## 4.5 - 2019-06-19 <dave at tiredofit dot ca>

* Alpine 3.10

## 4.4.4 - 2019-02-24 <dave at tiredofit dot ca>

* Add some error checking 

## 4.4.3 - 2019-02-24 <dave at tiredofit dot ca>

* Add Debug during build

## 4.4.2 - 2019-02-08 <dave at tiredofit dot ca>

* Bump to Alpine 3.9

## 4.4.1 - 2018-12-11 <dave at tiredofit dot ca>

* Add acl-dev during build process
* Startup Script cleanup

## 4.4 - 2018-12-11 <dave at tiredofit dot ca>

* BackupPC 4.3.0
* BackupPCXS 0.58
* BackupPC Rsync 3.12.0

## 4.3 - 2018-04-15 <dave at tiredofit dot ca>

* Update permissions to write for Nginx
* Patchup for LLNG Handler Function

## 4.2 - 2018-04-15 <dave at tiredofit dot ca>

* Update BackupPC to 4.2.0

## 4.1 - 2018-03-26 <dave at tiredofit dot ca>

* Add $PORT_NUMBER env variable for changing Nginx Port if using on user_ns: host

## 4.0 - 2018-02-25 <dave at tiredofit dot ca>

* Switch to Nginx w/fcgiwrap from Lightttpd
* Update Rsync_BPC to 3.0.9.12
* Update to Alpine 3.7
* Add new AUTHENTICATION_TYPE variable for BASIC, LLNG (LemonLDAP:NG) and NONE
* Cleanup Source

## 3.5 - 2018-01-23 <dave at tiredofit dot ca>

* Update PAR2 0.80
* Update Rsync BPC to 3.0.9.11
* Zabbix Tweaks

## 3.41 - 2017-12-09 <dave at tiredofit dot ca>

* Filesystem Cleanup

## 3.4 - 2017-12-09 <dave at tiredofit dot ca>

* Version Bump to 4.15
* BackupPC:XS 0.57

## 3.31 - 2017-12-09 <dave at tiredofit dot ca>

* Update BackupXS to 0.56

## 3.3 - 2017-11-30 <dave at tiredofit dot ca>

* Version bump to 4.14

## 3.2 - 2017-07-04 <dave at tiredofit dot ca>

* Version Bump and MSMTP Fixup

## 3.1 - 2017-07-04 <dave at tiredofit dot ca>

* File Cleanup
* MSMTP Fixup

## 3.0 - 2017-07-04 <dave at tiredofit dot ca>

* Rebase with s6
* Add Sudo

## 2.1 - 2017-05-14 <dave at tiredofit dot ca>

* Zabbix Agent Monitoring Scripts Update

## 2.0 - 2017-05-12 <dave at tiredofit dot ca>

* Rebase w/Alpine 3.5
* Zabbix Monitoring Enabled
* BackupPC 4.1.2
* Lighthttpd

## 1.0 - 2017-01-01 <dave at tiredofit dot ca>

* Initial Commit
