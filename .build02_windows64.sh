#! /bin/bash
set -e

PRJ_DIR=${PWD}

# This is the path to the jonchki tool.
JONCHKI=${PRJ_DIR}/jonchki/local/jonchki.lua

#-----------------------------------------------------------------------------
#
# Build the windows64 version.
#
rm -rf build_windows64
mkdir build_windows64

mkdir build_windows64/lua5.1
mkdir build_windows64/lua5.1/build_requirements

pushd build_windows64/lua5.1/build_requirements
cmake -DBUILDCFG_ONLY_JONCHKI_CFG="ON" -DCMAKE_INSTALL_PREFIX="" -DCMAKE_C_FLAGS=-m64 -DCMAKE_CXX_FLAGS=-m64 -DCMAKE_SYSTEM_NAME=Windows -DCMAKE_C_COMPILER=x86_64-w64-mingw32-gcc -DCMAKE_CXX_COMPILER=x86_64-w64-mingw32-g++ -DCMAKE_RC_COMPILER=x86_64-w64-mingw32-windres ${PRJ_DIR}
make
lua5.1 ${JONCHKI} --verbose info --syscfg ${PRJ_DIR}/jonchki/jonchkisys.cfg --prjcfg ${PRJ_DIR}/jonchki/jonchkicfg.xml --distribution-id windows --cpu-architecture x86_64 --build-dependencies lua-curlv3/lua5.1-curlv3-0.3.5.1.xml
popd

pushd build_windows64/lua5.1
cmake -DBUILDCFG_LUA_USE_SYSTEM="OFF" -DBUILDCFG_LUA_VERSION="5.1" -DCMAKE_INSTALL_PREFIX="" -DCMAKE_C_FLAGS=-m64 -DCMAKE_CXX_FLAGS=-m64 -DCMAKE_SYSTEM_NAME=Windows -DCMAKE_C_COMPILER=x86_64-w64-mingw32-gcc -DCMAKE_CXX_COMPILER=x86_64-w64-mingw32-g++ -DCMAKE_RC_COMPILER=x86_64-w64-mingw32-windres ${PRJ_DIR}
make
popd
