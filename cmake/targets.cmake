# Records a target so that it may later be retrieved
function(cwrap_impl_record_target TARGET)
	set_property(GLOBAL APPEND PROPERTY CWRAP_TARGETS ${TARGET})
endfunction()

function(cwrap_executable NAME)
	cwrap_impl_record_target(${NAME})
	add_executable(${NAME} ${ARGN})
endfunction()

function(cwrap_library NAME)
	cwrap_impl_record_target(${NAME})
	add_library(${NAME} ${ARGN})
endfunction()
