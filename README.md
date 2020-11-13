# docker-moin

Deploy a moinmoin wiki using Docker.


## Structure

This container will expose uWSGI on port 9000. The `nginx` folder contains a
recommended web server configuration.

The wiki is served from `/var/www/moin`. uWSGI runs in this directory as
`www-data`.

The `MoinMoin` source code is located at `/var/moin/install`, while the wiki
data is located at `/var/moin/data`.


## Setup

`docker-compose.yml` is an example of how to deploy this container image. If
you want to use it, be sure to configure the location of your local wiki data.
It is currently configured to look at `/var/moin`.

In `moinmoin/wikiconfig.py`, configure the wiki name
(`s/your_wiki_name_here/My Wiki/g`) as well as your own account name
(`s/your_name_here/MyName/g`).

> If setting up a new wiki, a superuser must be created. The easiest method is
> to use the `moin` CLI tool inside the container.
>
> ```bash
> moin --config-dir=/var/moin/data --wiki-url=example.com account create --name=MyName --email=me@example.com --password=foobar
> ```
>
> As a reminder, to access a shell inside a container, try
> `docker exec -it <CONTAINER> /bin/sh`.

Start the container and connect it a web browser. The `nginx` folder contains a
recommended web server configuration, which would be accessible on port 8080.
Just be sure to edit `nginx/moinmoin.conf` and set the domain name
(`s/your_domain_here/example.com/g`).

Open the wiki in a browser, specifically to the LanguageSetup page. Follow the
on-screen instructions for installing system (i.e. underlay) pages.


## Security

The stable release of moinmoin (v1.9) is written for python2. It is a complex
(i.e. multiple vendored libraries), web-facing (i.e. interprets and executes
user input) service. There have been high-risk CVE's as recently as November
2020 (see CVE-2020-15275).

Python 2.7 is unsupported as of January 2020.

Alpine Linux v3.10 (the last to support critical python2 dependencies) receives
security fixes only and will reach end of life in November 2021.

Good luck.


## License

All contents of this repository are licensed under BSD (see LICENSE.md).
The exceptions are vendored scripts, which will contain all relevent copyright
information internally.


