# SWAG Reverse Proxy Configuration

This directory contains a complete SWAG (LinuxServer.io nginx) reverse proxy setup for the homelab with 37+ pre-configured services.

## Overview

SWAG (Secure Web Application Gateway) is a nginx-based reverse proxy with:

- Automatic SSL certificate generation via Let's Encrypt
- Built-in fail2ban for security
- CloudFlare DNS validation support
- Pre-configured subdomain configs for all homelab services

## Directory Structure

```
SWAG-reverse-proxy/
├── swag-configs/              # Auto-generated subdomain configs (37+ services)
│   ├── vault.subdomain.conf   # Vaultwarden configuration
│   ├── photos.subdomain.conf  # Immich photo service
│   ├── plex.subdomain.conf    # Plex media server
│   └── ...                    # All other services
├── docker-compose.yml         # SWAG deployment configuration
├── cloudflare.ini.template    # CloudFlare credentials template
├── fix-swag-configs.sh        # Configuration fix script
├── cleanup-swag-configs.sh    # Configuration cleanup utility
└── README.md                  # This file
```

## Quick Deployment

### 1. Prerequisites

- Docker and Docker Compose installed
- CloudFlare account with API token
- Domain name managed by CloudFlare

### 2. Setup CloudFlare Credentials

```bash
# Copy the template
cp cloudflare.ini.template cloudflare.ini

# Edit with your credentials
nano cloudflare.ini
```

Add your CloudFlare API token:

```ini
dns_cloudflare_api_token = YOUR_CLOUDFLARE_API_TOKEN_HERE
```

### 3. Deploy SWAG

```bash
# Start SWAG with fail2ban
docker-compose up -d

# Check logs
docker-compose logs -f swag
```

### 4. Verify Configuration

```bash
# Check nginx configuration syntax
docker exec swag nginx -t

# Reload nginx after any config changes
docker exec swag nginx -s reload
```

## Configuration Details

### Service Configuration Format

Each service follows this standard SWAG subdomain format:

```nginx
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    http2 on;

    server_name service.piyushmehta.com;

    include /config/nginx/ssl.conf;

    client_max_body_size 0;

    # Security headers
    add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload" always;
    add_header X-Frame-Options SAMEORIGIN always;
    add_header X-Content-Type-Options nosniff always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;

    location / {
        include /config/nginx/proxy.conf;
        include /config/nginx/resolver.conf;

        set $upstream_app 192.168.0.xxx;
        set $upstream_port xxxx;
        set $upstream_proto http;

        proxy_pass $upstream_proto://$upstream_app:$upstream_port;

        # WebSocket support
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
    }
}
```

### Configured Services (37+)

**Media & Entertainment:**

- `vault.piyushmehta.com` → Vaultwarden (192.168.0.248:8000)
- `photos.piyushmehta.com` → Immich (192.168.0.4:2283)
- `plex.piyushmehta.com` → Plex Media Server (192.168.0.4:32400)
- `jellyfin.piyushmehta.com` → Jellyfin (192.168.0.4:8096)

**Automation & Downloads:**

- `request.piyushmehta.com` → Overseerr (192.168.0.120:5055)
- `qbit.piyushmehta.com` → qBittorrent (192.168.0.107:6969)
- `sonarr.piyushmehta.com` → Sonarr (192.168.0.120:8989)
- `radarr.piyushmehta.com` → Radarr (192.168.0.120:7878)

**Development & AI:**

- `a1111.piyushmehta.com` → Stable Diffusion WebUI (192.168.0.124:8090)
- `ollama.piyushmehta.com` → Ollama AI (192.168.0.124:11434)
- `git.piyushmehta.com` → Gitea (192.168.0.151:3000)

**And many more...** (see individual .subdomain.conf files for complete list)

## Security Features

### Automatic SSL

- Let's Encrypt certificates via CloudFlare DNS validation
- Automatic certificate renewal
- HTTP to HTTPS redirection

### Security Headers

- HSTS (HTTP Strict Transport Security)
- X-Frame-Options protection
- Content type sniffing protection
- XSS protection
- Referrer policy

### Fail2Ban Integration

- Automatic IP blocking for failed login attempts
- Protection against brute force attacks
- Customizable ban rules

## Troubleshooting

### Common Issues

1. **nginx syntax errors:**

   ```bash
   ./fix-swag-configs.sh
   ```

2. **Certificate generation failures:**

   - Check CloudFlare API token permissions
   - Verify domain DNS settings
   - Check SWAG logs: `docker-compose logs swag`

3. **Service not accessible:**
   - Verify backend service is running
   - Check IP addresses and ports in config
   - Test backend connectivity: `curl http://192.168.0.xxx:port`

### Useful Commands

```bash
# Test nginx configuration
docker exec swag nginx -t

# Reload nginx configuration
docker exec swag nginx -s reload

# View certificate status
docker exec swag certbot certificates

# Force certificate renewal
docker exec swag certbot renew --force-renewal

# Check fail2ban status
docker exec fail2ban fail2ban-client status

# View blocked IPs
docker exec fail2ban fail2ban-client status nginx-http-auth
```

## Monitoring

### Health Checks

- Built-in Docker health checks
- nginx configuration validation
- SSL certificate monitoring

### Logs

- Access logs: `/opt/swag/log/nginx/access.log`
- Error logs: `/opt/swag/log/nginx/error.log`
- fail2ban logs: `/opt/fail2ban/log/fail2ban.log`

## Migration from NPMplus

1. **Stop NPMplus:**

   ```bash
   docker-compose down
   ```

2. **Update DNS (if needed):**

   - Ensure all subdomains point to your server
   - Update any hardcoded IP references

3. **Deploy SWAG:**

   ```bash
   cd SWAG-reverse-proxy
   docker-compose up -d
   ```

4. **Verify services:**
   - Test each service URL
   - Check SSL certificates
   - Verify WebSocket functionality where needed

## Customization

### Adding New Services

1. Create a new subdomain config:

   ```bash
   cp swag-configs/template.subdomain.conf swag-configs/newservice.subdomain.conf
   ```

2. Edit the configuration:

   - Update server_name
   - Set correct upstream_app and upstream_port
   - Add any service-specific settings

3. Reload nginx:
   ```bash
   docker exec swag nginx -s reload
   ```

### Modifying Existing Services

1. Edit the relevant `.subdomain.conf` file
2. Test configuration: `docker exec swag nginx -t`
3. Reload: `docker exec swag nginx -s reload`

## Performance Optimization

- Uses HTTP/2 for improved performance
- Optimized nginx worker settings
- Efficient SSL configuration
- Connection reuse and keep-alive settings

## Backup Recommendations

- Backup `/opt/swag` directory (contains certificates and logs)
- Version control your `swag-configs/` directory
- Document any custom modifications

## Support

For issues with:

- **SWAG container:** [LinuxServer.io SWAG Documentation](https://docs.linuxserver.io/images/docker-swag)
- **nginx configuration:** [nginx Documentation](https://nginx.org/en/docs/)
- **Let's Encrypt:** [Certbot Documentation](https://certbot.eff.org/)
- **fail2ban:** [fail2ban Documentation](https://www.fail2ban.org/)
