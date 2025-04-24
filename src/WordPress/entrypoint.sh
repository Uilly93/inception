#!/bin/bash
set -e

if [ ! -f /var/www/html/wp-config.php ]; then
  wp core download --path=/var/www/html --allow-root
  wp config create \
    --dbname=$WORDPRESS_DB_NAME \
    --dbuser=$WORDPRESS_DB_USER \
    --dbpass=$WORDPRESS_DB_PASSWORD \
    --dbhost=$WORDPRESS_DB_HOST \
    --path=/var/www/html \
    --allow-root
  wp core install \
    --url=$DOMAIN_NAME \
    --title="Inception" \
    --admin_user=$ADMIN_USER \
    --admin_password=$ADMIN_PASSWORD \
    --admin_email=$ADMIN_MAIL \
    --path=/var/www/html \
    --allow-root
fi

exec php-fpm -F
