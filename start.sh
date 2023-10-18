#!/bin/sh

set -e

echo "run db migrations"
source /app/app.env
echo "$DB_SOURCE"
/app/migrate -path /app/migrations -database "$DB_SOURCE" -verbose up

echo "start the app"
exec "$@"
