#!/bin/bash

export url='rtsp://192.168.1.10:554/user=admin&password=&channel=1&stream=0.sdp?'


while true
do
  date=$(date +"%F")
  hour=$(date +"%H-00")
  file=$(date +"%H-%M-%S.mp4")

  # Path to Camera Records (Apache Server)
  root='/var/www/camera'
  if [ ! -e $root ]
  then
    exit
  fi
  # ----------------------

  if [ ! -e "$root/$date" ]
  then
    mkdir "$root/$date"
  fi
  # ----------------------

  if [ ! -e "$root/$date/$hour" ]
  then
    mkdir "$root/$date/$hour"
  fi
  
  cd "$root/$date/$hour"
  openRTSP -D 1 -b 10000000 -4 -d 120 -P 121 -F "$file" -t "$url"
done
