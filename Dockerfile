FROM docker:stable-dind

ARG INSECURE_REGS=""
ENV INSECURE_REGS="${INSECURE_REGS}"

COPY daemon.json /etc/docker/daemon.json

COPY easypull-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["easypull-entrypoint.sh"]

# CMD ["/bin/sh"]
