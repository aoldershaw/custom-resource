FROM ubuntu

RUN apt-get update && apt-get install -y jq python && rm -rf /var/lib/apt/lists/*

COPY assets /opt/resource
