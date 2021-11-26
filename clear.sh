#!/bin/bash

export limit=21474836480

free=$(echo $(($(stat -f --format="%a*%S" .))))

if [ "$free" -lt "$limit" ]
then
  find /var/www/camera/* -mtime +4 -type d -exec rm -rf {} \;
fi