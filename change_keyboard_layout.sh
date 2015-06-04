#!/usr/bin/env bash

LAYOUT=`setxkbmap -query | grep layout | awk '{ print $2}'`

if [ "$LAYOUT" = "se" ]; then
	echo "Changing keyboard to US"
	setxkbmap us
else
	echo "Changing keyboard to SE"
	setxkbmap se
fi

xmodmap /home/krl/.xmodmap
