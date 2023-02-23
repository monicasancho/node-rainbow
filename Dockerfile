FROM nodered/node-red-docker:slim
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
ADD settings.js /data
ADD index.html /static/index.html
ADD entrypoint.sh /

VOLUME /data
EXPOSE 1880
ENTRYPOINT  ["dumb-init","/entrypoint.sh"]
