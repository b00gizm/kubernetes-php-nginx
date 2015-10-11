#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

kubectl create -f ${DIR}/todo-app.yml

nodePort=$(kubectl get svc todo-api -o template --template="{{(index .spec.ports 0).nodePort}}")
externalIP=$(kubectl get no -o template --template="{{(index .items 0).metadata.name}}")

echo "---"
echo "When pod(s) are ready, hit http://${externalIP}:${nodePort} in your browser!"
