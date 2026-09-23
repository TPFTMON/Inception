#!/bin/sh

if [ ! -f "/etc/vsftpd/user_created" ]; then
    addgroup -g 1000 ftpgroup
    adduser -D -h /var/www/html -s /bin/false -G ftpgroup -u 1000 "$FTP_USER"
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
    touch /etc/vsftpd/user_created
fi

exec vsftpd /etc/vsftpd/vsftpd.conf