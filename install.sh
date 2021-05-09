#!/bin/bash

##################################################
## Author - DN-debug
## Description - Peux Leftwm setup via fetcher app
##################################################

# Install packages

if zenity --question --text="Install Leftwm?"
then 

    PASSWD="$(zenity --password --title=Authentication)\n"

    pkg="$(pacman -Qq | grep leftwm)"

    if [ "${pkg}" = "leftwm" ]; then
        notify-send "Leftwm is already installed. Skipping!"   
    else 
        echo -e $PASSWD | sudo -S pacman -U /tmp/fetcher/Peux-Leftwm/leftwm-1:0.2.7-1-x86_64.pkg.tar.zst
        notify-send "installed Leftwm"
    fi
    if zenity --question --text="Install Polybar Panel?"
    then 
        pkg1="$(pacman -Qq | grep polybar)"
        if [ "${pkg1}" = "polybar" ]; then
            notify-send "Polybar is already installed. Skipping!"
        else
            echo -e $PASSWD | sudo -S pacman -U /tmp/fetcher/Peux-Leftwm/polybar-3.5.5-2-x86_64.pkg.tar.zst
            notify-send "installed Polybar"
        fi
    fi
    if zenity --question --text="Install Rofi?"
    then 
        pkg1="$(pacman -Qq | grep rofi | tail -n1)"
        if [ "${pkg1}" = "rofi" ]; then
            notify-send "Rofi is already installed. Skipping!"
        else
            echo -e $PASSWD | sudo -S pacman -Syu rofi
            notify-send "installed Rofi"
        fi
    fi

else
    notify-send "skipping Leftwm installation!"
fi

# copy configurations

if zenity --question --text="Want to copy the configurations?"
then 
    echo "changing directory"
    cd ../
    cp -r Peux-Leftwm/*/ $HOME/.config/
    notify-send "Copied the configurations"
else
    notify-send "skipping the setup!"
fi

# cleanup

rm -rf /tmp/fetcher/Peux-Leftwm
notify-send "Done!"