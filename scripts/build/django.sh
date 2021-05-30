#!/bin/bash

# Copy the prod-requirements file from the codebase into the Django Docker folder
cp codebase/mahi-backend/Pipfile      django/
cp codebase/mahi-backend/Pipfile.lock django/

# Set the build argument IMAGETYPE to blank
IMAGETYPE=''

# Assign a tag of prod-latest for usecases that mandate production
TAG='prod-latest'

# Enter the Django Docker folder
cd django/

# Build the container from the Django folder and tag it
TIMESTAMP=$(date +"%s")

docker build \
    --build-arg IMAGETYPE=${IMAGETYPE} \
    --tag mahi-django:${TIMESTAMP} \
    --tag mahi-django:${TAG} \
    --tag mahi-django:latest \
    .

# Remove the requirement files after they have served their purpose
rm Pipfile
rm Pipfile.lock
