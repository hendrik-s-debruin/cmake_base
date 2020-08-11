# ==============================================================================
# Find Documentation Programmes
# ==============================================================================
find_program(doxygen NAMES doxygen)
if(NOT doxygen)
	message(WARNING "Doxygen not found -- documentation targets not available")
	return()
endif()
find_program(graphviz_dot NAMES dot)
if(NOT graphviz_dot)
	message(WARNING "Graphviz Dot not found -- documentation targets not available")
	return()
endif()

# ==============================================================================
# Doxygen Settings
# ==============================================================================
set(DOXYGEN_HAVE_DOT              "YES")
set(DOXYGEN_ELEVATE_WARN_TO_ERROR "NO")
set(DOXYGEN_INPUT                 ${PROJECT_SOURCE_DIR})
set(DOXYGEN_OUTPUT_PATH            ${CMAKE_CURRENT_BINARY_DIR})
set(DOXYGEN_PROJECT_BRIEF          "")
set(DOXYGEN_HIDE_FRIEND_COMPOUNDS  "YES")
set(DOXYGEN_GENERATE_TODO_LIST     "NO")
set(DOXYGEN_ENABLED_SECTIONS       "")
set(DOXYGEN_SHOW_FILES             "NO")
set(DOXYGEN_EXCLUDE_PATTERNS       "")
set(DOXYGEN_EXCLUDE                "")
set(DOXYGEN_EXCLUDE_SYMBOLS        "")
set(DOXYGEN_USE_MDFILE_AS_MAINPAGE "")
set(DOXYGEN_CALL_GRAPH             "NO")
set(DOXYGEN_EXTRACT_PRIVATE        "NO")
set(DOXYGEN_INPUT_FILTER           "")

# ==============================================================================
# Build
# ==============================================================================
configure_file(
	doxyfile.in
	${DOXYGEN_OUTPUT_PATH}/doxyfile
)

add_custom_target(doc
	COMMAND           doxygen ${DOXYGEN_OUTPUT_PATH}/doxyfile
	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
	BYPRODUCTS        ${DOXYGEN_OUTPUT_PATH}
)
