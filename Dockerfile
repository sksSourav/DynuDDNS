FROM alpine:3.20

RUN apk add --no-cache curl bash

WORKDIR /app

COPY dynu_ddns_update.sh /app/dynu_ddns_update.sh
RUN chmod +x /app/dynu_ddns_update.sh

ENV HOSTNAME="" \
    API_KEY="" \
    INTERVAL=300

ENTRYPOINT ["/bin/sh", "-c", "/app/dynu_ddns_update.sh ${HOSTNAME} ${API_KEY} ${INTERVAL}"]
