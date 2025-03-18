# MeshCentral2 Docker Image

![Works - On My Machine](https://img.shields.io/badge/Works-On_My_Machine-2ea44f)
![Project Status - Feature Complete](https://img.shields.io/badge/Project_Status-Feature_Complete-2ea44f)
[![Docker Image Version](https://img.shields.io/docker/v/jamesits/meshcentral2?label=Docker%20Hub)](http://hub.docker.com/r/jamesits/meshcentral2)

## System Requirements

* Memory: 300MiB

## Usage

### Docker Compose

```shell
cp -r example deploy

# edit your MongoDB password and MeshCentral config now in deploy/

docker-compose -f docker-compose.yml up -d
```

### Docker

You need to set up your own config and database.

```shell
docker run --name=meshcentral2 \
	--restart=unless-stopped \
	-e NODE_ENV=production \
	-p 80:80 \
	-p 443:443 \
	-p 4443:4443 \
	-it docker.io/jamesits/meshcentral2:latest
```

## Development

### Upgrading

Notes:
- Upgrades should be auto-proposed by Mend Renovate
- Always run `./sync_deps.js` since MeshCentral implements a package version check in its startup procedure
