#!/bin/bash
killall goipcron_x64 >/dev/null 2>/dev/null
sleep 0.5
cd /usr/local/goip
./goipcron_x64 inc/config.inc.php
echo "goipcron start"

apache2-foreground
echo "apache2 start"
