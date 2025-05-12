#!/bin/bash
echo "MariaDB initialization check"

# Ne réinstalle que si aucun fichier user n'existe
if [ ! -f "/var/lib/mysql/mysql/user.frm" ]; then 
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    /etc/init.d/mariadb start

    mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    mariadb -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mariadb -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
    mariadb -e "FLUSH PRIVILEGES;"

    /etc/init.d/mariadb stop
else
    echo "Database already initialized, skipping install."
fi

exec "$@"
