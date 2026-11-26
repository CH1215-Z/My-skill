#!/bin/bash
# x.sh <display no> click X Y [btn] | dclick X Y | rclick X Y | move X Y | drag X1 Y1 X2 Y2 | wheel up|down [n] | key K | type TEXT | shot NAME
export DISPLAY=:${1:?display}; shift
OUT=${OUT:-$PWD}
case "$1" in
  click) xdotool mousemove $2 $3; sleep 0.15; xdotool click ${4:-1}; sleep 0.3 ;;
  dclick) xdotool mousemove $2 $3; sleep 0.15; xdotool click --repeat 2 --delay 80 1; sleep 0.4 ;;
  rclick) xdotool mousemove $2 $3; sleep 0.15; xdotool click 3; sleep 0.4 ;;
  move) xdotool mousemove $2 $3; sleep 0.3 ;;
  drag) xdotool mousemove $2 $3; sleep 0.15; xdotool mousedown 1
        for i in 1 2 3 4 5 6 7 8 9 10; do xdotool mousemove $(( $2 + ($4-$2)*i/10 )) $(( $3 + ($5-$3)*i/10 )); sleep 0.05; done
        xdotool mouseup 1; sleep 0.3 ;;
  wheel) b=$([ "$2" = up ] && echo 4 || echo 5); for i in $(seq 1 ${3:-3}); do xdotool click $b; sleep 0.05; done ;;
  key) xdotool key $2; sleep 0.3 ;;
  type) xdotool type --delay 50 "$2"; sleep 0.3 ;;
  shot) import -window root "$OUT/$2.png" && echo "$OUT/$2.png" ;;
esac
