# Build zlib first, it is a requirement of OpenSSL.
ADD_SUBDIRECTORY(zlib)

ADD_SUBDIRECTORY(libgpg-error)
ADD_SUBDIRECTORY(libgcrypt)

# libssh2 depends on openssl.
ADD_SUBDIRECTORY(libssh2)

# curl requires libssh2.
ADD_SUBDIRECTORY(curl)
