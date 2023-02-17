# rancher-backup
This repository contains a Docker container based on Alpine Linux that runs a Bash script to backup docker-compose.yml and rancher-compose.yml files every 1 hour from one or more Rancher 1.6 servers.
You can use it running:

```bash
 docker run --name rancher-backup -e RANCHER_SITE=test -e RANCHER_URL=[URL] -e RANCHER_ACCESS_KEY=[ACCESS KEY] -e RANCHER_SECRET_KEY=[SECRET KEY] -d ecardinali/rancher-backup:latest
```

## Building
To build the container, clone the repository and run the following commands:

```bash
git clone https://github.com/ezq/rancher-backup.git
cd rancher-backup
docker build -t rancher-backup .
```

## Usage
### Backup of a single Rancher site
To backup a single Rancher site, run the following command:

```bash
docker run --name rancher-backup -e RANCHER_SITE=test -e RANCHER_URL=[URL] -e RANCHER_ACCESS_KEY=[ACCESS KEY] -e RANCHER_SECRET_KEY=[SECRET KEY] -d rancher-backup
```
Make sure to replace `[URL]`, `[ACCESS KEY]`, `[SECRET KEY]`, and test with the corresponding values.

### Backup of multiple Rancher sites
To backup multiple Rancher sites, place the configuration files for each site in the `${CONFIG_PATH}/${SITENAME}/config` path, for example:

```bash
/config/test/config :

export RANCHER_URL=[URL]
export RANCHER_ACCESS_KEY=[ACCESS KEY]
export RANCHER_SECRET_KEY=[SECRET KEY]
```

Then, run the following command:

```bash
docker run --name rancher-backup -v ./config:/config -d rancher-backup
```
This way, the script that performs the backup will go through the subdirectories of `/config` and take the data from the configuration files of each site to perform the backup.

## Saving backups outside the container
To save backups outside the container, you can use a volume. To do this, run the following command:

```bash
docker run --name rancher-backup -v ./config:/config -v ./backup:/backup -e BKP_PATH=/backup -d rancher-backup
```

This way, the backups will be saved in the `./backup` path outside the container. You can set `BKP_PATH` to a directory of your choice by default its `/backup`.

That's it! If you have any suggestions or issues, please open an issue.
