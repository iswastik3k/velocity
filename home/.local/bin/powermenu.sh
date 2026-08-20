#!/bin/bash

OPTIONS="  Lock\n  Reboot\n  Shutdown"

CHOICE=$(echo -e "$OPTIONS" | wofi \
    --dmenu \
    --prompt "" \
    --width 200 \
    --height 130 \
    --no-actions \
    --hide-search \
    --insensitive \
    --cache-file /dev/null \
    --style ~/.config/wofi/power.css)

case $CHOICE in
    "  Lock")
        hyprlock ;;
    "  Reboot")
        systemctl reboot ;;
    "  Shutdown")
        systemctl poweroff ;;
esac
