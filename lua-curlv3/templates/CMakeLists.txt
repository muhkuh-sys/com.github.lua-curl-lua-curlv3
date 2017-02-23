CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

PROJECT("lua-curlv3")

ENABLE_TESTING()
FIND_PACKAGE(PythonInterp REQUIRED)


# Get the includes and library for zlib.
MESSAGE("net.zlib-zlib_DIR: ${net.zlib-zlib_DIR}")
FIND_PACKAGE(net.zlib-zlib REQUIRED CONFIG)
GET_TARGET_PROPERTY(ZLIB_LIBRARIES net.zlib-zlib::zlibstatic LOCATION)
SET(ZLIB_INCLUDE_DIRS ${net.zlib-zlib_INCLUDE_DIR})
MESSAGE("ZLIB_LIBRARIES: ${ZLIB_LIBRARIES}")
MESSAGE("ZLIB_INCLUDE_DIRS: ${ZLIB_INCLUDE_DIRS}")

# Get the curl library.
MESSAGE("curl_DIR: ${curl_DIR}")
FIND_PACKAGE(curl REQUIRED CONFIG)
GET_TARGET_PROPERTY(CURL_LINK_FLAGS curl INTERFACE_LINK_FLAGS)

# Build the Lua modules.
ADD_LIBRARY(TARGET_lua_curlv3 MODULE
            src/l52util.c
            src/lceasy.c
            src/lcerror.c
            src/lchttppost.c
            src/lcmulti.c
            src/lcshare.c
            src/lcurl.c
            src/lcutils.c)

TARGET_INCLUDE_DIRECTORIES(TARGET_lua_curlv3
                           PRIVATE ${LUA_INCLUDE_DIR} ${CURL_INCLUDE_DIR})
TARGET_COMPILE_DEFINITIONS(TARGET_lua_curlv3
                           PRIVATE CURL_STATICLIB)
TARGET_LINK_LIBRARIES(TARGET_lua_curlv3
                      PRIVATE curl net.zlib-zlib::zlibstatic ${LUA_LIBRARIES})
SET_TARGET_PROPERTIES(TARGET_lua_curlv3 PROPERTIES LINK_FLAGS ${CURL_LINK_FLAGS})
SET_TARGET_PROPERTIES(TARGET_lua_curlv3 PROPERTIES PREFIX "" OUTPUT_NAME "lcurl")


# On mingw link all compiler libraries static.
IF((${CMAKE_SYSTEM_NAME} STREQUAL "Windows") AND (${CMAKE_COMPILER_IS_GNUCC}))
	SET_PROPERTY(TARGET TARGET_lua_curlv3 PROPERTY LINK_FLAGS "-static -static-libgcc -static-libstdc++")
ENDIF((${CMAKE_SYSTEM_NAME} STREQUAL "Windows") AND (${CMAKE_COMPILER_IS_GNUCC}))

# Install the LUA module.
INSTALL(TARGETS TARGET_lua_curlv3
        EXPORT EXPORT_package
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION include)

# Add tests for this module.
IF((${CMAKE_SYSTEM_NAME} STREQUAL "Windows") AND (${CMAKE_COMPILER_IS_GNUCC}))
	# Here are the MinGW specific tests.
	ADD_TEST(NAME lua_curlv3_MinGW_DLL_dependencies
	         COMMAND "${PYTHON_EXECUTABLE}" ${CMAKE_HOME_DIRECTORY}/cmake/tests/mingw_dll_dependencies.py -u lua5.1 -u lua5.2 -u lua5.3 $<TARGET_FILE:TARGET_lua_curlv3>)
ENDIF((${CMAKE_SYSTEM_NAME} STREQUAL "Windows") AND (${CMAKE_COMPILER_IS_GNUCC}))
