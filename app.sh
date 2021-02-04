#!/bin/bash

# App version
version="1.0.4"

# Delay in seconds (default - 10 minutes)
delay="${DELAY:-600}"

# Wifi interface (default - wlan0)
wlan="${WLAN:-wlan0}"

# Wifi interface (default - 192.168.0.100)
mqtt_url="${MQTT_URL:-192.168.0.100}"

# Topic to publish results
mqtt_topic="${MQTT_TOPIC:-wifi/scan}"

echo
echo "Wifi scan By Eyal Cohen, version $version"
echo
echo "Configuration:"
echo
echo "  Delay      - $delay"
echo "  Interface  - $wlan"
echo "  Mqtt URL   - $mqtt_url"
echo "  Mqtt topic - $mqtt_topic"

while true
do
  values=()
  
  for i in $( iwlist $wlan scan | bash scan.sh ); do
    values+=($i)
  done

  # Extract ssid channel and reset first item
  ssid_channel=${values[0]}
  channels=("${values[@]:1:13}")
  levels=("${values[@]:14:26}")

  # Get the number of networks in the ssid channel
  channel=$((ssid_channel-1))
  ssid_networks=${channels[$channel]}

  # Total number of networks
  total=0
  for i in ${channels[@]}; do
    let total+=$i
  done
  
  # Convert to jsion array format
  channels=$(printf ",%s" "${channels[@]}")
  channels=$(echo \[${channels:1}\])
  levels=$(printf ",%s" "${levels[@]}")
  levels=$(echo \[${levels:1}\])
  
  # Publish
  message=$(echo \{\"state\":$total,\"version\":\"$version\",\"ssid_channel\":$ssid_channel,\"ssid_networks\":$ssid_networks,\"channels\":$channels,\"levels\":$levels\})
  mosquitto_pub -h $mqtt_url -t $mqtt_topic -m $message

  # Wait before next scan
  sleep $delay
done