#!/bin/bash
set -e  # stop kalau ada error

# build image
docker build -t $DOCKER_USERNAME/karsajobs:latest .

# login ke Docker Hub
echo $PASSWORD_DOCKER_HUB | docker login -u $DOCKER_USERNAME --password-stdin

# push image
docker push $DOCKER_USERNAME/karsajobs:latest
