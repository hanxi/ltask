CFLAGS=-g -Wall
# CFLAGS+=-DDEBUGLOG

LUAINC?=-I./3rd/lua

ifeq ($(OS),Windows_NT)
  LIBS=-lwinmm
  SHARED=--shared
  SO=dll
  LUALIB?=-L/usr/local/bin -llua54
else
  SHARED=--shared -fPIC
  SO=so
  LIBS=-lpthread
endif

.PHONY: lua
all : lua ltask.$(SO)

lua:
	cd 3rd/lua && $(MAKE)

SRCS=\
 src/ltask.c \
 src/queue.c \
 src/sysinfo.c \
 src/service.c \
 src/config.c \
 src/lua-seri.c \
 src/message.c \
 src/systime.c \
 src/timer.c \
 src/sysapi.c \
 src/logqueue.c \
 src/debuglog.c

ltask.$(SO) : $(SRCS)
	$(CC) $(CFLAGS) $(SHARED) $(LUAINC) -Isrc -o $@ $^ $(LUALIB) $(LIBS)

clean :
	rm -rf *.$(SO)
	cd 3rd/lua && $(MAKE) clean


