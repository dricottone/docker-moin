# NOTE: Alpine Linux removed uwsgi-python in v3.11, so using v3.10 forever
FROM alpine:3.10

RUN apk add python uwsgi uwsgi-python
RUN addgroup -S -g 82 www-data \
    && adduser -S -u 82 -D -h /var/www -s /sbin/nologin www-data

# install `MoinMoin` python package
RUN mkdir /var/moin
COPY --chown=www-data:www-data build/moin-1.9.11 /var/moin/install
RUN cd /var/moin/install && python setup.py install

# setup wiki
RUN mkdir /var/www/moin \
    && cp /usr/share/moin/server /var/www/moin/ -r \
    && cp /usr/share/moin/underlay /var/www/moin/ -r \
    && chown www-data:www-data /var/www/moin -R
COPY --chown=www-data:www-data moinmoin/* /var/www/moin/

EXPOSE 9000
WORKDIR /var/www/moin
ENTRYPOINT ["/usr/sbin/uwsgi"]
CMD ["--ini", "/var/www/moin/uwsgi.ini"]

