#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

docker run \
    -v ${DIR}/../frontend:/app \
    -w /app \
    node:4.1 \
    npm ${@}
