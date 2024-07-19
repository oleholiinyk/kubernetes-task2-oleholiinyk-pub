#!/bin/bash

echo "Starting PostgreSQL"
service postgresql start

echo "Running migrations"
rails db:migrate

echo "Running Ruby on Rails server"
rails server -b 0.0.0.0