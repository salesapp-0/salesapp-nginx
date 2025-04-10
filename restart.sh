#!/bin/bash

CONTAINER_NAME="salesapp_nginx"
IMAGE_NAME="salesapp_nginx"
ACME_CHALLENGE_DIR="/root/certificates"

mkdir -p $ACME_CHALLENGE_DIR

if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping the container: $CONTAINER_NAME"
    docker stop $CONTAINER_NAME
fi

if [ "$(docker ps -a -q -f name=$CONTAINER_NAME)" ]; then
    echo "Removing the container: $CONTAINER_NAME"
    docker rm $CONTAINER_NAME
fi

if [ "$(docker images -q $IMAGE_NAME)" ]; then
    echo "Removing the image: $IMAGE_NAME"
    docker rmi $IMAGE_NAME
fi

echo "Building the image: $IMAGE_NAME"
docker build -t $IMAGE_NAME .

echo "Running the container: $CONTAINER_NAME"
docker run -d --name $CONTAINER_NAME -p 80:80 -p 443:443 \
    -v $ACME_CHALLENGE_DIR:/usr/share/nginx/html/.well-known/acme-challenge \
    $IMAGE_NAME

echo "Done!"