#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

docker build -t b00gizm/php-nginx ${DIR}/..
docker tag -f b00gizm/php-nginx latest
docker push b00gizm/php-nginx:latest
