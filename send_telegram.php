<?php
function sendTelegramMessage($token, $chatId, $message) {
    $url = "https://api.telegram.org/bot{$token}/sendMessage";

    $data = [
        'chat_id' => $chatId,
        'text' => $message,
        'parse_mode' => 'Markdown'
    ];

    $ch = curl_init();
    curl_setopt_array($ch, [
        CURLOPT_URL => $url,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => $data,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT => 10
    ]);

    $result = curl_exec($ch);
    if (curl_errno($ch)) {
        error_log('Telegram Error: ' . curl_error($ch));
    }
    curl_close($ch);
}
?>
