<?php
require_once 'send_telegram.php';

$allowedExtensions = ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'txt'];
$allowedMimes = [
    'application/pdf',
    'application/msword',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'application/vnd.ms-excel',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    'application/vnd.ms-powerpoint',
    'application/vnd.openxmlformats-officedocument.presentationml.presentation',
    'text/plain'
];

// ใส่ข้อมูลของ Telegram bot
$telegramToken = 'ใส่_BOT_TOKEN';
$telegramChatId = 'ใส่_CHAT_ID';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['file'])) {
    $file = $_FILES['file'];
    $ext = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
    $tmpPath = $file['tmp_name'];

    $finfo = finfo_open(FILEINFO_MIME_TYPE);
    $mime = finfo_file($finfo, $tmpPath);
    finfo_close($finfo);

    if (in_array($ext, $allowedExtensions) && in_array($mime, $allowedMimes)) {
        $newName = uniqid() . '.' . $ext;
        $uploadPath = '/opt/uploads/' . $newName;
        if (move_uploaded_file($tmpPath, $uploadPath)) {
            echo "✅ Upload success";
        } else {
            echo "❌ Failed to save file";
        }
    } else {
        echo "⛔ ไม่อนุญาตให้อัปโหลดไฟล์นี้";
        sendTelegramMessage($telegramToken, $telegramChatId, "🚨 ตรวจพบความพยายามอัปโหลดไฟล์ต้องห้าม\nMIME: `$mime`\nExtension: `$ext`\nIP: {$_SERVER['REMOTE_ADDR']}");
    }
}
?>
