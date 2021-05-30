# Use Python from the Debian Linux project
FROM python:3.8.7-slim-buster

# Add labels for metadata
LABEL maintainer="Mrinal Kumar"

# Create a non-root user
RUN groupadd --system django && useradd --system --gid django django

# Install dependencies
RUN apt-get update \
    && apt-get install -y build-essential gcc libcairo2 libffi-dev \
        libgdk-pixbuf2.0-0 libpango-1.0-0 libpangocairo-1.0-0 poppler-utils \
        python3-cffi shared-mime-info \
    && rm -rf /var/lib/apt/lists/*

# Install pip packages
RUN pip install --upgrade pip \
    && pip install --upgrade setuptools \
    && pip install --upgrade pipenv \
    && pip install --upgrade supervisor

# Work in the root directory of the container
WORKDIR /

# Copy the file Pipfile.lock over to the container
# This command implies an image rebuild when PyPI requirements change
COPY ./Pipfile ./Pipfile
COPY ./Pipfile.lock ./Pipfile.lock

# Install dependencies from the file Pipfile.lock
RUN pipenv install --deploy --system

# Create the media files volume as a directory
RUN mkdir -p /media_files \
    && chown -R django:django /media_files \
    && chmod -R o+r /media_files

# Create the static files volume as a directory
RUN mkdir -p /static_files \
    && chown -R django:django /static_files \
    && chmod -R o+r /static_files

# Create the supervisor configuration files volume as a directory
RUN mkdir -p /supervisor.d \
    && chown -R django:django /supervisor.d \
    && chmod -R o+r /supervisor.d

# Create the web server logs volume as a directory
RUN mkdir -p /web_server_logs/supervisord_logs  \
    && mkdir -p /web_server_logs/gunicorn_logs \
    && mkdir -p /web_server_logs/server_logs \
    && chown -R django:django /web_server_logs \
    && chmod -R o+r /web_server_logs

# Change the directories into volumes
VOLUME /web_server_logs /supervisor.d /media_files /static_files
# Copy the supervisord.conf file over to the container
COPY ./supervisord.conf ./supervisord.conf

# Copy the gunicorn_config.py file over to the container
COPY ./gunicorn_config.py ./gunicorn_config.py

# Grant read rights to supervisord.conf and gunicorn_config.py
RUN chown django:django ./supervisord.conf \
    && chown django:django ./gunicorn_config.py

# Add some terminal jazz
RUN echo "PS1='docker@\$NAME:\w\$ '" >> /etc/bash.bashrc

# Enter the mahi_care directory
WORKDIR /mahi_care
