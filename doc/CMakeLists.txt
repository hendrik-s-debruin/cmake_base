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
# List Building
# ==============================================================================
# Builds a doxygen list
#
# This macro is additive by default - it will not overwrite the list that is
# passed to it, it will just add to it
#
# Params:  key       - the variable in which to store the list items
# Section: VALUES    - precedes a list of string entries to add to ${key}
# Switch:  OVERWRITE - overwrite the list -- useful for when creating multiple
#                      versions of the documentation
macro(add_doxygen_values key)
	# =============================== Parse Input ==============================
	set(prefix        add_doxygen_value )
	set(noValues      OVERWRITE         ) # unused
	set(singleValues                    ) # unused
	set(multiValues   VALUES            )

	cmake_parse_arguments(${prefix}
		"${noValues}"
		"${singleValues}"
		"${multiValues}"
		${ARGN}
	)

	# ========================== Clear Key If Required =========================
	if(${${prefix}_OVERWRITE})
		message(STATUS "overwriting")
		set(${key} "")
	else()
		message(STATUS "not overwriting")
	endif()

	# ========================== Append Values to Key ==========================
	list(JOIN
		${prefix}_VALUES # join these values
		" "              # using this as glue
		values           # and store here
	)
	string(JOIN
		" "              # join using this as glue
		${key}           # store here - the variable named by key
		${${key}}        # add this, the value of the variable named by key
		${values}        # also add the values that were passed to this function
	)
endmacro()

# ==============================================================================
# Doxygen Settings
# ==============================================================================
# Example usage: add multiple values to variable DOXYGEN_ENABLED_SECTIONS
add_doxygen_values(DOXYGEN_ENABLED_SECTIONS
	VALUES
	doxygen_section_1
	doxygen_section_2
	doxygen_section_3
	doxygen_section_4
)

# Add more variables to this variable
add_doxygen_values(DOXYGEN_ENABLED_SECTIONS
	VALUES
	doxygen_section_5
	doxygen_section_6
	doxygen_section_7
	doxygen_section_8
)

# Overwrite the variable with the following values
add_doxygen_values(DOXYGEN_ENABLED_SECTIONS
	OVERWRITE
	VALUES
	doxygen_section_a
	doxygen_section_b
	doxygen_section_c
	doxygen_section_d
)

set(DOXYGEN_HAVE_DOT              "YES")
set(DOXYGEN_ELEVATE_WARN_TO_ERROR "NO")
set(DOXYGEN_INPUT                  ${PROJECT_SOURCE_DIR})
set(DOXYGEN_OUTPUT_PATH            ${CMAKE_CURRENT_BINARY_DIR})
set(DOXYGEN_PROJECT_BRIEF          "")
set(DOXYGEN_HIDE_FRIEND_COMPOUNDS  "YES")
set(DOXYGEN_GENERATE_TODO_LIST     "NO")
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
