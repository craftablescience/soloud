set (SOURCE_PATH ../src)

set (TARGET_NAME tool_codegen)
add_executable(${TARGET_NAME} ${SOURCE_PATH}/tools/codegen/main.cpp)
target_link_libraries (${TARGET_NAME} soloud)
include (Install)

set (TARGET_NAME tool_lutgen)
add_executable(${TARGET_NAME} ${SOURCE_PATH}/tools/lutgen/main.cpp)
target_link_libraries (${TARGET_NAME} soloud)
include (Install)

set (TARGET_NAME tool_resamplerlab)
add_executable(${TARGET_NAME}
	${SOURCE_PATH}/tools/resamplerlab/main.cpp
	${SOURCE_PATH}/tools/resamplerlab/stb_image_write.c
)
target_link_libraries (${TARGET_NAME} soloud)
include (Install)

set (TARGET_NAME tool_sanity)
add_executable(${TARGET_NAME} ${SOURCE_PATH}/tools/sanity/sanity.cpp)
target_link_libraries (${TARGET_NAME} soloud)
include (Install)
