#!/bin/bash

if [[ "$1" == "node" ]]; then
	chown -R node:node .
	
	exec gosu node:node "$@"
fi

exec "$@"

