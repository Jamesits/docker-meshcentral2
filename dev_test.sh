#!/bin/bash

function dc() {
	docker-compose -f docker-compose.yml "$@"
}

cd "$( dirname "${BASH_SOURCE[0]}" )"

mkdir -p dev
cp -r example/* deploy/

dc rm -f -v
dc build
dc up

