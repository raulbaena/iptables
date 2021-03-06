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

#Regles amb treafic input output
#permetr navegar web(mal feta)
#iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
#iptables -A INPUT -p tcp --sport 80 -j ACCEPT
#filtrant el trafic nomes de resposta
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --sport 80 -m tcp -m state --state RELATED,ESTABLISHED -j ACCEPT #-m state carregant el modul que pregunta als pquest el seu stat


