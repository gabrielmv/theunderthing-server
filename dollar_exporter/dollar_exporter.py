import time
import json
import requests
from prometheus_client.core import GaugeMetricFamily, REGISTRY, CounterMetricFamily
from prometheus_client import start_http_server


class DollarCollector(object):
    def __init__(self):
        pass

    @staticmethod
    def _get_dollar_price():
        response = requests.get("https://app-api.remessaonline.com.br/v1/simulator?operationType=inbound&inputCurrencyISOCode=USD&outputCurrencyISOCode=BRL&amount=1&targetCustomerType=business")
        data = json.loads(response.content)
        return data["simulation"]["tradingQuotation"]

    def collect(self):
        dollar_price = self._get_dollar_price()

        g = GaugeMetricFamily("dollar_price", 'USD price in BRL', labels=['dollar_price'])
        g.add_metric(["dollar_price"], dollar_price)
        yield g


if __name__ == '__main__':
    start_http_server(9991)
    REGISTRY.register(DollarCollector())
    while True:
        time.sleep(1)
