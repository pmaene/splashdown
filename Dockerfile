FROM caddy/caddy:scratch AS caddy

FROM alpine:latest AS alpine

RUN mkdir /data

COPY fonts/ /data/fonts/
COPY index.html /data/

FROM scratch

COPY --from=caddy /etc/ssl/certs/ /etc/ssl/certs/
COPY --from=caddy /usr/bin/caddy /usr/bin/

COPY --from=alpine /data/ /data/

COPY Caddyfile /etc/caddy/

EXPOSE 8080

ENTRYPOINT ["caddy"]
CMD ["run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
