FROM nodered/node-red-docker:slim
ENV RED_PORT=1880
USER root

RUN apk --no-cache upgrade \
 && apk --no-cache add \
    cmake libuv-dev build-base \
    sudo bash wget curl openssh git \
    python \
    ffmpeg

# Install dumb-init (avoid PID 1 issues). https://github.com/Yelp/dumb-init
RUN curl -Lo /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 \
 && chmod +x /usr/local/bin/dumb-init

USER node-red
EXPOSE $RED_PORT
VOLUME /data

ADD entrypoint.sh /
ENTRYPOINT  ["dumb-init","/entrypoint.sh"]
