#!/bin/sh

choice=$(printf "Performance\nBalanced\nPower Saver" | fuzzel --config ~/.config/fuzzel/powerProfile.ini --dmenu)

case "$choice" in
    "Performance")
        powerprofilesctl set performance
        ;;
    "Balanced")
        powerprofilesctl set balanced
        ;;
    "Power Saver")
        powerprofilesctl set power-saver
        ;;
esac
