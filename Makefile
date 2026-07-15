ifeq ($(origin CC),default)
	CC = gcc
endif

ARCH ?= arm64
CROSS_COMPILE ?= aarch64-linux-gnu-
INCLUDE_PATH = include/
BUILD_PATH = build/$(ARCH)/

all: lib

include_path:
	@echo $(INCLUDE_PATH)

build_path:
	@echo $(BUILD_PATH)

$(INCLUDE_PATH):
	mkdir -p $@

$(BUILD_PATH):
	mkdir -p $@

# $(INCLUDE_PATH)/log.h: include/log.h $(INCLUDE_PATH)
# 	cp include/log.h $(INCLUDE_PATH)

$(BUILD_PATH)/log.o: src/log.c $(INCLUDE_PATH)/log.h $(BUILD_PATH)
	$(CROSS_COMPILE)gcc -g -static -rdynamic -DLOG_USE_COLOR -c src/log.c -Iinclude/ -o $(BUILD_PATH)/log.o

lib: include/log.o include/log.h $(BUILD_PATH)/log.o $(INCLUDE_PATH)/log.h
	@echo "Log library built successfully."
	

include/log.o: include/log.h src/log.c
	[ -d include ] || mkdir -p include
	cd include
	$(CROSS_COMPILE)gcc -g -static -rdynamic -DLOG_USE_COLOR -c src/log.c -Iinclude/ -o include/log.o

build:
	mkdir -p build

build/log.o: src/log.c | build
	$(CROSS_COMPILE)$(CC) -g -static -rdynamic -DLOG_USE_COLOR -c src/log.c -Iinclude/ -o build/log.o
	
# include/log.h: src/log.h
# 	[ -d include ] || mkdir -p include
# 	cp src/log.h include/

clean:
	rm -rf build include/*.o