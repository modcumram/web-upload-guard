#!/bin/bash
UPLOAD_DIR="/opt/uploads"
ALLOWED_EXT="pdf|doc|docx|xls|xlsx|ppt|pptx|txt"
TELEGRAM_BOT_TOKEN="ใส่ของคุณ"
TELEGRAM_CHAT_ID="ใส่ของคุณ"

send_alert() {
  curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
    -d chat_id="${TELEGRAM_CHAT_ID}" \
    -d text="$1" \
    -d parse_mode="Markdown"
}

INVALID_FILES=$(find "$UPLOAD_DIR" -type f ! -iregex ".*\.\($ALLOWED_EXT\)")
if [ -n "$INVALID_FILES" ]; then
  for file in $INVALID_FILES; do
    rm -f "$file"
  done
  send_alert "⚠️ ตรวจพบไฟล์ต้องสงสัย:\n\n$(echo "$INVALID_FILES" | head -n 5)"
fi
