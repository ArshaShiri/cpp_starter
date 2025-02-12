cmake_minimum_required(VERSION 3.21)

project(
    arithmetics
    VERSION 1.0
    LANGUAGES CXX
)

add_library(${PROJECT_NAME})
file(GLOB SOURCES "src/*.cpp")

target_include_directories(${PROJECT_NAME} PUBLIC include)
target_sources(${PROJECT_NAME} PRIVATE ${SOURCES})

target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_20)

add_subdirectory(test)
