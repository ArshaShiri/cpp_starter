from conan import ConanFile
from conan.tools.cmake import cmake_layout

class Starter(ConanFile):
    name = "Starter"
    version = "0.1"
    settings = "os", "compiler", "build_type", "arch"
    generators = "CMakeDeps" "CMakeToolchain"

    def layout(self):
        cmake_layout(self)

    def requirements(self):
        self.requires("gtest/1.14.0")
