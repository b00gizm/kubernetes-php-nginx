#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

kubectl delete -f ${DIR}/php-nginx-app.yml
