#!/bin/bash
# Script para exibir cava no hyprlock

# Configuração
BARS=16
HEIGHT=10
WIDTH=30

# Função para converter dados do cava em barras
draw_bars() {
    while read -r line; do
        # Converte os valores para barras
        IFS=';' read -ra values <<< "$line"
        output=""
        for i in "${!values[@]}"; do
            # Escala o valor para 0-8
            value=${values[i]}
            bars=$(( (value * HEIGHT) / 65535 ))
            
            # Desenha as barras
            for ((j=0; j<bars; j++)); do
                output+="▊"
            done
            for ((j=bars; j<HEIGHT; j++)); do
                output+=" "
            done
        done
        echo "$output"
    done
}

# Executa o cava
cava -p ~/.config/cava/hyprlock_config 2>/dev/null | draw_bars
