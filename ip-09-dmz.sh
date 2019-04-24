
#Configurar un host/router amb dues xarxes privades locals xarxaA i xarxaB i una tercera xarxa DMZ amb servidors: 
#nethost, ldap, kerberos, samba. Implementar-ho amb containers i xarxes docker.

#Exercicis a implementar:
#(1) des d'un host exterior accedir al servei ldap de la DMZ. Ports 389, 636.
#(2) des d'un host exterior, engegar un container kclient i obtenir un tiket kerberos del servidor de la DMZ. Ports: 88, 543, 749.
#(3) des d'un host exterior muntar un recurs samba del servidor de la DMZ.