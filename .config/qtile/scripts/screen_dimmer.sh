#!/bin/sh

# Save current brightness
brightnessctl get > /tmp/qtile_brightness

# Dim to 10%
brightnessctl set 10%
