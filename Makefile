# gcc -O2 -funroll-loops -DNOMAIN -c *.c
# gcc –O2 –funroll-loops *.o texture.c -o texture
# gcc –O2 –funroll-loops *.o texture_image.c -o texture_image

BIN_DIR := ./bin
BUILD_DIR ?= ./build
SRC_DIR ?= ./src

SOURCES := $(wildcard $(SRC_DIR)/*.c)
OBJS :=  $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(SOURCES))

CC := gcc
CFLAGS := -O2 -funroll-loops -DNOMAIN
LDLIBS  := -lm

all: bin/texture bin/texture_image

bin/texture: $(OBJS)
	    $(CC) $(LDFLAGS) $^ $(SRC_DIR)/texture.c -o $@ $(LDLIBS)

bin/texture_image: $(OBJS)
	    $(CC) $(LDFLAGS) $^ $(SRC_DIR)/texture_image.c -o $@ $(LDLIBS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

$(BIN_DIR) $(BUILD_DIR):
    $(MKDIR) $@

.PHONY: all run clean

clean:
	$(RM) -r $(BUILD_DIR) $(BIN_DIR)