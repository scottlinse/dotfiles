#!/usr/bin/env bash

connectivity=$(nmcli -t -f CONNECTIVITY general)
device_info=$(nmcli -t -f TYPE,STATE,DEVICE device | grep ':connected' | head -n1)

dev_type=$(echo "$device_info" | cut -d: -f1)
dev_name=$(echo "$device_info" | cut -d: -f3)

tooltip=""

if [ -n "$dev_name" ]; then
  case "$dev_type" in
    ethernet)
      gw=$(ip route | awk '/default/ {print $3; exit}')
      tooltip="${dev_name} via ${gw} "
      ;;
    wifi)
      essid=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d: -f2)
      strength=$(nmcli -t -f ACTIVE,SIGNAL dev wifi | grep '^yes' | cut -d: -f2)
      tooltip="${essid} (${strength}%) "
      ;;
  esac
fi

case "$connectivity" in
  full)
    case "$dev_type" in
      ethernet)
        echo "{\"text\": \" \", \"tooltip\": \"$tooltip\", \"class\": \"ethernet\"}"
        ;;
      wifi)
        echo "{\"text\": \" \", \"tooltip\": \"$tooltip\", \"class\": \"wifi\"}"
        ;;
      *)
        echo "{\"text\": \"🌐 \", \"tooltip\": \"Connected\", \"class\": \"online\"}"
        ;;
    esac
    ;;
  limited|portal)
    echo "{\"text\": \"⚠ \", \"tooltip\": \"Network connected but no internet\", \"class\": \"limited\"}"
    ;;
  none)
    echo "{\"text\": \"⚠ \", \"tooltip\": \"No network connection\", \"class\": \"offline\"}"
    ;;
  *)
    echo "{\"text\": \"⚠ \", \"tooltip\": \"Unknown state\", \"class\": \"unknown\"}"
    ;;
esac
