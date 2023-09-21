#!/bin/bash

# Define the name of your Docker container
CONTAINER_NAME="bucardo-container"
BUCARDO_DIRECTORY=/sarsabad-cron/bucardo


echo $BUCARDO_DIRECTORY
log_timestamp() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") $1"
}

# Check if the container is running
if ! docker ps --format "{{.Names}}" | grep -q "$CONTAINER_NAME"; then
    log_timestamp "Container $CONTAINER_NAME is not running. Starting it..."
    sh $BUCARDO_DIRECTORY/run.sh
else
    log_timestamp "Container $CONTAINER_NAME is already running."
fi