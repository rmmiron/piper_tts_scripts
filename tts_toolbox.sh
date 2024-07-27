#!/bin/bash
kill $(ps aux | awk '/Piper TTS/ {print $2}')
sleep 1

app_dir="${HOME}/Applications/piper"
script_dir="$(dirname "${BASH_SOURCE[0]}")"
#speak_script="${script_dir}/speak.sh"
speak_script="${script_dir}/speak.sh"
stop_script="${script_dir}/stop_speaking.sh"

# Obter o modelo de voz atualmente selecionado
current_model=$(basename $(cat "${app_dir}/current_model.txt"))

# Cria array com o caminho completo de todos os modelos de voz
all_models=( $app_dir/models/*.onnx )

# Cria string para o ComboBox do YAD
# descobrir qual é o último nro de índice
all_indexes=("${!all_models[@]}")
last_index="${all_indexes[-1]}"

all_models_names_cb=''

for i in ${!all_models[@]};
do
   # encontrar o arquivo correspondente ao modelo atualmente selecionado
   if [[ $(basename ${all_models[i]}) = $current_model ]];
   then all_models_names_cb="${all_models_names_cb}^";fi

   # adicionar o nome do arquivo à string e formatar
   all_models_names_cb="${all_models_names_cb}$(basename ${all_models[i]} | \
   cut -f 1 -d '.' | \
   tr a-z A-Z)"

   # verificar se o elemente não é o último do array
   if [[ ! $i -eq $last_index ]];
   then all_models_names_cb="${all_models_names_cb}!"; fi
done

# Show the dialog box
yad --form --title="Piper TTS" \
--text="Speak the current selected text.\n" \
--field=":CB" "${all_models_names_cb}" \
--field="Pitch:NUM" '10!5..30!1!' \
--field="Speed:NUM" '1!1..4!1!0.25!' \
--field='Speak!Speak the selected text:BTN' "${speak_script}" \
--field='Stop!Stop speakingb:BTN' "${stop_script}" \
--align=center \
--changed-action="${script_dir}/set_voice_model.sh" \
--focus-field=4 \
--borders=10 --no-focus \
--text-align=center \
--no-buttons
#--undecorated
#kill $(ps aux | awk '/Piper TTS/ {print $2}')
