# Use Node from the Debian Linux project
FROM node:buster-slim

# Add labels for metadata
LABEL maintainer="Mrinal Kumar"

# Create a non-root user
RUN groupadd --system react && useradd --system --gid react react

# Work in the root directory of the container
WORKDIR /

# Copy the package-lock file over to the container
# This command implies an image rebuild when npm dependencies change
COPY ./package.json ./package.json
COPY ./yarn.lock ./yarn.lock

# Install dependenices from the file package.lock
RUN yarn install

# Add some terminal jazz
RUN echo "PS1='docker@\$NAME:\w\$ '" >> /etc/bash.bashrc

# Enter the frontend directory
WORKDIR /mahi_care
