#! /bin/bash
#edt ASIX m11 2018-2019
#Raul Baena Nocea
#Exemples iptables
#----------------------------
#echo 1 > /proc/sys/ipv4/ip_forward
#Regles flush
iptables -F #Flush the selected chain
iptables -X # Delete  the  optional user-defined chain specified. Cadenas personalitzadas
iptables -Z #Eleimina la cadena
iptables -t nat -F #-t This  option specifies the packet matching table which the command should operate on.

#RPolitiques per defecte
iptables -P INPUT  DROP #Per defecte DROP o ACCEPT
iptables -P OUTPUT DROP 
iptables -P FORWARD DROP
iptables -t nat -P PREROUTING DROP
iptables -t nat -P POSTROUTING DROP #totes aquestes comandes es un si a tot


# obrir el localhost
iptables -A INPUT  -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# obrir la nostra ip
iptables -A INPUT -s 192.168.2.42 -j ACCEPT
iptables -A OUTPUT -d 192.168.2.42 -j ACCEPT

# Consultem i obrim DNS
iptables -A INPUT -s 192.168.0.10 -p udp  -m udp --sport 53 -j ACCEPT
iptables -A OUTPUT -d 192.168.0.10 -p udp -m udp --dport 53 -j ACCEPT
iptables -A INPUT -s 10.1.1.200 -p udp  -m udp --sport 53 -j ACCEPT
iptables -A OUTPUT -d 10.1.1.200 -p udp -m udp --dport 53 -j ACCEPT

#dhclient(68)
iptables 