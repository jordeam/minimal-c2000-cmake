# Minimum CMake version required
cmake_minimum_required(VERSION 3.10)

#set(CMAKE_DEPENDS_USE_COMPILER FALSE)
set(CMAKE_TOOLCHAIN_FILE "${CMAKE_SOURCE_DIR}/c2000-toolchain.cmake")

# Project name
project(MyC2000Project C CXX ASM)

set(HOME $ENV{HOME})

# toolchain-c2000.cmake

# Include directories (e.g., C2000Ware driverlib)
include_directories(
    "${CMAKE_CURRENT_SOURCE_DIR}/inc"
    "${HOME}/ti/C2000Ware_${TI_C2000_WARE_VERSION}/device_support/${C2000_DEVICE}/common/include/"
    "${HOME}/ti/C2000Ware_${TI_C2000_WARE_VERSION}/driverlib/${C2000_DEVICE}/driverlib/"
    )

# Source files
set(SOURCE_FILES
    main.c
    device_init.c
)

# Add executable target
add_executable(${CMAKE_PROJECT_NAME} ${SOURCE_FILES})


# Add libraries (e.g., driverlib)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
    "${HOME}/ti/C2000Ware_${TI_C2000_WARE_VERSION}/driverlib/${C2000_DEVICE}/driverlib/ccs/Debug/driverlib.lib" # Example driverlib path
)

# Add general compile options
target_compile_options(MyC2000Project PRIVATE
  # This generator expression adds dependency flags only for specific compilers
  # $<COMPILE_LANG_AND_ID:C,GNU,Clang:-MF>
  # $<COMPILE_LANG_AND_ID:C,GNU,Clang:-MD>
  # $<COMPILE_LANG_AND_ID:C,GNU,Clang:-MT>
  # Other C2000-specific options can go here, without generator expressions
  --opt_level=3
  -DCPU1
)

target_link_options(${CMAKE_PROJECT_NAME} PRIVATE LINKER:${LINKER_CMD_FILE})

# Generate Code Composer Studio project files
set_property(TARGET ${CMAKE_PROJECT_NAME} PROPERTY CMAKE_GENERATOR_PLATFORM "C2000") # Important for CCS
# set_property(TARGET ${CMAKE_PROJECT_NAME} PROPERTY CMAKE_GENERATOR_TOOLCHAIN "C2000") # Important for CCS
