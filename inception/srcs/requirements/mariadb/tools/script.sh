#!/bin/bash

if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
    echo "Initializing database..."

    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    mysqld_safe --skip-networking &

    while ! mysqladmin ping --silent; do
        echo "Waiting for MariaDB to start..."
        sleep 2
    done

    mysql -u root <<-EOSQL
        CREATE DATABASE IF NOT EXISTS ${DB_NAME};
        CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PWD}';
        GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
        FLUSH PRIVILEGES;
EOSQL

    mysqladmin shutdown
fi

exec mysqld_safe
