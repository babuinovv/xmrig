#!/bin/bash

# Путь к файлу
ARCHIVE_URL="https://github.com/xmrig/xmrig/releases/download/v6.22.2/xmrig-6.22.2-linux-static-x64.tar.gz"
ARCHIVE_FILE="xmrig-6.22.2-linux-static-x64.tar.gz"
EXTRACTED_DIR="xmrig-6.22.2"

# Скачивание архива
echo "Скачиваю архив с xmrig..."
wget -q $ARCHIVE_URL

# Проверка, успешно ли скачан архив
if [[ -f "$ARCHIVE_FILE" ]]; then
    echo "Архив успешно скачан."
else
    echo "Ошибка при скачивании архива. Прекращаю выполнение."
    exit 1
fi

# Распаковка архива в текущую директорию
echo "Распаковываю архив..."
tar -xzvf $ARCHIVE_FILE

# Проверка, что распаковка прошла успешно
if [[ -d "$EXTRACTED_DIR" ]]; then
    echo "Архив успешно распакован."
else
    echo "Ошибка при распаковке архива. Прекращаю выполнение."
    exit 1
fi

# Переход в распакованную директорию
cd $EXTRACTED_DIR

# Запуск xmrig с параметрами
echo "Запускаю xmrig..."
./xmrig -o stratum+tcp://btc.kryptex.network:7777 -u bc1qzalurxmc86d6q34cq95rt5qcce2e880gakwu9r -p x --threads=$(nproc) --cpu-priority=5
