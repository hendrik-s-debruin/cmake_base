cmake_minimum_required(VERSION 3.18.0)
project(PROJECT_NAME_HERE)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
enable_testing()
include(targets)


include_directories(include)
cwrap_executable(tester src/test.cpp)

include(CTest)
add_subdirectory(test)

include(format)
