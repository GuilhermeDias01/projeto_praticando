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

echo "Instalando Docker..."
sudo apt install -y docker.io
sudo usermod -aG docker $USER

echo "Configurando aliases e prompt..."
echo 'alias gs="git status"' >> ~/.bashrc
echo 'alias ll="ls -lah"' >> ~/.bashrc
echo 'export EDITOR=nano' >> ~/.bashrc

echo "Instalação finalizada. Reinicie o terminal ou execute 'source ~/.bashrc'"

