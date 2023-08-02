# Machines

This repository contains two folders, `mediarr` and `misc`, each with their respective `docker-compose.yml` files and a `readme` file.

## mediarr

The `mediarr` folder contains a `docker-compose.yml` file with a setup for a media server environment. It includes services for media management, torrenting, and more. Below are the details of the services:

### homarr

A service running a container with the latest version of Homarr, a media management tool. It is accessible at `http://home.lab`.

### pihole

A service running a container with Pi-hole, a network-wide ad blocker and DNS sinkhole. It is accessible at `http://pihole.lab`.

### tautulli

A service running a container with Tautulli, a monitoring and tracking tool for Plex media server. It is accessible at `http://tautulli.lab`.

### qbit-autobrr

A service running a container with qBittorrent, a BitTorrent client, with AutoBRR for ratio automation and seeding. It is accessible at `http://qbit-autobrr.lab`.

### qbittorrent

A service running a container with qBittorrent. It is accessible at `http://qbit.lab`.

### watchtower

A container running Watchtower, which automatically updates other containers to their latest available image versions.

### reverse-proxy

A container running Traefik as a reverse proxy. It enables access to the services using the specified hostnames in each service's configuration. It listens on ports 80 (HTTP) and 8081 (Traefik API).

## misc

The `misc` folder contains another `docker-compose.yml` file with a different set of services. Below are the details of the services:

### homarr

A service running a container with the latest version of Homarr, a media management tool. It is accessible at `http://home.lab`.

### pihole

A service running a container with Pi-hole, a network-wide ad blocker and DNS sinkhole. It is accessible at `http://pihole.lab`.

### tautulli

A service running a container with Tautulli, a monitoring and tracking tool for Plex media server. It is accessible at `http://tautulli.lab`.

### qbit-autobrr

A service running a container with qBittorrent, a BitTorrent client, with AutoBRR for ratio automation and seeding. It is accessible at `http://qbit-autobrr.lab`.

### qbittorrent

A service running a container with qBittorrent. It is accessible at `http://qbit.lab`.

### watchtower

A container running Watchtower, which automatically updates other containers to their latest available image versions.

### reverse-proxy

A container running Traefik as a reverse proxy. It enables access to the services using the specified hostnames in each service's configuration. It listens on ports 80 (HTTP) and 8081 (Traefik API).

Please refer to the respective `docker-compose.yml` files and readmes in each folder for more specific information about each setup.

Feel free to explore, customize, and utilize the services based on your needs and preferences. Happy home server setup! 🚀
