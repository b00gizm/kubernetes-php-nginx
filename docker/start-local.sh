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
    --link="b00gizm-php-api":"php-api" \
    -p 8081:80 \
    -v ${DIR}/../php-api:/app \
    b00gizm/php-api:latest \
    nginx

docker run \
    -d \
    --name="b00gizm-frontend" \
    --link="b00gizm-php-api":"todo-api" \
    -p 8080:80 \
    -e API_HOST=$(docker-machine ip dev) \
    -e API_PORT=8081 \
    -v ${DIR}/../frontend/docker/nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
    -v ${DIR}/../frontend:/usr/share/nginx/html \
    -v ${DIR}/../frontend/start.sh:/usr/bin/start.sh:ro \
    nginx:1.9 \
    start.sh
