#!/bin/bash

# Tratar os argumentos
if [[ $# -gt 0 ]]; then
   text_to_speech=$1
   rate=$2
   speed=$3
else
   text_to_speech=$(xclip -o)
   speed=1
fi

# Set script variables
script_dir="$(dirname "${BASH_SOURCE[0]}")"
app_dir="${HOME}/Applications/piper"
current_model_file=$(cat "${app_dir}/current_model.txt")
current_model_name="${current_model_file##*/}"
current_model_name=$(echo "${current_model_name%.*}" | tr '-' ' ' | tr '_' '-' | tr 'a-z' 'A-Z')

# Check if the voice model file is present
if [[ ! $(ls "${current_model_file}") ]]; then
   echo "Error! Voice model ${current_model_name} not found."
   exit 1
fi

# First, stop any running process related to this tts engine
(ps -C aplay -o pid= && ps -C piper -o pid=) | xargs kill -9

# Get the right sample rate to play the file
if [[ ! $rate ]]; then
   rate=$(cat "${current_model_file}.json" | grep "sample_rate" | cut -d ":" -f 2 | cut -d "," -f1)
fi

echo "Text to speech: ${text_to_speech}"
echo "sample rate: ${rate}, speed:${speed}"

# Paste selected text, send it to piper and play it "on-the-fly"
echo "${text_to_speech}" | \
$app_dir/piper --model $current_model_file --output-raw -f - | \
ffplay -nodisp -autoexit -ar $rate -af "atempo=${speed}" - &
#aplay -r $rate -f S16_LE -t raw - &

# Send a notification 
msg="${current_model_name}\n${rate} sample rate\nspeed ${speed}."
stop_speaking=$(notify-send -e -a "Speaking..." "${msg}" -i "user-available" -A "Stop")
echo "${msg}"

if [[ $stop_speaking ]]; then
   "${script_dir}/stop_speaking.sh"
fi
