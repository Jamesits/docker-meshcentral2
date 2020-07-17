#!/bin/bash

function dc() {
	docker-compose -f docker-compose.yml "$@"
}

cd "$( dirname "${BASH_SOURCE[0]}" )"

mkdir -p deploy
cp -r example/* deploy/

dc rm -f -v
dc build
dc up

