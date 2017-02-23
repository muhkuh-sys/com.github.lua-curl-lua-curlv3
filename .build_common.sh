# Do not call this script directly. It is included from the .build??_*.sh files.

echo "PRJ_DIR        = ${PRJ_DIR}"
echo "BUILD_DIR      = ${BUILD_DIR}"
echo "CMAKE_COMPILER = ${CMAKE_COMPILER}"
echo "JONCHKI        = ${JONCHKI}"
echo "JONCHKI_SYSTEM = ${JONCHKI_SYSTEM}"

# Create all folders.
rm -rf ${BUILD_DIR}
mkdir -p ${BUILD_DIR}/lua5.1/build_requirements
mkdir -p ${BUILD_DIR}/lua5.2/build_requirements
mkdir -p ${BUILD_DIR}/lua5.3/build_requirements


# Get the build requirements for the LUA5.1 version.
pushd ${BUILD_DIR}/lua5.1/build_requirements
cmake -DBUILDCFG_ONLY_JONCHKI_CFG="ON" -DBUILDCFG_LUA_VERSION="5.1" -DCMAKE_INSTALL_PREFIX="" ${CMAKE_COMPILER} ${PRJ_DIR}
make
lua5.1 ${JONCHKI} --verbose debug --syscfg ${PRJ_DIR}/jonchki/jonchkisys.cfg --prjcfg ${PRJ_DIR}/jonchki/jonchkicfg.xml ${JONCHKI_SYSTEM} --build-dependencies lua-curlv3/lua5.1-curlv3-*.xml
popd
CMAKE_MODULES="-Dcurl_DIR='${BUILD_DIR}/lua5.1/build_requirements/jonchki/install/dev/cmake' -Dnet.zlib-zlib_DIR='${BUILD_DIR}/lua5.1/build_requirements/jonchki/install/dev/cmake'"

# Build the CURL library for LUA5.1.
pushd ${BUILD_DIR}/lua5.1
cmake -DBUILDCFG_LUA_USE_SYSTEM="OFF" -DBUILDCFG_LUA_VERSION="5.1" -DCMAKE_INSTALL_PREFIX="" ${CMAKE_COMPILER} ${CMAKE_MODULES} ${PRJ_DIR}
make
make install DESTDIR=${BUILD_DIR}/lua5.1/install
popd


# Get the build requirements for the LUA5.2 version.
pushd ${BUILD_DIR}/lua5.2/build_requirements
cmake -DBUILDCFG_ONLY_JONCHKI_CFG="ON" -DBUILDCFG_LUA_VERSION="5.2" -DCMAKE_INSTALL_PREFIX="" ${CMAKE_COMPILER} ${PRJ_DIR}
make
lua5.1 ${JONCHKI} --verbose debug --syscfg ${PRJ_DIR}/jonchki/jonchkisys.cfg --prjcfg ${PRJ_DIR}/jonchki/jonchkicfg.xml ${JONCHKI_SYSTEM} --build-dependencies lua-curlv3/lua5.2-curlv3-*.xml
popd
CMAKE_MODULES="-Dcurl_DIR='${BUILD_DIR}/lua5.2/build_requirements/jonchki/install/dev/cmake' -Dnet.zlib-zlib_DIR='${BUILD_DIR}/lua5.2/build_requirements/jonchki/install/dev/cmake'"

# Build the CURL library for LUA5.2.
pushd ${BUILD_DIR}/lua5.2
cmake -DBUILDCFG_LUA_USE_SYSTEM="OFF" -DBUILDCFG_LUA_VERSION="5.2" -DCMAKE_INSTALL_PREFIX="" ${CMAKE_COMPILER} ${CMAKE_MODULES} ${PRJ_DIR}
make
make install DESTDIR=${BUILD_DIR}/lua5.2/install
popd


# Get the build requirements for the LUA5.3 version.
pushd ${BUILD_DIR}/lua5.3/build_requirements
cmake -DBUILDCFG_ONLY_JONCHKI_CFG="ON" -DBUILDCFG_LUA_VERSION="5.3" -DCMAKE_INSTALL_PREFIX="" ${CMAKE_COMPILER} ${PRJ_DIR}
make
lua5.1 ${JONCHKI} --verbose debug --syscfg ${PRJ_DIR}/jonchki/jonchkisys.cfg --prjcfg ${PRJ_DIR}/jonchki/jonchkicfg.xml ${JONCHKI_SYSTEM} --build-dependencies lua-curlv3/lua5.3-curlv3-*.xml
popd
CMAKE_MODULES="-Dcurl_DIR='${BUILD_DIR}/lua5.3/build_requirements/jonchki/install/dev/cmake' -Dnet.zlib-zlib_DIR='${BUILD_DIR}/lua5.3/build_requirements/jonchki/install/dev/cmake'"

# Build the CURL library for LUA5.3.
pushd ${BUILD_DIR}/lua5.3
cmake -DBUILDCFG_LUA_USE_SYSTEM="OFF" -DBUILDCFG_LUA_VERSION="5.3" -DCMAKE_INSTALL_PREFIX="" ${CMAKE_COMPILER} ${CMAKE_MODULES} ${PRJ_DIR}
make
make install DESTDIR=${BUILD_DIR}/lua5.3/install
popd
