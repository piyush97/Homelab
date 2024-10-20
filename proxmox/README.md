# Proxmox Configuration

This directory contains configuration files for Proxmox, a powerful open-source server virtualization management solution. Below is an overview of the directory structure and the purpose of each subdirectory and file.

## Directory Structure

### `etc/`

Contains various configuration files for Proxmox.

#### `modules-load.d/`

Contains module load configurations.

- **modules.conf**: Configuration file specifying which kernel modules to load at boot.

#### `network/`

Contains network configuration files.

- **interfaces**: Configuration file for network interfaces.

#### `pve/`

Contains Proxmox VE (Virtual Environment) specific configurations.

- **.version**: File containing the version information of Proxmox VE.
- **.vmlist**: File listing all virtual machines managed by Proxmox VE.
- **lxc/**: Contains configuration files for LXC (Linux Containers).
  - **100.conf**: Configuration file for LXC container with ID 100.
- **storage.cfg**: Configuration file for storage settings in Proxmox VE.

### `filelist.txt`

A text file listing all the files in the Proxmox configuration directory.

## Purpose

The configurations in this directory are used to manage and customize the Proxmox server environment. Each subdirectory and file serves a specific purpose in the overall configuration and operation of Proxmox.

## How to Use

1. Navigate to the desired configuration directory.
2. Review and edit the configuration files as needed.
3. Apply the changes by restarting the relevant services or the entire Proxmox server if necessary.

### Example Commands

- To restart the network service after modifying the `interfaces` file:
  ```sh
  systemctl restart networking
  ```
