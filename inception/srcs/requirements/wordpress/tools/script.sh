#!/bin/bash

until mysqladmin ping -h mariadb --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done


if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Downloading WordPress..."
    wp core download --allow-root

    echo "Configuring WordPress..."
    wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PWD --dbhost=mariadb:3306 --allow-root

    echo "Installing WordPress..."
    wp core install --url=${DOMAIN_NAME} --title="${WP_TITLE}" --admin_user=${WP_ADMIN_USR} --admin_password=${WP_ADMIN_PWD} --admin_email=${WP_ADMIN_EMAIL} --skip-email --allow-root

    echo "Creating a WordPress user..."
    wp user create ${WP_USR} ${WP_EMAIL} --role=author --user_pass=${WP_PWD} --allow-root
fi

/sbin/php-fpm8.2 -F

