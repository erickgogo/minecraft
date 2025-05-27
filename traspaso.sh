#!/bin/bash

set -e

# Colores para mensajes
verde='\033[0;32m'
rojo='\033[0;31m'
reset='\033[0m'

echo -e "${verde}🚀 Iniciando instalación del servidor de Minecraft 1.21.1...${reset}"

# 1. Instalar wget y curl si no existen
echo -e "${verde}🔍 Verificando wget y curl...${reset}"
sudo apt update
sudo apt install -y wget curl tar

# 2. Descargar e instalar Java 21 (desde Adoptium)
echo -e "${verde}📦 Descargando Java 21 desde Adoptium...${reset}"
cd ~
mkdir -p java
cd java
JDK_URL="https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.1+12/OpenJDK21U-jdk_x64_linux_hotspot_21.0.1_12.tar.gz"
wget -O java21.tar.gz "$JDK_URL"
tar -xzf java21.tar.gz
JAVA_DIR=$(find . -maxdepth 1 -type d -name "jdk-*")
JAVA_HOME="$HOME/java/$JAVA_DIR"
export PATH="$JAVA_HOME/bin:$PATH"

echo -e "${verde}✅ Java instalado: ${reset}"
java -version

# 3. Crear carpeta del servidor
echo -e "${verde}📁 Preparando carpeta del servidor...${reset}"
cd ~
mkdir -p minecraft-server
cd minecraft-server

# 4. Descargar server.jar de Minecraft 1.21.1
echo -e "${verde}⬇️ Descargando server.jar de Minecraft 1.21.1...${reset}"
MC_URL="https://launcher.mojang.com/v1/objects/f0103cce3942b049ae29e58a4eb9fe67995b37c0/server.jar"
wget -O server.jar "$MC_URL"

# 5. Crear archivo eula.txt
echo -e "${verde}📄 Aceptando el EULA...${reset}"
echo "eula=true" > eula.txt

# 6. Crear script de inicio
echo -e "${verde}⚙️ Creando script de inicio...${reset}"
cat <<EOF > start.sh
#!/bin/bash
export PATH="$JAVA_HOME/bin:\$PATH"
java -Xmx1024M -Xms1024M -jar server.jar nogui
EOF

chmod +x start.sh

# 7. Iniciar el servidor
echo -e "${verde}🚀 Iniciando el servidor de Minecraft...${reset}"
./start.sh
