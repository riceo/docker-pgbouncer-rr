FROM debian:jessie

WORKDIR /opt/pgbouncer

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y -q \
	libevent-dev \
	libssl-dev \
	git	\
	libtool	\
	python-dev \
	autotools-dev \
	automake \
	pkg-config \
	build-essential

RUN git clone https://github.com/pgbouncer/pgbouncer.git /opt/pgbouncer && \
	git clone https://github.com/riceo/pgbouncer-rr-patch.git /opt/pgbouncer-rr-patch && \
	cd /opt/pgbouncer-rr-patch && ./install-pgbouncer-rr-patch.sh /opt/pgbouncer && \
	mkdir /etc/pgbouncer-rr && \
	useradd -m pgbouncer && chown -R pgbouncer:pgbouncer /etc/pgbouncer-rr

RUN git submodule init && git submodule update \
	&& ./autogen.sh && ./configure && make && make install

VOLUME /etc/pgbouncer-rr

EXPOSE 5439

CMD ["/usr/local/bin/pgbouncer", "/etc/pgbouncer-rr/pgbouncer.conf"]
