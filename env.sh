#!/bin/bash

docker rm -f `docker ps -aq -f name=wobbly-django*`
set -a
source .env
cat ${COMPOSE_CONFIG} | envsubst | docker-compose up --build --abort-on-container-exit