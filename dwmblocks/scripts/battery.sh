#!/bin/sh

# Prints all batteries, their percentage remaining and an emoji corresponding
# to charge status (🔌 for plugged up, 🔋 for discharging on battery, etc.).

case $BLOCK_BUTTON in
	1) pamixer -t; kill -44 $(pidof dwmblocks) ;;
	2) rofi -theme "~/.config/rofi/themes/gruvbox/gruvbox-dark.rasi" -e "Audio clicked 2" ;;
	3) rofi -theme "~/.config/rofi/themes/gruvbox/gruvbox-dark.rasi" -e "Audio clicked 3" ;;
	4) pamixer --allow-boost -i 1; kill -44 $(pidof dwmblocks) ;;
	5) pamixer --allow-boost -d 1; kill -44 $(pidof dwmblocks) ;;
	6) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

# Loop through all attached batteries and format the info
# for battery in /sys/class/power_supply/BAT?*; do
# 	# If non-first battery, print a space separator.
# 	[ -n "${capacity+x}" ] && printf " "
# 	# Sets up the status and capacity
# 	case "$(cat "$battery/status")" in
# 		"Full") status="⚡" ;;
# 		"Discharging") status="🔋" ;;
# 		"Charging") status="🔌" ;;
# 		"Not charging") status="🛑" ;;
# 		"Unknown") status="♻️" ;;
# 	esac
# 	capacity=$(cat "$battery/capacity")
# 	# Will make a warn variable if discharging and low
# 	[ "$status" = "🔋" ] && [ "$capacity" -le 25 ] && warn="❗"
# 	# Prints the info
# 	printf "%s%s%d%%" "$status" "$warn" "$capacity"; unset warn
# done && exit 0

# Old version
# Loop through all attached batteries and format the info
#for battery in /sys/class/power_supply/BAT?*; do
#	# If non-first battery, print a space separator.
#	[ -n "${capacity+x}" ] && printf " "
#	# Sets up the status and capacity
#	case "$(cat "$battery/status")" in
#		"Full") status=" " ;;
#		"Discharging") status="" ;;
#		"Charging") status="󰂄" ;;
#		#"Charging") status="ﮣ⚡ " ;;
#		"Not charging") status="" ;;
#		"Unknown") status="" ;;
#	esac
#	capacity=$(cat "$battery/capacity")
#	# Will make a warn variable if discharging and low
#	#[ "$status" = "🔋" ] && [ "$capacity" -le 25 ] && warn="❗"
#    if [ $capacity = "99" ]; then
#        capacity=100;
#    fi
#
#	# Prints the info
#	# For debian change env to /usr/bin/bash and remove whitespaces from prints...
#	if [[ $status = " " ]]; then
#		printf "%s %s%d%%" "$status" "$warn" "$capacity"; unset warn
#	elif [[ $status = "󰂄" ]]; then
#		printf "%s %s%d%%" "$status" "$warn" "$capacity"; unset warn
#	elif (( $capacity > 85)); then
#		printf "  %s%s%d%%" "$status" "$warn" "$capacity"; unset warn
#	elif (( $capacity > 60)); then
#		printf "  %s%s%d%%" "$status" "$warn" "$capacity"; unset warn
#	elif (( $capacity > 30 )); then
#		printf "  %s%s%d%%" "$status" "$warn" "$capacity"; unset warn
#	else
#		printf "  %s%s%d%%" "$status" "$warn" "$capacity"; unset warn
#	fi
#
#done && exit 0


# Loop through all attached batteries and format the info
for battery in /sys/class/power_supply/BAT?*; do
    # If non-first battery, print a space separator.
    [ -n "${capacity+x}" ] && printf " "
    # Sets up the status and capacity
    case "$(cat "$battery/status")" in
        "Full") status="full" ;;
        "Discharging") status="discharging" ;;
        "Charging") status="charging" ;;
        "Not charging") status="not_charging" ;;
        "Pending charge") status="pending_charge" ;;
        "Unknown") status="unknown" ;;
    esac
    capacity=$(cat "$battery/capacity")
    
    # Ensure capacity is not 99, if so set it to 100
    if [ "$capacity" = "99" ]; then
        capacity=100
    fi

    # Testing
    #status="full"
    #status="discharging"
    #capacity="29"

    # Set the appropriate emoji based on status and capacity
    if [ "$status" = "full" ]; then
        emoji=" "
    elif [ "$status" = "charging" ]; then
        emoji="🔌 "
    elif [ "$status" = "not_charging" ]; then
        emoji=" "   
    elif [ "$status" = "pending_charge" ]; then
        emoji=" "
    elif [ "$status" = "unknown" ]; then
        emoji=" "
    elif [ "$capacity" -gt 85 ]; then
        emoji=" "
    elif [ "$capacity" -gt 60 ]; then
        emoji=" "
    elif [ "$capacity" -gt 30 ]; then
        emoji=" "  
    else
        emoji=" "
    fi

    # Prints the info
    printf "%s %d%%" "$emoji" "$capacity"

done && exit 0
