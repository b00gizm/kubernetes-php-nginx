#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

docker stop b00gizm-frontend && docker rm b00gizm-frontend
docker stop b00gizm-php-nginx && docker rm b00gizm-php-nginx
docker stop b00gizm-php-api && docker rm b00gizm-php-api
docker stop b00gizm-redis && docker rm b00gizm-redis
