# 🦞 Ai-cloawed

**AI Secretary** — ผู้ช่วย AI ส่วนตัวที่รันบนเครื่องของคุณ ใช้ [OpenClaw](https://openclaw.ai) เป็น gateway เชื่อมต่อ AI model ทั้ง Cloud (Google Gemini) และ Local (Ollama)

## ✨ Features

- 💬 Chat กับ AI ผ่าน Web Dashboard
- 📁 อ่าน/เขียนไฟล์ในเครื่อง
- 🖥️ รันคำสั่ง Terminal
- 🌐 ค้นหาข้อมูลบนเว็บ (ต้องตั้งค่า Brave API)
- 🐳 รองรับ Docker

## 🚀 Quick Start

### วิธีที่ 1: Setup อัตโนมัติ (แนะนำ)

```bash
# 1. Clone repo
git clone https://github.com/Pathapongoo11/Ai-cloawed.git
cd Ai-cloawed

# 2. ตั้งค่า API Key
cp .env.example .env
# แก้ไฟล์ .env ใส่ Gemini API Key ของคุณ
# สมัครฟรีที่: https://aistudio.google.com/apikey

# 3. รัน setup
bash setup.sh

# 4. เริ่มใช้งาน
openclaw gateway
```

เปิด browser ไปที่: **http://127.0.0.1:18789**

### วิธีที่ 2: Docker

```bash
# 1. Clone repo
git clone https://github.com/Pathapongoo11/Ai-cloawed.git
cd Ai-cloawed

# 2. ตั้งค่า API Key
cp .env.example .env
# แก้ไฟล์ .env ใส่ Gemini API Key

# 3. รัน
docker compose up -d
```

เปิด browser ไปที่: **http://127.0.0.1:18789**

### วิธีที่ 3: Manual Setup

```bash
# 1. ติดตั้ง OpenClaw
curl -fsSL https://openclaw.ai/install.sh | bash

# 2. Copy config
cp openclaw.example.json ~/.openclaw/openclaw.json

# 3. แก้ไข config ใส่ API Key
nano ~/.openclaw/openclaw.json
# เปลี่ยน ${GEMINI_API_KEY} เป็น key จริงของคุณ

# 4. รัน
openclaw gateway
```

## 🔑 API Keys ที่ต้องใช้

| Service | จำเป็น | Free Tier | สมัครที่ |
|---------|--------|-----------|---------|
| Google Gemini | ✅ ใช่ | 15 req/min, 1500 req/day | [aistudio.google.com](https://aistudio.google.com/apikey) |
| Brave Search | ❌ ไม่จำเป็น | 2,000 queries/month | [brave.com/search/api](https://brave.com/search/api/) |

## 🤖 รองรับ AI Models

### Cloud (เร็ว, ต้องมี API Key)
- **Google Gemini 2.5 Flash** — แนะนำ, ฟรี, เร็ว

### Local (ช้ากว่า, ไม่ต้องมี API Key)
- **Ollama + qwen2.5:3b** — รันในเครื่อง 100%, ต้องมี RAM >= 8GB

ดูวิธีเปลี่ยน model ใน `openclaw.example.json`

## 📁 โครงสร้างโปรเจกต์

```
Ai-cloawed/
├── openclaw.example.json  # Config template (ไม่มี API key)
├── .env.example            # ตัวอย่าง environment variables
├── setup.sh                # สคริปต์ตั้งค่าอัตโนมัติ
├── Dockerfile              # สำหรับรันผ่าน Docker
├── docker-compose.yml      # Docker Compose config
├── docker-entrypoint.sh    # Docker startup script
├── package.json
└── README.md
```

## ⚠️ หมายเหตุ

- **อย่า commit ไฟล์ `.env` หรือ `openclaw.json`** ที่มี API key จริง
- ไฟล์ `.gitignore` ถูกตั้งค่าไว้แล้วเพื่อป้องกันเรื่องนี้
- ถ้าใช้ Ollama บน Intel Mac อาจช้าเพราะไม่มี GPU acceleration

## 📝 License

ISC
