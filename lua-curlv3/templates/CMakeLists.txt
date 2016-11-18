CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

PROJECT("lua-curlv3")

ENABLE_TESTING()
FIND_PACKAGE(PythonInterp REQUIRED)

MESSAGE("curl lib: ${CURL_LIBRARY}")
MESSAGE("curl inc: ${CURL_INCLUDE_DIR}")


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
                      PRIVATE ${CURL_LIBRARY} ${LUA_LIBRARIES})
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
