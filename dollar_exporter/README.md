# Dollar Exporter

Get dollar rates from RemessaOnline API and export it to Prometheus

## Develop

Create virtualenv and run the application

```
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python dollar_exporter.py
```

## Run
docker build . -t dollar_exporter
docker run -d --name dollar_exporter -p 9991:9991 dollar_exporter
