find_package(PkgConfig)

PKG_CHECK_MODULES(PC_MATX matx)

FIND_PATH(
    MATX_INCLUDE_DIRS
    NAMES matx/api.h
    HINTS $ENV{MATX_DIR}/include
        ${PC_MATX_INCLUDEDIR}
    PATHS ${CMAKE_INSTALL_PREFIX}/include
          /usr/local/include
          /usr/include
)

FIND_LIBRARY(
    MATX_LIBRARIES
    NAMES gnuradio-matx
    HINTS $ENV{MATX_DIR}/lib
        ${PC_MATX_LIBDIR}
    PATHS ${CMAKE_INSTALL_PREFIX}/lib
          ${CMAKE_INSTALL_PREFIX}/lib64
          /usr/local/lib
          /usr/local/lib64
          /usr/lib
          /usr/lib64
          )

include("${CMAKE_CURRENT_LIST_DIR}/matxTarget.cmake")

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(MATX DEFAULT_MSG MATX_LIBRARIES MATX_INCLUDE_DIRS)
MARK_AS_ADVANCED(MATX_LIBRARIES MATX_INCLUDE_DIRS)
