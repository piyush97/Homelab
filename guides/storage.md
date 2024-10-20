# Storage Configuration Guide

## Table of Contents

1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [RAID 1 Setup with ZFS](#raid-1-setup-with-zfs)
4. [Additional Storage Details](#additional-storage-details)

## Introduction

This guide provides instructions on configuring a RAID 1 setup using ZFS, along with additional storage-related details.

## Prerequisites

- Two or more identical hard drives
- A system with ZFS installed
- Basic knowledge of command-line operations

## RAID 1 Setup with ZFS

### Step 1: Install ZFS

Ensure ZFS is installed on your system. For example, on Ubuntu:

```sh
sudo apt update
sudo apt install zfsutils-linux
```

### Step 2: Identify Your Drives

List all available drives:

```sh
sudo fdisk -l
```

Identify the drives you want to use for the RAID 1 setup (e.g., `/dev/sda` and `/dev/sdb`).

### Step 3: Create the ZFS Pool

Create a mirrored ZFS pool:

```sh
sudo zpool create mypool mirror /dev/sda /dev/sdb
```

### Step 4: Verify the Pool

Check the status of the ZFS pool:

```sh
sudo zpool status
```

## Additional Storage Details

### Mounting the ZFS Pool

Mount the ZFS pool to a directory:

```sh
sudo zfs set mountpoint=/mnt/mypool mypool
```

### Setting Up Automatic Mounting

Ensure the ZFS pool mounts automatically at boot:

```sh
sudo zfs set canmount=on mypool
```

### Monitoring and Maintenance

Regularly check the health of your ZFS pool:

```sh
sudo zpool scrub mypool
```

For more detailed information, refer to the [ZFS documentation](https://openzfs.github.io/openzfs-docs/).
