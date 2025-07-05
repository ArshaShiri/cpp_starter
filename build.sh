#!/bin/bash

programName="$(basename "$0")"

printManual() {
    cat <<EOF
usage: $programName

    echo -c "\t clean build"
    echo -d "\t debug build"
    echo -i "\t reconfigure project"
    echo -t all "\t run all the tests in the project"
    echo -t {test_name} "\t run a specific test"
EOF
    exit "${1-0}"
}

BUILD_TYPES=("Debug" "Release")

declare -A COMPILER_FLAGS
COMPILER_FLAGS["Debug"]="-g -O0 -Wall -Werror"
COMPILER_FLAGS["Release"]="-O3 -Wall -Werror"

declare -A LINKER_FLAGS
LINKER_FLAGS["Debug"]=""
LINKER_FLAGS["Release"]="-s"

clean_build=false
reconfigure=false
debug=false
run_tests=false
test_name="all"

while getopts "cidt:" opt; do
    case $opt in
    c)
        clean_build=true
        ;;
    i)
        reconfigure=true
        ;;
    d)
        debug=true
        ;;
    t)
        run_tests=true
        test_name="$OPTARG"
        ;;
    *)
        printManual
        exit 64 # EX_USAGE
        ;;
    esac
done

BUILD_FOLDER_NAME="build"

if [ $clean_build = true ]; then
    rm -rf $BUILD_FOLDER_NAME
fi

build_path=${BUILD_FOLDER_NAME}/Release
build_type=Release

if [ $debug = true ]; then
    echo "Debug build"
    build_path=${BUILD_FOLDER_NAME}/Debug
    build_type=Debug
fi

mkdir -p ${build_path}

if [ $reconfigure = true ] || [ "$clean_build" = true ]; then
    echo "Reconfiguring the project"
    conan install . --build=missing --settings:host=build_type=$build_type
fi

if [ $reconfigure = true ] || [ $clean_build = true ]; then
    echo "Clean build"
    cmake -S . -DCMAKE_BUILD_TYPE=${build_type} \
        -DCMAKE_CXX_FLAGS="${COMPILER_FLAGS[$build_type]}" \
        -B $build_path -DCMAKE_TOOLCHAIN_FILE="${build_path}/generators/conan_toolchain.cmake" # --trace-expand > trace.txt 2>&1
fi

cmake --build $build_path --parallel $(($(nproc) - 1))

if [ $run_tests = true ]; then
    if [ $test_name = "all" ]; then
        echo "Running all tests!"
        ctest --test-dir $build_path
    else
        echo "Running test: $test_name"
        ctest --test-dir $build_path -R "^${test_name}$"
    fi
fi
