#!/bin/sh

PREFIX='tell application "System Events" to tell appearance preferences to'

#######################################
# Print help message
#######################################
show_help()
{
	echo "$(cat <<-END
		Usage: sh dark-mode.sh [command]

		Commands
		  <none>  Toggle dark mode
		  on      Enable dark mode
		  off     Disable dark mode
		  status  Dark mode status
	END
	)"
}

#######################################
# Get current status
# Returns:
# 	"Dark Mode" or "Light Mode"
#######################################
status()
{
	defaults read -g "AppleInterfaceStyle" &>/dev/null	\
	&& echo "Dark Mode" 								\
	|| echo "Light Mode"
}

#######################################
# Set the mode
# Arguments:
# 	$1: mode to be set
#######################################
set_mode()
{
	osascript -e "$PREFIX set dark mode to $1"
}

if [[ $(uname) != "Darwin" ]] ; then
	echo "Can only be run on macOS!"
	exit 0
elif [[ -z $1 ]] ; then
	set_mode "not dark mode"
elif [[ $1 = "on" ]] ; then
	set_mode "True"
elif [[ $1 = "off" ]] ; then
	set_mode "False"
elif [[ $1 = "status" ]] ; then
	status
else
	show_help
fi
