# The Underthing Server

Automatic setup for a Media Server with the following services

- Plex
- Radarr
- Sonarr
- Bazarr
- Jackett
- qBittorrent
- Nginx
- Calibre Web
- Tautulli
- Primetheus
- Grafana

Also sets up a Dynamic DNS using duckdns.org. 

## Instructions
- Create an account on duckdns.org
- Fill the `.env` file with your domain and token from duckdns
- run `sudo setup.sh`
