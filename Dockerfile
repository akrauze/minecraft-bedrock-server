FROM ubuntu:latest

ARG MINECRAFT_SERVER_VERSION=1.19.30.04

ENV LD_LIBRARY_PATH=.

WORKDIR /bedrock_server

RUN apt-get update \
    && apt-get install -y zip curl \
    && curl -L https://minecraft.azureedge.net/bin-linux/bedrock-server-$MINECRAFT_SERVER_VERSION.zip -o bedrock-server-$MINECRAFT_SERVER_VERSION.zip \
    && unzip bedrock-server-$MINECRAFT_SERVER_VERSION.zip \
    && rm bedrock-server-$MINECRAFT_SERVER_VERSION.zip

CMD ["./bedrock_server"]
