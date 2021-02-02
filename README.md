<p align="left"><br>
<a href="https://paypal.me/eyalco1967?locale.x=he_IL" target="_blank"><img src="http://khrolenok.ru/support_paypal.png" alt="PayPal" width="250" height="48"></a>
</p>

*Please :star: this repo if you find it useful*

# Wifi Scan

Run wifi scan to detect and publish number of active networks in each channel.

## Docker

To build the docker image

```
docker build -t  wifiscan .
```

To start wifiscan container

```
docker run -d --restart unless-stopped --name wifiscan --network host --privileged wifiscan
```

Running with different settings (e.g., change delay time)

```
docker run -d --restart unless-stopped --name wifiscan --network host --privileged -e DELAY=1800 wifiscan
```

## Configuration

Name | Description | Default
---|---|---
DELAY | Number of seconds between scans | 600 (10 minutes)
WLAN | Interface to use | wlan0
SSID | SSID name | 
MQTT_URL | Mqtt broker IP | 192.168.0.100
MQTT_TOPIC | Mqtt topic | wifi/scan

## Home assiatnt sensor

The application publish the number of discovered networks in the state field, and total number of networks per channel in the channels field. The ssid channel will be set with the channle of the specified ssid (0 if not specified).

```
{"state":6,"ssid_channel":6,"channels":[0,0,0,0,0,0,4,0,0,0,2,0,0]}
```

The following sensor can be used to track the number of networks in wifi channel 7:

```
sensor:
  - platform: mqtt
    name: Wifi channel 7
    icon: mdi:wifi
    state_topic: "wifi/scan"
    value_template: "{{ value_json['channels'][6] }}"
```

## Wifi channels and frequency

Channel | Frequency
---|---
Channel 01 | 2.412 GHz
Channel 02 | 2.417 GHz
Channel 03 | 2.422 GHz
Channel 04 | 2.427 GHz
Channel 05 | 2.432 GHz
Channel 06 | 2.437 GHz
Channel 07 | 2.442 GHz
Channel 08 | 2.447 GHz
Channel 09 | 2.452 GHz
Channel 10 | 2.457 GHz
Channel 11 | 2.462 GHz
Channel 12 | 2.467 GHz
Channel 13 | 2.472 GHz

---

I put a lot of work into making this repo and component available and updated to inspire and help others! I will be glad to receive thanks from you — it will give me new strength and add enthusiasm:
<p align="center"><br>
<a href="https://paypal.me/eyalco1967?locale.x=he_IL" target="_blank"><img src="http://khrolenok.ru/support_paypal.png" alt="PayPal" width="250" height="48"></a>
</p>
