#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

docker run \
    -d \
    --name="b00gizm-php-fpm" \
    -p 9000:9000 \
    -v ${DIR}/../app:/app \
    b00gizm/php-nginx:latest \
    php5-fpm --nodaemonize

docker run \
    -d \
    --name="b00gizm-php-nginx" \
    --link="b00gizm-php-fpm":"php-fpm-svc" \
    -p 8080:80 \
    -v ${DIR}/../app:/app \
    b00gizm/php-nginx:latest \
    nginx
