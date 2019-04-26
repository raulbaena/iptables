#! /bin/bashdhc
#edt ASIX m11 2018-2019
#Raul Baena Nocea
#Exemples iptables
#----------------------------
echo 1 > /proc/sys/net/ipv4/ip_forward
#Regles flush
iptables -F #Flush the selected chain
iptables -X # Delete  the  optional user-defined chain specified. Cadenas personalitzadas
iptables -Z #Eleimina la cadena
iptables -t nat -F #-t This  option specifies the packet matching table which the command should operate on.

#RPolitiques per defecte
iptables -P INPUT  ACCEPT #Per defecte DROP o ACCEPT
iptables -P OUTPUT ACCEPT 
iptables -P FORWARD ACCEPT
#iptables -t nat -P PREROUTING ACCEPT
#iptables -t nat -P POSTROUTING ACCEPT #totes aquestes comandes es un no a tot
# obrir el localhost
iptables -A INPUT  -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
# obrir la nostra ip
iptables -A INPUT -s 192.168.2.42 -j ACCEPT
iptables -A OUTPUT -d 192.168.2.42 -j ACCEPT

 #Fer NAT per les xarxes internes:
iptables -t nat -A POSTROUTING -s 172.23.0.0/24 -o enp6s0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 172.24.0.0/24 -o enp6s0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 172.25.0.0/24 -o enp6s0 -j MASQUERADE
#Configurar un host/router amb dues xarxes privades locals xarxaA i xarxaB i una tercera xarxa DMZ amb servidors: 
#nethost, ldap, kerberos, samba. Implementar-ho amb containers i xarxes docker.
#Exercicis a implementar:
#(1) des d'un host exterior accedir al servei ldap de la DMZ. Ports 389, 636.
iptables -t nat -A PREROUTING -i enp5s0 -p tcp --dport 389 -j DNAT --to 172.25.0.3:389
iptables -t nat -A PREROUTING -i enp5s0 -p tcp --dport 636 -j DNAT --to 172.25.0.6:636
#(2) des d'un host exterior, engegar un container kclient i obtenir un tiket kerberos del servidor de la DMZ. Ports: 88, 543, 749.
iptables -t nat -A PREROUTING -i enp5s0 -p tcp --dport 88 -j DNAT --to 172.25.0.4:88
iptables -t nat -A PREROUTING -i enp5s0 -p tcp --dport 543 -j DNAT --to 172.25.0.4:543
iptables -t nat -A PREROUTING -i enp5s0 -p tcp --dport 749 -j DNAT --to 172.25.0.4:749
#(3) des d'un host exterior muntar un recurs samba del servidor de la DMZ.
iptables -t nat -A PREROUTING -i enp5s0 -p tcp --dport 2049 -j DNAT --to 172.25.0.4:2049