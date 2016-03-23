# 
# Liviu Caramida (carliv@xda), Carliv Image Kitchen source
#
MAKEFLAGS += --silent
CC = gcc
AR = ar rcs
RM = rm -f
ifeq ($(target),32)
LDFLAGS = -m32
LDFLAGS += -std=c99 -pipe -O3 -DUSE_MMAP
CFLAGS = -m32
CFLAGS += -std=c99 -pipe -O3 -DUSE_MMAP
LIBS= -m32 libz.a
else
LDFLAGS = -std=c99 -pipe -O3 -DUSE_MMAP
CFLAGS = -std=c99 -pipe -O3 -DUSE_MMAP
LIBS= libz.a
endif
LIB_SRC_FILES := \
	src/adler32.c \
	src/compress.c \
	src/crc32.c \
	src/deflate.c \
	src/gzclose.c \
	src/gzlib.c \
	src/gzread.c \
	src/gzwrite.c \
	src/infback.c \
	src/inflate.c \
	src/inftrees.c \
	src/inffast.c \
	src/trees.c \
	src/uncompr.c \
	src/zutil.c

MINIGZIP_FILES:=        \
	src/test/minigzip.c
	
LIB = libz.a
LIB_OBJS = $(patsubst %.c,%.o,$(LIB_SRC_FILES))

all:$(LIB) minigzip

clean:
	$(RM) $(LIB_OBJS) $(LIB) minigzip.exe

$(LIB):$(LIB_OBJS)
	$(AR) $@ $^

%.o:%.c
	$(CC) -o $@ $(LDFLAGS) -c $<

minigzip:
	$(CC) $(MINIGZIP_FILES) -o $@.exe $(LIBS)
	strip $@.exe

.PHONY: all clean minigzip
