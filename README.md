# hub.docker.com/r/tiredofit/backuppc

[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/backuppc.svg)](https://hub.docker.com/r/tiredofit/backuppc)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/backuppc.svg)](https://hub.docker.com/r/tiredofit/backuppc)
[![Docker
Layers](https://images.microbadger.com/badges/image/tiredofit/backuppc.svg)](https://microbadger.com/images/tiredofit/backuppc)

# Introduction

Dockerfile to build a [BackupPC](https://backuppc.github.io/backuppc/) 4.x (stable) container image.

This Container uses [Alpine 3.12](http://www.alpinelinux.org) and [tiredofit/nginx](https://github.com/tiredofit/docker-nginx)

[Changelog](CHANGELOG.md)

# Authors

- [Dave Conroy](https://github.com/tiredofit)

# Table of Contents

- [Configuration](#configuration)
  - [Data-Volumes](#data-volumes)
  - [Environment Variables](#environment-variables)
- [Networking](#networking)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)

# Prerequisites

None

# Dependencies

Make sure there is adequate storage available to perform deduplicated backups!

# Installation

Automated builds of the image are available on [Docker Hub](https://tiredofit/r/backuppc) and is the recommended method of installation.

```bash
docker pull tiredofit/backuppc
```

# Quick Start

- The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

- Set various [environment variables](#environment-variables) to understand the capabilities of this image.
- Map [persistent storage](#data-volumes) for access to configuration and data files for backup.

Start backuppc using:

```bash
docker-compose up
```

Point your browser to `https://YOURHOSTNAME`

**NOTE**: It is highly recommended this be run through a SSL proxy, with authentication enabled.

## Configuration

### Data-Volumes

The following directories are used for configuration and can be mapped for persistent storage.

| Directory           | Description                                       |
| ------------------- | ------------------------------------------------- |
| `/var/lib/backuppc` | The backed up Data                                |
| `/etc/backuppc`     | Configuration Files                               |
| `/home/backuppc`    | Home Directory for Backuppc (SSH Keys)            |
| `/www/logs`         | Logfiles for Nginx, Supervisord, BackupPC, Zabbix |

### Environment Variables

Along with the Environment Variables from the [Base image](https://hub.docker.com/r/tiredofit/alpine) and the [Nginx image](https://hub.docker.com/r/tiredofit/nginx) , below is the complete list of available options that can be used to customize your installation.

| Variable        | Description                              |
| --------------- | ---------------------------------------- |
| `BACKUPPC_UUID` | The uid for the backuppc user e.g. 10000 |
| `BACKUPPC_GUID` | The gid for the backuppc user e.g. 10000 |

_Authentication_

By default, this image does not use authentication. This is definitely not recommended on a production environment! Based on the environment variables from the Nginx Base Image you can set them here:

It's highly recommend you set at minimum:

```bash
NGINX_AUTHENTICATION_TYPE=BASIC
NGINX_AUTHENTICATION_BASIC_USER1=backuppc
NGINX_AUTHENTICATION_BASIC_PASS1=backuppc
```

| Parameter                                   | Description                                                                    | Default        |
| ------------------------------------------- | ------------------------------------------------------------------------------ | -------------- |
| `NGINX_AUTHENTICATION_TYPE`                 | Protect the site with `BASIC`, `LDAP`, `LLNG`                                  | `NONE`         |
| `NGINX_AUTHENTICATION_TITLE`                | Challenge response when visiting protected site                                | `Please login` |
| `NGINX_AUTHENTICATION_BASIC_USER1`          | If `BASIC` chosen enter this for the username to protect site                  | `admin`        |
| `NGINX_AUTHENTICATION_BASIC_PASS1`          | If `BASIC` chosen enter this for the password to protect site                  | `password`     |
| `NGINX_AUTHENTICATION_BASIC_USER2`          | As above, increment for more users                                             |                |
| `NGINX_AUTHENTICATION_BASIC_PASS2`          | As above, increment for more users                                             |                |
| `NGINX_AUTHENTICATION_LDAP_HOST`            | Hostname and port number of LDAP Server - ie `ldap://ldapserver:389`           |                |
| `NGINX_AUTHENTICATION_LDAP_BIND_DN`         | User to Bind to LDAP - ie `cn=admin,dc=orgname,dc=org`                         |                |
| `NGINX_AUTHENTICATION_LDAP_BIND_PW`         | Password for Above Bind User - ie `password`                                   |                |
| `NGINX_AUTHENTICATION_LDAP_BASE_DN`         | Base Distringuished Name - eg `dc=hostname,dc=com`                             |                |
| `NGINX_AUTHENTICATION_LDAP_ATTRIBUTE`       | Unique Identifier Attrbiute -ie `uid`                                          |                |
| `NGINX_AUTHENTICATION_LDAP_SCOPE`           | LDAP Scope for searching - ie `sub`                                            |                |
| `NGINX_AUTHENTICATION_LDAP_FILTER`          | Define what object that is searched for (ie `objectClass=person`)              |                |
| `NGINX_AUTHENTICATION_LDAP_GROUP_ATTRIBUTE` | If searching inside of a group what is the Group Attribute - ie `uniquemember` |                |
| `NGINX_AUTHENTICATION_LLNG_HANDLER_HOST`    | If `LLNG` chosen use hostname of handler                                       | `llng-handler` |
| `NGINX_AUTHENTICATION_LLNG_HANDLER_PORT`    | If `LLNG` chosen use this port for handler                                     | `2884`         |
| `NGINX_AUTHENTICATION_LLNG_ATTRIBUTE1`      | Syntax: HEADER_NAME, Variable, Upstream Variable - See note below              |                |
| `NGINX_AUTHENTICATION_LLNG_ATTRIBUTE2`      | Syntax: HEADER_NAME, Variable, Upstream Variable - See note below              |                |

When working with `NGINX_AUTHENTICATION_LLNG_ATTRIBUTE2` you will need to omit any `$` chracters from your string. It will be added in upon container startup. Example:
`NGINX_AUTHENTICATION_LLNG_ATTRIBUTE1=HTTP_AUTH_USER,uid,upstream_http_uid` will get converted into `HTTP_AUTH_USER,$uid,$upstream_http_uid` and get placed in the appropriate areas in the configuration.

## Networking

The following ports are exposed and available to public interfaces

| Port | Description |
| ---- | ----------- |
| `80` | HTTP        |

**NOTE**: It is highly recommended this be run through a SSL proxy, or via localhost and tunnel via SSH.

## Maintenance

### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

```bash
docker exec -it backuppc bash
```

# References

- http://backuppc.sourceforge.net/
- https://backuppc.github.io/backuppc/
