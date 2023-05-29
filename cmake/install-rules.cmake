if(PROJECT_IS_TOP_LEVEL)
  set(
      CMAKE_INSTALL_INCLUDEDIR "include/macro-player-${PROJECT_VERSION}"
      CACHE PATH ""
  )
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package macro-player)

install(
    DIRECTORY
    include/
    "${PROJECT_BINARY_DIR}/export/"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT macro-player_Development
)

install(
    TARGETS macro-player_macro-player
    EXPORT macro-playerTargets
    RUNTIME #
    COMPONENT macro-player_Runtime
    LIBRARY #
    COMPONENT macro-player_Runtime
    NAMELINK_COMPONENT macro-player_Development
    ARCHIVE #
    COMPONENT macro-player_Development
    INCLUDES #
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    macro-player_INSTALL_CMAKEDIR "${CMAKE_INSTALL_LIBDIR}/cmake/${package}"
    CACHE PATH "CMake package config location relative to the install prefix"
)
mark_as_advanced(macro-player_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${macro-player_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT macro-player_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${macro-player_INSTALL_CMAKEDIR}"
    COMPONENT macro-player_Development
)

install(
    EXPORT macro-playerTargets
    NAMESPACE macro-player::
    DESTINATION "${macro-player_INSTALL_CMAKEDIR}"
    COMPONENT macro-player_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
