#!/bin/sh

touch /etc/crontab /etc/cron.*/* /var/log/cron.log
env > /docker_env.sh
service cron start
tail -f /var/log/cron.log
