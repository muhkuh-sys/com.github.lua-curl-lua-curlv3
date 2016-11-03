cmake_minimum_required(VERSION 3.2.3)

PROJECT("libssh2")

INCLUDE(ExternalProject)


#----------------------------------------------------------------------------
#
# Build the project.
#

SET(PRJ_CMAKE_ARGS "")
LIST(APPEND PRJ_CMAKE_ARGS "-DBUILD_SHARED_LIBS=OFF")
LIST(APPEND PRJ_CMAKE_ARGS "-DBUILD_EXAMPLES=OFF")
LIST(APPEND PRJ_CMAKE_ARGS "-DBUILD_TESTING=OFF")
LIST(APPEND PRJ_CMAKE_ARGS "-DCMAKE_C_FLAGS=${CMAKE_C_FLAGS}")
LIST(APPEND PRJ_CMAKE_ARGS "-DCMAKE_SYSTEM_NAME=${CMAKE_SYSTEM_NAME}")
LIST(APPEND PRJ_CMAKE_ARGS "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}")
IF(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
	LIST(APPEND PRJ_CMAKE_ARGS "-DCMAKE_RC_COMPILER=${CMAKE_RC_COMPILER}")
ENDIF(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
LIST(APPEND PRJ_CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=''")

ExternalProject_Add(TARGET_libssh2
                    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/libssh2-1.8.0
                    URL ${CMAKE_CURRENT_SOURCE_DIR}/libssh2-1.8.0.tar.gz
                    URL_HASH SHA1=baf2d1fb338eee531ba9b6b121c64235e089e0f5
                    CMAKE_ARGS ${PRJ_CMAKE_ARGS}
                    INSTALL_COMMAND make install DESTDIR=${CMAKE_CURRENT_BINARY_DIR}/install
                    TEST_AFTER_INSTALL 1
                    TEST_COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/install/lib/cmake/libssh2/Libssh2Config.cmake ${CMAKE_CURRENT_BINARY_DIR}/install/lib/cmake/libssh2/LibSSH2Config.cmake
)

SET(LIBSSH2_CMAKE_MODULE_PATH  ${CMAKE_CURRENT_BINARY_DIR}/install/lib/cmake/libssh2  CACHE INTERNAL "The CMAKE configuration file for the ssh2 library.")
