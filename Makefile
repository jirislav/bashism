DESTDIR=
COMPONENT=bashism

DEB_VERSION:=$(shell dpkg-parsechangelog | grep Version | cut -d' ' -f2)

COMPONENT_MASK="${COMPONENT}_${DEB_VERSION}"
PACKAGE="${COMPONENT_MASK}_all.deb"

BIN=$(DESTDIR)/usr/bin
LIB=$(DESTDIR)/usr/lib/$(COMPONENT)
VAR=$(DESTDIR)/var/lib/$(COMPONENT)

CONF=$(DESTDIR)/etc/$(COMPONENT)

all:

deb:
	dpkg-buildpackage -b -rfakeroot -uc -us && mv ../$(COMPONENT_MASK)* build

install:
	install -d $(CONF) $(VAR) $(LIB) $(BIN)
	cp -R conf/* $(CONF)
	cp -R lib/* $(LIB)
	cp -R bin/* $(BIN)

localtest: deb
	sudo dpkg -i build/$(PACKAGE)

