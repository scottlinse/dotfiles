#!/bin/sh

if [ -f /tmp/qtile_brightness ]; then
    brightnessctl set "$(cat /tmp/qtile_brightness)"
    rm /tmp/qtile_brightness
else
    # Fallback
    brightnessctl set 100%
fi
