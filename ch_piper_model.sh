piper_path=~/Applications/piper
current_model_file="${piper_path}/current_model.txt"
current_model=$(cat "${current_model_file}")
current_model_name="${current_model##*/}"
current_model_name="${current_model_name%.*}"


# Get a list with all models available
all_models=( ${piper_path}/models/*.onnx )
first_model="${all_models[0]}"
last_model="${all_models[-1]}"

echo "Current model: ${current_model_name}"

#todo check if there is no model installed

for i in "${!all_models[@]}"; do
   if [[ "${all_models[$i]}" == "$current_model" ]]; then
      if [[ ! "${all_models[${i}]}" == "${last_model}" ]]; then
         selected_model="${all_models[$((i + 1))]}"
         break
      fi
   fi
   selected_model="${first_model}"
done

model_name="${selected_model##*/}"
model_name="${model_name%.*}"

echo "${selected_model}">"${current_model_file}"
echo "Piper model set to ${model_name}"

#display notification
msg="TTS Voice selected:\n${model_name}"
zenity --notification --text="${msg}"
