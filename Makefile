all: build
	cmake --build build

build:
	cmake --log-level=VERBOSE -DCMAKE_VERBOSE_MAKEFILE=ON -B build

clean:
	rm -rf build
