#!/bin/bash

scripts=/home/steam/valheim-scripts

$scripts/dependencies.sh
$scripts/steamcmd_app.sh
cd /home/steam/valheim
$scripts/runvalheim.sh
