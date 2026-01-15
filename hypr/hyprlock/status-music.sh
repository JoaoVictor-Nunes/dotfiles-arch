#!/bin/bash
# Spotify status para hyprlock

# Verifica se o Spotify está rodando
if ! pgrep -x "spotify" > /dev/null 2>&1; then
    echo "⏹ No music"
    exit 0
fi

# Usa playerctl para obter informações do Spotify
STATUS=$(playerctl -p spotify status 2>/dev/null)

case $STATUS in
    "Playing")
        ARTIST=$(playerctl -p spotify metadata artist 2>/dev/null | head -c 30)
        TITLE=$(playerctl -p spotify metadata title 2>/dev/null | head -c 40)
        
        # Formata a saída
        if [[ -n "$ARTIST" && -n "$TITLE" ]]; then
            echo "▶ $ARTIST - $TITLE"
        elif [[ -n "$TITLE" ]]; then
            echo "▶ $TITLE"
        else
            echo "▶ Spotify (Playing)"
        fi
        ;;
    "Paused")
        ARTIST=$(playerctl -p spotify metadata artist 2>/dev/null | head -c 30)
        TITLE=$(playerctl -p spotify metadata title 2>/dev/null | head -c 40)
        
        if [[ -n "$ARTIST" && -n "$TITLE" ]]; then
            echo "⏸ $ARTIST - $TITLE"
        elif [[ -n "$TITLE" ]]; then
            echo "⏸ $TITLE"
        else
            echo "⏸ Spotify (Paused)"
        fi
        ;;
    *)
        echo "⏹ No music"
        ;;
esac
