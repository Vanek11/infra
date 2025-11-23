#!/bin/bash
set -e

# 1. Обновляем индекс пакетов
apt-get update

# 2. Ставим Ruby + инструменты для сборки гемов
apt-get install -y \
  ruby-full ruby-dev build-essential \
  libssl-dev zlib1g-dev pkg-config \
  libxml2-dev libxslt1-dev

# 3. Устанавливаем Bundler (глобально)
gem install bundler -V

# 4. Для логов Packer — выводим версии
echo "=== Ruby version ==="
ruby -v || true
echo "=== Bundler version ==="
bundle -v || true
