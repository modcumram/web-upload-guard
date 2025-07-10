#!/bin/bash

# ตั้งค่าพื้นฐาน
TARGET_DIR="./"
THRESHOLD=756

# Telegram Bot Token และ Chat ID
TELEGRAM_BOT_TOKEN="ใส่_Token_ของคุณที่นี่"
TELEGRAM_CHAT_ID="ใส่_ChatID_ของคุณที่นี่"

# ฟังก์ชันส่งข้อความผ่าน Telegram
send_telegram_alert() {
  local message="$1"
  curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
    -d chat_id="${TELEGRAM_CHAT_ID}" \
    -d text="$message" \
    -d parse_mode="Markdown"
}

# นับจำนวนไฟล์ทั้งหมด
FILE_COUNT=$(find "$TARGET_DIR" -type f | wc -l)

echo "จำนวนไฟล์ทั้งหมดใน '$TARGET_DIR': $FILE_COUNT"

# ตรวจสอบว่าเกินจำนวนที่กำหนดหรือไม่
if [ "$FILE_COUNT" -gt "$THRESHOLD" ]; then
  ALERT_MSG="⚠️ แจ้งเตือน: พบไฟล์จำนวน *$FILE_COUNT* ในโฟลเดอร์ *$TARGET_DIR* (เกินจาก $THRESHOLD ไฟล์)"
  send_telegram_alert "$ALERT_MSG"
fi
