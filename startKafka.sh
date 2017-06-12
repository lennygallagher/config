#!/usr/bin/env bash

docker stop zk-1 && docker rm zk-1 \
  && docker stop zk-2 && docker rm zk-2 \
  && docker stop zk-3 && docker rm zk-3

docker run -d \
   --net=hackathon \
   --name=zk-1 \
   -e ZOOKEEPER_SERVER_ID=1 \
   -e ZOOKEEPER_CLIENT_PORT=22181 \
   -e ZOOKEEPER_TICK_TIME=2000 \
   -e ZOOKEEPER_INIT_LIMIT=5 \
   -e ZOOKEEPER_SYNC_LIMIT=2 \
   -e ZOOKEEPER_SERVERS="zk-1:22888:23888;zk-2:32888:33888;zk-3:42888:43888" \
   confluentinc/cp-zookeeper:3.2.1

docker run -d \
   --net=hackathon \
   --name=zk-2 \
   -e ZOOKEEPER_SERVER_ID=2 \
   -e ZOOKEEPER_CLIENT_PORT=32181 \
   -e ZOOKEEPER_TICK_TIME=2000 \
   -e ZOOKEEPER_INIT_LIMIT=5 \
   -e ZOOKEEPER_SYNC_LIMIT=2 \
   -e ZOOKEEPER_SERVERS="zk-1:22888:23888;zk-2:32888:33888;zk-3:42888:43888" \
   confluentinc/cp-zookeeper:3.2.1

docker run -d \
   --net=hackathon \
   --name=zk-3 \
   -e ZOOKEEPER_SERVER_ID=3 \
   -e ZOOKEEPER_CLIENT_PORT=42181 \
   -e ZOOKEEPER_TICK_TIME=2000 \
   -e ZOOKEEPER_INIT_LIMIT=5 \
   -e ZOOKEEPER_SYNC_LIMIT=2 \
   -e ZOOKEEPER_SERVERS="zk-1:22888:23888;zk-2:32888:33888;zk-3:42888:43888" \
   confluentinc/cp-zookeeper:3.2.1

docker stop kafka-1 && docker rm kafka-1 \
  && docker stop kafka-2 && docker rm kafka-2 \
  && docker stop kafka-3 && docker rm kafka-3

docker run -d \
    --net=hackathon \
    --name=kafka-1 \
    -e KAFKA_ZOOKEEPER_CONNECT=zk-1:22181,zk-2:32181,zk-3:42181 \
    -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://kafka-1:29092 \
    confluentinc/cp-kafka:3.2.1

docker run -d \
    --net=hackathon \
    --name=kafka-2 \
    -e KAFKA_ZOOKEEPER_CONNECT=zk-1:22181,zk-2:32181,zk-3:42181 \
    -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://kafka-2:39092 \
    confluentinc/cp-kafka:3.2.1

docker run -d \
    --net=hackathon \
    --name=kafka-3 \
    -e KAFKA_ZOOKEEPER_CONNECT=zk-1:22181,zk-2:32181,zk-3:42181 \
    -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://kafka-3:49092 \
    confluentinc/cp-kafka:3.2.1
