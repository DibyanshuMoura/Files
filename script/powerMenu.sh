#!/usr/bin/env sh

set -eu

choice="$(
    printf '%s\n' \
        "Lock" \
        "Suspend" \
        "Logout" \
        "Reboot" \
        "Shutdown" |
    fuzzel --config ~/.config/fuzzel/powerMenu.ini --dmenu
)"

[ -n "$choice" ] || exit 0

case "$choice" in
    Lock)
        exec swaylock
        ;;

    Suspend)
        swaylock -f &
        sleep 1
        exec systemctl suspend
        ;;

    Logout)
        exec hyprctl dispatch exit
        ;;

    Reboot)
        exec systemctl reboot
        ;;

    Shutdown)
        exec systemctl poweroff
        ;;

    *)
        exit 1
        ;;
esac
