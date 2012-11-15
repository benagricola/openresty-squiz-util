OPENRESTY_PREFIX=/usr/local/openresty-debug
TEST_LEDGE_REDIS_DATABASE=1

PREFIX ?=          /usr/local
LUA_INCLUDE_DIR ?= $(PREFIX)/include
LUA_LIB_DIR ?=     $(PREFIX)/lib/lua/$(LUA_VERSION)
INSTALL ?= install

.PHONY: all install

all: ;

install: all
	$(INSTALL) -d $(DESTDIR)/$(LUA_LIB_DIR)/util
	$(INSTALL) lib/util/*.lua $(DESTDIR)/$(LUA_LIB_DIR)/util