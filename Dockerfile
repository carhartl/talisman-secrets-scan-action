FROM ubuntu:20.04

RUN apt update && apt install -y git

ADD ["https://github.com/thoughtworks/talisman/releases/download/v1.26.0/talisman_linux_amd64", "/talisman"]
RUN chmod +x /talisman

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
