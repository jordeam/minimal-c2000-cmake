# Minimum CMake version required
cmake_minimum_required(VERSION 3.10)

# Project name
project(MyC2000Project C CXX ASM)

# Set the C2000 toolchain path (adjust as needed)
# This assumes the C2000 compiler is in your PATH or specified here
set(TI_C2000_TOOLCHAIN_PATH "~/ti/ccs/tools/compiler/ti-cgt-c2000_21.6.0.LTS/bin") # Example path

# Add the toolchain to the system path for CMake to find it
list(APPEND CMAKE_PROGRAM_PATH "${TI_C2000_TOOLCHAIN_PATH}")

# Specify the C2000 compiler and linker
set(CMAKE_C_COMPILER cl2000)
set(CMAKE_CXX_COMPILER cl2000)
set(CMAKE_ASM_COMPILER cl2000)
set(CMAKE_LINKER cl2000)

# Set the target processor (e.g., F2837xD)
set(C2000_DEVICE "F2837xD")

# Define compiler flags
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} --endian=little --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu0 -g --diag_warning=225 --diag_wrap=off --display_error_number -me --preproc_with_compile --preproc_dependency=${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_C_COMPILER_ID}Deps.dep")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --endian=little --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu0 -g --diag_warning=225 --diag_wrap=off --display_error_number -me --preproc_with_compile --preproc_dependency=${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_C_COMPILER_ID}Deps.dep")
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} --endian=little")

# Define linker flags and command file
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -z -m\"${CMAKE_PROJECT_NAME}.map\" --stack_size=0x200 --heap_size=0x200 -x --reread_libs --xml_link_info=\"${CMAKE_PROJECT_NAME}_link_info.xml\"")
set(LINKER_CMD_FILE "${CMAKE_CURRENT_SOURCE_DIR}/F2837xD_FLASH_lnk.cmd") # Example linker command file
target_link_options(${CMAKE_PROJECT_NAME} PRIVATE LINKER:\"${LINKER_CMD_FILE}\")

# Include directories (e.g., C2000Ware driverlib)
include_directories(
    "${CMAKE_CURRENT_SOURCE_DIR}/inc"
    "~/ti/c2000/C2000Ware_4_01_00_00/driverlib/f2837xd/driverlib" # Example C2000Ware path
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
    "~/ti/c2000/C2000Ware_4_01_00_00/driverlib/f2837xd/driverlib/ccs/Debug/driverlib.lib" # Example driverlib path
)

# Generate Code Composer Studio project files
set_property(TARGET ${CMAKE_PROJECT_NAME} PROPERTY CMAKE_GENERATOR_PLATFORM "C2000") # Important for CCS
set_property(TARGET ${CMAKE_PROJECT_NAME} PROPERTY CMAKE_GENERATOR_TOOLCHAIN "C2000") # Important for CCS
