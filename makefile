ifdef DEBUG
	DEBUGFLAGS = -g
else
	DEBUGFLAGS =
endif

TARGET  := a.out
SRC     := $(wildcard *.s)
OBJS    := $(SRC:%.s=%.o)

$(TARGET): $(OBJS)
	arm-linux-gnueabi-ld -o $(TARGET) $(OBJS)

%.o: %.s
	arm-linux-gnueabi-as $(DEBUGFLAGS) $< -o $@

clean:
	-@rm $(TARGET)
	-@rm $(OBJS)