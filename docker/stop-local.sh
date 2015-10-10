#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

docker stop b00gizm-php-nginx && docker rm b00gizm-php-nginx
docker stop b00gizm-php-fpm && docker rm b00gizm-php-fpm
