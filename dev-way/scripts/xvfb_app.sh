#!/bin/sh
# xvfb_app.sh <display no> <WxH> -- <command...> : virtual screen + app, screenshot s0.png after WAIT seconds (default 10)
N=${1:?display}; SIZE=${2:?WxH}; shift 2; [ "$1" = "--" ] && shift
OUT=${OUT:-$PWD}
pkill -f "Xvfb :$N" 2>/dev/null; sleep 1
Xvfb :$N -screen 0 ${SIZE}x24 -nolisten tcp >/dev/null 2>&1 &
sleep 1
DISPLAY=:$N setsid "$@" > "$OUT/app.log" 2>&1 &
sleep ${WAIT:-10}
DISPLAY=:$N import -window root "$OUT/s0.png" && echo "$OUT/s0.png"
