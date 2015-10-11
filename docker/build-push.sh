#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

docker build -t b00gizm/${1} ${DIR}/../${1}
docker tag -f b00gizm/${1} latest
#docker push b00gizm/php-nginx:latest
