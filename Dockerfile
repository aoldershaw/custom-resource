FROM ubuntu

RUN apt-get update && apt-get install -y jq python

COPY assets /opt/resource
