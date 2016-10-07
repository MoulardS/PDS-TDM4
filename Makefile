CC =gcc
CFLAGS =-Wall -Werror -ansi -pedantic
CFLAGS += -D_XOPEN_SOURCE=500
CFLAGS +=-g
LDFLAGS  = -g

TOUS:= mcat 

tout: ${TOUS}


%.o: %.c
		${CC} ${CFLAGS} -c $<

%: %.o
		${CC} ${LDFLAGS} -o $@ $^

clean :rm *.o || true

.PHONY: all clean realclean

