FROM python:slim AS builder

RUN set -e \
      && apt-get -y update \
      && apt-get -y dist-upgrade \
      && apt-get -y install gcc

RUN set -e \
      && pip install -U --no-cache-dir pip v20

FROM python:slim

COPY --from=builder /usr/local /usr/local

RUN set -e \
      && ln -sf /bin/bash /bin/sh

RUN set -e \
      && apt-get -y update \
      && apt-get -y dist-upgrade \
      && apt-get -y autoremove \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/local/bin/python"]
