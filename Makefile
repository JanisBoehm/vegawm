# vegawm - dwm fork / clone

include config.mk

SRC = drw.c vegawm.c util.c
OBJ = ${SRC:.c=.o}

all: options vegawm

options:
	@echo vegawm build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk

config.h:
	cp config.def.h $@

vegawm: ${OBJ}
	${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	rm -f vegawm ${OBJ} vegawm-${VERSION}.tar.gz

dist: clean
	mkdir -p vegawm-${VERSION}
	cp -R Makefile config.def.h config.mk\
		drw.h util.h ${SRC} transient.c vegawm-${VERSION}
	tar -cf vegawm-${VERSION}.tar vegawm-${VERSION}
	gzip vegawm-${VERSION}.tar
	rm -rf vegawm-${VERSION}

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f vegawm ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/vegawm

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/vegawm\
		${DESTDIR}${MANPREFIX}/man1/vegawm.1

.PHONY: all options clean dist install uninstall
