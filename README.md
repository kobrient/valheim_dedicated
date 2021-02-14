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

Change the arguments used in `valheim-scripts/runvalheim.sh` to suit your server details.

## Start the container
To start the container and then detach (recommended):
```
docker run -d -p 2456:2456/udp -p 2457:2457/udp -p 2458:2458/udp -v $(pwd)/valheim-data:/home/steam/valheim/ -v $(pwd)/valheim-scripts:/home/steam/valheim-scripts/ -v $(pwd)/Valheim:/home/steam/.config/unity3d/IronGate/Valheim/ --name=valheim-dedicated cm2network/steamcmd:latest /home/steam/valheim-scripts/setup.sh
```
If you want to enter the container interactively for debug:
```
docker run -it -p 2456:2456/udp -p 2457:2457/udp -p 2458:2458/udp -v $(pwd)/valheim-data:/home/steam/valheim/ -v $(pwd)/valheim-scripts:/home/steam/valheim-scripts/ -v $(pwd)/Valheim:/root/.config/unity3d/IronGate/Valheim/ --name=valheim-dedicated cm2network/steamcmd:root bash
```

## Stopping and starting the container
```
docker container stop valheim-dedicated
...
docker container start valheim-dedicated
```
To remove the container in case you want to start a new one completely:
```
docker container rm valheim-dedicated
```

## Connecting to the sever
Go to Steam -> View -> Servers -> Favorites -> Add a server
Put your IP and then port 2457, example: 192.168.1.20:2457
You can now direct connect through the steam server browser. If you're connecting from the outside, put your exterior IP.

## Acknowledgments
Thanks to @cm2network's steamcmd docker container
[https://hub.docker.com/r/cm2network/steamcmd/]
[https://github.com/CM2Walki/steamcmd]

