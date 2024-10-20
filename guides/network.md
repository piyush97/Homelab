# Network Configuration

## Overview

This document provides detailed information on the network setup for Proxmox, including VLANs, subnets, and firewall rules implemented. The configuration is defined in the `/etc/network/interfaces` file.

## Table of Contents

1. [Network Interfaces](#network-interfaces)
2. [VLANs](#vlans)
3. [Subnets](#subnets)
4. [Firewall Rules](#firewall-rules)
5. [Troubleshooting](#troubleshooting)

## Network Interfaces

### Loopback Interface

The loopback interface is configured as follows:

```conf
auto lo
iface lo inet loopback
```

### Ethernet Interfaces

The Ethernet interfaces are configured as follows:

```conf
iface enp85s0 inet manual
iface wlo1 inet manual
```

### 2.5G Ethernet Port

The 2.5G Ethernet port is configured as follows:

```conf
auto enp86s0
iface enp86s0 inet manual
```

### Bridge Interface (vmbr0)

The bridge interface `vmbr0` is configured to manage the network traffic and is VLAN-aware:

```conf
auto vmbr0
iface vmbr0 inet static
    address 192.168.0.2/24
    gateway 192.168.0.1
    bridge-ports enp86s0
    bridge-stp off
    bridge-fd 0
    bridge-vlan-aware yes
    bridge-vids 2-4094
```

## VLANs

The bridge interface `vmbr0` is configured to be VLAN-aware, allowing VLAN IDs from 2 to 4094. This setup enables the segmentation of network traffic for different purposes.

## Subnets

The static IP address `192.168.0.2/24` is assigned to the bridge interface `vmbr0`, with a gateway set to `192.168.0.1`. This configuration places the Proxmox server in the `192.168.0.0/24` subnet.

## Firewall Rules

Firewall rules can be managed within the Proxmox web interface or by editing the relevant configuration files in the `/etc/pve/firewall/` directory. These rules help secure the network by controlling the traffic flow to and from the Proxmox server.

## Troubleshooting

### Network Issues

- Ensure that the network cables are properly connected.
- Verify the network configuration in the Proxmox web interface.
- Check the status of network interfaces using the `ip a` command.

### VLAN Issues

- Ensure that the VLAN IDs are correctly configured on both the Proxmox server and the network switch.
- Verify that the bridge interface is VLAN-aware.

### Firewall Issues

- Review the firewall rules in the Proxmox web interface or the `/etc/pve/firewall/` directory.
- Ensure that the rules are correctly applied and do not block necessary traffic.

For more detailed troubleshooting steps, refer to the Proxmox VE documentation.

Thank you for following this guide. If you have any questions or need further assistance, feel free to reach out!
