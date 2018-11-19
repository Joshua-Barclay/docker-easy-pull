FROM docker:stable-dind

COPY daemon.json /etc/docker/daemon.json

COPY easypull-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["easypull-entrypoint.sh"]

# CMD ["/bin/sh"]
