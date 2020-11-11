UPSTREAM_URL_MOIN="http://static.moinmo.in/files/moin-1.9.11.tar.gz"
UPSTREAM_URL_SIG="http://static.moinmo.in/files/moin-1.9.11.tar.gz.asc"
UPSTREAM_SHA256="02be31d55f39d4fe0c6253df8b49e01b76d095634cbd1b56d185f66e1e0c3cf5"
UPSTREAM_GPG="FAF7B393"

clean:
	rm -f build/*

download:
	curl ${UPSTREAM_URL_MOIN} --output build/moin.tar.gz
	curl ${UPSTREAM_URL_SIG} --output build/moin.tar.gz.asc
	echo "${UPSTREAM_SHA256} build/moin.tar.gz" | sha256sum --check
	gpg --keyserver keys.gnupg.net --recv-key ${UPSTREAM_GPG}
	gpg --verify build/moin.tar.gz.asc build/moin.tar.gz
	tar xzf build/moin.tar.gz --directory build/

