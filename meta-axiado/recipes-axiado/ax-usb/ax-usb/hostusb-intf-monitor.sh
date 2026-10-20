#!/bin/bash

HOSTUSB_PATH="/sys/class/net/hostusb0"
SERVICE="phosphor-ipmi-net@hostusb0.service"

while true; do
    if [ -d "$HOSTUSB_PATH" ]; then
        systemctl is-active --quiet "$SERVICE"
        if [ $? -ne 0 ]; then
            #echo "Service not running. Starting $SERVICE..."
            systemctl start "$SERVICE"
        fi
    fi
    sleep 5
done

