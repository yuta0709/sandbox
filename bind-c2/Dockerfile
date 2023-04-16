FROM almalinux:latest

RUN dnf -y update && \
    dnf -y install bind bind-utils net-tools && \
    dnf clean all

COPY named.conf /etc/named.conf
COPY c2.com.zone /var/named/c2.com.zone


CMD ["/usr/sbin/named", "-c", "/etc/named.conf", "-g", "-u", "named"]