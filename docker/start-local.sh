#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

docker run \
    -d \
    --name="b00gizm-redis" \
    redis:3

docker run \
    -d \
    --name="b00gizm-php-api" \
    --link="b00gizm-redis":"redis" \
    -v ${DIR}/../php-api:/app \
    b00gizm/php-api:latest \
    php5-fpm --nodaemonize

docker run \
    -d \
    --name="b00gizm-php-nginx" \
    --link="b00gizm-php-api":"php-fpm" \
    -p 8081:80 \
    -v ${DIR}/../php-api:/app \
    b00gizm/php-api:latest \
    nginx

docker run \
    -d \
    --name="b00gizm-frontend" \
    --link="b00gizm-php-api":"todo-api" \
    -v ${DIR}/../frontend:/app \
    -e API_HOST=$(docker-machine ip dev) \
    -e API_PORT=8081 \
    -p 8080:3000 \
    b00gizm/frontend:latest \
