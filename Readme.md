# Scripts para TTS Piper

Scripts para criar um sistema de TTS (text-to-speech) no Linux.  
Usando atalhos de teclado, qualquer texto atualmente selecionado pode ser lido imediatamente pelo TTS;  
O usuário pode baixar vários modelos pré-treinados, diretamente no repositório do projeto, ou criar seus próprios modelos de voz (instruções na página do projeto, listada abaixo).  


## Requirementos:
- Piper TTS engine (https://github.com/rhasspy/piper)  
(recomendo usar os binários pré-compilados, mais simples de configurar que o script Python);
- Piper Voice Models (https://github.com/rhasspy/piper/blob/master/VOICES.md)
- Zenity notification system
- yad - Yet Another Dialog
- xclip
- aplay (command line sound player for ALSA sound system)

***Obs.: Estou usando Zenity e yad, embora os dois façam a mesma coisa, porque as notificações do yad não estão funcionando no meu sistema; Assim que corrigir, usarei só o yad. Adapte os scripts às suas necessidades.***


## Instalação
### Engine Piper
- Baixe os binários do Piper no link indicado;
- Descompacte os arquivos para o diretório de sua preferência;  
eu uso `~/Applications/piper`
- Certifique-se de que o binário do Piper tem permissão para execução;  
`chmod +x ~/Aplications/piper/piper`


### Modelos de voz
- Baixe os modelos de voz pré-treinados pelo link indicado;
- Salve os arquivos com extensão .onnx e .onnx.json em um diretório;  
eu uso `~/Aplications/piper/models`

***Obs: os arquivos .onnx e .onnx.json têm que ter exatamente o mesmo nome***


### Scripts
- Baixe os scripts deste repositório para alguma pasta no seu computador;
- No shell, modifique as permissões dos scripts para permitir execução:  
`chmod +x ~/Applications/piper-scripts/*.sh`
- Edite o arquivo *tts.cfg* e altere os camninhos conforme os locais onde os arquivos foram salvos;  
***Obs.: Este recurso ainda está sendo implementado.  
Por enquanto, cada script tem as configurações definidas em seu início.***



### Demais requerimentos
- Usando seu sistema de pacotes, certifique-se de que as demais dependências estão instlaadas:  
(zenity, yad, xclip, aplay (ALSA))


## Uso
- `speak.sh`  
"fala" o texto atualmente selecionado, o que estiver copiado na área de transferência ou um texto específico que o usuário indicar; Ex: speak.sh "Hello, world!"

- `stop_speaking.sh`  
Interrompe imediatamente o texto sendo "falado" atualmente, eliminando (kill) os processos relacionados em execução;

- `tts_toolbox.sh`  
Abre uma caixa de diálogo que permite selecionar o modelo de voz, iniciar a fala e interromper. A ideia é deixar esta caixa flutuante para o usuário clicar em qualquer momento.


***Obs.: Recomendo usar atalhos de teclado para automatizar a fala e seleção dos modelos; Exemplo, no meu sistema configurei CTRL+ALT+/ para abrir a caixa de diálogo `tts_tooblx.sh`, CTRL+ALT+\* (asterisco) para "falar" o texto selecionado e CTRL+ALT+\-* (sinal de menos) para interromper a fala.**

# ToDo
- Configurar parâmetros como velocidade de fala e *pitch*;
- Melhorar o método de leitura das configurações;
- Corrigir o problema no YAD e passar a usar somente ele;
- Caixa de diálogo que permite selecionar o modelo direto do repositório e baixá-lo;
- Melhoras na apresentação visual e notificações;

*Enjoy it!*
