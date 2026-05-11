CMAKE_MINIMUM_REQUIRED(VERSION 3.7)

PROJECT("lua-curlv3")

# Get the curl library.
MESSAGE("se.haxx.curl-curl_DIR: ${se.haxx.curl-curl_DIR}")
FIND_PACKAGE(se.haxx.curl-curl REQUIRED CONFIG)
GET_TARGET_PROPERTY(CURL_LINK_FLAGS se.haxx.curl-curl INTERFACE_LINK_FLAGS)

# Build the Lua modules.
ADD_LIBRARY(TARGET_lua_curlv3 MODULE
            src/l52util.c
            src/lceasy.c
            src/lcerror.c
            src/lchttppost.c
            src/lcmime.c
            src/lcmulti.c
            src/lcshare.c
            src/lcurlapi.c
            src/lcurl.c
            src/lcutils.c)

TARGET_INCLUDE_DIRECTORIES(TARGET_lua_curlv3
                           PRIVATE ${LUA_INCLUDE_DIR} ${CURL_INCLUDE_DIR})
TARGET_COMPILE_DEFINITIONS(TARGET_lua_curlv3
                           PRIVATE CURL_STATICLIB)
TARGET_LINK_LIBRARIES(TARGET_lua_curlv3
                      PRIVATE se.haxx.curl-curl z ${CURL_LINK_FLAGS} nghttp2 ngtcp2 ngtcp2_crypto_gnutls idn2 brotlidec brotlienc brotlicommon ${LOCAL_LIBRARIES}/libz.a z -L${LOCAL_LIBRARIES})
SET_TARGET_PROPERTIES(TARGET_lua_curlv3 PROPERTIES LINK_FLAGS ${CURL_LINK_FLAGS})
SET_TARGET_PROPERTIES(TARGET_lua_curlv3 PROPERTIES PREFIX "" OUTPUT_NAME "lcurl")

# Install the LUA module.
INSTALL(TARGETS TARGET_lua_curlv3
        EXPORT EXPORT_package
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION include)
