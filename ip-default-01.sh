#! /bin/bash
#edt ASIX m11 2018-2019
#Raul Baena Nocea
#Exemples iptables
#----------------------------i
iptables -F #Flush the selected chain
iptables -X # Delete  the  optional user-defined chain specified.
iptables -Z
iptables -t nat -F
#Permetre tot al localhost tot lo que sigui de mi a mi mateix
iptables -A INPUT -i lo -j ACCEPT #-A append, afegeix -i interficie input, -j accio
iptables -A OUTPUT -o lo -j ACCEPT #-o inetficie output

#Permetre el trafic per la nostra ip
iptables -A INPUT -s 192.168.2.42 -j ACCEPT #-s posar la ip input (source)
iptables -A OUTPUT -d 192.168.2.42 -j ACCEPT #-d posar la ip output (destiantion)

iptables -A INPUT -p tcp --dport 80 -j ACCEPT 
iptables -A INPUT -p tcp --dport 2080 -j DROP # -p trafic
iptables -A INPUT -p tcp --dport 3080 -j DROP
iptables -A INPUT -p tcp --dport 4080 -s 192.168.2.56 -j DROP
iptables -A INPUT -p tcp --dport 4080 -j ACCEPT
#port 5080n tancat a tothom, obert a hisx2 y tancat a i26
iptables -A INPUT -p tcp --dport 5080 -s 192.168.2.56 -j DROP
iptables -A INPUT -p tcp --dport 5080 -s 192.168.2.0/24 -j ACCEPT #Grup hisx
iptables -A INPUT -p tcp --dport 5080 -j DROP
#port 700 obert a tohom, tancat hisx2, obert i06
iptables -A INPUT -p tcp --dport 7080 -s 192.168.2.36 -j ACCEPT
iptables -A INPUT -p tcp --dport 7080 -s 192.168.2.0/24 -j REJECT
iptables -A INPUT -p tcp --dport 7080 -j ACCEPT
#Exemple rango: tancar rang port 3000:8000
#iptables -A INPUT -p tcp --dport 3000:8000 -j DROP
#NO PUEDES PASAR SI EJECUTAS EL RANGO!
#Regles OUTPUT

#########################################################################
