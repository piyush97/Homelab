# Installation Guide

## Overview

This guide provides detailed instructions on setting up Proxmox and configuring the Intel NUC i7-1360P for optimal performance. Follow the steps below to ensure a smooth installation and configuration process.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Downloading Proxmox VE](#downloading-proxmox-ve)
3. [Creating a Bootable USB Drive](#creating-a-bootable-usb-drive)
4. [Installing Proxmox VE](#installing-proxmox-ve)
5. [Initial Configuration](#initial-configuration)
6. [Optimizing Performance](#optimizing-performance)
7. [Post-Installation Steps](#post-installation-steps)
8. [Troubleshooting](#troubleshooting)

## Prerequisites

- Intel NUC i7-1360P
- At least 16GB of RAM (64GB recommended)
- SSD or NVMe storage (2TB recommended)
- USB drive (at least 8GB)
- Stable internet connection

## Downloading Proxmox VE

1. Visit the [Proxmox VE download page](https://www.proxmox.com/en/downloads).
2. Download the latest Proxmox VE ISO image.

## Creating a Bootable USB Drive

1. Use a tool like [Rufus](https://rufus.ie/) (Windows) or `dd` (Linux/macOS) to create a bootable USB drive.
2. Select the downloaded Proxmox VE ISO image and the USB drive.
3. Start the process and wait for it to complete.

## Installing Proxmox VE

1. Insert the bootable USB drive into the Intel NUC.
2. Power on the NUC and press the appropriate key to enter the boot menu (usually F10 or F12).
3. Select the USB drive to boot from.
4. Follow the on-screen instructions to install Proxmox VE.
5. Configure the network settings and set a strong password for the root user.

## Initial Configuration

1. Access the Proxmox VE web interface by navigating to `https://<your-proxmox-ip>:8006` in your web browser.
2. Log in with the root user and the password you set during installation.
3. Update the Proxmox VE system by running the following commands in the shell:
   ```sh
   apt update && apt full-upgrade -y
   ```
4. Reboot the system if necessary.

## Optimizing Performance

1. **Enable CPU Virtualization Extensions:**
   - Ensure that Intel VT-x and VT-d are enabled in the BIOS.
2. **Configure Storage:**
   - Use ZFS for RAID 1 configuration to ensure data redundancy and performance.
   - Follow the [Proxmox ZFS guide](https://pve.proxmox.com/wiki/ZFS_on_Linux) for detailed instructions.
3. **Network Configuration:**
   - Configure a 2.5GBe LAN connection for optimal network performance.
   - Set up VLANs and subnets as needed for your network environment.
4. **Memory and CPU Allocation:**
   - Allocate sufficient memory and CPU cores to your virtual machines and containers based on their requirements.

## Post-Installation Steps

1. **Install Additional Packages:**
   - Install any additional packages or tools you need for your setup.
   - Example:
     ```sh
     apt install ifupdown2
     ```
2. **Backup Configuration:**
   - Regularly back up your Proxmox configuration and virtual machines.
   - Use the built-in backup tools or third-party solutions.

## Troubleshooting

- **Network Issues:**
  - Ensure that the network cables are properly connected.
  - Verify the network configuration in the Proxmox web interface.
- **Performance Issues:**
  - Check the resource allocation for your virtual machines and containers.
  - Monitor system performance using tools like `htop` and `iostat`.

For more detailed troubleshooting steps, refer to the [Proxmox VE documentation](https://pve.proxmox.com/wiki/Main_Page).

---

Thank you for following this guide. If you have any questions or need further assistance, feel free to reach out!
