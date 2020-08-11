# Project-Wide Compilation Settings

# ==============================================================================
# Standards
# ==============================================================================
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_STANDARD   11)

# ==============================================================================
# Clang-Tidy
# ==============================================================================
find_program(clang-tidy NAMES clang-tidy)
if(NOT clang-tidy)
	message(FATAL_ERROR "Could not find the program 'clang-tidy'")
endif()
set(CMAKE_C_CLANG_TIDY   clang-tidy)
set(CMAKE_CXX_CLANG_TIDY clang-tidy)

# ==============================================================================
# Include What You Use
# ==============================================================================
find_program(iwyu NAMES include-what-you-use iwyu)
if(NOT iwyu)
	message(FATAL_ERROR "Could not find the program 'include-what-you-use'")
endif()
set(CMAKE_C_INCLUDE_WHAT_YOU_USE   ${iwyu})
set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE ${iwyu})
