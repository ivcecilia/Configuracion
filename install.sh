#!/bin/bash

set -e

echo "==> Instalando paquetes..."

sudo apt update

sudo apt install -y \
    i3 \
    polybar \
    rofi \
    dunst \
    feh \
    fish \
    picom \
    playerctl \
    pulseaudio \
    pavucontrol \
    flameshot \
    ranger \
    cmus

echo "==> Creando carpetas..."

mkdir -p ~/.config
mkdir -p ~/Pictures/wallpapers

echo "==> Backup de configuraciones antiguas..."

BACKUP_DIR=~/.config-backup-$(date +%Y%m%d-%H%M%S)
mkdir -p "$BACKUP_DIR"

for dir in config/*; do
    name=$(basename "$dir")

    if [ -e "$HOME/.config/$name" ]; then
        mv "$HOME/.config/$name" "$BACKUP_DIR/"
    fi
done

echo "==> Copiando configuraciones..."

cp -r config/* ~/.config/

echo "==> Copiando wallpapers..."

cp wallpapers/* ~/Pictures/wallpapers/ 2>/dev/null || true

echo "==> Configurando fondo..."

mkdir -p ~/.config/i3

if ! grep -q feh ~/.config/i3/config; then
    echo 'exec --no-startup-id feh --bg-fill ~/Pictures/wallpapers/fondo.jpg' >> ~/.config/i3/config
fi

echo "==> Configuración completada."
echo "Reinicia i3 con: Mod + Shift + R"
