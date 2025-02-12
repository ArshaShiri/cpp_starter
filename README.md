# C++ Starter Project
A simple C++ starter project using Conan and Cmake. The project consists of a single static library and its associated tests.

## Build
To build the project, the `build.sh` script can be used. The script can be modified to add the desired compiler or linker flags.

Script's options:

* `-c` Clean build (deleting the build folder and rebuilding)
* `-d` Debug build (default is release)
* `-i` Reconfigure the project
* `-t all` Run all the tests
* `-t {test_name}` run a specific test

## Formatting Tools
A predefined `.clang-format` file is provided in the project. Using [pre-commit](https://pre-commit.com/), git hooks can be enabled in the project to perform some basic checks before committing.
