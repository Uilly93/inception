#!/bin/bash

# Attente que la base soit prête
# until nc -z $WORDPRESS_DB_HOST 3306; do
#   echo "En attente de MariaDB sur $WORDPRESS_DB_HOST:3306..."
#   sleep 1
# done

# Création de wp-config.php si absent
if [ ! -f /var/www/html/wp-config.php ]; then
  cd /var/www/html
  wp core --allow-root download --path=/var/www/html
  echo aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
  echo user=$WORDPRESS_DB_USER
  echo passwd=$WORDPRESS_DB_PASSWORD
  echo db_name=$WORDPRESS_DB_NAME
  echo db_host=$WORDPRESS_DB_HOST
  wp config create --allow-root \
    --dbname=$WORDPRESS_DB_NAME \
    --dbuser=$WORDPRESS_DB_USER \
    --dbpass=$WORDPRESS_DB_PASSWORD \
    --dbhost=$WORDPRESS_DB_HOST \
    --path=/var/www/html
  echo bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
  wp core install --allow-root \
    --url=$DOMAIN_NAME \
    --title="Inception" \
    --admin_user=$ADMIN_USER \
    --admin_password=$ADMIN_PASSWORD \
    --admin_email=$ADMIN_MAIL \
    --path=/var/www/html
fi

# Droits corrects
chown -R www-data:www-data /var/www/html

# Création du dossier pour le PID de PHP-FPM
mkdir -p /run/php

echo ccccccccccccccccccccccccccccccccccccc

# Démarrage de PHP-FPM
php-fpm7.4 -F
