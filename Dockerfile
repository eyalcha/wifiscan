FROM balenalib/raspberry-pi

RUN apt-get update && \
    apt-get upgrade --yes && \
    apt-get --yes --no-install-recommends install \
      wireless-tools \
      mosquitto-clients \
      jo

WORKDIR app

COPY *.sh ./

CMD ["/bin/bash", "/app/app.sh"]
