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
