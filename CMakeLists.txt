# Minimum CMake version required
cmake_minimum_required(VERSION 3.10)

set(CMAKE_DEPENDS_USE_COMPILER FALSE)

# Project name
project(MyC2000Project C CXX ASM)

set(HOME $ENV{HOME})

# Set the C2000 toolchain path (adjust as needed)
# This assumes the C2000 compiler is in your PATH or specified here
set(TI_C2000_TOOLCHAIN_PATH "${HOME}/ti/ccs1240/ccs/tools/compiler/ti-cgt-c2000_22.6.1.LTS/bin") # Example path

# Add the toolchain to the system path for CMake to find it
list(APPEND CMAKE_PROGRAM_PATH "${TI_C2000_TOOLCHAIN_PATH}")

# Specify the C2000 compiler and linker
set(CMAKE_C_COMPILER ${TI_C2000_TOOLCHAIN_PATH}/cl2000)
set(CMAKE_CXX_COMPILER ${TI_C2000_TOOLCHAIN_PATH}/cl2000)
set(CMAKE_ASM_COMPILER ${TI_C2000_TOOLCHAIN_PATH}/cl2000)
set(CMAKE_LINKER ${TI_C2000_TOOLCHAIN_PATH}/cl2000)

# set(CMAKE_TOOLCHAIN_FILE c2000-toolchain.cmake)

# toolchain-c2000.cmake

# Override the default C compilation rule
set(CMAKE_C_COMPILE_OBJECT
  "<CMAKE_C_COMPILER> <DEFINES> <INCLUDES> <FLAGS> --compile_only --c_file=<SOURCE> --output_file=<OBJECT>"
)

set(CMAKE_C_LINKER_WRAPPER_FLAG "")

# Set the target processor (e.g., F2837xD)
set(C2000_DEVICE "f2837xd")

# Define compiler flags
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} --endian=little --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu0 -g --diag_warning=225 --diag_wrap=off --display_error_number -me --preproc_with_compile --preproc_dependency=${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_C_COMPILER_ID}Deps.dep")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --endian=little --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu0 -g --diag_warning=225 --diag_wrap=off --display_error_number -me --preproc_with_compile --preproc_dependency=${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_C_COMPILER_ID}Deps.dep")
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} --endian=little")

# Define linker flags and command file
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -z -m\"${CMAKE_PROJECT_NAME}.map\" --stack_size=0x200 --heap_size=0x200 -x --reread_libs --xml_link_info=\"${CMAKE_PROJECT_NAME}_link_info.xml\"")

set(LINKER_CMD_FILE "${CMAKE_CURRENT_SOURCE_DIR}/F2837xD_FLASH_lnk.cmd") # Example linker command file

# Include directories (e.g., C2000Ware driverlib)
include_directories(
    "${CMAKE_CURRENT_SOURCE_DIR}/inc"
    "${HOME}/ti/C2000Ware_5_00_00_00/device_support/${C2000_DEVICE}/common/include/"
    "${HOME}/ti/C2000Ware_5_00_00_00/driverlib/${C2000_DEVICE}/driverlib/"
    )

# Source files
set(SOURCE_FILES
    main.c
    device_init.c
)

# Add executable target
add_executable(${CMAKE_PROJECT_NAME} ${SOURCE_FILES})

# Add general compile options
target_compile_options(MyC2000Project PRIVATE
  # This generator expression adds dependency flags only for specific compilers
  # $<COMPILE_LANG_AND_ID:C,GNU,Clang:-MF>
  # $<COMPILE_LANG_AND_ID:C,GNU,Clang:-MD>
  # $<COMPILE_LANG_AND_ID:C,GNU,Clang:-MT>
  # Other C2000-specific options can go here, without generator expressions
  --endian=little
  --opt_level=3
)

target_link_options(${CMAKE_PROJECT_NAME} PRIVATE LINKER:${LINKER_CMD_FILE})

# Add libraries (e.g., driverlib)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
    "${HOME}/ti/C2000Ware_5_00_00_00/driverlib/f2837xd/driverlib/ccs/Debug/driverlib.lib" # Example driverlib path
)

# Generate Code Composer Studio project files
set_property(TARGET ${CMAKE_PROJECT_NAME} PROPERTY CMAKE_GENERATOR_PLATFORM "C2000") # Important for CCS
# set_property(TARGET ${CMAKE_PROJECT_NAME} PROPERTY CMAKE_GENERATOR_TOOLCHAIN "C2000") # Important for CCS

message(STATUS "Before CMAKE_C_FLAGS=${CMAKE_C_FLAGS}")
message(STATUS "Before ENV=$ENV{CFLAGS}")

string(REPLACE "-MD" "" CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
string(REPLACE "-MF" "" CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
string(REPLACE "-MT" "--preproc_dependency" CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")


message(STATUS "CMAKE_C_FLAGS=${CMAKE_C_FLAGS}")

get_cmake_property(_variableNames VARIABLES)
list(SORT _variableNames)
foreach (_variableName ${_variableNames})
  message(STATUS "${_variableName}=${${_variableName}}")
endforeach()

# "/home/jrm/ti/ccs1240/ccs/tools/compiler/ti-cgt-c2000_22.6.1.LTS/bin/cl2000" -v28 -ml -mt --cla_support=cla1 --float_support=fpu32 --tmu_support=tmu0 --vcu_support=vcu2 --fp_mode=relaxed --advice:performance=all --define=_FLASH --define=CPU1 --define=GSC_CONTROL --define=NO_WITHOUT_UCC5870 -g --c11 --diag_warning=225 --diag_wrap=off --display_error_number --abi=coffabi -z -m"f28379d_simple.map" --stack_size=0x200 --warn_sections -i"/home/jrm/ti/ccs1240/ccs/tools/compiler/ti-cgt-c2000_22.6.1.LTS/lib" -i"/home/jrm/ti/ccs1240/ccs/tools/compiler/ti-cgt-c2000_22.6.1.LTS/include" --reread_libs --diag_wrap=off --display_error_number --xml_link_info="f28379d_simple_linkInfo.xml" --rom_model -o "f28379d_simple.out" "./adc_soc.obj" "./can_system.obj" "./cotask.obj" "./encoder_eqep.obj" "./hvp045a.obj" "./leds.obj" "./main.obj" "./max6675.obj" "./pins_io.obj" "./pwm_module.obj" "./device/F2837xD_CodeStartBranch.obj" "./device/device.obj" "./device/driverlib/adc.obj" "./device/driverlib/asysctl.obj" "./device/driverlib/can.obj" "./device/driverlib/cla.obj" "./device/driverlib/clb.obj" "./device/driverlib/cmpss.obj" "./device/driverlib/cputimer.obj" "./device/driverlib/dac.obj" "./device/driverlib/dcsm.obj" "./device/driverlib/dma.obj" "./device/driverlib/ecap.obj" "./device/driverlib/emif.obj" "./device/driverlib/epwm.obj" "./device/driverlib/eqep.obj" "./device/driverlib/flash.obj" "./device/driverlib/gpio.obj" "./device/driverlib/hrpwm.obj" "./device/driverlib/i2c.obj" "./device/driverlib/interrupt.obj" "./device/driverlib/mcbsp.obj" "./device/driverlib/memcfg.obj" "./device/driverlib/sci.obj" "./device/driverlib/sdfm.obj" "./device/driverlib/spi.obj" "./device/driverlib/sysctl.obj" "./device/driverlib/upp.obj" "./device/driverlib/usb.obj" "./device/driverlib/version.obj" "./device/driverlib/xbar.obj" "../2837x_FLASH_lnk_cpu1.cmd"  -llibc.a 
