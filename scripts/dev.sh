#!/bin/bash
set -e

echo "Starting Meteor Development Server"

PORT=5000
APP_DIR="/home/alite-148/Task/meteor-app"
SETTINGS_FILE="$APP_DIR/config/settings.development.json"

# Validate settings file exists
if [ ! -f "$SETTINGS_FILE" ]; then
  echo "ERROR: settings.development.json not found at $SETTINGS_FILE"
  exit 1
fi

# Kill port if already used
echo "Freeing port $PORT..."
fuser -k $PORT/tcp 2>/dev/null || true

# Run Meteor dev server
echo "Starting on port $PORT..."
cd "$APP_DIR"
meteor run --port $PORT --settings "$SETTINGS_FILE"