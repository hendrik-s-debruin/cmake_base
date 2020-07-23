cmake_minimum_required(VERSION 3.18.0)
project(PROJECT_NAME_HERE)

# Run clang-tidy with each compilation
set(CMAKE_C_CLANG_TIDY   clang-tidy)
set(CMAKE_CXX_CLANG_TIDY clang-tidy)

# Run Include-What-You-Use with each compilation
find_program(iwyu NAMES include-what-you-use iwyu)
if(NOT iwyu)
	message(FATAL_ERROR "Could not find the program 'include-what-you-use'")
endif()
set(CMAKE_C_INCLUDE_WHAT_YOU_USE   ${iwyu})
set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE ${iwyu})

# Add module path
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

enable_testing()
include(targets)


include(CTest)
add_subdirectory(test)

include(format)
