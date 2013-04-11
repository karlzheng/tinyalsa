CFLAGS = -static -s -c -fPIC -Wall
INC = include
OBJECTS = mixer.o pcm.o
LIB = libtinyalsa.a
#CROSS_COMPILE =

all: $(LIB) tinyplay tinycap tinymix tinypcminfo

tinyplay: $(LIB) tinyplay.o
	$(CROSS_COMPILE)gcc -static tinyplay.o -L. -ltinyalsa -o tinyplay

tinycap: $(LIB) tinycap.o
	$(CROSS_COMPILE)gcc -static tinycap.o -L. -ltinyalsa -o tinycap

tinymix: $(LIB) tinymix.o
	$(CROSS_COMPILE)gcc -static tinymix.o -L. -ltinyalsa -o tinymix

tinypcminfo: $(LIB) tinypcminfo.o
	$(CROSS_COMPILE)gcc -static tinypcminfo.o -L. -ltinyalsa -o tinypcminfo

$(LIB): $(OBJECTS)
	$(CROSS_COMPILE)ar crv $(LIB) $(OBJECTS) 

.c.o:
	$(CROSS_COMPILE)gcc $(CFLAGS) $< -I$(INC)

clean:
	-rm $(LIB) $(OBJECTS) tinyplay.o tinyplay tinycap.o tinycap \
	tinymix.o tinymix tinypcminfo.o tinypcminfo
