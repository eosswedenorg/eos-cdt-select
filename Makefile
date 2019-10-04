
# ---------------------------------------
#  Makefile for EOS CDT Select
#
#  Copyright (c) 2019 EOS Sw/eden
# ----------------------------------------

PREFIX := /usr/local

.PHONY: install deb clean

install:
	install -D -m 755 -t $(PREFIX)/bin eos-cdt-select
	install -D -m 644 -t $(PREFIX)/share/eos-cdt-select README.md LICENSE
	mkdir -p /opt/eosio.cdt

deb:
	export PACKAGE_PREFIX=$(PREFIX:/%=%) && scripts/build_deb.sh

clean:
	$(RM) -fr scripts/pack
	$(RM) scripts/*.deb
