# Dockerised Pgbouncer-rr

This dockerfile will install pgbouncer on a Debian Jessie container, download the pgbouncer-rr patch,
and apply it.

*It will not start without passing it a valid Pgbouncer config file!* The Dockerfile is configured with the
assumption that you'll define a volume that will be mapped to /etc/pgbouncer-rr in the container.

Example:
```
docker run -p 5439:5439 --volume <path to pgbouncer config dir>:/etc/pgbouncer-rr riceo/docker-pgbouncer-rr:latest
```

Questions/Comments - @riceo100 / cube@sneakybox.com
