#!/bin/bash
iptables -t filter -A INPUT   -p udp   -m state --state NEW -j ACCEPT
iptables -t filter -A INPUT   -p udp   -m state --state NEW -j ACCEPT
iptables -t filter -A INPUT   -p udp   -m state --state NEW -j ACCEPT
 
