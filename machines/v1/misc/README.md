# Readme for Docker Compose Setup

This `docker-compose.yml` file sets up multiple services using Docker containers and Traefik as a reverse proxy. The services included are:

1. **homarr**: A container running a service called "homarr" accessible at `http://home.lab:7575`. The container uses volumes to store configurations and icons.

2. **pihole**: A container running Pi-hole, a network-wide ad blocker accessible at `http://pihole.lab`. It is set up to use ports 54, 56, and 89 for DNS and web interface access, respectively. The container uses volumes to persist data between upgrades.

3. **tautulli**: A container running Tautulli, a monitoring and tracking tool for Plex media server, accessible at `http://tautulli.lab:8181`. It uses a volume to store its configuration.

4. **qbit-autobrr**: A container running qBittorrent with AutoBRR, a BitTorrent client with automated post-processing. It is accessible at `http://qbit-autobrr.lab:8082` and uses volumes for configuration and downloaded files.

5. **qbittorrent**: A container running qBittorrent, a BitTorrent client accessible at `http://qbit.lab:8080`. Similar to the previous qBittorrent setup, it uses volumes for configuration and downloaded files.

6. **watchtower**: A container running Watchtower, a tool that automatically updates other containers to their latest available image versions.

7. **reverse-proxy**: A container running Traefik, acting as a reverse proxy. It enables access to the services using labels defined in each service's configuration. It listens on ports 80 and 8081 for HTTP and API traffic, respectively.

## Instructions

1. Make sure you have Docker and Docker Compose installed on your system.

2. Create the necessary directories to store configuration and downloaded files. For example, create directories `./homarr/configs`, `./homarr/icons`, `./etc-pihole`, `./etc-dnsmasq.d`, `/appdata/tautulli`, `/appdata/qbit2/config`, `/media/hdd2`, `/appdata/qbit/config`, and `/media/media-for-home`.

3. Update the `traefik.toml` file with appropriate configurations for Traefik if needed. This file should be placed in `/root/traefik.toml`.

4. Modify the environment variables of each service as per your requirements. For example, you can change the timezone (`TZ`), the web interface password for Pi-hole (`WEBPASSWORD`), and other environment variables specific to each service.

5. Once the necessary configurations are in place, run the following command in the same directory as the `docker-compose.yml` file:

```bash
docker-compose up -d
```

This will start all the defined services in detached mode, meaning they will run in the background.

6. Access the services using the URLs mentioned above:

   - `http://home.lab:7575`: Homarr service
   - `http://pihole.lab`: Pi-hole web interface
   - `http://tautulli.lab:8181`: Tautulli monitoring tool
   - `http://qbit-autobrr.lab:8082`: qBittorrent with AutoBRR
   - `http://qbit.lab:8080`: qBittorrent

7. To update the containers to their latest versions, run the following command:

```bash
docker-compose up -d --no-deps --build watchtower
```

This will instruct Watchtower to check for and update newer versions of the containers.

Remember to ensure that your server's firewall and network configurations allow access to the necessary ports from external devices or networks.

**Note:** This readme assumes that the host machine has appropriate DNS and networking configurations set up to access the services using the specified hostnames (`home.lab`, `pihole.lab`, `tautulli.lab`, `qbit-autobrr.lab`, and `qbit.lab`). If necessary, you can update your local DNS resolver or hosts file to resolve these hostnames to the IP address of your server.
