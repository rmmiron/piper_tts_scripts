#!/bin/zsh
pids=$(pidof aplay && pidof piper)

if [[ "${pids}" ]]; then
   zenity --notification --text="Speaking stopped."
   echo "${pids}" | xargs kill -9
else
   zenity --notification --text="No speaking process running."
fi

