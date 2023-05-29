cmake_minimum_required(VERSION 3.14)

project(macro-playerTests LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)

# ---- Dependencies ----

if(PROJECT_IS_TOP_LEVEL)
  find_package(macro-player REQUIRED)
  enable_testing()
endif()

find_package(Catch2 REQUIRED)
include(Catch)

# ---- Tests ----

add_executable(macro-player_test source/macro-player_test.cpp)
target_link_libraries(
    macro-player_test PRIVATE
    macro-player::macro-player
    Catch2::Catch2WithMain
)
target_compile_features(macro-player_test PRIVATE cxx_std_20)

catch_discover_tests(macro-player_test)

# ---- End-of-file commands ----

add_folders(Test)
