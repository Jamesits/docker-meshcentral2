#!/bin/bash

if [[ "$1" == "node" ]]; then
	# optional initialization
	
	exec gosu node:node "$@"
fi

exec "$@"

