# Register tests with the function 'create_test'. The test is assumed to be a
# Catch2 test
#
# Synopsis:
# * make tests
# * make check
# * make tests_${TAG}
# * make check_${TAG}
#
# Usage:
# Specify as the first argument to 'create_test' the name of the test.
# The following sections are available to the function:
#
# * SOURCE: a list of the source files for the test
# * LINK: a list of libraries against which the test must be linked
# * TAG: A list of tags for the test
#
# A test will be displayed in CTest as: "[tag1 tag2 ... tagN]:TEST_DESCRIPTION"
#
# By default, the tests are not built. For each tag registered by this function,
# a target 'tests_${TAG}' is created. By typing 'make tests_${TAG}', all tests
# that have registred themselves under that tag will be built.
#
# To build all tests, type 'make tests'. CTest can then be run by typing 'make
# test'
#
# A convenience target, 'make check' is available. This will build all tests
# prior to running CTest.
#
# The test tags can be used in combination with CTests' -R and -E arguments to
# select which tests to run. Alternatively, there are convenience targets for
# each tag that has been registered with this function. Simply type
# 'make check_${TAG}'. This will build all the tests that match the tag and run
# them.

# ==============================================================================
# Dependencies for All Tests
# ==============================================================================
add_custom_target(tests)
add_library(catch_main EXCLUDE_FROM_ALL SHARED ${PROJECT_SOURCE_DIR}/lib/catch.cpp)
target_link_libraries(catch_main PRIVATE Catch2::Catch2)
add_dependencies(tests catch_main)
add_custom_target(check DEPENDS tests COMMAND ${CMAKE_CTEST_COMMAND})

# ==============================================================================
# Test Creation
# ==============================================================================
function(create_test TARGET_NAME)
	# =============================== Parse Input ==============================
	include(CMakeParseArguments)
	set(prefix       ARG)
	set(noValues     "")
	set(singleValues "")
	set(multiValues  SOURCE LINK TAG)

	cmake_parse_arguments(
		${prefix}
		"${noValues}"
		"${singleValues}"
		"${multiValues}"
		${ARGN}
	)

	# ============================= Sanitise Input =============================
	# Require source files to be listed under SOURCE
	list(LENGTH ${prefix}_SOURCE SOURCE_FILE_COUNT)
	if(${SOURCE_FILE_COUNT} EQUAL 0)
		message(
			FATAL_ERROR
			"ERROR: 'create_test' requires source files specified under section"
			" 'SOURCE'"
		)
	endif()

	# Require that at least one tag be specified
	list(LENGTH ${prefix}_TAG TAG_COUNT)
	if(${TAG_COUNT} EQUAL 0)
		message(
			FATAL_ERROR
			"ERROR: each test registered with 'create_test' must be given at "
			"least one TAG"
		)
	endif()

	# Parse the tags
	# Tags are reported in CTest as "[tag1 tag2 ... tagN]:"
	set(TEST_TAGNAME "[")
	foreach(TAGNAME IN LISTS ${prefix}_TAG)
		string(APPEND TEST_TAGNAME ${TAGNAME} " ")
	endforeach()
	string(STRIP ${TEST_TAGNAME} TEST_TAGNAME)
	string(APPEND TEST_TAGNAME "]: ")

	# =============================== Create Test ==============================
	message(STATUS "Adding test '${TARGET_NAME}'")
	add_executable(${TARGET_NAME} EXCLUDE_FROM_ALL ${${prefix}_SOURCE})
	target_link_libraries(${TARGET_NAME} ${${prefix}_LINK} catch_main)
	catch_discover_tests(${TARGET_NAME} TEST_PREFIX ${TEST_TAGNAME})

	# =========================== Setup Dependencies ===========================
	# The target 'tests' builds all the tests
	add_dependencies(tests ${TARGET_NAME})

	# Create a new target for each tag name. Those targets build all the tests
	# that are registered to it
	foreach(TAGNAME IN LISTS ${prefix}_TAG)
		if(NOT TARGET tests_${TAGNAME})
			message(STATUS "Adding target 'tests_${TAGNAME}'")
			add_custom_target(tests_${TAGNAME})
			add_custom_target(
				check_${TAGNAME}
				DEPENDS tests_${TAGNAME}
				COMMAND ${CMAKE_CTEST_COMMAND} "-R" "'\\[.*${TAGNAME}.*\\]'"
			)
		endif()
		add_dependencies(tests_${TAGNAME} ${TARGET_NAME})
	endforeach()
endfunction()
