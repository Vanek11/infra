#!/bin/bash
set -e

# 1. Обновляем индекс пакетов
apt-get update

# 2. Устанавливаем Docker
apt-get install -y docker.io

# 3. Включаем Docker в автозапуск и сразу стартуем
systemctl enable --now docker

# 4. Создаём и запускаем контейнер MongoDB 4.4,
#    если он ещё не создан
if ! docker ps -a --format '{{.Names}}' | grep -q '^mongo$'; then
  docker run -d \
    --name mongo \
    --restart=always \
    -p 27017:27017 \
    mongo:4.4
fi

# 5. Немного логов для Packer, чтобы видеть, что всё ок
echo "=== Docker containers ==="
docker ps || true

echo "=== Listening on 27017 ==="
ss -ltnp | grep 27017 || true
