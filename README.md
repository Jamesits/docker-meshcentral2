# MeshCentral2 Docker Image

[![Build Status](https://dev.azure.com/nekomimiswitch/General/_apis/build/status/docker-meshcentral2?branchName=master)](https://dev.azure.com/nekomimiswitch/General/_build/latest?definitionId=94&branchName=master)

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
	-it jamesits/meshcentral2:latest
```

