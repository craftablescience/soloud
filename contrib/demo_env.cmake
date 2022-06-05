set (TARGET_NAME SoLoud_env)
add_executable(${TARGET_NAME}
	${SOURCE_PATH}/env/main.cpp
	${COMMON_SOURCES}
)
target_link_libraries (${TARGET_NAME} soloud OpenGL::GL)
include (Install)
