#!/usr/bin/env bash

docker stop zk-1 && docker rm zk-1 \
  && docker stop zk-2 && docker rm zk-2 \
  && docker stop zk-3 && docker rm zk-3

docker stop kafka-1 && docker rm kafka-1 \
  && docker stop kafka-2 && docker rm kafka-2 \
  && docker stop kafka-3 && docker rm kafka-3

docker stop schema-reg-1 && docker rm schema-reg-1
