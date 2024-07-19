#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

echo "Starting PostgreSQL"
service postgresql start

echo "Running migrations"
rails db:migrate

echo "Running Ruby on Rails server"
rails server -b 0.0.0.0

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"