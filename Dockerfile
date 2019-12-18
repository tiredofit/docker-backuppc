FROM tiredofit/nginx:alpine3.10
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

ENV BACKUPPC_VERSION=4.3.1 \
    BACKUPPC_XS_VERSION=0.59 \
    PAR2_VERSION=v0.8.0 \
    RSYNC_BPC_VERSION=3.1.2.1 \
    NGINX_ENABLE_CREATE_SAMPLE_HTML=FALSE \
    NGINX_USER=backuppc \
    NGINX_GROUP="" \
    ZABBIX_HOSTNAME=backuppc-app \
    ENABLE_SMTP=TRUE

RUN set -x && \
    apk update && \
    apk upgrade && \
    apk add -t .backuppc-build-deps \
			# Install backuppc build dependencies
				autoconf \
				automake \
				acl-dev \
				build-base \
				bzip2-dev \
				expat-dev \
				g++ \
				gcc \
				git \
				make \
				patch \
				perl-dev \
				&& \
    \
	# Install backuppc runtime dependencies
    apk add -t .backuppc-run-deps \
				bzip2 \
				expat \
				gzip \
				fcgiwrap \
				iputils \
				openssh \
				openssl \
				perl \
				perl-archive-zip \
				perl-cgi \
				perl-file-listing \
				perl-xml-rss \
				pigz \
				rrdtool \
				rsync \
				samba-client \
				spawn-fcgi \
		        sudo \
		        && \
		    \
    \
    # Compile and install Parallel BZIP
    mkdir -p /usr/src/pbzip2 && \
    curl -ssL https://launchpad.net/pbzip2/1.1/1.1.13/+download/pbzip2-1.1.13.tar.gz | tar xvfz - --strip=1 -C /usr/src/pbzip2 && \
    cd /usr/src/pbzip2 && \
    make && \
    make install && \
    \
	# Compile and install BackupPC:XS
	cd /usr/src && \
	git clone https://github.com/backuppc/backuppc-xs.git /usr/src/backuppc-xs --branch $BACKUPPC_XS_VERSION && \
	cd /usr/src/backuppc-xs && \
	perl Makefile.PL && \
	make && \
	make test && \
	make install && \
    \
	# Compile and install Rsync (BPC version)
	git clone https://github.com/backuppc/rsync-bpc.git /usr/src/rsync-bpc --branch $RSYNC_BPC_VERSION && \
	cd /usr/src/rsync-bpc && \
	./configure && \
	make reconfigure && \
	make && \
	make install && \
    \
	# Compile and install PAR2
	git clone https://github.com/Parchive/par2cmdline.git /usr/src/par2cmdline --branch $PAR2_VERSION && \
	cd /usr/src/par2cmdline && \
	./automake.sh && \
	./configure && \
	make && \
	make check && \
	make install && \
    \
	# Get BackupPC, it will be installed at runtime to allow dynamic upgrade of existing config/pool
	curl -o /usr/src/BackupPC-$BACKUPPC_VERSION.tar.gz -L https://github.com/backuppc/backuppc/releases/download/$BACKUPPC_VERSION/BackupPC-$BACKUPPC_VERSION.tar.gz && \
	\
	# Prepare backuppc home
	mkdir -p /home/backuppc && \
	\
	# Mark the docker as not runned yet, to allow entrypoint to do its stuff
	touch /firstrun && \
    \
	# Cleanup
    apk del .backuppc-build-deps && \
    rm -rf /usr/src/backuppc-xs /usr/src/rsync-bpc /usr/src/par2cmdline /usr/src/pbzip2 && \
    rm -rf /tmp/* && \
	rm -rf /var/cache/apk/*

### Add Folders
ADD install/ /

## Zabbix Setup 
RUN chmod +x /etc/zabbix/zabbix_agentd.conf.d/*.pl

## Networking
EXPOSE 80
