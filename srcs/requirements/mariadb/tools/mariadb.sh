#!/bin/bash
set -e

# Read password secrets if available
if [ -f /run/secrets/db_password ]; then
    MYSQL_PASSWORD=$(cat /run/secrets/db_password)
fi
if [ -f /run/secrets/db_root_password ]; then
    MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
fi

# Ensure run directory exists with correct permissions
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Initialize database directory if not already created
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null

    # Run SQL setup commands via temporary bootstrap process
    mysqld --user=mysql --bootstrap << EOF
USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF
fi

# Replace shell process with MariaDB daemon (PID 1)
exec mysqld --user=mysql