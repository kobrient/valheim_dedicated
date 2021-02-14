#!/bin/sh

#To be run from the Valheim server directory that SteamCMD installed into

export templdpath=$LD_LIBRARY_PATH
export SteamAppId=892970

if [ -f "valheim_server.x86_64" ]; then

    export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
    echo "Starting server PRESS CTRL-C to exit"
    ./valheim_server.x86_64 -name "MyServer" -port 2456 -world "Worldname" -password "secret"
    export LD_LIBRARY_PATH=$templdpath

else
    echo "ERROR: valheim_server.x86_64 not found"
    exit 1
fi
