FROM centos:7
MAINTAINER Jamie Neil <jamie.neil@healthforge.io>

USER root
EXPOSE 3000

VOLUME ["/var/lib/grafana", "/var/log/grafana"]

ENV GRAFANA_VERSION="4.0.2" \
    GRAFANA_BUILD="1481203731"

RUN yum -y install https://grafanarel.s3.amazonaws.com/builds/grafana-"$GRAFANA_VERSION"-"$GRAFANA_BUILD".x86_64.rpm \
    && yum clean all

COPY run.sh /usr/share/grafana
RUN for d in /usr/share/grafana /etc/grafana /var/lib/grafana /var/log/grafana; do chgrp -R 0 $d; chmod -R g+rwX $d; done

WORKDIR /usr/share/grafana
CMD ["./run.sh"]
