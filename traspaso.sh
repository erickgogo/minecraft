docker run -d -it \
  --name minecraft \
  -p 25565:25565 \
  -v $(pwd)/data:/data \
  -e EULA=TRUE \
  -e VERSION=1.21.1 \
  -e TYPE=PAPER \
  itzg/minecraft-server
