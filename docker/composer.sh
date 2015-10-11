#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

docker run \
    -v ${DIR}/../php-api:/app \
    composer/composer \
    ${@}
