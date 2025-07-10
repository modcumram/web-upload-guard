#!/bin/bash

UPLOAD_DIR="/opt/uploads"
MAX_FILES=500

TELEGRAM_BOT_TOKEN="ใส่_Token_ของคุณ"
TELEGRAM_CHAT_ID="ใส่_ChatID_ของคุณ"

send_alert() {
  local message="$1"
  curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
    -d chat_id="$TELEGRAM_CHAT_ID" \
    -d text="$message" \
    -d parse_mode="Markdown"
}

FILE_COUNT=$(find "$UPLOAD_DIR" -type f | wc -l)

if [ "$FILE_COUNT" -gt "$MAX_FILES" ]; then
  send_alert "📦 แจ้งเตือน: จำนวนไฟล์ใน *$UPLOAD_DIR* คือ *$FILE_COUNT* ไฟล์ ซึ่งเกินที่กำหนดไว้ ($MAX_FILES)"
fi
