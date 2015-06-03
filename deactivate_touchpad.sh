#!/usr/bin/env bash

DEVICEID=`xinput | grep "Synaptics TouchPad" | awk '{ print $6 }' | tr '=' ' ' | awk '{ print $2 }'`
STATE=`xinput list-props $DEVICEID | grep "Device Enabled" | awk '{ print $4 }'`

if [ "$STATE" = "0" ]; then
    echo "We should activate the touchpad"
    xinput enable $DEVICEID
else
    echo "DEACTIVATE!"
    xinput disable $DEVICEID
fi
