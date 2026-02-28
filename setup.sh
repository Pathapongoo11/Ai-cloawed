#!/bin/bash
# ===================================
# Ai-cloawed Setup Script
# ===================================
# ตั้งค่า OpenClaw AI Secretary อัตโนมัติ
# Usage: bash setup.sh

set -e

echo "🦞 Ai-cloawed Setup"
echo "===================="

# --- 1. Check .env ---
if [ ! -f .env ]; then
  echo ""
  echo "⚠️  ไม่พบไฟล์ .env"
  echo "   กรุณา copy .env.example แล้วใส่ API key ของคุณ:"
  echo ""
  echo "   cp .env.example .env"
  echo "   nano .env"
  echo ""
  exit 1
fi

# Load .env
source .env

if [ -z "$GEMINI_API_KEY" ] || [ "$GEMINI_API_KEY" = "your_gemini_api_key_here" ]; then
  echo "❌ กรุณาใส่ GEMINI_API_KEY ใน .env ก่อน"
  echo "   สมัครฟรีที่: https://aistudio.google.com/apikey"
  exit 1
fi

echo "✅ .env loaded"

# --- 2. Install OpenClaw ---
if ! command -v openclaw &> /dev/null; then
  echo "📦 Installing OpenClaw..."
  curl -fsSL https://openclaw.ai/install.sh | bash
else
  echo "✅ OpenClaw already installed"
fi

# --- 3. Setup config ---
OPENCLAW_DIR="$HOME/.openclaw"
mkdir -p "$OPENCLAW_DIR"

if [ -f "$OPENCLAW_DIR/openclaw.json" ]; then
  echo "⚠️  พบ openclaw.json เดิมอยู่แล้ว — สำรองเป็น openclaw.json.bak"
  cp "$OPENCLAW_DIR/openclaw.json" "$OPENCLAW_DIR/openclaw.json.bak"
fi

# Copy template and replace API key
sed "s/\${GEMINI_API_KEY}/$GEMINI_API_KEY/g" openclaw.example.json > "$OPENCLAW_DIR/openclaw.json"

echo "✅ Config saved to $OPENCLAW_DIR/openclaw.json"

# --- 4. Install Ollama (optional) ---
echo ""
read -p "🤖 ต้องการติดตั้ง Ollama สำหรับรัน AI local ด้วยมั้ย? (y/n): " INSTALL_OLLAMA

if [ "$INSTALL_OLLAMA" = "y" ] || [ "$INSTALL_OLLAMA" = "Y" ]; then
  if ! command -v ollama &> /dev/null; then
    echo "📦 Installing Ollama..."
    curl -fsSL https://ollama.com/install.sh | bash
  fi
  echo "📥 Pulling qwen2.5:3b model..."
  ollama pull qwen2.5:3b
  echo "✅ Ollama + qwen2.5:3b installed"
fi

# --- 5. Done ---
echo ""
echo "========================================="
echo "🎉 Setup เสร็จสมบูรณ์!"
echo "========================================="
echo ""
echo "เริ่มใช้งาน:"
echo "  openclaw gateway"
echo ""
echo "แล้วเปิด browser ไปที่:"
echo "  http://127.0.0.1:18789"
echo ""
