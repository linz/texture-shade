BIN_DIR := ./bin
BUILD_DIR ?= ./build
SRC_DIR ?= ./src

SOURCES := $(wildcard $(SRC_DIR)/*.c)
OBJS :=  $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(SOURCES))

CC := gcc
CFLAGS := -O2 -funroll-loops -DNOMAIN
LDLIBS  := -lm


all: $(BIN_DIR)/texture $(BIN_DIR)/texture_image

$(BIN_DIR)/texture: $(OBJS) | $(BIN_DIR)/
	mkdir -p $(@D)
	$(CC) $(LDFLAGS) $^ $(SRC_DIR)/texture.c -o $@ $(LDLIBS)

$(BIN_DIR)/texture_image: $(OBJS) | $(BIN_DIR)/
	$(CC) $(LDFLAGS) $^ $(SRC_DIR)/texture_image.c -o $@ $(LDLIBS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)/
	$(CC) $(CFLAGS) -c -o $@ $<

$(BUILD_DIR)/ $(BIN_DIR)/:
	mkdir -p $@

.PHONY: all run clean

clean:
	$(RM) -r $(BUILD_DIR) $(BIN_DIR)