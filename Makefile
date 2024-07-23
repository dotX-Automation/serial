# serial library build system.
#
# Roberto Masocco <r.masocco@dotxautomation.com>
#
# July 23, 2024

all: serial

CMAKE_FLAGS := -DCMAKE_INSTALL_PREFIX=/usr/local
UNAME := $(shell uname -s)

install:
	cd build && make install

serial:
	@mkdir -p build
	cd build && cmake $(CMAKE_FLAGS) ..
ifneq ($(MAKE),)
	cd build && $(MAKE)
else
	cd build && make
endif

.PHONY: clean
clean:
	rm -rf build

.PHONY: doc
doc:
	@doxygen doc/Doxyfile
ifeq ($(UNAME),Darwin)
	@open doc/html/index.html
endif

.PHONY: test
test:
	@mkdir -p build
	cd build && cmake $(CMAKE_FLAGS) ..
ifneq ($(MAKE),)
	cd build && $(MAKE) run_tests
else
	cd build && make run_tests
endif
