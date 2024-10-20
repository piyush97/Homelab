# v1 Directory

This directory contains the first version of service configurations for various machines deployed on the Homelab server. Below is an overview of the directory structure and the purpose of each subdirectory.

## Directory Structure

### `adguard home/`

Contains the configuration for AdGuard Home, a network-wide software for blocking ads and tracking.

- **AdGuardHome.yaml**: Configuration file for AdGuard Home.

### `master/`

Contains the configuration for master services.

- **docker-compose.yaml**: Docker Compose file for deploying master services.

### `mediarr/`

Contains the configuration for media-related services.

- **docker-compose.yml**: Docker Compose file for deploying media-related services.
- **README.md**: Documentation for media-related services.

### `misc/`

Contains miscellaneous service configurations.

- **docker-compose.yml**: Docker Compose file for deploying miscellaneous services.
- **README.md**: Documentation for miscellaneous services.

## Purpose

The configurations in this directory are used to deploy and manage various services on the Homelab server. Each subdirectory contains specific configurations for different services, allowing for easy management and deployment using Docker Compose.

## How to Use

1. Navigate to the desired service directory.
2. Review the `docker-compose.yaml` or `AdGuardHome.yaml` file and make any necessary adjustments.
3. Deploy the service using Docker Compose:
   ```sh
   docker-compose up -d
   ```
