#!/usr/bin/env bash

/etc/init.d/apache2 start

for SCRIPT in /scripts/*.sh
do
  if [ -f $SCRIPT -a -x $SCRIPT ]
  then
    echo -e "\n=== Executing script $SCRIPT ===\n"
    $SCRIPT $@
  fi
done

chown -R www-data:www-data /var/www/html/*

tail -f /var/log/apache2/error.log /var/log/mysql/error.log
