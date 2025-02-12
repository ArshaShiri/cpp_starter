cmake_minimum_required(VERSION 3.21)
project(starter CXX)

# This is going to be useful to link to the VS Code.
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
enable_testing()
add_subdirectory(libs)
