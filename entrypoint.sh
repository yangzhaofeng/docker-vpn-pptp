#!/bin/sh

set -e

# enable IP forwarding
sysctl -w net.ipv4.ip_forward=1

# configure firewall
iptables -t nat -A POSTROUTING -s {{LOCAL_SUBNET}}.0/24 ! -d {{LOCAL_SUBNET}}.0/24 -j MASQUERADE
iptables -A FORWARD -s {{LOCAL_SUBNET}}.0/24 -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -j TCPMSS --set-mss 1356
iptables -A INPUT -i ppp0 -j ACCEPT
iptables -A OUTPUT -o ppp0 -j ACCEPT
iptables -A FORWARD -i ppp0 -j ACCEPT
iptables -A FORWARD -o ppp0 -j ACCEPT

exec "$@"
