#!/bin/bash

sudo apt-get update
sudo apt-get install -y gcc-arm-linux-gnueabi qemu-user

cat << 'EOF' > makefile
ifdef DEBUG
    DEBUGFLAGS = -g
else
    DEBUGFLAGS =
endif
TARGET  := a.out
SRC     := $(wildcard *.s)
OBJS    := $(SRC:%.s=%.o)
%.o: %.s
	arm-linux-gnueabi-as $(DEBUGFLAGS) $< -o $@
$(TARGET): $(OBJS)
	arm-linux-gnueabi-ld -o $(TARGET) $(OBJS)
clean:
	-@rm $(TARGET)
	-@rm $(OBJS)
EOF

if [ $? -eq 0 ]; then
    rm -- "$0"
fi