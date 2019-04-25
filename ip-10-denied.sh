#! /bin/bashdhc
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
#iptables -t nat -P PREROUTING DROP
#iptables -t nat -P POSTROUTING DROP #totes aquestes comandes es un no a tot


# obrir el localhost
iptables -A INPUT  -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# obrir la nostra ip
iptables -A INPUT -s 192.168.2.42 -j ACCEPT
iptables -A OUTPUT -d 192.168.2.42 -j ACCEPT

# Consultem i obrim DNS
iptables -A OUTPUT -p udp -d 192.168.0.10 --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT  -p udp -s 192.168.0.10  --sport 53 -m state --state ESTABLISHED     -j ACCEPT
iptables -A OUTPUT -p tcp -d 192.168.0.10  --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT  -p tcp -s 192.168.0.10  --sport 53 -m state --state ESTABLISHED     -j ACCEPT
iptables -A OUTPUT -p udp -d 10.1.1.200 --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT  -p udp -s 10.1.1.200 --sport 53 -m state --state ESTABLISHED     -j ACCEPT
iptables -A OUTPUT -p tcp -d 10.1.1.200 --dport 53 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT  -p tcp -s 10.1.1.200 --sport 53 -m state --state ESTABLISHED     -j ACCEPT

#dhclient(68)
iptables -A INPUT -p tcp -m tcp --dport 68 -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --sport 68 -j ACCEPT

#ssh (22)
iptables -A INPUT -p tcp --dport 22 -m state --state ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m state --state NEW,ESTABLISHED -j ACCEPT

#rpc 111, 507
iptables -A INPUT -p tcp -m state --state ESTABLISHED --dport 111 -j ACCEPT
iptables -A OUTPUT -p tcp -m state --state NEW,ESTABLISHED --sport 111 -j ACCEPT
iptables -A INPUT -p tcp -m state --state ESTABLISHED --dport 507 -j ACCEPT
iptables -A OUTPUT -p tcp -m state --state NEW,ESTABLISHED --sport 507 -j ACCEPT

#chronyd 123, 371
iptables -A OUTPUT -p udp --dport 123 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT  -p udp --sport 123 -m state --state ESTABLISHED     -j ACCEPT
iptables -A OUTPUT -p udp --dport 371 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT  -p udp --sport 371 -m state --state ESTABLISHED     -j ACCEPT

#cups 631
iptables -A INPUT -p tcp -m state --state ESTABLISHED --dport 631 -j ACCEPT
iptables -A OUTPUT -p tcp -m state --state NEW,ESTABLISHED --sport 631 -j ACCEPT

#xinetd 3411
iptables -A INPUT -p tcp -m state --state ESTABLISHED --dport 3411 -j ACCEPT
iptables -A OUTPUT -p tcp state --state NEW,ESTABLISHED  --sport 3411 -j ACCEPT

#postgresql 5432
iptables -A INPUT -p tcp --state ESTABLISHED --dport 5432 -j ACCEPT
iptables -A OUTPUT -p tcp --state NEW,ESTABLISHED --sport 5432 -j ACCEPT

#x11forwarding 6010, 6011
iptables -A INPUT -p tcp --state ESTABLISHED --dport 6010 -j ACCEPT
iptables -A OUTPUT -p tcp --state NEW,ESTABLISHED --sport 6010 -j ACCEPT
iptables -A INPUT -p tcp --state ESTABLISHED --dport 6011 -j ACCEPT
iptables -A OUTPUT -p tcp --state NEW,ESTABLISHED --sport 6011 -j ACCEPT

#avahi 368
iptables -A INPUT -p tcp -m tcp --dport 368 -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --sport 368 -j ACCEPT

#alpes 462
iptables -A INPUT -p tcp -m tcp --dport 462 -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --sport 462 -j ACCEPT

#tcpnethaspsrv 475
iptables -A INPUT -p tcp -m tcp --dport 475 -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --sport 475 -j ACCEPT

#rxe 761
iptables -A INPUT -p tcp -m tcp --dport 761 -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --sport 761 -j ACCEPT

