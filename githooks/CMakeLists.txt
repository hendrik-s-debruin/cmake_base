# Remove the default githook directory and link it instead to this directory
file(REMOVE_RECURSE
	${PROJECT_SOURCE_DIR}/.git/hooks
)

file(CREATE_LINK
	${CMAKE_CURRENT_SOURCE_DIR}
	${PROJECT_SOURCE_DIR}/.git/hooks
	SYMBOLIC
)
