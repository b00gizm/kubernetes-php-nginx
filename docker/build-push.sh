#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

image=$1;

if [[ -z image ]]
then
    echo "You need to specify the image to build and push"
    exit
fi

docker build -t b00gizm/${image} ${DIR}/../${image}
docker push b00gizm/${image}:latest
