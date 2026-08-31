#!/bin/bash
set -e

if [ -f /run/secrets/db_password ]; then
    MYSQL_PASSWORD=$(cat /run/secrets/db_password)
fi

# Wait for MariaDB container to be ready on port 3306
while ! mariadb-admin ping -h"mariadb" --silent; do
    sleep 2
done

# Perform setup only on first initialization
if [ ! -f /var/www/html/wp-config.php ]; then
    wp core download --allow-root --path=/var/www/html

    wp config create --allow-root --path=/var/www/html \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="mariadb:3306"

    # Install WordPress site (Admin username CANNOT contain admin/Admin)
    wp core install --allow-root --path=/var/www/html \
        --url="https://$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL"

    # Create second non-administrator user
    wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" \
        --role=author \
        --allow-root \
        --path=/var/www/html
fi

# Run PHP-FPM in foreground (PID 1)
exec php-fpm8.2 -F