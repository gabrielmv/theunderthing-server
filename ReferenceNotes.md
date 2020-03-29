# Reference Notes 

## Removing password authentication

Type "sudo nano /etc/sshd_config" (without quotation marks here and throughout) and enter your administrative login password when prompted.

Step 3
Press "Ctrl+W" to open a search window; type in "PasswordAuthentication" and press "Enter."

Step 4
Remove the "#" sign at the start of the PasswordAuthentication label, then replace "Yes" with "No" so that the line reads: PasswordAuthentication no

## Creating non-root user

https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-18-04

Syncing SSH keys

```bash
rsync --archive --chown=sammy:sammy ~/.ssh /home/sammy
```

## Docker compose on startup

112

When we use crontab or the deprecated /etc/rc.local file, we need a delay (e.g. sleep 10, depending on the machine) to make sure that system services are available. Usually, systemd (or upstart) is used to manage which services start when the system boots. You can try use the similar configuration for this:

```vim
# /etc/systemd/system/docker-compose-app.service

[Unit]
Description=Docker Compose Application Service
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/srv/docker
ExecStart=/usr/local/bin/docker-compose up -d
ExecStop=/usr/local/bin/docker-compose down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
```

Or, if you want run without the -d flag:

```vim
# /etc/systemd/system/docker-compose-app.service

[Unit]
Description=Docker Compose Application Service
Requires=docker.service
After=docker.service

[Service]
WorkingDirectory=/srv/docker
ExecStart=/usr/local/bin/docker-compose up
ExecStop=/usr/local/bin/docker-compose down
TimeoutStartSec=0
Restart=on-failure
StartLimitIntervalSec=60
StartLimitBurst=3

[Install]
WantedBy=multi-user.target
```
Change the WorkingDirectory parameter with your dockerized project path. And enable the service to start automatically:


systemctl enable docker-compose-app

## Configuring Firewall

https://www.digitalocean.com/community/tutorials/ufw-essentials-common-firewall-rules-and-commands

### Commands used
    - sudo ufw status
    - ufw allow OpenSSH
    - sudo ufw allow 443
    - sudo ufw allow 32400

## Certbot

sudo apt-get update
sudo apt-get install software-properties-common
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update


sudo apt-get install certbot python-certbot-nginx

sudo certbot certonly --manual --preferred-challenges dns

To check if text entry is active:
    - https://mxtoolbox.com/TXTLookup.aspx