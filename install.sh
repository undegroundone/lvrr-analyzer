#!/bin/bash

REPO="undegroundone/lvrr-analyzer"
BRANCH="main"  # Или "master" если используете эту ветку
FILE_URL="https://raw.githubusercontent.com/$REPO/$BRANCH/analyzer.sh"
TARGET_DIR="$HOME/.lvrr-analyzer"
TARGET_FILE="$TARGET_DIR/analyzer.sh"

# Проверка и установка зависимостей
pkg install -y curl git ruby figlet >/dev/null 2>&1
gem install lolcat >/dev/null 2>&1

# Создаем директорию
mkdir -p "$TARGET_DIR"

# Скачиваем файл с проверкой
echo "Скачивание analyzer.sh..."
if ! curl -sL "$FILE_URL" -o "$TARGET_FILE"; then
    echo "Ошибка: Не удалось скачать analyzer.sh!"
    echo "Проверьте:"
    echo "1. Существует ли файл по адресу: $FILE_URL"
    echo "2. Доступен ли репозиторий"
    exit 1
fi

# Проверяем, что файл не является страницей 404
if grep -q "404: Not Found" "$TARGET_FILE"; then
    echo "Ошибка: Файл analyzer.sh не найден в репозитории!"
    rm -f "$TARGET_FILE"
    exit 1
fi

# Делаем файл исполняемым
chmod +x "$TARGET_FILE"

# Добавляем алиас
if ! grep -q "alias lvrr=" ~/.bashrc; then
    echo "alias lvrr='$TARGET_FILE'" >> ~/.bashrc
fi

# Обновляем оболочку
source ~/.bashrc 2>/dev/null

echo "Установка завершена успешно!"
echo "Для запуска введите команду: lvrr"
