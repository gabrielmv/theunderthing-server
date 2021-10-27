FROM python:3.8

COPY . /src

WORKDIR /src

RUN pip install -r requirements.txt
ENV PYTHONPATH '/src/'

EXPOSE 9991

CMD ["python" , "/src/dollar_exporter.py"]
