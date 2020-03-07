# Environment Variables
source .env

# Install dependencies
apt install py-pip python-dev libffi-dev openssl-dev gcc libc-dev make curl

# Install duckdns.org cronjob
mkdir duckdns
cd duckdns
rm -rf duck.sh
echo "echo url=\"https://www.duckdns.org/update?domains=${DOMAIN}\&token=${TOKEN}\" | curl -k -o ~/duckdns/duck.log -K -" >> duck.sh
chmod 700 duck.sh
echo "*/5 * * * * ~/duckdns/duck.sh >/dev/null 2>&1" >> crontab -e
./duck.sh
cd

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
usermod -aG docker $USER
chmod +x /usr/local/bin/docker-compose

# Run Server containers
PUID=`(id -u $USER)`
PGID=`(id -g $USER)`

docker-compose up


# zfs
sudo apt install zfsutils-linux -y
sudo zpool create yosemite /dev/sdb

#docker

sudo chown -R gabriel:gabriel /yosemite
sudo chmod -R 777 /yosemite

docker create \
  --name=jackett \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=America/Sao_Paulo \
  -p 9117:9117 \
  -v ~/config:/config \
  -v /yosemite/downloads:/downloads \
  --restart unless-stopped \
  linuxserver/jackett

docker create \
  --name=deluge \
  --net=host \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=America/Sao_Paulo \
  -e UMASK_SET=022 `#optional` \
  -e DELUGE_LOGLEVEL=error `#optional` \
  -v ~/config:/config \
  -v /yosemite/downloads:/downloads \
  --restart unless-stopped \
  linuxserver/deluge

docker run \
  --name=sonarr \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=America/Sao_Paulo \
  -e UMASK_SET=022 `#optional` \
  -p 8989:8989 \
  -v ~/config:/config \
  -v /yosemite/tvseries:/tv \
  -v /yosemite/downloads:/downloads \
  --restart unless-stopped \
  linuxserver/sonarr

docker create \
  --name=radarr \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=America/Sao_Paulo \
  -e UMASK_SET=022 `#optional` \
  -p 7878:7878 \
  -v ~/config:/config \
  -v /yosemite/movies:/movies \
  -v /yosemite/downloads:/downloads \
  --restart unless-stopped \
  linuxserver/radarr

docker create \
  --name=plex \
  --net=host \
  -e PUID=1000 \
  -e PGID=1000 \
  -e VERSION=docker \
  -e UMASK_SET=022 `#optional` \
  -v ~/config:/config \
  -v /yosemite/tvseries:/tv \
  -v /yosemite/movies:/movies \
  --restart unless-stopped \
  linuxserver/plex
