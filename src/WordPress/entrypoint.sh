#!/bin/bash

# Attente que la base soit prête
# until nc -z $WORDPRESS_DB_HOST 3306; do
#   echo "En attente de MariaDB sur $WORDPRESS_DB_HOST:3306..."
#   sleep 1
# done

# Création de wp-config.php si absent
if ! wp core is-installed --allow-root --path=/var/www/html; then
  mkdir -p /var/www/html 
  cd /var/www/html 
  wp core download --allow-root --path=/var/www/html 
  wp core --allow-root download --path="/var/www/html"

  wp config create --allow-root \
          --dbname=$WORDPRESS_DB_NAME \
          --dbuser=$WORDPRESS_DB_USER  \
          --dbpass=$WORDPRESS_DB_PASSWD \
          --url=$DOMAIN_NAME  \
          --dbhost="mariadb" \
          --skip-check   \
          --path="/var/www/html" 

  wp core install --allow-root \
          --url=$DOMAIN_NAME  \
          --title=$DOMAIN_NAME  \
          --admin_user=$ADMIN_USER  \
          --admin_password=$ADMIN_PASSWD  \
          --admin_email=$ADMIN_EMAIL  \
          --path="/var/www/html"
fi

# Droits corrects
chown -R www-data:www-data /var/www/html

# Création du dossier pour le PID de PHP-FPM
mkdir -p /run/php

echo ccccccccccccccccccccccccccccccccccccc

# Démarrage de PHP-FPM
exec php-fpm7.4 -F
