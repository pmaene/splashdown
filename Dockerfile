FROM caddy:2.1.0 AS caddy

FROM alpine:3.12.0 AS alpine

RUN mkdir /app

COPY fonts/ /app/fonts/
COPY index.html /app/

FROM scratch

COPY --from=caddy /etc/ssl/certs/ /etc/ssl/certs/
COPY --from=caddy /usr/bin/caddy /usr/bin/

COPY --from=alpine /app/ /app/

COPY Caddyfile /etc/caddy/

EXPOSE 8080

ENTRYPOINT ["caddy"]
CMD ["run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
