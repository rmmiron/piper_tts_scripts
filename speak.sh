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
model_name="${model_name%.*}"

# Check if the voice model file is present
if [[ ! $(ls "${model_file}") ]]; then
   echo
   echo "Error! Voice model ${model_name} not found."
   exit 1
fi

# First, stop any running processes
(ps -C aplay -o pid= && ps -C piper -o pid=) | xargs kill -9

# Send a notification 
msg="Speaking with\n${model_name} model."
zenity --notification --text="${msg}" --icon="user-available"
echo "${msg}"

# Paste selected text, send it to piper and play it "on-the-fly"
echo "${text_to_speech}" | \
  $mypath/piper --model $model_file --output-raw | \
  aplay -r 22050 -f S16_LE -t raw -
