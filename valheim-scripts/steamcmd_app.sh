#!/bin/bash

game=valheim
appid=896660
installdir=/home/steam/$game

mkdir -p $installdir
if [ -f "/home/steam/steamcmd/steamcmd.sh" ]; then
    /home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir $installdir +app_update $appid +quit
else
    echo "ERROR: steamcmd.sh not found"
    exit 1
fi
