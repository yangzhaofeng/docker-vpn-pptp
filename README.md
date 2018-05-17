# VPN (PPTP) for Docker

This is a docker image with simple VPN (PPTP) server with single user.


## Starting VPN server

To start VPN server as a docker container run:

````
docker run -itd \
--restart=always \
--privileged \
--net=host \
-e PPP_USER=username \
-e PPP_PASS=pass \
-e MS_DNS1=8.8.8.8 \
-e MS_DNS2=8.8.4.4 \
-e LOCAL_SUBNET=10.250.80 \
yangzhaofengsteven/pptpd
````

If you would like the vpn to access the Internet, please add nat rules:
````
iptables -t nat -A POSTROUTING -s {{LOCAL_SUBNET}}.0/24 ! -d {{LOCAL_SUBNET}}.0/24 -j MASQUERADE
````

## Connecting to VPN service
You can use any VPN (PPTP) client to connect to the service.
To authenticate use credentials provided in _chap-secrets_ file.


**Note:** Before starting container in `--net=host` mode, please read how networking in `host` mode works in Docker:
https://docs.docker.com/reference/run/#mode-host

