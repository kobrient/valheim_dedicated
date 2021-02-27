# valheim_dedicated
Dedicated Valheim Game Server in a Docker container

## Setup
Change permissions on valheim-data and Valheim directories to 777 so that Steam user within Docker container can read and write data to that directory which will be volumed in.
This ensures that world and player data is persistent across container restarts
```
chmod 0777 valheim-data/
chmod 0777 Valheim/
chmod 0777 Valheim/worlds
```
The container will require and use ports 2456-2458 so make sure to forward those to the host machine.

If you have existing world files, copy them into Valheim/worlds directory before starting.

Change the arguments used in `valheim-scripts/runserver.sh` to suit your server details.

## Start the container
To spin up the container with docker-compose:
```
docker-compose up
```
If compose is not available, to start the container manually and then detach:
```
docker run -d -p 2456:2456/udp -p 2457:2457/udp -p 2458:2458/udp -v $(pwd)/valheim-data:/home/steam/valheim/ -v $(pwd)/valheim-scripts:/home/steam/valheim-scripts/ -v $(pwd)/Valheim:/home/steam/.config/unity3d/IronGate/Valheim/ --name=valheim-dedicated cm2network/steamcmd:latest /home/steam/valheim-scripts/runserver.sh
```
If you want to enter the container interactively for debug:
```
docker-compose -f docker-compose.scratch.yml run --service-ports valheim-dedicated-scratch
```

## Managing the container
To stop the server, input Ctrl-C from the shell the container is running in OR
```
docker kill --signal="SIGINT" <container-id>
```
To remove the container in case you want to start a new one completely:
```
docker container rm <container-id | container-name>
```

## Connecting to the sever
Find the server name in the Valheim client server browser or connect to the IP address directly with port 2456.

## Acknowledgments
Thanks to @cm2network's steamcmd docker container
[https://hub.docker.com/r/cm2network/steamcmd/]
[https://github.com/CM2Walki/steamcmd]

