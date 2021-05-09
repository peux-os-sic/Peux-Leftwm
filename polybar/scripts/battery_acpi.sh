#!/usr/bin/bash

path=$(ls -A '/sys/class/power_supply/')

if [[ "$path" == "" ]] ; then
    # Format charge & color depending on the status.
    FORMAT="%{B#57e626}%{B#57e626}  "

    FORMAT="$FORMAT ON AC $FORMAT"
    # Display on bar
    echo $FORMAT
else
    # Getting the data and initializing an array.
    BATTERY_INFO=($( acpi | awk -F',' '{ print $0 }'))

    # Formatting helpers
    CHARGE=$((${BATTERY_INFO[3]//%,}))
    ICON=""
    FORMAT=""

    # Battery icon to reflect on the bar.
    if [[ "${BATTERY_INFO[2]}" == *"Charging"* ]] || [[ "${BATTERY_INFO[2]}" == *"Unknown"* ]] ; then
        ICON="  "
    else
        ICON=" - "
    fi


    # charging status with same background color
    if [[ $CHARGE -lt 10 ]]; then
        FORMAT="%{B#FF0000}%{B#FF0000}  "
    elif [[ $CHARGE -lt 30 ]]; then
        FORMAT="%{B#FF0000}%{B#7ab5e9}  "
    elif [[ $CHARGE -lt 60 ]]; then
        FORMAT="%{B#7ab5e9}%{B#7ae9a9}  "
    elif [[ $CHARGE -lt 100 ]]; then
        FORMAT="%{B#57e626}%{B#57e626}  "
    fi

    # Format charge & color depending on the status.
    FORMAT="$FORMAT $ICON $CHARGE% $FORMAT"

    # Display on bar
    echo $FORMAT
fi