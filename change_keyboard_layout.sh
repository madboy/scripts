#!/usr/bin/env bash

LAYOUT=`setxkbmap -query | grep layout | awk '{ print $2}'`

if [ "$LAYOUT" = "se" ]; then
	echo "Changing keyboard to US"
	setxkbmap -option ctrl:nocaps -layout us
else
	echo "Changing keyboard to SE"
	setxkbmap -option ctrl:nocaps -layout se
fi

