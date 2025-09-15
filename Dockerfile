FROM alpine:3.20

RUN apk add --no-cache curl bash

# Environment variables
ENV API_KEY=""
ENV HOSTNAME=""
ENV INTERVAL=300

# Script to update Dynu DDNS
RUN echo '#!/bin/bash\n\
while true; do\n\
  echo "Updating DNS for $HOSTNAME..."\n\
  curl -s "https://api.dynu.com/nic/update?hostname=$HOSTNAME&myip=$(curl -s ifconfig.me)&password=$API_KEY"\n\
  echo "Sleeping $INTERVAL seconds..."\n\
  sleep $INTERVAL\n\
done' > /dynu_ddns_update.sh && chmod +x /dynu_ddns_update.sh

CMD ["/dynu_ddns_update.sh"]