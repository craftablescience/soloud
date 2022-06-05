set (TARGET_NAME SoLoud_megademo)
add_executable(${TARGET_NAME}
	${SOURCE_PATH}/megademo/3dtest.cpp
	${SOURCE_PATH}/megademo/annex.cpp
	${SOURCE_PATH}/megademo/ay.cpp
	${SOURCE_PATH}/megademo/filterfolio.cpp
	${SOURCE_PATH}/megademo/main.cpp
	${SOURCE_PATH}/megademo/mixbusses.cpp
	${SOURCE_PATH}/megademo/monotone.cpp
	${SOURCE_PATH}/megademo/multimusic.cpp
	${SOURCE_PATH}/megademo/pewpew.cpp
	${SOURCE_PATH}/megademo/radiogaga.cpp
	${SOURCE_PATH}/megademo/space.cpp
	${SOURCE_PATH}/megademo/speakers.cpp
	${SOURCE_PATH}/megademo/speechfilter.cpp
	${SOURCE_PATH}/megademo/tedsid.cpp
	${SOURCE_PATH}/megademo/thebutton.cpp
	${SOURCE_PATH}/megademo/virtualvoices.cpp
	${SOURCE_PATH}/megademo/wavformats.cpp
	${COMMON_SOURCES}
)
target_link_libraries (${TARGET_NAME} soloud OpenGL::GL)
include (Install)
