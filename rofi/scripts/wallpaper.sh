#!/bin/bash

wallpapers="$HOME/Wallpapers"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Função para notificações
notify() {
    notify-send -a "Wallpaper Switcher" "$1" "$2" -i "$3"
}

# Escolher wallpaper
wallpaper_file=$(find "$wallpapers" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" \) | \
  sed "s|^$wallpapers/||" | \
  rofi -dmenu -i -p "墙纸： ")

[[ -z "$wallpaper_file" ]] && exit 0

wallpaper="$wallpapers/$wallpaper_file"

# Notificação inicial
notify "主题切换器" "Aplicando: $(basename "$wallpaper_file")"

# 1. Parar swww
#notify "Wallpaper" "Parando swww..." "video-display"
#pkill swww 2>/dev/null
#pkill swww-daemon 2>/dev/null
#sleep 0.5

# 2. Iniciar swww
#notify "SWWW" "Iniciando daemon..." "system-run"
##sleep 2

# 3. Aplicar wallpaper
swww img "$wallpaper" \
  --transition-type random \
  --transition-fps 60 \
  --transition-step 255
# 4. Aplicar cores com pywal
wal -i "$wallpaper" -n

# 5. Recarregar Waybar
pkill waybar
sleep 0.5
waybar > /dev/null 2>&1 &

# 6. Recarregar swaync (usando notify-send dentro do swaync)
killall swaync 2>/dev/null
sleep 0.5
swaync >/dev/null 2>&1 &

# 7. Pywalfox
pywalfox update >/dev/null 2>&1 &

# 8. Notificação final
sleep 1
notify "Cores aplicadas com sucesso! 谢谢"
# 9. Notificação extra do swaync (opcional)
sleep 2
