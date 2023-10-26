# We'd like to just use the regular caddy image
# But it doesn't include any extensions, and this is the defacto way to add em
# So the process here is to build new image, push up, and use that
# Shouldn't need to do this very often at all, but for when you do need to
# Use the following commands
#
# docker buildx build . -t "pickledish/caddy:$(git rev-parse --short HEAD)"
# docker push "pickledish/caddy:$(git rev-parse --short HEAD)"

FROM caddy:2.7-builder AS builder

RUN xcaddy build --with github.com/mholt/caddy-l4 --with github.com/gamalan/caddy-tlsredis

FROM caddy:2.7

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
