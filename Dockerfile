FROM alpine

MAINTAINER Ezequiel Cardinali <ecardinali@gmail.com>

RUN apk add --no-cache curl git bash

COPY bin/rancher /usr/local/bin/
COPY bin/rancher-compose /usr/local/bin/
COPY bin/rancher-backup /usr/local/bin/
RUN ln -s /usr/local/bin/rancher-backup /etc/periodic/hourly/

CMD ["crond", "-f", "-l", "8", "-L", "/dev/stdout"]
