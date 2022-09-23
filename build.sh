#!/bin/bash

VER=$( curl -A "Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/81.0"  https://www.minecraft.net/en-us/download/server/bedrock  2>&1 | grep "Download Minecraft Dedicated Server software for Ubuntu" |  grep -o 'https://[^"]*' | grep -o 'r-[^z]*' | cut -c3- | rev | cut -c2- | rev ) 

if [ -f ".lastimage" ]; then 
  LAST_VER=$( cat .lastimage )
else
  LAST_VER="none"
fi

PWD=$( pwd )

source "${PWD}/build.conf"

REGP=""
PUSH=""
REPO=${REPOSITORY:-mine}

if [ "$VER" != "$LAST_VER" ]; then
  if [ -n "$USER" ] && [ -n "$PASSWORD" ] && [ -n "$REGISTRY" ]; then
    docker login --password $PASSWORD --username $USER $REGISTRY
    REGP="${REGISTRY}/"
  fi

  docker build --build-arg MINECRAFT_SERVER_VERSION="$VER" -t ${REGP}${REPO}/minecraft-bedrock-server:${VER} -t ${REGP}${REPO}/minecraft-bedrock-server:latest .

#  if [ -n "$USER" && -n "$PASSWORD" &&  -n "$REGISTRY" ]; then
#    docker image push --all-tags ${$REGP}akrauze/minecraft-bedrock-server:${VER}
#  fi
  
  echo "$VER" >.lastimage
else
  echo "No new version"
fi
