
# ---------------------------------------
#  Makefile for EOS CDT Select
#
#  Copyright (c) 2019-2020 EOS Sw/eden
# ----------------------------------------

PREFIX := /usr/local

.PHONY: install deb clean changelog

install:
	install -D -m 755 -t $(PREFIX)/bin eos-cdt-select
	install -D -m 644 -t $(PREFIX)/share/eos-cdt-select README.md LICENSE
	mkdir -p /opt/eosio.cdt

deb:
	export PACKAGE_PREFIX=$(PREFIX:/%=%) && scripts/build_deb.sh

changelog:
	git log --pretty="%s" `git tag -l --sort=-creatordate | head -n 1`..HEAD

clean:
	$(RM) -fr scripts/pack
	$(RM) scripts/*.deb
