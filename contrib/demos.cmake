set (HEADER_PATH ../include)
set (SOURCE_PATH ../demos)

set (COMMON_SOURCES
	${SOURCE_PATH}/common/glew/GL/glew.c
	${SOURCE_PATH}/common/imgui/imgui.cpp
	${SOURCE_PATH}/common/imgui/imgui_demo.cpp
	${SOURCE_PATH}/common/imgui/imgui_draw.cpp
	${SOURCE_PATH}/common/soloud_demo_framework.cpp
)

if (SOLOUD_STATIC)
  add_definitions(-DGLEW_STATIC)
endif()

include_directories (${SOURCE_PATH}/common)
include_directories (${SOURCE_PATH}/common/glew)
include_directories (${SOURCE_PATH}/common/imgui)

find_package(OpenGL REQUIRED)

function (soloud_add_demo name sources)
	set (TARGET_NAME SoLoud_${name})
	add_executable (${TARGET_NAME} ${sources})
	target_link_libraries (${TARGET_NAME} soloud)
	include (Install)
endfunction()

soloud_add_demo(enumerate ${SOURCE_PATH}/enumerate/main.cpp)
soloud_add_demo(null ${SOURCE_PATH}/null/main.cpp)
soloud_add_demo(simplest ${SOURCE_PATH}/simplest/main.cpp)
soloud_add_demo(welcome ${SOURCE_PATH}/welcome/main.cpp)

if (SOLOUD_C_API)
	soloud_add_demo(c_test ${SOURCE_PATH}/c_test/main.c)
endif()

include (demo_env.cmake)
include (demo_megademo.cmake)
include (demo_piano.cmake)
