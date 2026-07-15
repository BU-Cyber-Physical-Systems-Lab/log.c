
LOG_DIR     := $(patsubst %/,%,$(dir $(lastword $(MAKEFILE_LIST))))

include $(LOG_DIR)/../../config/common_simple.mk

$(eval $(call NORMAL_DIR,LOG,$(LOG_DIR)))

LOG_O       := $(LOG_DIR)/build/$(ARCH)/log.o

# CFLAGS       += -g -rdynamic -static -MMD -MP
INCLUDE_LIST += -I$(LOG_DIR)/include

CLEAN_LIST   += $(LOG_DIR)/build 

$(LOG_O): $(LOG_DIR)/src/log.c | $(LOG_DIR)/include/log.h $(LOG_DIR)/build/$(ARCH)
	$(CROSS_COMPILE)$(CC) $(CFLAGS) $(INCLUDE_LIST) -DLOG_USE_COLOR -c $< -o $@
