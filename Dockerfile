FROM ghcr.io/connecteurs/alpine:v3.19.1

RUN apk add \
  alpine-conf \
  alpine-sdk \
  sudo \
  ccache \
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
