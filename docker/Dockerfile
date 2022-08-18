ARG TAILSCALE_TAG=latest
FROM docker.io/tailscale/tailscale:${TAILSCALE_TAG}

COPY tailscale-entrypoint.sh /usr/local/bin/tailscale-entrypoint.sh
RUN chmod +x /usr/local/bin/tailscale-entrypoint.sh
CMD ["/usr/local/bin/tailscale-entrypoint.sh"]