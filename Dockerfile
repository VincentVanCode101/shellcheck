FROM alpine:3.21
RUN apk add --no-cache shellcheck bash
RUN mkdir -p /entrypoint
COPY bin/entrypoint.sh /entrypoint/entrypoint.sh
RUN chmod +x /entrypoint/entrypoint.sh
WORKDIR /workdir
ENTRYPOINT ["/entrypoint/entrypoint.sh"]
