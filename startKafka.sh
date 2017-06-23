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

docker stop schema-registry && docker rm schema-registry

docker run -d \
    --net=hackathon \
    --name=schema-registry \
    -p 8081:8081 \
    -e SCHEMA_REGISTRY_KAFKASTORE_CONNECTION_URL=zk-1:22181,zk-2:32181,zk-3:42181 \
    -e SCHEMA_REGISTRY_HOST_NAME=schema-registry \
    -e SCHEMA_REGISTRY_LISTENERS=http://schema-registry:8081 \
    -e SCHEMA_REGISTRY_DEBUG=true \
    confluentinc/cp-schema-registry:3.2.1

docker stop kafka-rest && docker rm kafka-rest

docker run -d \
    --net=hackathon \
    --name=kafka-rest \
    -p 8082:8082 \
    -e KAFKA_REST_ZOOKEEPER_CONNECT=zk-1:22181,zk-2:32181,zk-3:42181 \
    -e KAFKA_REST_LISTENERS=http://kafka-rest:8082 \
    -e KAFKA_REST_SCHEMA_REGISTRY=http://schema-registry:8081 \
    -e KAFKA_REST_HOST_NAME=kafka-rest \
    confluentinc/cp-kafka-rest:3.2.1


docker stop schema-registry-ui && docker rm schema-registry-ui

docker run -d \
    --net=hackathon \
     --name=schema-registry-ui \
     -p 8000:8000 \
     -e SCHEMAREGISTRY_URL=http://schema-registry:8081 \
     -e PROXY=true \
     landoop/schema-registry-ui

docker stop kafka-topic-ui && docker rm kafka-topic-ui

docker run -d \
    --net=hackathon \
     --name=kafka-topic-ui \
     -p 8001:8000 \
     -e KAFKA_REST_PROXY_URL=http://kafka-rest:8082 \
     -e PROXY=true \
     landoop/kafka-topics-ui


docker stop kafka-manager && docker rm kafka-manager

docker run -d \
    --net=hackathon \
    -p 9000:9000 \
    --name=kafka-manager \
    -e ZK_HOSTS=zk-1:22181,zk-2:32181,zk-3:42181 \
    -e APPLICATION_SECRET=letmein sheepkiller/kafka-manager


