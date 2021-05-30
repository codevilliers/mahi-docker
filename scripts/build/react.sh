#!/bin/bash

# Copy the package-lock.json file from the codebase into the React Docker folder
cp codebase/mahi-frontend/package.json react/
cp codebase/mahi-frontend/package-lock.json react/

# Set the build argument IMAGETYPE to --prod
IMAGETYPE='--prod'

# Assign a tag of prod-latest for usecases that mandate production
TAG='prod-latest'

# Enter the React Docker folder
cd react/

# Build the container from the React folder and tag it
TIMESTAMP=$(date +"%s")

docker build \
    --build-arg IMAGETYPE=${IMAGETYPE} \
    --tag mahi-react:${TIMESTAMP} \
    --tag mahi-react:${TAG} \
    --tag mahi-react:latest \
    .
    
rm package.json
rm package-lock.json
