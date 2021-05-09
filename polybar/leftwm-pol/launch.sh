#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar -c=~/.config/polybar/leftwm-pol/config.ini menu &

echo "Polybar launched..."
