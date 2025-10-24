# This file configures CMake to use the C2000 Code Generation Tools (CGT)
# This assumes the toolchain binaries are available in your system's PATH.
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR c28x)
set(CMAKE_CROSSCOMPILING TRUE)

# Find the C2000 compiler executables
find_program(CMAKE_C_COMPILER cl2000)
find_program(CMAKE_ASM_COMPILER cl2000)
find_program(CMAKE_AR_AR ar2000)
find_program(CMAKE_LINKER_LINKER cl2000)

# Set common compiler and linker flags for the C2000
set(CMAKE_C_FLAGS
    "${CMAKE_C_FLAGS} -v28 -ml -mt --float_support=fpu32 --tmu_support=tmu0 -O2"
)
set(CMAKE_ASM_FLAGS
    "${CMAKE_ASM_FLAGS} -v28 -ml -mt --float_support=fpu32 --tmu_support=tmu0"
)

# Add C2000-specific linker flags.
set(CMAKE_EXE_LINKER_FLAGS
    "${CMAKE_EXE_LINKER_FLAGS} -heap0x400 -stack0x400"
)

# Instruct CMake where to search for libraries and include files.
# It's recommended to set C2000WARE_PATH externally, for example via a shell environment variable.
if(NOT C2000WARE_PATH)
    message(FATAL_ERROR "C2000WARE_PATH is not set. Please set it to your C2000Ware installation directory.")
endif()
set(CMAKE_FIND_ROOT_PATH ${C2000WARE_PATH})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Handle debug and release builds, overriding default options not supported by TI CGT.
set(CMAKE_C_FLAGS_DEBUG "-g --symdebug:dwarf")
set(CMAKE_C_FLAGS_RELEASE "-O2")

# In your toolchain-c2000.cmake file

# Use an external variable to track CMAKE_C_FLAGS before CMake populates them
set(CMAKE_C_FLAGS_INITIAL "$ENV{CFLAGS}" )

# Now, set the variables that CMake will use, stripping the unwanted flags
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS_INITIAL}" )
string(REPLACE "-MD" "" CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
string(REPLACE "-MF" "" CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
string(REPLACE "-MT" "" CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
