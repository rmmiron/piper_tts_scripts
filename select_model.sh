app_dir=~/Applications/piper

all_models=( "${app_dir}/models/*.onnx" )
current_model=$(basename $(cat "${app_dir}/current_model.txt"))

all_models_names=$((for i in $all_models; do ( echo $(basename ${i})! ); done)|xargs)
result=$(yad --form --field="Speak selected text now":CHK --field="Models":CB False "${all_models_names}")

if [[ ! $result ]]; then
   echo "Cancelled"
   exit 1
fi

speak_now=$(echo $result|cut -f1 -d '|')
selected_model=$(echo $result|cut -f2 -d '|'|xargs)

zenity --notification --text="${selected_model}"

echo "${app_dir}/models/${selected_model}">"${app_dir}/current_model.txt"

if [[ "$speak_now" == "TRUE" ]]; then
   speak.sh
fi
