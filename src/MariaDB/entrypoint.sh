#!bin/bash
echo fffffffffffffffffffffffffffffffffff
if [ ! -d "/var/lib/mysql/$WORDPRESS_DB_NAME" ]; then 
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql
	/etc/init.d/mariadb start
	mariadb -e "CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB_NAME};"
	mariadb -e "CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';"
	mariadb -e "GRANT ALL PRIVILEGES ON ${WORDPRESS_DB_NAME}.* TO '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';"
	mariadb -e "FLUSH PRIVILEGES;"
	/etc/init.d/mariadb stop
fi
exec "$@"