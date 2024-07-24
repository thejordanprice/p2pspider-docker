#!/bin/bash

# Start MongoDB
mongod --fork --logpath /var/log/mongodb.log

# Start Redis
redis-server &

# Wait for MongoDB and Redis to be ready
sleep 5

# Start the Node.js scripts
node daemon.js &
node webserver.js
