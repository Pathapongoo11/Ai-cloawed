#!/bin/bash
set -e

CONFIG_DIR="/root/.openclaw"
CONFIG_FILE="$CONFIG_DIR/openclaw.json"

# Generate config from template if not exists
if [ ! -f "$CONFIG_FILE" ]; then
  echo "🔧 Generating OpenClaw config..."
  
  if [ -z "$GEMINI_API_KEY" ]; then
    echo "❌ GEMINI_API_KEY is not set!"
    echo "   Please set it in .env or pass as environment variable."
    exit 1
  fi
  
  sed "s/\${GEMINI_API_KEY}/$GEMINI_API_KEY/g" /app/openclaw.example.json > "$CONFIG_FILE"
  echo "✅ Config generated"
fi

echo "🦞 Starting OpenClaw Gateway..."
exec openclaw gateway
