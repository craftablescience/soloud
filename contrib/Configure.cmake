include (OptionDependentOnPackage)
include (PrintOptionStatus)

option (SOLOUD_DYNAMIC "Set to ON to build dynamic SoLoud" OFF)
print_option_status (SOLOUD_DYNAMIC "Build dynamic library")

option (SOLOUD_STATIC "Set to ON to build static SoLoud" ON)
print_option_status (SOLOUD_STATIC "Build static library")

option (SOLOUD_C_API "Set to ON to include the C API" OFF)
print_option_status (SOLOUD_C_API "Build C API")

# TODO:
option (SOLOUD_BUILD_DEMOS "Set to ON for building demos" OFF)
print_option_status (SOLOUD_BUILD_DEMOS "Build demos")

option (SOLOUD_BACKEND_NULL "Set to ON for building NULL backend" ON)
print_option_status (SOLOUD_BACKEND_NULL "NULL backend")

option (SOLOUD_BACKEND_SDL2 "Set to ON for building SDL2 backend" OFF)
print_option_status (SOLOUD_BACKEND_SDL2 "SDL2 backend")

option (SOLOUD_BACKEND_SDL2_STATIC "Set to ON for building static SDL2 backend" OFF)
print_option_status (SOLOUD_BACKEND_SDL2_STATIC "SDL2 backend (static)")

option (SOLOUD_BACKEND_JACK "Set to ON for building JACK backend" OFF)
print_option_status (SOLOUD_BACKEND_JACK "JACK backend")

option (SOLOUD_BACKEND_MINIAUDIO "Set to ON for building miniaudio backend" ON)
print_option_status (SOLOUD_BACKEND_MINIAUDIO "miniaudio backend")

option (SOLOUD_BACKEND_NOSOUND "Set to ON for building nosound backend" ON)
print_option_status (SOLOUD_BACKEND_NOSOUND "nosound backend")

option (SOLOUD_BACKEND_OPENAL "Set to ON for building OpenAL backend" OFF)
print_option_status (SOLOUD_BACKEND_OPENAL "OpenAL backend")

option (SOLOUD_BACKEND_OPENAL_STATIC "Set to ON for building OpenAL backend (static)" OFF)
print_option_status (SOLOUD_BACKEND_OPENAL_STATIC "OpenAL backend (static)")

option (SOLOUD_BACKEND_OPENSLES "Set to ON for building OpenSLES backend" OFF)
print_option_status (SOLOUD_BACKEND_OPENSLES "OpenSLES backend")

option (SOLOUD_BACKEND_PORTAUDIO "Set to ON for building PortAudio backend" OFF)
print_option_status (SOLOUD_BACKEND_PORTAUDIO "PortAudio backend")

if (UNIX AND NOT APPLE)
	option (SOLOUD_BACKEND_ALSA "Set to ON for building ALSA backend" ON)
	print_option_status (SOLOUD_BACKEND_ALSA "ALSA backend")

elseif (APPLE)
	option (SOLOUD_BACKEND_COREAUDIO "Set to ON for building CoreAudio backend" ON)
	print_option_status (SOLOUD_BACKEND_COREAUDIO "CoreAudio backend")
endif()

if (WIN32)
	option (SOLOUD_BACKEND_XAUDIO2 "Set to ON for building XAudio2 backend" OFF)
	print_option_status (SOLOUD_BACKEND_XAUDIO2 "XAudio2 backend")

	option (SOLOUD_BACKEND_WINMM "Set to ON for building WINMM backend" ON)
	print_option_status (SOLOUD_BACKEND_WINMM "WINMM backend")

	option (SOLOUD_BACKEND_WASAPI "Set to ON for building WASAPI backend" OFF)
	print_option_status (SOLOUD_BACKEND_WASAPI "WASAPI backend")
endif()

option (SOLOUD_LIBMODPLUG_SUPPORT "Set to ON for libmodplug support" OFF)
print_option_status (SOLOUD_LIBMODPLUG_SUPPORT "Enable libmodplug support")

option (SOLOUD_LIBMODPLUG_SUPPORT_STATIC "Set to ON for libmodplug support (static)" OFF)
print_option_status (SOLOUD_LIBMODPLUG_SUPPORT_STATIC "Enable libmodplug support (static)")

option (SOLOUD_GENERATE_GLUE "Set to ON for generating the Glue APIs" OFF)
print_option_status (SOLOUD_GENERATE_GLUE "Generate Glue")
