#!/bin/bash

export url='rtsp://192.168.1.10:554/user=admin&password=&channel=1&stream=0.sdp?'


while true
do
  date=$(date +"%F")
  hour=$(date +"%H-00")
  file=$(date +"%H-%M-%S.mp4")
  cvlc -vvv "$url" --rtsp-tcp --rtsp-frame-buffer-size=10000000 --rtsp-timeout=10 --sout-transcode-fps=25 --sout=file/mp4:record.mp4 -I dummy --stop-time=16 vlc://quit

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

  # Move written video file to Camera Path
  if [ -e "record.mp4" ]
  then
    if [ $(stat --format=%s "record.mp4") -gt 256 ]
    then
      mv "record.mp4" "$root/$date/$hour/$file"
    else
      rm "record.mp4"
    fi
  fi
done