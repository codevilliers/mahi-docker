#!/bin/bash

# Enter the NGINX Docker folder
cd nginx/

# Build the container from the NGINX folder and tag it
TIMESTAMP=$(date +"%s")

docker build \
    --tag mahi-nginx:${TIMESTAMP} \
    --tag mahi-nginx:latest \
    .
