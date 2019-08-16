Oracle GoldenGate on Docker - For Oracle Database 19c
===============
Instructions for creating a Docker image with the Oracle Instant Client 19c and Oracle GoldenGate Microservices Edition for Oracle Database 19c.

## Contents

* [Before You Start](#before-you-start)
* [Clone This Git Repository](#clone-this-git-repository)
* [Create a Base Docker Image for Oracle Instant Client 19c](#create-a-base-docker-image-for-oracle-instant-client-19c)
* [Create the Oracle GoldenGate Docker Image for Oracle Database 19c](#create-the-oracle-goldengate-docker-image-for-oracle-database-19c)
* [Create a Docker container with Oracle GoldenGate for Oracle 19c](#create-a-docker-container-with-oracle-goldengate-for-oracle-19c)
* [Access the Oracle GoldenGate Container](#access-the-oracle-goldengate-container)
  * [Using a Web Browser](#using-a-web-browser)
  * [Using the Administration Client](#using-the-administration-client)
* [Terminating the Docker Container](#terminating-the-docker-container)
* [Known issues](#known-issues)
* [License](#license)
* [Copyright](#copyright)

## Before You Start
These instructions were tested with

- Oracle GoldenGate 19.1.0.0.1 Microservices for Oracle

To build the images, use the [dockerBuild.sh](dockerBuild.sh) script or follow the instructions for manually building an image.

**IMPORTANT:** To create images for Oracle GoldenGate on Docker, you must use Docker version 17.05.0 or later. You can check the version of Docker on your system with the `docker version` command.

**IMPORTANT:** You must download the installation binaries of Oracle GoldenGate. You only need to provide the binaries for the version you plan to install. The binaries can be downloaded from the [Oracle Technology Network](http://www.oracle.com/technetwork/middleware/goldengate/downloads/index.html). Do not uncompress the Oracle GoldenGate ZIP file. The `dockerBuild.sh` script will handle that for you. You also must have Internet connectivity when building the Docker image for the package manager to perform additional software installations.

For more information about Oracle GoldenGate please see the [Oracle GoldenGate 19.1 On-line Documentation](https://docs.oracle.com/en/middleware/goldengate/core/19.1/index.html).

## Clone This Git Repository
The contents of this Git repository must be cloned to your local environment. Use these commands:

    git clone -b Oracle19c https://github.com/sbalousek/docker-images.git
    cd ./docker-images/OracleGoldenGate/

## Create a Base Docker Image for Oracle Instant Client 19c
Use these commands to create the base Docker image that contains Oracle Instant Client 19.

    cd ./OracleInstantClient/dockerfiles/19
    docker build --pull -t oracle/instantclient:19 .
    cd -

## Create the Oracle GoldenGate Docker Image for Oracle Database 19c
The Oracle GoldenGate Docker image is created from the Oracle Instant Client 19 Docker image created in the previous step with the following command.

    BASE_IMAGE="oracle/instantclient:19" ./dockerBuild.sh \
        ~/Downloads/191001_fbo_ggs_Linux_x64_services_shiphome.zip 19c \
        --tag oracle/goldengate-microservices:19.1.0.0.1-19c

## Create a Docker container with Oracle GoldenGate for Oracle 19c
Start a new Oracle GoldenGate container with the following command. The container will run in the background.

    docker run \
        --detach \
        --name ogg-19c \
        --env OGG_ADMIN_PWD=oggadmin-A1 \
        --env PORT_BASE=19000 -p 19000-19005:19000-19005 \
        oracle/goldengate-microservices:19.1.0.0.1-19c

## Access the Oracle GoldenGate Container
Services in the `ogg-19c` Oracle GoldenGate container can be accessed in several ways:

### Using a Web Browser
Connect to http://localhost:19000 with the User Name, `oggadmin`, and the password, `oggadmin-A1`.

### Using the Administration Client
Start the Administration Client with the following shell command:

    docker exec -ti ogg-19c adminclient

Then connect to the local instance with this Administration Client command:

    CONNECT http://localhost:19000 as oggadmin password oggadmin-A1

## Terminating the Docker Container
The Oracle GoldenGate Docker container is terminated with the following command.

    docker rm -f ogg-19c

## Known issues
The shared library, `libons.so`, is not included as part of the Oracle Instant Client 19 YUM distribution. It must be copied manually to the Docker image after the YUM installation of the `oracle-instantclient19.3-devel` package.  This is handled in the custom [Oracle Instant Client 19 Dockerfile](OracleInstantClient/dockerfiles/19/Dockerfile).

## License
All scripts and files hosted in this project and GitHub [docker-images/OracleGoldenGate](./) repository required to build the Docker images are, unless otherwise noted, released under the Universal Permissive License (UPL), Version 1.0.  See [LICENSE](./LICENSE) for details.

To download and run Oracle GoldenGate, regardless whether inside or outside a Docker container, you must download the binaries from the [Oracle Technology Network](http://www.oracle.com/technetwork/middleware/goldengate/downloads/index.html) and accept the license indicated at that page.

## Copyright
Copyright &copy; 2019 Oracle and/or its affiliates. All rights reserved.
