# v2 Directory

This directory contains the second version of service configurations for various machines deployed on the Homelab server. Below is an overview of the directory structure and the purpose of each subdirectory.

## Directory Structure

### `nextcloud/`

Contains the configuration for Nextcloud, a suite of client-server software for creating and using file hosting services.

- **docker-compose.yaml**: Docker Compose file for deploying Nextcloud.

### `reverse-proxy/`

Contains the configuration for reverse proxy services.

- **docker-compose.yaml**: Docker Compose file for deploying reverse proxy services.

### `servarr/`

Contains the configuration for \*arr stack services, which are used for managing media content.

- **docker-compose.yaml**: Docker Compose file for deploying \*arr stack services.

## Purpose

The configurations in this directory are used to deploy and manage various services on the Homelab server. Each subdirectory contains specific configurations for different services, allowing for easy management and deployment using Docker Compose.

## How to Use

1. Navigate to the desired service directory.
2. Review the `docker-compose.yaml` file and make any necessary adjustments.
3. Deploy the service using Docker Compose:
   ```sh
   docker-compose up -d
   ```
