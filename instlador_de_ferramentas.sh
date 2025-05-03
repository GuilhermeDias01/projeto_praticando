#!/bin/bash

set -e

echo "Atualizando pacotes..."
sudo apt update && sudo apt upgrade -y

echo "Instalando pacotes básicos..."
sudo apt install -y git curl wget zsh build-essential

echo "Instalando Python e pip..."
sudo apt install -y python3 python3-pip

echo "Instalado Node.js (via nvm)..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"
nvm install --lts

echo "Verificando instalação do Docker..."
if dpkg -l | grep -q containerd; then
	echo "Pacote 'containerd' encontrado. Removendo para evitar conflitos..."
	sudo apt-get remove --purge -y containerd
fi

echo "Corrigindo pacotes quebrados..."
sudo apt-get install -f -y

echo "Verificando pacotes 'held'..."
held_packages=$(dpkg --get-selections | grep hold || true)
if [[ -n "$held_packages" ]]; then
	echo "Encontrado pacotes 'held'. Removendo o hold..."
	echo "$held_packages" | awk '{print $1}' | xargs sudo apt-mark unhold
else
	echo "Nenhum pacote 'held' econtrado."	
fi

echo "Instalando Docker (método oficial)..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

echo "Adicionando usuário ao grupo Docker..."
sudo usermod -aG docker $USER

echo "Configurando aliases e prompt..."
echo 'alias gs="git status"' >> ~/.bashrc
echo 'alias ll="ls -lah"' >> ~/.bashrc
echo 'export EDITOR=nano' >> ~/.bashrc

echo "Instalação finalizada. Reinicie o terminal ou execute 'source ~/.bashrc'"

