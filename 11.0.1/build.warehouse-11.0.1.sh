#!/bin/bash

docker build . -f ${VERSION}.Dockerfile -t ${REPO}/${IMAGE}:${TAG}
docker push  ${REPO}/${IMAGE}:${TAG}
