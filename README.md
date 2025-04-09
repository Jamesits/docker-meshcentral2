# MeshCentral2 Docker Image

![Works - On My Machine](https://img.shields.io/badge/Works-On_My_Machine-2ea44f)
![Project Status - Feature Complete](https://img.shields.io/badge/Project_Status-Feature_Complete-2ea44f)
[![Docker Image Version](https://img.shields.io/docker/v/jamesits/meshcentral2?label=Docker%20Hub)](http://hub.docker.com/r/jamesits/meshcentral2)

## System Requirements

* Memory: 300MiB

## Usage

### Docker Compose

Example with FerretDB or MongoDB has been provided.

```shell
cd contrib/docker-compose-ferretdb
cp -r example deployment

# edit your passwords in deployment/*.env
docker compose up -d
```

Notes:

- The FerretDB bundled DocumentDB can use database `postgres` only by default. If you want to use other database names, you need to edit the PostgreSQL configuration.

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

Upgrades should be auto-proposed by Mend Renovate.

Run:

```shell
pnpm install --frozen-lockfile
./sync_deps.js
```

before merging.
