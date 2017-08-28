FROM tiredofit/alpine:3.5
MAINTAINER Dave Conroy <dave at tiredofit dot ca>

ENV BACKUPPC_VERSION=4.1.2 \
    BACKUPPC_XS_VERSION=0.53 \
    PAR2_VERSION=v0.7.0 \
    RSYNC_BPC_VERSION=3.0.9.6 \
    ZABBIX_HOSTNAME=backuppc-app

RUN apk --no-cache add \

	# Install backuppc build dependencies
		autoconf \
		automake \
		curl \
		expat \
		expat-dev \
		g++ \
		gcc \
		git \
		make \
		patch \
		perl \
		perl-cgi \
		perl-dev \
		wget \

	# Install backuppc runtime dependencies
		apache2-utils \
		gzip \
		iputils \
		lighttpd \
		lighttpd-mod_auth \
		openssh \
		openssl \
		rrdtool \
		rsync \
		samba-client \
  	        sudo \
	        && \
		
	# Compile and install needed perl modules
	mkdir -p /usr/src && \
	cd /usr/src && \
	cpan App::cpanminus && \
	cpanm -n Archive::Zip XML::RSS File::Listing && \

	# Compile and install BackupPC:XS
	git clone https://github.com/backuppc/backuppc-xs.git /usr/src/backuppc-xs --branch $BACKUPPC_XS_VERSION && \
	cd /usr/src/backuppc-xs && \
	# => temporary correction on version 0.53, already done on master: can be removed with version 0.54
	printf "\n#define ACCESSPERMS 0777" >> rsync.h && \
	perl Makefile.PL && make && make test && make install && \

	# Compile and install Rsync (BPC version)
	git clone https://github.com/backuppc/rsync-bpc.git /usr/src/rsync-bpc --branch $RSYNC_BPC_VERSION && \
	cd /usr/src/rsync-bpc && ./configure && make reconfigure && make && make install && \
		
	# Compile and install PAR2
	git clone https://github.com/Parchive/par2cmdline.git /usr/src/par2cmdline --branch $PAR2_VERSION && \
	cd /usr/src/par2cmdline && ./automake.sh && ./configure && make && make check && make install && \

	# Configure MSMTP for mail delivery (initially sendmail is a sym link to busybox)
	rm -f /usr/sbin/sendmail && \
	ln -s /usr/bin/msmtp /usr/sbin/sendmail && \

	# Get BackupPC, it will be installed at runtime to allow dynamic upgrade of existing config/pool
	curl -o /usr/src/BackupPC-$BACKUPPC_VERSION.tar.gz -L https://github.com/backuppc/backuppc/releases/download/$BACKUPPC_VERSION/BackupPC-$BACKUPPC_VERSION.tar.gz && \
	
	# Prepare backuppc home
	mkdir -p /home/backuppc && \
	
	# Mark the docker as not runned yet, to allow entrypoint to do its stuff
	touch /firstrun && \

	# Cleanup
	rm -rf /usr/src/backuppc-xs /usr/src/rsync-bpc /usr/src/par2cmdline && \
	
	   apk --no-cache del \
	   autoconf \
	   automake \
	   curl \
	   expat-dev \
	   g++ \
	   gcc \
	   git \
	   gcc \
	   make \
	   patch \
	   perl-dev \
	   wget \
	   && \

	rm -rf /var/cache/apk/*

### Add Folders
   ADD /install /
   
## Zabbix Setup 
   RUN chmod +x /etc/zabbix/zabbix_agentd.conf.d/*.pl

## Networking
	EXPOSE 80

## Entrypoint
    ENTRYPOINT ["/init"]
