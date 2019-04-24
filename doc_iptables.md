Output: Informacio que es genera en el ordinador y va cap a fora
Input: Informacio que ve de fora cap al ordinador
Forward: Informacio que creua un router per al destinatari a travesa l'ordinador
Iptables es una feature lligada al kernel y es la manera de gorbernar la xarxa a nivell de kernel
ACCEPT: Accepta lo que t'envian o lo que surt
DROP: Rebutxa tot
REJECT: Dropea pero avisant al emisor
ICMP: Protocolo de control de mensajes de Internet
Llistar les iptables
```
[root@i12 iptables]# iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination         

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination   
```
Dimoni iptables
```
[root@i12 iptables]# systemctl status firewalld.service
● firewalld.service - firewalld - dynamic firewall daemon
   Loaded: loaded (/usr/lib/systemd/system/firewalld.service; disabled; vendor preset: enabled)
   Active: inactive (dead)
     Docs: man:firewalld(1)
```
Script iptables posem lo seguent y executem l'script
```
#Regles flush
iptables -F #Flush the selected chain
iptables -X # Delete  the  optional user-defined chain specified.
iptables -Z
iptables -t nat -F
[root@i12 iptables]# iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination         

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination
```
Les ACL es miren de adalt cap abaix y si fan match es paran, son independents cada regla s'aplica a un chain (cadena). Les OUTPUT son  OUTPUT, les INPUTS son INSPUTS y les FORDWARD son FORWARD
Posem la seguent configuracio al scrpt
```
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
```
Executem y mirem les iptables
```
[root@i12 iptables]# iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination         
ACCEPT     all  --  anywhere             anywhere            
ACCEPT     all  --  www.baena.com        anywhere            

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination         
ACCEPT     all  --  anywhere             anywhere            
ACCEPT     all  --  anywhere             www.baena.com       
```
Creem 4 servidors web en xinetd amb la seguent configuracio
```
service http-bis
{
disable = no
type = UNLISTED
socket_type = stream
protocol = tcp
wait = no
redirect = 192.168.2.42 80
bind = 0.0.0.0
port = 2080
user = nobody
}
-rw-r--r--. 1 root root  162 Apr  1 12:28 httpd-5
-rw-r--r--. 1 root root  164 Apr  1 12:26 httpd-bis
-rw-r--r--. 1 root root  168 Apr  1 12:27 httpd-quatris
-rw-r--r--. 1 root root  165 Apr  1 12:27 httpd-tris
systemctl restart xinetd
```
Primer van les regles particulars y despres les generals

Exemple que pot tothom menys el i26

Clase 3/4/2019
Exemples clase
```
#port 700 obert a tohom, tancat hisx2, obert i06
iptables -A INPUT -p tcp --dport 7080 -s 192.168.2.36 -j ACCEPT
iptables -A INPUT -p tcp --dport 7080 -s 192.168.2.0/24 -j DROP
iptables -A INPUT -p tcp --dport 7080 -j ACCEPT
```

Exemples output, hem creat un fitxer amb regles output
```

```
POSTROUTING y PREROUTING
- NAT: reglas PREROUTING, POSTROUTING
- POSTROUTING SNAT

