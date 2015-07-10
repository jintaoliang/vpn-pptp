FROM ubuntu:latest
MAINTAINER Jintao Liang <jintaoleong@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y pptpd iptables
RUN echo -e "localip 128.199.132.19\nremoteip 10.99.99.100-199" >> /etc/pptpd.conf
RUN echo -e "ms-dns 8.8.8.8\nms-dns 8.8.4.4" >> /etc/ppp/pptpd-options
RUN echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
RUN echo sysctl -p

COPY entrypoint.sh /entrypoint.sh
RUN chmod 0700 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["pptpd", "--fg"]
