FROM ubuntu

RUN apt-get update && apt-get install -y jq

COPY assets /opt/resource
