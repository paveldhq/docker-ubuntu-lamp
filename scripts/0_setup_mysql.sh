#!/usr/bin/env bash

MYSQL_SETUP_FLAG_FILE="/mysql_configured"


# workaround for MySQL OverlayFS issue:
# https://github.com/docker/for-linux/issues/72
# https://docs.docker.com/engine/userguide/storagedriver/overlayfs-driver/#limitations-on-overlayfs-compatibility
find /var/lib/mysql -type f -exec touch {} \;

if [ ! -f "${MYSQL_SETUP_FLAG_FILE}" ]; then
    sed -i 's/^bind-address\s*=.*$/bind-address = "0.0.0.0"/' /etc/mysql/my.cnf

    /etc/init.d/mysql start
    sleep 5

    echo Initializing database...
    echo "CREATE DATABASE \`${MYSQL_DB_NAME};\`" | mysql
    echo "CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';" | mysql
    echo "GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' WITH GRANT OPTION;" | mysql

    touch "${MYSQL_SETUP_FLAG_FILE}"
else
    /etc/init.d/mysql start
fi
