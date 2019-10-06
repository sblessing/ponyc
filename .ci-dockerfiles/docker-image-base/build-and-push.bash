#!/bin/bash

set -o errexit
set -o nounset

#
# *** You should already be logged in to DockerHub when you run this ***
#

TODAY=$(date +%Y%m%d)
DOCKERFILE_DIR="$(dirname "$0")"
TAG="ponylang/ponyc-ci-docker-image-base:${TODAY}"

docker build -t "${TAG}" "${DOCKERFILE_DIR}"
docker push "${TAG}"
