if(WIN32 AND NOT MINGW) # this MUST NOT match CYGWIN or MinGW cross-compilation
	set(CMAKE_GENERATOR "NMake Makefiles" CACHE INTERNAL "" FORCE)
else()
	set(CMAKE_GENERATOR "Unix Makefiles" CACHE INTERNAL "" FORCE)
endif()
