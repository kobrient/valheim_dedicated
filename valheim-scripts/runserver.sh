#!/bin/bash

#Install and run the gameserver. Try to die gracefully and leave breadcrumbs.

#For SteamCMD
game=valheim
appid=896660
installdir=/home/steam/$game

#Script vars
server_pid=-1
timeout=30
stdout_logfile="${game}_stdout.log"
stderr_logfile="${game}_stderr.log"

#Space separated
dependencies="libsqlite3-dev "

export templdpath=$LD_LIBRARY_PATH
#Game executable will be looking for this:
export SteamAppId=892970


main() {
    dependencies
    steamcmd
    cd $installdir
    run_server
}

dependencies() {
    #Skip dependencies if we're not root/sudo
    if [ $(id -u) -eq 0 ]; then
        apt update
        apt install --assume-yes $dependencies
    else
        echo "WARN: Skipping dependencies because you're not root"
    fi
}

steamcmd() {
    mkdir -p $installdir
    /home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir $installdir +app_update $appid +quit
}

shutdown() {
    if [ $server_pid -eq -1 ]; then
        echo "Server is not running yet - aborting startup"
        exit
    fi
    kill -INT $server_pid
    shutdown_timeout=$(($(date +%s)+$timeout))
    while [ -d "/proc/$server_pid" ]; do
        if [ $(date +%s) -gt $shutdown_timeout ]; then
            shutdown_timeout=$(($(date +%s)+$timeout))
            echo "Timeout while waiting for server to shutdown - sending KILL to PID $server_pid"
            kill -KILL $server_pid
        fi
        echo "Waiting for server with PID $server_pid to shutdown"
        sleep 6
    done
    echo "Shutdown complete"
    exit
}

run_server() {
    if [ -f "valheim_server.x86_64" ]; then
    
        export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
        echo "Starting server PRESS CTRL-C to exit"
        ./valheim_server.x86_64 -nographics -batchmode -name "MyServer" -port 2456 -world "Worldname" -password "secret" > $stdout_logfile 2> $stderr_logfile &
        server_pid=$!
        export LD_LIBRARY_PATH=$templdpath
        echo $server_pid > valheim_server.pid
        wait $server_pid
    else
        echo "ERROR: valheim_server.x86_64 not found"
        exit 1
    fi
}

trap shutdown SIGINT SIGTERM
main
