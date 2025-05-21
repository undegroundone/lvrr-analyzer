#!/bin/bash

# Проверка и установка зависимостей
[ ! -f /data/data/com.termux/files/usr/bin/lolcat ] && {
    pkg install -y ruby figlet > /dev/null 2>&1
    gem install lolcat > /dev/null 2>&1
}

# Базы данных
car_db=(
    "Lada:Granta,Vesta,Niva"
    "Toyota:Camry,RAV4,Corolla"
    "Kia:Rio,Sportage,Ceed"
    "BMW:X5,X3,X6"
)

owners=(
    "Иванов Иван Иванович"
    "Петров Петр Петрович"
    "Сидоров Алексей Владимирович"
    "Кузнецова Анна Дмитриевна"
)

# Функции анализа
analyze_phone() {
    read -p "Введите номер телефона (+7...): " phone
    echo -e "\n🔍 Анализируем номер..." | lolcat
    sleep 1
    
    echo "╔════════════════════════════════════╗" | lolcat
    echo "  📱 Номер: $phone" | lolcat
    echo "  🌐 IP: $(shuf -i 0-255 -n 4 | tr '\n' '.' | sed 's/\.$//')" | lolcat
    echo "  📍 Регион: $(shuf -e "Москва" "СПб" "Казань" -n 1)" | lolcat
    echo "  🏢 Оператор: $(shuf -e "МТС" "Мегафон" "Билайн" -n 1)" | lolcat
    echo "  📅 Дата регистрации: $(date -d "-$((RANDOM%3650)) days" +'%Y-%m-%d')" | lolcat
    echo "╚════════════════════════════════════╝" | lolcat
    read -p "Нажмите Enter..."
}

analyze_ip() {
    read -p "Введите IP-адрес: " ip
    echo -e "\n🔎 Анализируем IP..." | lolcat
    sleep 1
    
    echo "╔════════════════════════════════════╗" | lolcat
    echo "  🌐 IP: $ip" | lolcat
    echo "  📍 Локация: $(shuf -e "Москва" "СПб" "Екатеринбург" -n 1)" | lolcat
    echo "  🏢 Провайдер: $(shuf -e "Ростелеком" "МТС" "Билайн" -n 1)" | lolcat
    echo "  📞 Привязанный номер: +79$(shuf -i 10000000-99999999 -n 1)" | lolcat
    echo "  🕒 Последняя активность: $(date -d "-$((RANDOM%72)) hours" +'%Y-%m-%d %H:%M')" | lolcat
    echo "╚════════════════════════════════════╝" | lolcat
    read -p "Нажмите Enter..."
}

analyze_car() {
    read -p "Введите номер машины: " car_num
    echo -e "\n🚗 Анализируем авто..." | lolcat
    sleep 1
    
    brand_data=${car_db[$RANDOM % ${#car_db[@]}]}
    brand=${brand_data%:*}
    model=$(echo ${brand_data#*:} | tr ',' '\n' | shuf -n 1)
    owner=${owners[$RANDOM % ${#owners[@]}]}
    reg_date=$(date -d "-$((RANDOM%3650)) days" +'%Y-%m-%d')
    
    echo "╔════════════════════════════════════╗" | lolcat
    echo "  🚘 Номер: $car_num" | lolcat
    echo "  🚗 Авто: $brand $model" | lolcat
    echo "  👤 Владелец: $owner" | lolcat
    echo "  📍 Регион: $(shuf -e "Москва" "СПб" "Краснодар" -n 1)" | lolcat
    echo "  📅 Дата регистрации: $reg_date" | lolcat
    echo "  📞 Контактный номер: +79$(shuf -i 10000000-99999999 -n 1)" | lolcat
    echo "╚════════════════════════════════════╝" | lolcat
    read -p "Нажмите Enter..."
}

analyze_username() {
    read -p "Введите юзернейм: " username
    echo -e "\n👤 Анализируем юзернейм..." | lolcat
    sleep 1
    
    reg_date=$(date -d "-$((RANDOM%3650)) days" +'%Y-%m-%d')
    last_active=$(date -d "-$((RANDOM%720)) hours" +'%Y-%m-%d %H:%M')
    
    echo "╔════════════════════════════════════╗" | lolcat
    echo "  👤 Юзернейм: $username" | lolcat
    echo "  📅 Дата регистрации: $reg_date" | lolcat
    echo "  🕒 Последняя активность: $last_active" | lolcat
    echo "  🌐 IP: $(shuf -i 0-255 -n 4 | tr '\n' '.' | sed 's/\.$//')" | lolcat
    echo "  📍 Локация: $(shuf -e "Москва" "СПб" "Екатеринбург" -n 1)" | lolcat
    echo "  📱 Привязанный номер: +79$(shuf -i 10000000-99999999 -n 1)" | lolcat
    echo "╚════════════════════════════════════╝" | lolcat
    read -p "Нажмите Enter..."
}

# Главное меню
while true; do
    clear
    figlet -f block "LVRR" | lolcat
    echo -e "\n1 Анализ номера\n2 Анализ IP\n3 Анализ авто\n4 Анализ юзернейма\n5 Выход" | lolcat
    
    read -p "Выберите пункт: " choice
    
    case $choice in
        1) analyze_phone ;;
        2) analyze_ip ;;
        3) analyze_car ;;
        4) analyze_username ;;
        5) echo "Выход..." | lolcat; exit 0 ;;
        *) echo "Неверный выбор!" | lolcat; sleep 1 ;;
    esac
done
