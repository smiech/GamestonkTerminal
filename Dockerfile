FROM python:3.6.13-slim-buster

RUN apt-get update && apt-get -y install --no-install-recommends \
gcc \
g++ \
make \
wget \
curl \
telnet \
net-tools \
iputils-ping \
dnsutils \
git \
gnupg \
unzip \
bzip2 && \
apt-get -y autoremove && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN useradd --create-home --shell /bin/bash python
USER python
WORKDIR /home/python

COPY --chown=python:python . .

ENV VIRTUAL_ENV=/home/python/gst-env
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir numpy==1.19.2 && \
    pip install --no-cache-dir --upgrade setuptools wheel matplotlib fbprophet && \
    pip install --upgrade plotly &&\
    INSTALL_ON_LINUX=1 pip install --no-cache-dir --upgrade -r requirements.txt

CMD ["python", "gamestonk_terminal.py"]
