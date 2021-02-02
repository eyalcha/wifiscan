# Wifiscna

Run wifi scan to detect and publish number of active networks in each channel.

## Docker

To build the docker image

```
docker build -t  wifiscan .
```

To start wifiscan container

```
docker run -d --name wifiscan --network host --privileged wifiscan
```

Running with different settings (e.g., change delay time)

```
docker run -d --name wifiscan --network host --privileged -e DELAY=1800 wifiscan
```

## Configuration

Name | Description | Default
---|---|---
DELAY | Number of seconds between scans | 3600
WLAN | INterface to use | wlan0
MQTT_URL | Mqtt broker IP | 192.168.0.100
MQTT_TOPIC | Mqtt topic | wifi/scan

## Home assiatnt sensor

The following sensor can be used to track the number of networks in wifi channel 7:

```
sensor:
  - platform: mqtt
    name: Wifi channel 7
    state_topic: "wifi/scan"
    value_template: "{{ value_json['channels'][7] }}"
```

## Wifi channels and frequency

Channel 01 : 2.412 GHz
Channel 02 : 2.417 GHz
Channel 03 : 2.422 GHz
Channel 04 : 2.427 GHz
Channel 05 : 2.432 GHz
Channel 06 : 2.437 GHz
Channel 07 : 2.442 GHz
Channel 08 : 2.447 GHz
Channel 09 : 2.452 GHz
Channel 10 : 2.457 GHz
Channel 11 : 2.462 GHz
Channel 12 : 2.467 GHz
Channel 13 : 2.472 GHz