all: build
	cmake --build build -v

build:
	cmake --log-level=VERBOSE -DCMAKE_VERBOSE_MAKEFILE=ON -B build

clean:
	rm -rf build
# /home/jrm/ti/ccs1240/ccs/tools/compiler/ti-cgt-c2000_22.6.1.LTS/bin/cl2000  -I/home/jrm/Code/minimal-c2000-cmake/inc -I/home/jrm/ti/C2000Ware_5_00_00_00/device_support/f28p65x/common/include --endian=little --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu0 -g --diag_warning=225 --diag_wrap=off --display_error_number -me --preproc_with_compile --preproc_dependency=/home/jrm/Code/minimal-c2000-cmake/build/GNUDeps.dep -o CMakeFiles/MyC2000Project.dir/main.c.o -c /home/jrm/Code/minimal-c2000-cmake/main.c
# /home/jrm/ti/ccs1240/ccs/tools/compiler/ti-cgt-c2000_22.6.1.LTS/bin/cl2000  -I/home/jrm/Code/minimal-c2000-cmake/inc -I/home/jrm/ti/C2000Ware_5_00_00_00/driverlib/f2837xd/driverlib --endian=little --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu0 -g --diag_warning=225 --diag_wrap=off --display_error_number -me --preproc_with_compile --preproc_dependency=/home/jrm/Code/minimal-c2000-cmake/build/GNUDeps.dep -o CMakeFiles/MyC2000Project.dir/main.c.o -c /home/jrm/Code/minimal-c2000-cmake/main.c
