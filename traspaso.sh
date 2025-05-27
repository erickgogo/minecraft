#!/bin/bash

set -e

verde='\033[0;32m'
rojo='\033[0;31m'
reset='\033[0m'

echo -e "${verde}🚀 Instalación del servidor Minecraft 1.20.1 con Java 17 y descarga dinámica del server.jar${reset}"

# 1. Instalar wget, curl y jq si no están
echo -e "${verde}🔍 Instalando wget, curl y jq...${reset}"
sudo apt update
sudo apt install -y wget curl jq

# 2. Verificar que Java 17 esté instalado
echo -e "${verde}🔍 Verificando Java 17...${reset}"
if ! java -version 2>&1 | grep '17' >/dev/null; then
  echo -e "${rojo}❌ Java 17 no está instalado. Instálalo con: sudo apt install openjdk-17-jdk${reset}"
  exit 1
fi

# 3. Crear carpeta del servidor
echo -e "${verde}📁 Creando carpeta del servidor...${reset}"
cd ~
mkdir -p minecraft-server
cd minecraft-server

# 4. Obtener URL dinámica del server.jar para Minecraft 1.20.1
echo -e "${verde}🌐 Obteniendo URL oficial del server.jar para Minecraft 1.20.1...${reset}"
URL=$(curl -s https://launchermeta.mojang.com/mc/game/version_manifest.json \
      | jq -r '.versions[] | select(.id=="1.20.1") | .url' \
      | xargs curl -s | jq -r '.downloads.server.url')

echo -e "${verde}⬇️ Descargando server.jar desde:${reset} $URL"
wget -O server.jar "$URL"

# 5. Aceptar EULA
echo -e "${verde}📄 Aceptando el EULA...${reset}"
echo "eula=true" > eula.txt

# 6. Crear script de inicio
echo -e "${verde}⚙️ Creando script de inicio...${reset}"
cat <<EOF > start.sh
#!/bin/bash
java -Xmx1024M -Xms1024M -jar server.jar nogui
EOF

chmod +x start.sh

# 7. Ejecutar servidor
echo -e "${verde}🚀 Iniciando el servidor de Minecraft...${reset}"
./start.sh
