CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER 'wnocchi'@'%' IDENTIFIED BY 'wnocchi';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wnocchi'@'%';
SELECT user, host FROM mysql.user;
FLUSH PRIVILEGES;