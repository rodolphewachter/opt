#!/bin/bash

chemin="/opt/firewall"
# Remise à 0 :

iptables -t filter -F
iptables -t filter -X

# Interdiction :

iptables -t filter -P INPUT DROP
iptables -t filter -P FORWARD DROP
iptables -t filter -P OUTPUT DROP

# Autoriser les connexions déjà établies :

iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT

# Autoriser l'interface de loopback :

iptables -t filter -A INPUT -i lo -j ACCEPT
iptables -t filter -A OUTPUT -o lo -j ACCEPT

# Autorisation du nat : 

iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE

# Activation du routage :

echo 1 > /proc/sys/net/ipv4/ip_forward

#ICMP
iptables -t filter -A INPUT -p icmp -j ACCEPT
iptables -t filter -A OUTPUT -p icmp -j ACCEPT

# Autorisation des ports pour les services sur enp0s3 :

#SSH TCP
iptables -t filter -A INPUT -m state --state NEW -i enp0s3 -p tcp --dport 22 --syn -j ACCEPT
iptables -t filter -A OUTPUT -m state --state NEW -o enp0s3 -p tcp --dport 22 --syn -j ACCEPT

#HTTP TCP
iptables -t filter -A INPUT -m state --state NEW -i enp0s3 -p tcp --dport 80 --syn -j ACCEPT
iptables -t filter -A  OUTPUT -m state --state NEW -o enp0s3 -p tcp --dport 80 --syn -j ACCEPT

#HTTPS TCP
iptables -t filter -A INPUT -m state --state NEW -i enp0s3 -p tcp --dport 443 --syn -j ACCEPT
iptables -t filter -A OUTPUT -m state --state NEW -o enp0s3 -p tcp --dport 443 --syn -j ACCEPT

#DNS UDP

iptables -t filter -A INPUT -m state --state NEW -i enp0s3 -p udp --dport 53 -j ACCEPT
iptables -t filter -A OUTPUT -m state --state NEW -o enp0s3 -p udp --dport 53 -j ACCEPT
iptables -t filter -A INPUT -m state --state NEW -i enp0s3 -p tcp --dport 53 --syn -j ACCEPT
iptables -t filter -A OUTPUT -m state --state NEW -o enp0s3 -p tcp --dport 53 --syn -j ACCEPT

#VPN TCP
iptables -t filter -A INPUT -m state --state NEW -i enp0s3 -p tcp --dport 1194 --syn -j ACCEPT
iptables -t filter -A OUTPUT -m state --state NEW -o enp0s3 -p tcp --dport 1194 --syn -j ACCEPT
#VPN UDP
iptables -t filter -A INPUT -m state --state NEW -i enp0s3 -p udp --dport 1194 -j ACCEPT
iptables -t filter -A OUTPUT -m state --state NEW -o enp0s3 -p udp --dport 1194 -j ACCEPT

#------------------------------------------------------------
#REDIRECTION ET FILTRAGE
#------------------------------------------------------------
 
 
 
