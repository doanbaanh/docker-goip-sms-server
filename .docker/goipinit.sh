#!/bin/bash

/usr/bin/mysqld_safe > /dev/null 2>&1 &

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done

if [[ ! -d /var/lib/mysql/goip ]]; then
  mysql -uroot < /usr/local/goip/goipinit.sql
fi

mysqladmin -uroot shutdown
