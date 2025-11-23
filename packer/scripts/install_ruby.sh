#!/bin/bash
set -e

# Обновляем список пакетов
apt-get update

# Ставим Ruby + dev-пакеты для сборки гемов
apt-get install -y ruby-full ruby-dev build-essential \
  libssl-dev zlib1g-dev pkg-config libxml2-dev libxslt1-dev

# Ставим совместимую версию Bundler для Ruby 2.7
gem install bundler -v 2.4.22
