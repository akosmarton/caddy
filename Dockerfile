FROM golang:alpine AS builder

RUN apk update && apk add git
RUN go get github.com/mholt/caddy/caddy

FROM alpine

COPY --from=builder /go/bin/caddy /

ENV CADDYPATH=/data

VOLUME /data
EXPOSE 80 443

ENTRYPOINT ["/caddy"]
CMD ["-agree", "-log", "stdout", "-conf", "/data/Caddyfile"]
