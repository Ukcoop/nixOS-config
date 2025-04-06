#!/bin/sh
while true; do
    GAME_OVERLAY_COUNT=$(ps -e -o comm | grep -E "steam.exe|wine|prismlauncher|stardew" | wc -l)

    if [ "$GAME_OVERLAY_COUNT" -gt 0 ]; then
        if systemctl is-active --quiet kanata; then
            systemctl stop kanata-laptop.service
        fi
    else
        if ! systemctl is-active --quiet kanata; then
            systemctl start kanata-laptop.service
        fi
    fi
    sleep 5
done
