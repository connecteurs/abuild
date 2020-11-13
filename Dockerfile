FROM registry.gitlab.com/les-connecteurs/docker/alpine

RUN apk add --update-cache \
  alpine-conf \
  alpine-sdk \
  sudo \
  ccache \
  && apk upgrade -a \
  && setup-apkcache /var/cache/apk

RUN adduser -D builder \
  && addgroup builder abuild \
  && echo 'builder ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

WORKDIR /home/builder
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh
USER builder
RUN mkdir packages

ENTRYPOINT ["/home/builder/entrypoint.sh"]
