project(lab-1)
cmake_minimum_required(VERSION 3.17)
enable_language(C ASM)
add_executable(mem_test test_memcpy.c memcpy.c rep_movs.s)

if(${CMAKE_BUILD_TYPE} STREQUAL Debug)
    target_compile_options(mem_test PUBLIC "-fsanitize=address" "-funroll-loops")
    target_link_options(mem_test PUBLIC "-fsanitize=address")
endif()