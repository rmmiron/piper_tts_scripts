#!/bin/zsh
pids=$(pidof aplay && pidof piper)

if [[ "${pids}" ]]; then
#   notify-send -a "Stop" -e "Speaking stopped."
   echo "${pids}" | xargs kill -9
fi

