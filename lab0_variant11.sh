#!/bin/bash
# Лабораторная работа №1. Вариант 11.

mkdir -p lab0
cd lab0

# Раздел 1. Создание дерева каталогов
mkdir -p claude_monet/owner_office
mkdir -p claude_monet/contracts
mkdir -p claude_monet/advertising
mkdir -p claude_monet/kitchen
mkdir -p claude_monet/chef_office
mkdir -p claude_monet/hall
mkdir -p archive

# Создание файлов с содержимым
cat > nagiev_call << 'EOF'
Нагиев позвонил Вике утром
Владелец приедет после открытия
Отчёт о расходах должен быть готов
EOF

cat > claude_monet/owner_office/owner_order << 'EOF'
Дмитрий Нагиев требует подготовить ресторан к съёмке
Виктор Петрович должен представить новое меню
Вика отвечает за порядок в зале
EOF

cat > claude_monet/owner_office/expense_plan << 'EOF'
Новая вывеска требует согласования
Реклама ресторана оплачивается владельцем
Расходы на банкет проверить отдельно
EOF

cat > claude_monet/contracts/supplier_contract << 'EOF'
Поставщик привозит продукты утром
Шеф лично проверяет качество мяса
Оплата производится после приёмки
EOF

cat > claude_monet/contracts/concert_contract << 'EOF'
Музыканты выступают в пятницу вечером
Костя готовит напитки для артистов
Вика согласует время начала программы
EOF

cat > claude_monet/advertising/promo_plan << 'EOF'
Реклама показывает кухню и главный зал
Нагиев появляется в финале рекламного ролика
Баринов отказывается повторять текст дважды
EOF

cat > claude_monet/kitchen/chef_order << 'EOF'
Приготовить фирменное блюдо к восьми часам
Сеня и Федя отвечают за горячий цех
Лёва проверяет выдачу каждого блюда
EOF

cat > claude_monet/kitchen/menu_prices << 'EOF'
Утиная ножка 850
Луковый суп 430
Мильфей 520
Стейк от шефа 1100
EOF

cat > claude_monet/chef_office/barinov_reply << 'EOF'
Баринов согласен обновить меню
Баринов не согласен сниматься в рекламе
Все решения по кухне принимает шеф
EOF

cat > claude_monet/hall/vip_guests << 'EOF'
За первым столом сидят актёры
Для Нагиева оставить место у сцены
Постоянным гостям подать десерт от Луи
EOF

# Раздел 2. Права доступа
chmod 755 claude_monet
chmod 640 claude_monet/owner_office/owner_order
chmod 750 claude_monet/contracts
chmod 640 claude_monet/contracts/concert_contract
chmod 644 claude_monet/advertising/promo_plan
chmod 640 claude_monet/kitchen/chef_order
chmod 644 claude_monet/kitchen/menu_prices
chmod 750 claude_monet/chef_office
chmod 755 claude_monet/hall
chmod 644 claude_monet/hall/vip_guests
chmod 640 nagiev_call

chmod u=rwx,g=rx,o= claude_monet/owner_office
chmod u=rw,g=r,o= claude_monet/owner_office/expense_plan
chmod u=rw,g=r,o= claude_monet/contracts/supplier_contract
chmod u=rwx,g=rx,o= claude_monet/advertising
chmod u=rwx,g=rx,o= claude_monet/kitchen
chmod u=rw,g=r,o= claude_monet/chef_office/barinov_reply
chmod u=rwx,g=rx,o= archive

# Раздел 3. Копирование, перемещение, ссылки
cp nagiev_call claude_monet/owner_office/nagiev_call_copy
cp -r claude_monet/advertising claude_monet/owner_office/advertising_backup
ln -s claude_monet/contracts/supplier_contract owner_contract
ln -s ../hall claude_monet/owner_office/hall_access
ln claude_monet/contracts/supplier_contract claude_monet/contracts/supplier_duplicate
cat claude_monet/owner_office/owner_order claude_monet/chef_office/barinov_reply > claude_monet/owner_office/meeting_notes
cat claude_monet/kitchen/chef_order >> nagiev_call
mv claude_monet/advertising/promo_plan archive/promo_final

# Раздел 4. Поиск, фильтрация, обработка данных
ls -lR | grep '^-' | grep -v 'copy' | sort -k5 -n -r | head -5

grep -rhi -e 'нагиев' -e 'баринов' claude_monet archive | grep -vi 'реклам' | sort -r | head -5

grep -rli 'поставщик' claude_monet/contracts claude_monet/owner_office | wc -l

for f in claude_monet/contracts/*; do (head -1 "$f"; tail -1 "$f"); done | grep -i -e 'поставщик' -e 'музыкант' -e 'оплат' | sort

grep -v 'согласен' claude_monet/owner_office/meeting_notes | grep -i -e 'меню' -e 'кухн' | sort -r | wc -w

ls -lR | grep '^l' | sort -k9 -r

grep -rhi 'реклам' claude_monet/owner_office/advertising_backup | grep -v 'Нагиев' | sort | wc -w

# Раздел 5. Удаление
rm claude_monet/owner_office/nagiev_call_copy
rm owner_contract
rm claude_monet/owner_office/hall_access
rm claude_monet/contracts/supplier_duplicate
rm claude_monet/hall/vip_guests
rmdir claude_monet/hall
rmdir claude_monet/advertising
rm -r claude_monet/owner_office/advertising_backup

ls -R
SCRIPT_EOF