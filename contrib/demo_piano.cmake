set (TARGET_NAME SoLoud_piano)
add_executable(${TARGET_NAME}
	${SOURCE_PATH}/piano/main.cpp
	${SOURCE_PATH}/piano/soloud_basicwave.cpp
	${SOURCE_PATH}/piano/soloud_padsynth.cpp
	${SOURCE_PATH}/piano/RtMidi.cpp
	${COMMON_SOURCES}
)

if (UNIX AND NOT WIN32 AND NOT APPLE)
	target_compile_definitions(${TARGET_NAME} PRIVATE "__LINUX_ALSA__")
elseif (WIN32)
	target_compile_definitions(${TARGET_NAME} PRIVATE "__WINDOWS_MM__")
elseif (APPLE)
	target_compile_definitions(${TARGET_NAME} PRIVATE "__MACOSX_CORE__")
endif()

target_link_libraries (${TARGET_NAME} ${LINK_LIBRARIES})
include (Install)
