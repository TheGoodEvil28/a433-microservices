#!/bin/bash
set -euo pipefail

IMAGE_NAME="item-app"
TAG="v1"
LOCAL_IMAGE="${IMAGE_NAME}:${TAG}"

if [ -z "${DOCKER_USERNAME:-}" ]; then
  echo "Error: please export DOCKER_USERNAME"
  exit 1
fi

DOCKERHUB_IMAGE="${DOCKER_USERNAME}/${IMAGE_NAME}:${TAG}"

echo "=== Build image: ${LOCAL_IMAGE} ==="
docker build -t "${LOCAL_IMAGE}" .

echo "=== Local images (recent) ==="
docker images | head -n 20

echo "=== Tag image to Docker Hub format: ${DOCKERHUB_IMAGE} ==="
docker tag "${LOCAL_IMAGE}" "${DOCKERHUB_IMAGE}"

echo "=== Login to Docker Hub ==="
if [ -z "${PASSWORD_DOCKER_HUB:-}" ]; then
  echo "Error: please export PASSWORD_DOCKER_HUB"
  exit 1
fi
echo "${PASSWORD_DOCKER_HUB}" | docker login -u "${DOCKER_USERNAME}" --password-stdin

echo "=== Push image: ${DOCKERHUB_IMAGE} ==="
docker push "${DOCKERHUB_IMAGE}"

echo "Done. Image pushed: ${DOCKERHUB_IMAGE}"
