#!/bin/zsh
# Script para fazer a leitura em TTS do texto atualmente selecionado,
# usando o engine e modelos de voz Piper, e o comando aplay do sistema.
# Rodrigo Miron 2024-05-29

if [[ $1 ]]; then
   text_to_speech=$1
else
   text_to_speech=$(xclip -o)
fi

mypath="/home/rodrigom/Applications/piper"
model_file=$(cat "${mypath}/current_model.txt")
model_name="${model_file##*/}"
model_name=$(echo "${model_name%.*}" | tr '-' ' ' | tr '_' '-' | tr 'a-z' 'A-Z')

# Check if the voice model file is present
if [[ ! $(ls "${model_file}") ]]; then
   echo
   echo "Error! Voice model ${model_name} not found."
   exit 1
fi

# First, stop any running processes
(ps -C aplay -o pid= && ps -C piper -o pid=) | xargs kill -9

# Get the right sample rate to play the file
# Note: maybe its not the best approach but, for now, it is working.
#rate=$(cat "${model_file}.json" | grep "sample_rate" | cut -d ":" -f 2 | cut -d "," -f1)
rate=$(cat "${model_file}.json" | jq -r ".audio.sample_rate")
echo $rate
# Send a notification 
msg="Speaking with\n${model_name}"
zenity --notification --text="${msg}" --icon="user-available"
echo "${msg}"

# Paste selected text, send it to piper and play it "on-the-fly"
echo "${text_to_speech}" | \
  $mypath/piper --model $model_file --output-raw | \
  aplay -r $rate -f S16_LE -t raw -