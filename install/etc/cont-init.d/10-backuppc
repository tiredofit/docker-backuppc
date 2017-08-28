#!/usr/bin/with-contenv bash

		echo '*** First run of the container. BackupPC will be installed.'
		echo '*** If exist, configuration and data will be reused and upgraded as needed.'

		# Create backuppc user
		addgroup -S -g ${BACKUPPC_GUID:-1000} backuppc
		adduser -D -S -h /home/backuppc -G backuppc -u ${BACKUPPC_UUID:-1000} backuppc
		chown backuppc:backuppc /home/backuppc

		# Generate cryptographic key
		if [ ! -f /home/backuppc/.ssh/id_rsa ]; then
			su backuppc -s /bin/sh -c "ssh-keygen -t rsa -N '' -f /home/backuppc/.ssh/id_rsa"
		fi

		# Extract BackupPC
		cd /usr/src
		tar xf BackupPC-$BACKUPPC_VERSION.tar.gz
		cd /usr/src/BackupPC-$BACKUPPC_VERSION

		# Install BackupPC (existing configuration will be reused and upgraded)
		perl configure.pl \
			--batch \
			--config-dir /etc/backuppc \
			--cgi-dir /www/cgi-bin/BackupPC \
			--data-dir /var/lib/backuppc \
			--hostname localhost \
			--html-dir /www/html/BackupPC \
			--html-dir-url /BackupPC \
			--install-dir /usr/local/BackupPC \
	        --log-dir /www/logs/backuppc

		# Configure WEB UI access
		sed -ie "s/^\$Conf{CgiAdminUsers}\s*=\s*'\w*'/\$Conf{CgiAdminUsers} = '${BACKUPPC_ADMIN_USER:-backuppc}'/g" /etc/backuppc/config.pl
		htpasswd -b -c /etc/backuppc/htpasswd ${BACKUPPC_ADMIN_USER:-backuppc} ${BACKUPPC_ADMIN_PASS:-password}

		# Prepare lighttpd
		mkdir -p /www/logs/lighttpd
		touch /www/logs/lighttpd/error.log 
		chown -R backuppc:backuppc /www/logs/lighttpd

		# Configure standard mail delivery parameters (may be overriden by backuppc user-wide config)
		echo "account default" > /etc/msmtprc
		echo "host ${SMTP_HOST:-mail.example.org}" >> /etc/msmtprc
		echo "auto_from on" >> /etc/msmtprc
		if [ "${SMTP_MAIL_DOMAIN:-}" != "" ]; then
		       echo "maildomain ${SMTP_MAIL_DOMAIN}" >> /etc/msmtprc
	       	fi

		#Clean
		rm -rf /usr/src/BackupPC-$BACKUPPC_VERSION.tar.gz /usr/src/BackupPC-$BACKUPPC_VERSION /firstrun

