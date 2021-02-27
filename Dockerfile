FROM cm2network/steamcmd:latest

WORKDIR /home/steam/

EXPOSE 2456/udp
EXPOSE 2457/udp
EXPOSE 2458/udp

VOLUME "./valheim-data:/home/steam/valheim/"
VOLUME "./valheim-scripts:/home/steam/valheim-scripts/"
VOLUME "./Valheim:/home/steam/.config/unity3d/IronGate/Valheim/"

CMD ["/home/steam/valheim-scripts/runserver.sh"]
