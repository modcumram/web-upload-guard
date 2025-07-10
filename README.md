# 🛡️ Web Upload Guard

Scripts & PHP utilities to protect web servers that allow file uploads.

## 🔧 Features

- ✅ ตรวจสอบไฟล์แปลกในโฟลเดอร์อัปโหลด
- ✅ ลบไฟล์ต้องสงสัย และแจ้งเตือนผ่าน Telegram
- ✅ นับจำนวนไฟล์อัปโหลด หากเกินจะเตือน
- ✅ ตรวจ MIME Type ฝั่ง PHP
- ✅ ตั้ง Cron job ทำงานอัตโนมัติ

## 📂 Scripts

| File | Description |
|------|-------------|
| `check_uploads.sh` | ลบไฟล์นามสกุลไม่อนุญาต และแจ้งเตือน |
| `count_uploads.sh` | แจ้งเตือนหากไฟล์ในโฟลเดอร์มากเกิน |
| `send_telegram.php` | ฟังก์ชัน PHP ส่งข้อความ Telegram |
| `upload_handler.php` | โค้ด PHP อัปโหลดไฟล์พร้อมตรวจ MIME |

## 🛠️ Setup

```bash
# แก้ไขค่าต่าง ๆ ในไฟล์ เช่น TOKEN, UPLOAD_DIR
chmod +x check_uploads.sh count_uploads.sh
crontab -e

# ตัวอย่าง cron:
*/10 * * * * /path/to/check_uploads.sh
