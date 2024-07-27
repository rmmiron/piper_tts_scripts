#!/bin/bash
if [[ ! $1 ]]; then exit 1; fi

recebido="$(echo ${2} | tr 'A-Z' 'a-z')"
cod_idioma="$(echo ${recebido} | cut -f1 -d '_')"
cod_pais="$(echo ${recebido} | cut -f1 -d '-' | cut -f2 -d '_' | tr 'a-z' 'A-Z')"
resto="$(echo ${recebido} | cut -f2,3 -d '-')"
filename="${cod_idioma}_${cod_pais}-${resto}.onnx"


#todo: Implementar busca do diretório no arquivo de configuração
app_dir="${HOME}/Applications/piper"
conf_file="${app_dir}/current_model.txt"
model_file_full_path="${app_dir}/models/${filename}"

# Gravar a informação no arquivo
echo "${model_file_full_path}">"${conf_file}"
#notify-send -e "${model_file}"
