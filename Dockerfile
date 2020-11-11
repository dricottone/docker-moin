
# Alpine Linux removed uwsgi-python in v3.11
FROM alpine:3.10

RUN apk add python uwsgi uwsgi-python

COPY build/moin-1.9.11/setup.py /var/moin/install
COPY build/moin-1.9.11/wiki /var/moin/wiki
COPY moinmoin/* /var/moin/wiki/

RUN find /var/moin -type d -exec chmod 775 {} \; \
	&& find /var/moin -type f -exec chmod 664 {} \; \
	&& chown www-data:www-data /var/moin -R
RUN cd /var/moin/install && python setup.py install --record=install.log

EXPOSE 9000
WORKDIR /var/moin
CMD /usr/sbin/uwsgi --ini /var/moin/uwsgi.ini

