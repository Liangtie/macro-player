cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
  macro-player
  VERSION 0.1.0
  DESCRIPTION "Short description"
  HOMEPAGE_URL "https://example.com/"
  LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----
add_library(
  macro-player_macro-player
  source/macro_player.cpp
)
add_library(macro-player::macro-player ALIAS macro-player_macro-player)

include(GenerateExportHeader)
generate_export_header(
  macro-player_macro-player
  BASE_NAME macro-player
  EXPORT_FILE_NAME export/macro-player/macro-player_export.hpp
  CUSTOM_CONTENT_FROM_VARIABLE pragma_suppress_c4251
)

if(NOT BUILD_SHARED_LIBS)
  target_compile_definitions(macro-player_macro-player PUBLIC MACRO_PLAYER_STATIC_DEFINE)
endif()

set_target_properties(
  macro-player_macro-player PROPERTIES
  CXX_VISIBILITY_PRESET hidden
  VISIBILITY_INLINES_HIDDEN YES
  VERSION "${PROJECT_VERSION}"
  SOVERSION "${PROJECT_VERSION_MAJOR}"
  EXPORT_NAME macro-player
  OUTPUT_NAME macro-player
)

target_include_directories(
  macro-player_macro-player ${warning_guard}
  PUBLIC
  "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

target_include_directories(
  macro-player_macro-player SYSTEM
  PUBLIC
  "$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/export>"
)

target_compile_features(macro-player_macro-player PUBLIC cxx_std_20)

find_package(fmt REQUIRED)
target_link_libraries(macro-player_macro-player PRIVATE fmt::fmt)

# ---- Install rules ----
if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Examples ----
if(PROJECT_IS_TOP_LEVEL)
  option(BUILD_EXAMPLES "Build examples tree." "${macro-player_DEVELOPER_MODE}")

  if(BUILD_EXAMPLES)
    add_subdirectory(example)
  endif()
endif()

# ---- Developer mode ----
if(NOT macro-player_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
    AUTHOR_WARNING
    "Developer mode is intended for developers of macro-player"
  )
endif()

include(cmake/dev-mode.cmake)
