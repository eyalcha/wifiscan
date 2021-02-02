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

Wifi scan sensor

```
```

Channel specific sensor

```
```