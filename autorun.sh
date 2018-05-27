#!/bin/bash

pid=$(pgrep sessio)

export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/${pid}/environ|cut -d= -f2-)
echo "$qdbus | grep .*\.Session$"


DIR=$(dirname $([ -L $0 ] && readlink -f $0 || echo $0))

# First execute. Let you to know who turned on your comp
#python $DIR/spy.py

dbus-monitor --session "type=signal,interface=com.canonical.Unity.Session" --profile \
| while read dbusmsg; do
    if [[ "$dbusmsg" =~ Unlocked$ ]] ; then

#	python $DIR/spy.py;
    notify-send "Gotcha!" "This incident was reported."
        # ...
    fi
done
