#!/bin/bash

# Delay in seconds (default - 10 minutes)
delay="${DELAY:-600}"

# Wifi interface (default - wlan0)
wlan="${WLAN:-wlan0}"

# Wifi interface (default - 192.168.0.100)
mqtt_url="${MQTT_URL:-192.168.0.100}"

# Topic to publish results
mqtt_topic="${MQTT_TOPIC:-wifi/scan}"

while true
do
  result=$( iwlist $wlan scan | bash scan.sh )
  for i in ${result[@]}; do
    channels+=($i)
  done

  # Extract ssid channel and reset first item
  ssid_channel=${channels[0]}
  channels=("${channels[@]:1}")
  
  # Total number of networks
  total=0
  for i in ${channels[@]}; do
    let total+=$i
  done

  # Publish
  message=`jo state=$total ssid_channel=$ssid_channel channels=$(jo -a ${channels[@]})`
  mosquitto_pub -h $mqtt_url -t $mqtt_topic -m $message

  # Wait before next scan
  sleep $delay
done