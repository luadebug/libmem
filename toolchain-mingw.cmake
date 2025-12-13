set(CMAKE_SYSTEM_NAME Windows)
set(WIN32 1)
set(MINGW 1)

# Determine MinGW prefix based on architecture
# First try to detect from CMAKE_SYSTEM_PROCESSOR if set, otherwise try both
if(CMAKE_SYSTEM_PROCESSOR MATCHES "i686|i386|x86")
  set(MINGW_PREFIX "i686-w64-mingw32" CACHE STRING "")
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64|AMD64|amd64")
  set(MINGW_PREFIX "x86_64-w64-mingw32" CACHE STRING "")
else()
  # Try to find which compiler is available
  find_program(_MINGW_I686_GCC NAMES i686-w64-mingw32-gcc)
  find_program(_MINGW_X86_64_GCC NAMES x86_64-w64-mingw32-gcc)
  
  if(_MINGW_X86_64_GCC)
    set(MINGW_PREFIX "x86_64-w64-mingw32" CACHE STRING "")
  elseif(_MINGW_I686_GCC)
    set(MINGW_PREFIX "i686-w64-mingw32" CACHE STRING "")
  else()
    message(FATAL_ERROR "Unable to determine MinGW prefix. CMAKE_SYSTEM_PROCESSOR=${CMAKE_SYSTEM_PROCESSOR}")
  endif()
endif()

find_program(CMAKE_C_COMPILER NAMES ${MINGW_PREFIX}-gcc REQUIRED)
find_program(CMAKE_CXX_COMPILER NAMES ${MINGW_PREFIX}-g++ REQUIRED)
find_program(CMAKE_AR NAMES ${MINGW_PREFIX}-ar)
find_program(CMAKE_RANLIB NAMES ${MINGW_PREFIX}-ranlib)
find_program(CMAKE_STRIP NAMES ${MINGW_PREFIX}-strip)

# Set find root paths
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

