#!/bin/bash
set -e;

# a default non-root role
MONGO_NON_ROOT_ROLE="${MONGO_NON_ROOT_ROLE:-readWrite}"

if [ -n "${MONGO_NON_ROOT_USERNAME:-}" ] && [ -n "${MONGO_NON_ROOT_PASSWORD:-}" ]; then
	"${mongo[@]}" "$MONGO_INITDB_DATABASE" <<-EOJS
		db.createUser({
			user: $(_js_escape "$MONGO_NON_ROOT_USERNAME"),
			pwd: $(_js_escape "$MONGO_NON_ROOT_PASSWORD"),
			roles: [ { role: $(_js_escape "$MONGO_NON_ROOT_ROLE"), db: $(_js_escape "$MONGO_INITDB_DATABASE") } ]
		})
	EOJS
	echo "Yeah, database init script finished"
else
	echo "Sorry, database init script screwed up"
fi

