message(STATUS "Adding 'format' target -- note this target should be added last")

get_property(DEFINED_TARGETS GLOBAL PROPERTY CWRAP_TARGETS)
foreach(TARGET IN LISTS DEFINED_TARGETS)
	get_property(TARGET_SOURCES TARGET ${TARGET} PROPERTY SOURCES)
	list(APPEND SOURCE_LIST ${TARGET_SOURCES})
endforeach()

add_custom_target(format
	COMMAND clang-format --dry-run ${SOURCE_LIST}
	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
)

add_custom_target(format-force-inplace
	COMMAND clang-format -i ${SOURCE_LIST}
	WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
)
