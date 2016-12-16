#----------------------------------------------------------------------------
#
# Muhkuh can build modules for the Lua language. This section allows to user
# to choose which lua version should be used.
#

OPTION(BUILDCFG_LUA_USE_SYSTEM "Use the system-wide installed LUA version. The default is OFF."
       "OFF")
OPTION(BUILDCFG_LUA_VERSION "Select the LUA version used in this build. Possible values are 5.1, 5.2 and 5.3. The default is 5.1."
       "5.1")

# Use the MBS LUA version on Windows.
IF((${BUILDCFG_LUA_USE_SYSTEM} STREQUAL "OFF"))
	LIST(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR}/build_requirements/jonchki/install/dev/cmake)
	MESSAGE("CMAKE_PREFIX_PATH: ${CMAKE_PREFIX_PATH}")

	IF((${BUILDCFG_LUA_VERSION} STREQUAL "5.1"))
		FIND_PACKAGE(org.lua-lua5.1 REQUIRED)
		SET(LUA_FOUND 1)
		GET_TARGET_PROPERTY(LUA_LIBRARIES org.lua-lua5.1::TARGET_lualib LOCATION)
		GET_TARGET_PROPERTY(LUA_INCLUDE_DIR org.lua-lua5.1::TARGET_lualib INTERFACE_INCLUDE_DIRECTORIES)
		SET(LUA_VERSION_STRING ${org.lua-lua51_VERSION})
	ELSEIF((${BUILDCFG_LUA_VERSION} STREQUAL "5.2"))
		FIND_PACKAGE(org.lua-lua5.2 REQUIRED)
		SET(LUA_FOUND 1)
		GET_TARGET_PROPERTY(LUA_LIBRARIES org.lua-lua5.2::TARGET_lualib LOCATION)
		GET_TARGET_PROPERTY(LUA_INCLUDE_DIR org.lua-lua5.2::TARGET_lualib INTERFACE_INCLUDE_DIRECTORIES)
		SET(LUA_VERSION_STRING ${org.lua-lua52_VERSION})
	ELSEIF((${BUILDCFG_LUA_VERSION} STREQUAL "5.3"))
		FIND_PACKAGE(org.lua-lua5.3 REQUIRED)
		SET(LUA_FOUND 1)
		GET_TARGET_PROPERTY(LUA_LIBRARIES org.lua-lua5.3::TARGET_lualib LOCATION)
		GET_TARGET_PROPERTY(LUA_INCLUDE_DIR org.lua-lua5.3::TARGET_lualib INTERFACE_INCLUDE_DIRECTORIES)
		SET(LUA_VERSION_STRING ${org.lua-lua53_VERSION})
	ELSE((${BUILDCFG_LUA_VERSION} STREQUAL "5.1"))
		# Stop here!
		MESSAGE(FATAL_ERROR "The value '${BUILDCFG_LUA_VERSION}' for BUILDCFG_LUA_VERSION is invalid!")
	ENDIF((${BUILDCFG_LUA_VERSION} STREQUAL "5.1"))
ELSE((${BUILDCFG_LUA_USE_SYSTEM} STREQUAL "OFF"))
	IF((${BUILDCFG_LUA_VERSION} STREQUAL "5.1"))
		FIND_PACKAGE(Lua 5.1 REQUIRED EXACT)
	ELSEIF((${BUILDCFG_LUA_VERSION} STREQUAL "5.2"))
		FIND_PACKAGE(Lua 5.2 REQUIRED EXACT)
	ELSEIF((${BUILDCFG_LUA_VERSION} STREQUAL "5.3"))
		FIND_PACKAGE(Lua 5.3 REQUIRED EXACT)
	ELSE((${BUILDCFG_LUA_VERSION} STREQUAL "5.1"))
		MESSAGE(FATAL_ERROR "The value '${BUILDCFG_LUA_VERSION}' for BUILDCFG_LUA_VERSION is invalid!")
	ENDIF((${BUILDCFG_LUA_VERSION} STREQUAL "5.1"))
ENDIF((${BUILDCFG_LUA_USE_SYSTEM} STREQUAL "OFF"))

