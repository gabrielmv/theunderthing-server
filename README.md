# plex-server

Automatic setup for a Plex Media Server with the following containers

- Plex
- Radarr
- Sonarr
- Jackett
- Deluge

Also sets up a Dynamic DNS using duckdns.org. 

## Instructions
- Create an account on duckdns.org
- Fill the `.env` file with your domain and token from duckdns
- run `sudo setup.sh`
