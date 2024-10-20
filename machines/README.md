# Machines Directory

This directory contains Docker Compose configurations and related files for different services deployed on the Homelab server. Below is an overview of the directory structure and the purpose of each subdirectory.

## Directory Structure

### `v1/`

Contains the first version of service configurations.

- **adguard home/**: Configuration for AdGuard Home.
  - [AdGuardHome.yaml](v1/adguard%20home/AdGuardHome.yaml)
- **master/**: Configuration for master services.
  - [docker-compose.yaml](v1/master/docker-compose.yaml)
- **mediarr/**: Configuration for media-related services.
  - [docker-compose.yml](v1/mediarr/docker-compose.yml)
  - [README.md](v1/mediarr/README.md)
- **misc/**: Miscellaneous service configurations.
  - [docker-compose.yml](v1/misc/docker-compose.yml)
  - [README.md](v1/misc/README.md)

### `v2/`

Contains the second version of service configurations.

- **nextcloud/**: Configuration for Nextcloud.
  - [docker-compose.yaml](v2/nextcloud/docker-compose.yaml)
- **reverse-proxy/**: Configuration for reverse proxy services.
  - [docker-compose.yaml](v2/reverse-proxy/docker-compose.yaml)
- **servarr/**: Configuration for \*arr stack services.
  - [docker-compose.yaml](v2/servarr/docker-compose.yaml)

## Purpose

The configurations in this directory are used to deploy and manage various services on the Homelab server. Each subdirectory contains specific configurations for different services, allowing for easy management and deployment using Docker Compose.

## How to Use

1. Navigate to the desired service directory.
2. Review the `docker-compose.yaml` file and make any necessary adjustments.
3. Deploy the service using Docker Compose:
   ```sh
   docker-compose up -d
   ```
