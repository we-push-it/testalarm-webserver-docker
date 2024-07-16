#!/bin/bash

if [ "$1" == "start" ]; then
    touch /var/www/html/alert_on
elif [ "$1" == "stop" ]; then
    rm -f /var/www/html/alert_on
fi

nginx -s reload
