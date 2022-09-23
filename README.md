# minecraft-bedrock-server

Minecraft Bedrock edition docker server script

## Create Docker Image

```
./build.sh
```

## Customize/Push Image

Edit the file ``build.conf`` and fill
```
USER=
PASSWORD=
REPOSITORY=
REGISTRY=
```

## Create Network

```
docker network create -d macvlan --subnet=192.168.1.0/24 --gateway=192.168.1.1  -o parent=enp3s0 extnet
```
Replace ``enp3s0`` with your network interface, ``192.168.1.0/24`` with your network and ``192.168.1.1`` with yout gateway

## Run Container

```
docker run -d --name minecraft --restart=unless-stopped  \
 --publish=19132:19132/tcp \
 --publish=19133:19133/tcp \
 -e TZ=America/New_York \
 --volume=/home/me/minecraft/server.properties:/bedrock_server/server.properties \
 --volume=/home/me/minecraft/allowlist.json:/bedrock_server/allowlist.json \
 --volume=/home/me/minecraft/permissions.json:/bedrock_server/permissions.json \
 --volume=/home/me/minecraft/valid_known_packs.json:/bedrock_server/valid_known_packs.json \
 --volume=/home/me/minecraft/worlds:/bedrock_server/worlds \
 --network=extnet \
 --ip=192.168.1.9 mine/minecraft-bedrock-server:latest
```
Replace ``192.168.1.9`` with a free IP on your network (make sure it is excluded from dhcp), ``me`` with your user and ``mine`` with the chosen repository name

The files ``server.properties``, ``allowlist.json``, ``permissions.json`` and ``valid_known_packs.json`` are available on the [server zip file](https://www.minecraft.net/en-us/download/server/bedrock)

Also check out ``bedrock_server_how_to.html`` on the [server zip file](https://www.minecraft.net/en-us/download/server/bedrock) for configuration options and server commands

**Note:** Commands that have to be input directly on the server, such as ``save hold`` won't work on a containerized server

## Disclaimer


[!WARNING] Make sure you always accept and comply with the [Minecraft EULA](https://www.minecraft.net/en-us/terms)

**Distributing the resulting image in any way is likely a violation of the EULA and copyright laws**
