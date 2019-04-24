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

##RPolitiques per defecte
iptables -P INPUT  ACCEPT #Per defecte DROP o ACCEPT
iptables -P OUTPUT ACCEPT 
iptables -P FORWARD ACCEPT
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT #totes aquestes comandes es un si a tot

#Permetre tot al localhost tot lo que sigui de mi a mi mateix
iptables -A INPUT -i lo -j ACCEPT #-A append, afegeix -i interficie input, -j accio
iptables -A OUTPUT -o lo -j ACCEPT #-o inetficie output

#Permetre el trafic per la nostra ip
iptables -A INPUT -s 192.168.2.42 -j ACCEPT #-s posar la ip input (source)
iptables -A OUTPUT -d 192.168.2.42 -j ACCEPT #-d posar la ip output (destiantion)

#Exemples de regles OUTPUT
#Accedir a qualsevol port/dest
#iptables -A OUTPUT -j ACCEPT
#Accedir a port 13 de qualsevol destii
##iptables -A OUTPUT -p tcp --dport 13 -j ACCEPT
#Accedir a qualsevol port 2013 excepte i06
#iptables -A OUTPUT -p tcp --dport 2013 -d 192.168.2.36 -j REJECT
#iptables -A OUTPUT -p tcp --dport 2013 -j ACCEPT
#denegar a qualsevol port 2013 excepte i06
#iptables -A OUTPUT -p tcp --dport 2013 -d 192.168.2.36 -j ACCEPT
#iptables -A OUTPUT -p tcp --dport 2013 -j REJECT
#Permet accedir al port 4000 a tothom, no a hisx2, obert a i06
#iptables -A OUTPUT -p tcp --dport 4013 -d 192.168.2.36 -j ACCEPT
#iptables -A OUTPUT -p tcp --dport 4013 -s 192.168.2.0/24 -j REJECT
#iptables -A OUTPUT -p tcp --dport 4013 -j ACCEPT
#No pot accedir a cap port 80 13 o 7
#iptables -A OUTPUT -p tcp --dport 80 -j REJECT
#iptables -A OUTPUT -p tcp --dport 13 -j REJECT
#iptables -A OUTPUT -p tcp --dport 7 -j REJECT
#No permetre accedir al host 26 ni 27
#iptables -A OUTPUT -p tcp -d 192.168.2.36 -j REJECT
#iptables -A OUTPUT -p tcp -d 192.168.2.35 -j REJECT
#No accedir a la xarxa de primer ni de segon
#iptables -A OUTPUT -p tcp -d 192.168.2.0/24 -j REJECT
#iptables -A OUTPUT -p tcp -d 192.168.1.0/24 -j REJECT
#A la xarxa hisx2 no pots accedir excepte per ssh
#ptables -A OUTPUT -p tcp --dport 22 -d 192.168.2.0/24 -j ACCEPT
#iptables -A OUTPUT -p tcp -d 192.168.2.0/24 -j REJECT

