#!/bin/sh

set -e

iptables -A INPUT -p tcp --dport 1723 -j ACCEPT
iptables -A INPUT -p gre -j ACCEPT 
iptables -t nat -A POSTROUTING -s 10.99.99.0/24 -o eth0 -j MASQUERADE 
iptables -A FORWARD -p tcp --syn -s  10.99.99.0/24 -j TCPMSS --set-mss 1356

exec "$@"
