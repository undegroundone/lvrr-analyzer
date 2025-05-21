#!/bin/bash

# Установка зависимостей
pkg install -y git ruby figlet > /dev/null 2>&1
gem install lolcat > /dev/null 2>&1

echo "Установка LVRR Analyzer..." | lolcat

# Создаем директорию
mkdir -p ~/.lvrr-analyzer

# Скачиваем сырой код напрямую (без git clone)
curl -sL https://raw.githubusercontent.com/undegroundone/lvrr-analyzer/main/analyzer.sh > ~/.lvrr-analyzer/analyzer.sh

# Делаем исполняемым
chmod +x ~/.lvrr-analyzer/analyzer.sh

# Создаем алиас для запуска
echo "alias lvrr='~/.lvrr-analyzer/analyzer.sh'" >> ~/.bashrc
source ~/.bashrc

echo "Готово! Теперь используйте команду 'lvrr'" | lolcat
