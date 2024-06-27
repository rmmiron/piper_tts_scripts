base_dir="/home/rodrigom/Applications/piper"

m=( "${base_dir}/models/*.onnx" )

current_model=$(basename $(cat "${base_dir}/current_model.txt"))

cm=$(for mn in $m; do basename "${mn}"; done | zenity --list --title="Choose the Voice Model for TTS" --text="Current model is ${current_model}" --column="Voice models available:" )

if [[ ! $cm ]]; then
   echo "Nothing selected."
   exit 1
fi

echo "${base_dir}/models/${cm}">"${base_dir}/current_model.txt"
zenity --notification --text="${cm}"
