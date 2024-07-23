#!/bin/bash
# Script para fazer a leitura em TTS do texto atualmente selecionado,
# usando o engine e modelos de voz Piper, e o comando aplay do sistema.
# Rodrigo Miron 2024-05-29

if [[ $1 ]]; then
   text_to_speech=$1
else
   text_to_speech=$(xclip -o)
fi

# Set script variables
script_dir="$(dirname "${BASH_SOURCE[0]}")"
app_dir="${HOME}/Applications/piper"
current_model_file=$(cat "${app_dir}/current_model.txt")
current_model_name="${current_model_file##*/}"
current_model_name=$(echo "${current_model_name%.*}" | tr '-' ' ' | tr '_' '-' | tr 'a-z' 'A-Z')

# Check if the voice model file is present
if [[ ! $(ls "${current_model_file}") ]]; then
   echo
   echo "Error! Voice model ${current_model_name} not found."
   exit 1
fi

# First, stop any running process related to this tts engine
(ps -C aplay -o pid= && ps -C piper -o pid=) | xargs kill -9

# Get the right sample rate to play the file
rate=$(cat "${current_model_file}.json" | grep "sample_rate" | cut -d ":" -f 2 | cut -d "," -f1)
#rate=$(cat "${model_file}.json" | jq -r ".audio.sample_rate")

# Paste selected text, send it to piper and play it "on-the-fly"
echo "${text_to_speech}" | $app_dir/piper --model $current_model_file --output-raw | aplay -r $rate -f S16_LE -t raw - &

# Send a notification 
msg="${current_model_name}, ${rate} sample rate."
stop_speaking=$(notify-send -e -a "Speaking..." "${msg}" -i "user-available" -A "Stop")
echo "${msg}"

if [[ $stop_speaking ]]; then
   "${script_dir}/stop_speaking.sh"
fi

