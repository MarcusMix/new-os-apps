# Script de Instalação Automatizada com Verificação para Flatpaks

Este script verifica se determinados aplicativos estão instalados no sistema e, caso não estejam, realiza a instalação via Flatpak a partir do repositório Flathub. Ele garante que aplicativos já instalados (por outras fontes, como Snap ou Apt) não sejam duplicados.

## Aplicativos Instalados

O script verifica e instala automaticamente os seguintes softwares, caso não estejam presentes:

- **Git**
- **OpenJDK 17**
- **VS Code**
- **DBeaver**
- **Postman**
- **Podman**
- **Docker**
- **Warp Terminal**
- **Flameshot**
- **OBS Studio**
- **VLC**

## Pré-requisitos

- **Linux** (Ubuntu, Fedora, ou sistemas compatíveis com Flatpak)
- **Flatpak** configurado. Se o Flatpak não estiver instalado, o script faz a instalação automaticamente.

## Como Usar o Script

### 1. Salve o código do script

Salve o código abaixo em um arquivo chamado `install_flatpaks_check.sh`:

```bash
#!/bin/bash

# Função para verificar se o comando existe
function check_and_install_flatpak() {
    local app_name=$1
    local flatpak_id=$2

    # Verifica se o aplicativo já está instalado no sistema
    if command -v $app_name &> /dev/null; then
        echo "$app_name já está instalado. Pulando..."
    else
        echo "Instalando $app_name..."
        flatpak install -y flathub $flatpak_id
    fi
}

# Atualiza o sistema
sudo apt update && sudo apt upgrade -y

# Instala o Flatpak se ainda não estiver instalado
if ! command -v flatpak &> /dev/null; then
    echo "Instalando o Flatpak..."
    sudo apt install -y flatpak
    # Adiciona o repositório Flathub (caso ainda não esteja configurado)
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

# Lista de aplicativos com seus IDs do Flathub
echo "Verificando e instalando aplicativos via Flatpak, caso necessário..."

check_and_install_flatpak "git" "com.git.Git"
check_and_install_flatpak "javac" "org.freedesktop.Sdk.Extension.openjdk17"    # OpenJDK
check_and_install_flatpak "code" "com.visualstudio.code"                      # VS Code
check_and_install_flatpak "dbeaver" "io.dbeaver.DBeaverCommunity"             # DBeaver
check_and_install_flatpak "postman" "com.getpostman.Postman"                  # Postman
check_and_install_flatpak "podman" "io.podman_desktop.PodmanDesktop"          # Podman
check_and_install_flatpak "docker" "io.docker.DockerDesktop"                  # Docker
check_and_install_flatpak "warp" "dev.warp.Warp"                              # Warp Terminal
check_and_install_flatpak "flameshot" "org.flameshot.Flameshot"               # Flameshot
check_and_install_flatpak "obs" "com.obsproject.Studio"                       # OBS Studio
check_and_install_flatpak "vlc" "org.videolan.VLC"                            # VLC

echo "Instalação concluída!"
