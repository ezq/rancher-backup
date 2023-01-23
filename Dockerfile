FROM debian

MAINTAINER Ezequiel Cardinali <ecardinali@gmail.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
        cron \
        curl \
        ca-certificates \
        git \
        && rm -rf /var/lib/apt/lists/*


COPY bin/rancher /usr/local/bin/
COPY bin/rancher-compose /usr/local/bin/
COPY ./entry_point.sh /

RUN git clone http://github.com/nikitux/ranchervm.git ~/.ranchervm
ENV PATH="${PATH}:~/.ranchervm/bin"

CMD ["/entry_point.sh"]

