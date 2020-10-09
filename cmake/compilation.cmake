# Project-Wide Compilation Settings

# ==============================================================================
# Standards
# ==============================================================================
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_STANDARD   11)

set(EXTRA_COMPILATION_CHECKS_CLANG_TIDY ON CACHE BOOL
	"Whether to run clang-tidy as part of compilation"
)
set(EXTRA_COMPILATION_CHECKS_IWYU ON CACHE BOOL
	"Whether to run include-what-you-use as part of compilation"
)

# ==============================================================================
# Clang-Tidy
# ==============================================================================
if(EXTRA_COMPILATION_CHECKS_CLANG_TIDY)
	find_program(clang-tidy NAMES clang-tidy)
	if(NOT clang-tidy)
		message(FATAL_ERROR "Could not find the program 'clang-tidy'")
	endif()
	set(CMAKE_C_CLANG_TIDY   clang-tidy)
	set(CMAKE_CXX_CLANG_TIDY clang-tidy)
else()
	set(CMAKE_C_CLANG_TIDY   "")
	set(CMAKE_CXX_CLANG_TIDY "")
endif()

# ==============================================================================
# Include What You Use
# ==============================================================================
if(EXTRA_COMPILATION_CHECKS_IWYU)
	find_program(iwyu NAMES include-what-you-use iwyu)
	if(NOT iwyu)
		message(FATAL_ERROR "Could not find the program 'include-what-you-use'")
	endif()
	set(CMAKE_C_INCLUDE_WHAT_YOU_USE   ${iwyu})
	set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE ${iwyu})
else()
	set(CMAKE_C_INCLUDE_WHAT_YOU_USE   "")
	set(CMAKE_CXX_INCLUDE_WHAT_YOU_USE "")
endif()
