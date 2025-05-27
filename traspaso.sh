#!/bin/bash

# Ruta de instalación
INSTALL_DIR="$HOME/minecraft-server"
JAR_URL="https://piston-data.mojang.com/v1/objects/e6ec2f64e6080b9b5d9b471b291c33cc7f509733/server.jar"
JAR_FILE="server.jar"

# Crear directorio del servidor
echo "📁 Creando directorio en: $INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR" || exit 1

# Descargar el server.jar
echo "⬇️ Descargando servidor de Minecraft 1.21.5..."
wget -O "$JAR_FILE" "$JAR_URL"

# Aceptar el EULA
echo "✅ Aceptando el EULA..."
echo "eula=true" > eula.txt

# Crear script de inicio
echo "⚙️ Creando script de inicio..."
cat <<EOF > start.sh
#!/bin/bash
cd "\$HOME/minecraft-server"
java -Xmx1024M -Xms1024M -jar server.jar nogui
EOF

chmod +x start.sh

# Iniciar el servidor
echo "🚀 Iniciando servidor..."
./start.sh
