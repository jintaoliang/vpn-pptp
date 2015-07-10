# Base image to use, this must be set as the first line
FROM ubuntu:14.04.2

# Maintainer: 
MAINTAINER Jintao Liang <jintaoleong@gmail.com>

RUN apt-get install -y pptpd iptables
RUN echo -e "localip 128.199.132.19\nremoteip 10.99.99.100-199" >> /etc/pptpd.conf
RUN echo -e "ms-dns 8.8.8.8\nms-dns 8.8.4.4" >> /etc/ppp/pptpd-options
RUN echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
RUN echo sysctl -p

RUN iptables -A INPUT -p tcp --dport 1723 -j ACCEPT
RUN iptables -A INPUT -p gre -j ACCEPT 
RUN iptables -t nat -A POSTROUTING -s 10.99.99.0/24 -o eth0 -j MASQUERADE 
RUN iptables -A FORWARD -p tcp --syn -s  10.99.99.0/24 -j TCPMSS --set-mss 1356

RUN /etc/init.d/pptpd restart
