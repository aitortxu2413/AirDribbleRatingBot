.DEFAULT_GOAL := all

CXX := g++

# ─── Compilation flags ─────────────────────────────────────────
CXXFLAGS_COMMON := -std=c++23 -Wall -Wextra -Wpedantic

# Debug: no optimización, símbolos
CXXFLAGS_DEBUG := $(CXXFLAGS_COMMON) -g -O0 -march=native

# Release: máxima optimización
CXXFLAGS_RELEASE := $(CXXFLAGS_COMMON) -O3 -DNDEBUG -flto=jobserver -fuse-linker-plugin

# ─── Auto-downloaded D++ (no pkg-config needed) ────────────────
DEP_DIR          := build/_deps
DPP_DEB          := $(DEP_DIR)/dpp.deb
DPP_EXTRACT_DIR  := $(DEP_DIR)/dpp
DPP_INCLUDE_BASE := $(DPP_EXTRACT_DIR)/usr/include
DPP_LIB_DIR      := $(DPP_EXTRACT_DIR)/usr/lib
DPP_STAMP := $(DEP_DIR)/dpp.stamp

DPP_VERSION := 10.1.5
DPP_DEB_URL := https://github.com/brainboxdotcc/DPP/releases/download/v$(DPP_VERSION)/libdpp-$(DPP_VERSION)-linux-x64.deb

# Descargar y extraer el .deb si no existe el directorio include
$(DPP_DEB):
	@echo "Downloading D++ $(DPP_VERSION)..."
	@mkdir -p $(DEP_DIR)
	wget -q -O $(DPP_DEB) $(DPP_DEB_URL) || (echo "ERROR: Failed to download D++" && exit 1)

$(DPP_STAMP): $(DPP_DEB)
	@echo "Extracting D++..."
	@mkdir -p $(DPP_EXTRACT_DIR)
	dpkg-deb -x $(DPP_DEB) $(DPP_EXTRACT_DIR)
	@touch $@
	@echo "D++ extracted to $(DPP_EXTRACT_DIR)"

# Flags de compilación y enlazado usando las rutas extraídas
DPP_CFLAGS := -I$(DPP_INCLUDE_BASE) -I$(DPP_INCLUDE_BASE)/dpp
DPP_LIBS   := -L$(DPP_LIB_DIR) -ldpp

# Extra system libs (necesarias para enlazar D++)
SYS_LIBS := -lssl -lcrypto -lz -pthread -ldl

# ─── Directories ───────────────────────────────────────────────
SRC_DIR := src
BUILD_DIR := build
BUILD_DIR_DEBUG := $(BUILD_DIR)/debug
BUILD_DIR_RELEASE := $(BUILD_DIR)/release

LDFLAGS_RELEASE := -Wl,-rpath,$(DPP_LIB_DIR)

SRCS := $(shell find $(SRC_DIR) -type f -name '*.cpp')

OBJS_DEBUG := $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR_DEBUG)/%.o,$(SRCS))
OBJS_RELEASE := $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR_RELEASE)/%.o,$(SRCS))

TARGET := AirDribbleRatingBot

# ─── Targets ───────────────────────────────────────────────────
.PHONY: all clean run compile release compile-release debug-run

debug-run: $(BUILD_DIR_DEBUG)/$(TARGET)
	@echo "▶ Running DEBUG build..."
	./$(BUILD_DIR_DEBUG)/$(TARGET)

compile: $(BUILD_DIR_DEBUG)/$(TARGET)
	@echo "✅ DEBUG build completed."

release: $(BUILD_DIR_RELEASE)/$(TARGET)
	@echo "▶ Running RELEASE build..."
	./$(BUILD_DIR_RELEASE)/$(TARGET)

compile-release: $(BUILD_DIR_RELEASE)/$(TARGET)
	@echo "✅ RELEASE build completed."

# ─── Linking ───────────────────────────────────────────────────
# Dependencia order-only de $(DPP_INCLUDE_BASE) para descargar/extraer,
# pero sin incluirla en $^ (evita pasar el directorio al linker)
$(BUILD_DIR_DEBUG)/$(TARGET): $(OBJS_DEBUG) | $(DPP_STAMP)
	@mkdir -p $(dir $@)
	$(CXX) $(OBJS_DEBUG) $(DPP_LIBS) $(SYS_LIBS) -Wl,-rpath,$(DPP_LIB_DIR) -o $@

$(BUILD_DIR_RELEASE)/$(TARGET): $(OBJS_RELEASE) | $(DPP_STAMP)
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS_RELEASE) $(OBJS_RELEASE) $(DPP_LIBS) $(SYS_LIBS) $(LDFLAGS_RELEASE) -o $@

# ─── Compilation ───────────────────────────────────────────────
$(BUILD_DIR_DEBUG)/%.o: $(SRC_DIR)/%.cpp | $(DPP_STAMP)
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS_DEBUG) $(DPP_CFLAGS) -c $< -o $@

$(BUILD_DIR_RELEASE)/%.o: $(SRC_DIR)/%.cpp | $(DPP_STAMP)
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS_RELEASE) $(DPP_CFLAGS) -c $< -o $@

# ─── Clean ─────────────────────────────────────────────────────
clean:
	rm -rf $(BUILD_DIR)
	@echo "🧹 Build directories removed."

run: debug-run

all: debug-run
