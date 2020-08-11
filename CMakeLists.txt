cmake_minimum_required(VERSION 3.18.0)
project(PROJECT_NAME_HERE)

# Update cmake module search path
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

# Set project-wide compilation options
include(compilation)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
	add_subdirectory(doc)
	enable_testing()
	include(CTest)
	include(create_test)
endif()
