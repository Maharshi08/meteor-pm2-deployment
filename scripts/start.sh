#!/bin/bash

echo " Starting Meteor App Setup..."

# Kill port 5000
echo " Freeing port 5000..."
fuser -k 5000/tcp 2>/dev/null

# Stop and delete old PM2 process
echo " Stopping old PM2 process..."
pm2 stop meteor-app 2>/dev/null
pm2 delete meteor-app 2>/dev/null

# Start app with PM2
echo " Starting Meteor app with PM2..."
pm2 start ecosystem.config.js

# Save PM2 process
pm2 save

# Wait for app to start
echo " Waiting for app to initialize..."
sleep 5

# Health Check
echo " Running health check..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:5000)

if [ "$STATUS" -eq 200 ]; then
  echo " App is healthy (HTTP $STATUS)"
else
  echo " App health check failed (HTTP $STATUS)"
fi

# Logs Check (last 10 lines)
echo " Showing latest logs..."
pm2 logs meteor-app --lines 10

echo " Deployment complete: http://localhost:5000"
