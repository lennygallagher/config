#!/usr/bin/env bash

docker stop gui
docker rm gui

docker stop partyservice
docker rm partyservice

docker stop readparty
docker rm readparty

docker stop kafka-streams
docker rm kafka-streams
