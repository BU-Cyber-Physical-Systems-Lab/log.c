CC ?= gcc
ARCH ?= arm64
CROSS_COMPILE ?= aarch64-linux-gnu-

all: include include/log.h include/log.o

include:
	mkdir include

include/log.h: src/log.h
	cp src/log.h include/log.h

include/log.o: src/log.h src/log.c
	$(CROSS_COMPILE)gcc -DLOG_USE_COLOR -c src/log.c -o include/log.o