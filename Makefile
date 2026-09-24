include ../../config/common_simple.mk

.DEFAULT_GOAL := all

include log.mk

all: $(LOG_O)

clean:
	rm -rf build