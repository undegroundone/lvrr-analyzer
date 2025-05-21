#!/bin/bash

# Установка зависимостей
pkg install -y git ruby figlet
gem install lolcat

# Создание директории и клонирование репозитория
mkdir -p ~/.lvrr-analyzer
git clone https://github.com/ваш-логин/lvrr-analyzer.git ~/.lvrr-analyzer || {
    echo "Ошибка при клонировании репозитория" | lolcat
    exit 1
}

# Создание исполняемого файла
cat > /data/data/com.termux/files/usr/bin/lvrr << 'EOL'
#!/bin/bash
# Автоматическое обновление и запуск
cd ~/.lvrr-analyzer
git pull origin main
./analyzer.sh
EOL

# Даем права на выполнение
chmod +x /data/data/com.termux/files/usr/bin/lvrr
chmod +x ~/.lvrr-analyzer/analyzer.sh

echo "Установка завершена! Теперь используйте команду 'lvrr'" | lolcat
