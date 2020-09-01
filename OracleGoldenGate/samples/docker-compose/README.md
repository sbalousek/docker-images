# Oracle GoldenGate on Docker

Using Oracle GoldenGate on Docker with Docker Compose.

## Contents

* [Overview](#Overview)
* [Steps](#Steps)
* [Copyright](#Copyright)

## Overview

[Docker Compose](https://docs.docker.com/compose/) is a tool for defining and
running multi-container Docker applications. This example allows you to setup
two GoldenGate Docker containers to capture transactions from an Oracle Database
and replicate them into a different target Oracle Database, potentially using
different database versions.

## Steps

1. Make sure you have Docker Compose installed.

2. Create Oracle GoldenGate Docker images for source and target database
   versions following instructions in this repository.

3. Customize the `setenv.sh` script to fit your environment:

| Environment Variable | Example Value | Description
|---|---|---
|OGG_SCHEMA|ggadmin|Database schema used by Oracle GoldenGate
|OGG_ADMIN|oggadmin|Admin user for Oracle GoldenGate login
|OGG_ADMIN_PWD|ENTER_PASSWORD_HERE|Admin password for Oracle GoldenGate login
|SOURCE_IMAGE|oracle/goldengate-microservices:oradb12|Docker image used for source deployment
|SOURCE_OGG_DEPLOYMENT|Source|Name used by source deployment
|SOURCE_HTTPS_PORT|7443|HTTPS port number for source Oracle GoldenGate Web UI and API, needs to differ from target
|SOURCE_LOCALDIR|/scratch/ogg_src|Local directory used for source deployment configuration and temporary files
|TARGET_IMAGE|oracle/goldengate-microservices:oradb19|Docker image used for target deployment
|TARGET_OGG_DEPLOYMENT|Target|Name used by target deployment
|TARGET_HTTPS_PORT|8443|HTTPS port number for target Oracle GoldenGate Web UI and API, needs to differ from source
|TARGET_LOCALDIR|/scratch/ogg_tgt|Local directory used for target deployment configuration and temporary files
|TRAILS_LOCALDIR|/scratch/ogg_src/trails|Local directory used for trail files, shared between source and target deployments

4. Set the environment by running `. ./setenv.sh`

5. Start the docker environment by running `docker-compose up`

At this point both Docker containers will get created and start. You can run
`docker-compose ps` to list running containers and their names. Use a browser to
access the GoldenGate web UI, for example
[http://localhost:7443](http://localhost:7443) to access the source
installation.

## Copyright

Copyright © 2020 Oracle and/or its affiliates.
