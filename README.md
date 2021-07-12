# github.com/tiredofit/docker-backuppc

[![GitHub release](https://img.shields.io/github/v/tag/tiredofit/docker-backuppc?style=flat-square)](https://github.com/tiredofit/docker-backuppc/releases/latest)
[![Build Status](https://img.shields.io/github/workflow/status/tiredofit/docker-backuppc/build?style=flat-square)](https://github.com/tiredofit/docker-backuppc/actions?query=workflow%3Abuild)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/backuppc.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/backuppc/)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/backuppc.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/backuppc/)
[![Become a sponsor](https://img.shields.io/badge/sponsor-tiredofit-181717.svg?logo=github&style=flat-square)](https://github.com/sponsors/tiredofit)
[![Paypal Donate](https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal&style=flat-square)](https://www.paypal.me/tiredofit)

* * *

## About
This will build a Docker image for [BackupPC](https://backuppc.github.io/backuppc/) - A backup system.

## Maintainer
- [Dave Conroy](https://github.com/tiredofit)

# Table of Contents

- [Configuration](#configuration)
  - [Data-Volumes](#data-volumes)
  - [Environment Variables](#environment-variables)
- [Networking](#networking)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)

## Prerequisites and Assumptions
*  Assumes you are using some sort of SSL terminating reverse proxy such as:
   *  [Traefik](https://github.com/tiredofit/docker-traefik)
   *  [Nginx](https://github.com/jc21/nginx-proxy-manager)
   *  [Caddy](https://github.com/caddyserver/caddy)
* Make sure there is adequate storage available to perform deduplicated backups!


## Installation

### Build from Source
Clone this repository and build the image with `docker build -t (imagename) .`

### Prebuilt Images
Builds of the image are available on [Docker Hub](https://hub.docker.com/r/tiredofit/backuppc) and is the recommended method of installation.

```bash
docker pull tiredofit/backuppc:(imagetag)
```

The following image tags are available along with their tagged release based on what's written in the [Changelog](CHANGELOG.md):

| Container OS | Tag       |
| ------------ | --------- |
| Alpine       | `:latest` |

## Configuration


### Quick Start

- The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

- Set various [environment variables](#environment-variables) to understand the capabilities of this image.
- Map [persistent storage](#data-volumes) for access to configuration and data files for backup.
- Enter inside the container and as user `backuppc` `ssh-copy-id` your public keys to a remote host
- Visit your Web interface

### Persistent Storage

The following directories are used for configuration and can be mapped for persistent storage.

| Directory           | Description                                       |
| ------------------- | ------------------------------------------------- |
| `/var/lib/backuppc` | The backed up Data                                |
| `/etc/backuppc`     | Configuration Files                               |
| `/home/backuppc`    | Home Directory for Backuppc (SSH Keys)            |
| `/www/logs`         | Logfiles for Nginx, Supervisord, BackupPC, Zabbix |

### Environment Variables

#### Base Images used

This image relies on an [Alpine Linux](https://hub.docker.com/r/tiredofit/alpine) or [Debian Linux](https://hub.docker.com/r/tiredofit/debian) base image that relies on an [init system](https://github.com/just-containers/s6-overlay) for added capabilities. Outgoing SMTP capabilities are handlded via `msmtp`. Individual container performance monitoring is performed by [zabbix-agent](https://zabbix.org). Additional tools include: `bash`,`curl`,`less`,`logrotate`, `nano`,`vim`.

Be sure to view the following repositories to understand all the customizable options:

| Image                                                  | Description                            |
| ------------------------------------------------------ | -------------------------------------- |
| [OS Base](https://github.com/tiredofit/docker-alpine/) | Customized Image based on Alpine Linux |
| [Nginx](https://github.com/tiredofit/docker-nginx/)    | Nginx webserver                        |

| Variable        | Description                                |
| --------------- | ------------------------------------------ |
| `BACKUPPC_UUID` | The uid for the backuppc user e.g. `10000` |
| `BACKUPPC_GUID` | The gid for the backuppc user e.g. `10000` |

#### Authentication

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
* * *

### Networking

The following ports are exposed and available to public interfaces

| Port | Description |
| ---- | ----------- |
| `80` | HTTP        |

**NOTE**: It is highly recommended this be run through a SSL proxy, or via localhost and tunnel via SSH.

## Maintenance

### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

``bash
docker exec -it (whatever your container name is) bash
``
## Support

These images were built to serve a specific need in a production environment and gradually have had more functionality added based on requests from the community.
### Usage
- The [Discussions board](../../discussions) is a great place for working with the community on tips and tricks of using this image.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) personalized support.
### Bugfixes
- Please, submit a [Bug Report](issues/new) if something isn't working as expected. I'll do my best to issue a fix in short order.

### Feature Requests
- Feel free to submit a feature request, however there is no guarantee that it will be added, or at what timeline.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) regarding development of features.

### Updates
- Best effort to track upstream changes, More priority if I am actively using the image in a production environment.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) for up to date releases.

## License
MIT. See [LICENSE](LICENSE) for more details.

# References

- http://backuppc.sourceforge.net/
- https://backuppc.github.io/backuppc/
