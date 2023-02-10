#!/bin/bash

# falta: Transparencias, chsh, polybar talvez, bat y lsd
# agregar lineas en blanco: sed -i "/startup/G" zshrc * 5
# final sed -i "74 s/$/plugins=(/" zshrc; sed -i "75 s/$/  zsh-autosuggestions/" zshrc; sed -i "76 s/$/)/" zshrc


function copiar_config(){

   clear
   cp sxhkdrc $HOME/.config/sxhkd/sxhkdrc
   cp bspwmrc $HOME/.config/bspwm/bspwmrc
   cp .xinitrc $HOME

} 


function crear_carpetas_bspwm (){

   mkdir $HOME/.config/bspwm
   mkdir $HOME/.config/sxhkd

}


function rofi_config (){
   
   # Aqui vamos a agregar la linea de configuracion de rofi para que funcione correctamente. 
   echo "rofi.theme: /usr/share/rofi/themes/rofi/launcher.rasi" > /$HOME/.config/rofi/config
   sudo cp -r rofi /usr/share/rofi/themes
   echo -e "\033[1m\033[31mDone."

}

function zsh_config () {
   
   # Aqui haremos la instalacion de oh-my-zsh y el plugin de sugerencias
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   clear

   # Con este bucle crearemos 5 lineas en blanco despues de la palabra "startup" en el archivo .zshrc
   contador=0
   while [ $contador -le 5 ]; do
      sed -i "/startup/G" zshrc     #$HOME/.zshrc
      let contador=$contador+1
   done

   # Con este comando haremos que el plugin de las sugerencias funcione,
   # sobreescribiremos 3 de las 5 lineas previamente creadas, exatamente las lineas 74, 75 y 76.
   sed -i "74 s/$/plugins=(/" zshrc; sed -i "75 s/$/  zsh-autosuggestions/" zshrc; sed -i "76 s/$/)/" zshrc
  
}


function sin_nombre () {
   
   # Configuracion de rofi
   if [[ -d $HOME/.config/rofi ]]; then   
      echo -e "\033[1m\033[34m\n\tEl archivo de configuracion de rofi existe, se va agregar un tema\n\t\tasi que sera necesario ser super usuario."
      echo -e "\033[1m\033[37mPresione enter para seguir..."
      rm -i $HOME/.config/rofi/* 2> /dev/null
      rofi_config
   
   else
      mkdir $HOME/.config/rofi  2> /dev/null
      rofi_config   
   
   fi

# Configuracion de zsh + oh-my-zsh
   if [[ -f /usr/bin/zsh ]]; then  
      zsh_config 2> /dev/null
   
   else
      sudo apt install zsh
      zsh_config 2> /dev/null
   fi

}


# Condicionales de oh-my-zsh y rofi
function oh-my-zsh_rofi (){

# Si existen esos directorios se va a ejecutar sin_nombre
   if [[ -d $HOME/.config/bspwm && -d $HOME/.config/sxhkd ]]; then
      copiar_config
      echo -e "\033[1m\033[32m\tExisten las carpetas de bspwm, se adjuntaron los archivos de configuracion."
      sin_nombre

# Si no va a crearlos y ejcutara sin_nombre
   else
      crear_carpetas 2> /dev/null
      copiar_config
      echo -e "\033[1m\033[31m\tSe crearon las carpetas de bspwm, se adjuntaron los archivos de configuracion."
      sin_nombre
   fi

}

function lsd () {

   read -p "Desea instalar LSDeluxe (s/n): " lsdluke

   if [[ $lsdluke == "s" ]] || [[ $lsdluke == "S" ]]; then
      echo "Espere un momento..."
      wget -q https://gutl.jovenclub.cu/wp-content/uploads/2019/04/lsd_0.14.0_amd64.zip
      unzip lsd_0.14.0_amd64.zip
      cd lsd_0.14.0_amd64; sudo dpkg -i lsd_0.14.0_amd64.deb 

   elif [[ $lsdluke == "n" ]] || [[ $lsdluke == "N" ]]; then
      echo "Eligio no"
   
   else
     echo "Opcion no valida";  
   fi
}




#wget https://gutl.jovenclub.cu/wp-content/uploads/2019/04/lsd_0.14.0_amd64.zip
#cd lsd_0.14.0_amd64; sudo dpkg -i lsd_0.14.0_amd64.deb 
#   rm lsd_0.14.0_amd64.zip -rf lsd_0.14.0_amd64






# Si bspwm, rofi y nitrogen esta instalado va a ejecutar la funcion oh-my-zsh_rofi, si no los va a instalar

if [[ -f /usr/bin/bspwm && -f /usr/bin/rofi && -f /usr/bin/nitrogen ]]; then
   oh-my-zsh_rofi 
   lsd

else 
   echo -e "\033[1m\033[37m\t\Es necesario ser super usuario para seguir.\n"
   sudo apt install bspwm rofi nitrogen
   oh-my-zsh_rofi 
   lsd 

fi