find_package(PkgConfig)

PKG_CHECK_MODULES(PC_GR_MATX gnuradio-matx)

FIND_PATH(
    GR_MATX_INCLUDE_DIRS
    NAMES gnuradio/matx/api.h
    HINTS $ENV{MATX_DIR}/include
        ${PC_MATX_INCLUDEDIR}
    PATHS ${CMAKE_INSTALL_PREFIX}/include
          /usr/local/include
          /usr/include
)

FIND_LIBRARY(
    GR_MATX_LIBRARIES
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

include("${CMAKE_CURRENT_LIST_DIR}/gnuradio-matxTarget.cmake")

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(GR_MATX DEFAULT_MSG GR_MATX_LIBRARIES GR_MATX_INCLUDE_DIRS)
MARK_AS_ADVANCED(GR_MATX_LIBRARIES GR_MATX_INCLUDE_DIRS)
