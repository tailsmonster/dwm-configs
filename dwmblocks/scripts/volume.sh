#!/bin/sh

# Prints the current volume or 🔇 if muted.

[ $(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master)) = "0%" ] && echo "󰖁 0%" && exit

vol="$(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master) | tr -d '%')"

if [ "$vol" -gt "70" ]; then
     icon=" "
elif [ "$vol" -lt "30" ]; then
     icon=" "
else
     icon=" "
fi

echo "$icon$vol%"
