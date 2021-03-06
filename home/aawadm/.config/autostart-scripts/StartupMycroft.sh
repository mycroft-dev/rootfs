#!/usr/bin/env bash

# Move mouse from the center of the screen to the lower-right edge
/usr/bin/xdotool mousemove 479 799

# Unmute speakers (they boot muted to prevent crackling)
/usr/local/bin/setgpio_dacamp_mute_off.sh
/usr/local/bin/setgpio_line_mute_off.sh
sleep 1

# Get the IP address and convert to "10 dot 10 dot 14 dot 77" or whatever
IP=$( ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' )
IPdotted=${IP//\./ dot }
/home/aawadm/mycroft-core/mimic/bin/mimic -t "Hello. I'm Mycroft"
sleep 1
/home/aawadm/mycroft-core/mimic/bin/mimic -t "I'm at I P address: $IPdotted"

# Check for remote updates
bash /home/aawadm/CheckForUpdate.sh

# Initializing screen power settings...
export DISPLAY=:0
echo "on" | tee /sys/class/drm/card0/power/control
echo "on" | tee /sys/class/drm/card0-DSI-1/power/control
xset -dpms
xset s off


# Launch Mycroft Core and the Mycroft GUI
sleep 5
. /home/aawadm/start_2_mycroft.sh
