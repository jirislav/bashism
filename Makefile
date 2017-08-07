DESTDIR=
COMPONENT=bashism

DEB_VERSION:=$(shell dpkg-parsechangelog | grep Version | cut -d' ' -f2)

COMPONENT_MASK="${COMPONENT}_${DEB_VERSION}"
PACKAGE="${COMPONENT_MASK}_all.deb"

BIN=$(DESTDIR)/usr/bin
LIB=$(DESTDIR)/usr/lib/$(COMPONENT)
VAR=$(DESTDIR)/var/lib/$(COMPONENT)
MAN1=$(DESTDIR)/usr/share/man/man1

CONF=$(DESTDIR)/etc/$(COMPONENT)

all:

deb:
	if test ! -d build; then mkdir build; fi
	dpkg-buildpackage -b -rfakeroot -uc -us && mv ../$(COMPONENT_MASK)* build

install:
	install -d $(CONF) $(VAR) $(LIB) $(BIN) $(MAN1)
	cp -R conf/* $(CONF)
	cp -R lib/* $(LIB)
	cp -R bin/* $(BIN)
	pandoc -s -t man doc/man.inject.md | gzip > $(MAN1)/inject.1.gz

localtest: deb
	sudo dpkg -i build/$(PACKAGE)

