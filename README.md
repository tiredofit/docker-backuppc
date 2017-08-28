# hub.docker.com/tiredofit/backuppc

# Introduction

Dockerfile to build a [BackupPC](https://backuppc.sourceforge.net/) 4.x (stable) container image.

This Container uses [Alpine 3.5](http://www.alpinelinux.org) as a base, along with served via LIghttpd.

[Changelog](CHANGELOG.md)

# Authors

- [Dave Conroy](https://github.com/tiredofit)

# Table of Contents

- [Introduction](#introduction)
    - [Changelog](CHANGELOG.md)
- [Prerequisites](#prerequisites)
- [Dependencies](#dependendcies)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
    - [Data Volumes](#data-volumes)
    - [Environment Variables](#environmentvariables)   
    - [Networking](#networking)
    - [Additional](#additional)   
- [Maintenance](#maintenance)
    - [Shell Access](#shell-access)
- [References](#references)


# Prerequisites

None

# Dependencies

Make sure there is adequate storage available to perform deduplicated backups!

# Installation

Automated builds of the image are available on [Docker Hub](https://tiredofit/backuppc) and is the recommended method of installation.


```bash
docker pull tiredofit/backuppc
```

# Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.

Start openldap-fusiondirectory using:

```bash
docker-compose up
```

Point your browser to `https://YOURHOSTNAME

__NOTE__: It is highly recommended this be run through a SSL proxy, with authentication, as by default there is none required!

## Data-Volumes

The following directories are used for configuration and can be mapped for persistent storage.

| Directory | Description |
|-----------|-------------|
| `/var/lib/backuppc` | The backed up Data |
| `/etc/backuppc` | Configuration Files |
| `/home/backuppc` | Home Directory for Backuppc (SSH Keys) |
| `/www/logs` | Logfiles for Lighttpd, Supervisord, BackupPC, Zabbix |



## Environment Variables

Along with the Environment Variables from the [Base image](https://hub.docker.com/r/tiredofit/alpine), below is the complete list of available options that can be used to customize your installation.

| Variable | Description |
|-----------|-------------|
| `BACKUPPC_ADMIN_USER` | The Admin User for Logging in |
| `BACKUPPC_ADMIN_PASS` | The Admin Pass for Logging in |
| `BACKUPPC_UUID` | The uid for the backuppc user e.g. 10000 |
| `BACKUPPC_GUID` | The gid for the backuppc user e.g. 10000 |

## Networking

The following ports are exposed and available to public interfaces

| Port | Description |
|-----------|-------------|
| `80` | HTTP |

__NOTE__: It is highly recommended this be run through a SSL proxy, or via localhost and tunnel via SSH.

## Maintenance
#### Shell Access

For debugging and maintenance purposes you may want access the containers shell. 

```bash
docker exec -it backuppc bash
```

# References

* http://backuppc.sourceforge.net/

