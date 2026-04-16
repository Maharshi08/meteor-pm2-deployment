#!/bin/bash
set -e

echo "Starting Production Deployment"

PORT=50001
APP_DIR="/home/alite-148/Task/meteor-app"
BUILD_DIR="/home/alite-148/Task/build/bundle"
SETTINGS_FILE="$APP_DIR/config/settings.production.json"

# Validate settings file exists
if [ ! -f "$SETTINGS_FILE" ]; then
  echo "ERROR: settings.production.json not found at $SETTINGS_FILE"
  exit 1
fi

# Kill old port
echo "Freeing port $PORT..."
fuser -k $PORT/tcp 2>/dev/null || true

# Build project
echo "Building Meteor app..."
cd "$APP_DIR"
meteor build ../build --directory

# Install dependencies
echo "Installing server dependencies..."
cd "$BUILD_DIR/programs/server"
npm install

# Restart PM2 cleanly
echo "Restarting PM2 process..."
pm2 stop meteor-prod 2>/dev/null || true
pm2 delete meteor-prod 2>/dev/null || true
pm2 start "$APP_DIR/ecosystem.config.js" --env production
pm2 save

# Wait for app to boot
echo "Waiting for app to start..."
sleep 5

# Health check
STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$PORT)
if [ "$STATUS" -eq 200 ]; then
  echo "Production running (HTTP $STATUS)"
else
  echo "Production failed (HTTP $STATUS)"
  pm2 logs meteor-prod --lines 20
  exit 1
fi

echo "URL: http://localhost:$PORT"