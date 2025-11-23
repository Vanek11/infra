#!/bin/bash
set -e

APP_DIR=/home/ubuntu/reddit

sudo apt-get update
sudo apt-get install -y git

rm -rf "$APP_DIR"
git clone -b monolith https://github.com/Artemmkin/reddit.git "$APP_DIR"

cd "$APP_DIR"

# ДОБАВИТЬ ЭТО:
sudo gem install bundler -v '1.15.3'
bundle _1.15.3_ install

puma -d
