set(TARGET_NAME "tests")
find_package(GTest)
file(GLOB SOURCES "*.cpp")

add_executable(${TARGET_NAME} ${SOURCES})
target_include_directories(${TARGET_NAME} PRIVATE "${CMAKE_SOURCE_DIR}/libs/arithmetics")
target_link_libraries(${TARGET_NAME} PRIVATE arithmetics GTest::GTest)

gtest_discover_tests(${TARGET_NAME})
