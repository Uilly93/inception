#set -e #premiere commande qui fail quite le scritp

if [ ! -f "/var/www/html/wp-config.php" ]; then 

cd /var/www/html

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

wp user create --allow-root $WP_USER $WP_USER_MAIL --user_pass=$WP_USER_PASSWD --path="/var/www/html"
				
wp theme install online-video-games  --allow-root --path="/var/www/html"
				
wp theme activate online-video-games  --allow-root --path="/var/www/html"

fi

exec "$@"