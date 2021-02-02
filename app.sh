#!/bin/bash

# Delay in seconds (default - 1 hour)
delay="${DELAY:-3600}"

# Wifi interface (default - wlan0)
wlan="${WLAN:-wlan0}"

# Wifi interface (default - 192.168.0.100)
mqtt_url="${MQTT_URL:-192.168.0.100}"

# Topic to publish results
mqtt_topic="${MQTT_TOPIC:-wifi/scan}"

while true
do
  channels=$(iwlist $wlan scan | bash scan.sh)

  # Total number of networks
  total=0
  for i in ${channels[@]}; do
    let total+=$i
  done

  # Publish
  message=`jo state=$total channels=$(jo -a ${channels[@]})`
  mosquitto_pub -h $mqtt_url -t $mqtt_topic -m $message

  # Wait before next scan
  sleep $delay
done