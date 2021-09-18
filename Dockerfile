FROM alpine:3.13.6

ADD ["https://github.com/thoughtworks/talisman/releases/download/v1.22.0/talisman_linux_amd64", "/talisman"]
RUN chmod +x /talisman

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
