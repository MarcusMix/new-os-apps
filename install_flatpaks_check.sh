#!/bin/bash

# Função para verificar se um programa já está instalado
function is_installed {
    command -v "$1" &> /dev/null
}

# Atualiza o sistema
sudo apt update && sudo apt upgrade -y

# Instala o Flatpak se ainda não estiver instalado
if ! is_installed flatpak; then
    echo "Instalando o Flatpak..."
    sudo apt install -y flatpak
    # Adiciona o repositório Flathub (caso ainda não esteja configurado)
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

echo "Iniciando a instalação dos programas..."

# Instalação dos programas desejados via Flatpak, se ainda não estiverem instalados

# Git
if ! is_installed git; then
    sudo apt install -y git
else
    echo "Git já está instalado."
fi

# OpenJDK
if ! is_installed java; then
    sudo apt install -y openjdk-17-jdk
else
    echo "Java JDK já está instalado."
fi

# VS Code
if ! is_installed code; then
    flatpak install -y flathub com.visualstudio.code
else
    echo "VS Code já está instalado."
fi

# DBeaver
if ! flatpak list | grep -q "DBeaverCommunity"; then
    flatpak install -y flathub io.dbeaver.DBeaverCommunity
else
    echo "DBeaver já está instalado."
fi

# Postman
if ! flatpak list | grep -q "Postman"; then
    flatpak install -y flathub com.getpostman.Postman
else
    echo "Postman já está instalado."
fi

# Podman Desktop
if ! flatpak list | grep -q "PodmanDesktop"; then
    flatpak install -y flathub io.podman_desktop.PodmanDesktop
else
    echo "Podman Desktop já está instalado."
fi

# Docker Desktop (substituto para Docker CLI)
if ! flatpak list | grep -q "DockerDesktop"; then
    flatpak install -y flathub io.docker.DockerDesktop
else
    echo "Docker Desktop já está instalado."
fi

# Warp Terminal
if ! flatpak list | grep -q "Warp"; then
    flatpak install -y flathub dev.warp.Warp
else
    echo "Warp Terminal já está instalado."
fi

# Flameshot
if ! flatpak list | grep -q "Flameshot"; then
    flatpak install -y flathub org.flameshot.Flameshot
else
    echo "Flameshot já está instalado."
fi

# OBS Studio
if ! flatpak list | grep -q "OBS Studio"; then
    flatpak install -y flathub com.obsproject.Studio
else
    echo "OBS Studio já está instalado."
fi

# VLC
if ! is_installed vlc && ! flatpak list | grep -q "VLC"; then
    flatpak install -y flathub org.videolan.VLC
else
    echo "VLC já está instalado."
fi

echo "Processo de instalação concluído!"