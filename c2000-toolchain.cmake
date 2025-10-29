# This file is for cross-compiling to the C2000 architecture.

# Set CMAKE_SYSTEM_NAME to "Generic" for embedded systems without an OS.
# set(CMAKE_SYSTEM_NAME Generic)
# set(CMAKE_CROSSCOMPILING TRUE)
set(CMAKE_DEPENDS_USE_COMPILER FALSE)

set(TI_C2000_TOOL_SHORT_VERSION "ccs1240")
set(TI_C2000_TOOL_VERSION "22.6.1.LTS")
set(TI_C2000_WARE_VERSION "5_00_00_00")
# Set the target processor (e.g., F2837xD)
set(C2000_DEVICE "f2837xd")

# Set the C2000 toolchain path
set(HOME $ENV{HOME})
# Adjust this path as needed for your specific installation.
set(TI_C2000_TOOLCHAIN_ROOT "${HOME}/ti/${TI_C2000_TOOL_SHORT_VERSION}/ccs/tools/compiler/ti-cgt-c2000_${TI_C2000_TOOL_VERSION}")
set(TI_C2000_TOOLCHAIN_PATH "${TI_C2000_TOOLCHAIN_ROOT}/bin")
set(TI_C2000_WARE_PATH "${HOME}/ti/c2000/${TI_C2000_WARE_VERSION}")

# Set CMAKE_SYSROOT to point to the target's root filesystem
# CMake will automatically look for headers in "${CMAKE_SYSROOT}/usr/include"
set(CMAKE_SYSROOT "${TI_C2000_TOOLCHAIN_ROOT}")

# Explicitly set the standard include directories for C and C++
# This variable is specifically designed to be set by toolchain files.
set(CMAKE_C_STANDARD_INCLUDE_DIRECTORIES "${CMAKE_SYSROOT}/include")
set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES "${CMAKE_SYSROOT}/include")

# Specify the C2000 compiler and linker binaries.
set(CMAKE_C_COMPILER ${TI_C2000_TOOLCHAIN_PATH}/cl2000)
set(CMAKE_CXX_COMPILER ${TI_C2000_TOOLCHAIN_PATH}/cl2000)
set(CMAKE_ASM_COMPILER ${TI_C2000_TOOLCHAIN_PATH}/cl2000)
set(CMAKE_LINKER ${TI_C2000_TOOLCHAIN_PATH}/cl2000)

# Add the toolchain to the system path for CMake to find it
list(APPEND CMAKE_PROGRAM_PATH "${TI_C2000_TOOLCHAIN_PATH}")

# Override the default C compilation rule
set(CMAKE_C_COMPILE_OBJECT
  "<CMAKE_C_COMPILER> <DEFINES> <INCLUDES> <FLAGS> --compile_only --c_file=<SOURCE> --output_file=<OBJECT>"
)

set(CMAKE_C_LINKER_WRAPPER_FLAG "")

# Define compiler flags
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu0 -g --diag_warning=225 --diag_wrap=off --display_error_number -me --preproc_with_compile --preproc_dependency=${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_C_COMPILER_ID}Deps.dep")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --endian=little --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu0 -g --diag_warning=225 --diag_wrap=off --display_error_number -me --preproc_with_compile --preproc_dependency=${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_C_COMPILER_ID}Deps.dep")
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} --endian=little")

# Define linker flags and command file
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -z -m\"${CMAKE_PROJECT_NAME}.map\" --stack_size=0x200 --heap_size=0x200 -x --reread_libs --xml_link_info=\"${CMAKE_PROJECT_NAME}_link_info.xml\"")

set(LINKER_CMD_FILE "${CMAKE_CURRENT_SOURCE_DIR}/F2837xD_FLASH_lnk.cmd") # Example linker command file

string(REPLACE "-MD" "" CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
string(REPLACE "-MF" "" CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
string(REPLACE "-MT" "--preproc_dependency" CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")



