#!/bin/bash
echo "Insert IP of the client that you want add" && read ipclient
mask="/32"
ipc=$ipclient$mask
echo $ipc
echo ""

#Publi Key of the client
echo "Insert Public Key of the client that you want add" && read pubkey
echo ""

#Add wg peer
wg set wg0 peer $pubkey allowed-ips $ipc
ip -4 route add $ipc dev wg0

# Enable VPN service at startup
systemctl enable wg-quick@wg0
# Start VPN service
systemctl start wg-quick@wg0
# Staus VPN service
systemctl status wg-quick@wg0

# Test server ping

ping -c 2 10.13.13.1 > /dev/null && echo "peer configured succesfully" || echo "peer NOT configured"

echo "Check the status"
wg