CMake Project Base
================================================================================

This repository contains a bare-bones CMake project to quick-start a new C++
project. It takes care of some tedious integrations that often need to be set up
for new projects.

Clang-Format Integration
--------------------------------------------------------------------------------

Clang-Format is preconfigured, but is not currently integrated into the project

CMake-Format Integration
--------------------------------------------------------------------------------

CMake-Foramt is preconfigured, but is not currently integrated into the project

Clang-Tidy Integration
--------------------------------------------------------------------------------

A preconfigured `.clang-tidy` file is provided. `clang-tidy` is run
automatically on each compilation. This can be set with the cache variable
`EXTRA_COMPILATION_CHECKS_CLANG_TIDY`. Consider setting this to `OFF` during
active development cycles by typing in the build directory:

	ccmake ..

Or by modifying `CMakeCache.txt`.

Include-What-You-Use Integration
--------------------------------------------------------------------------------

CMake will automatically run `include-what-you-use` on each compilation. This
can be set with the cache variable `EXTRA_COMPILATION_CHECKS_CLANG_IWYU`.
Consider setting this to `OFF` during active development cycles typing in the
build directory:

	ccmake ..

Or by modifying `CMakeCache.txt`.

CTest Integrations
--------------------------------------------------------------------------------

This project uses [Catch2](https://github.com/catchorg/Catch2) as its test
framework. To run the tests, Catch2 will have to be installed on the system.

Tests can be placed inside of the `test` directory. To register a test, simply
use the function `create_test`. As its first argument, specify the name of the
test. The function takes the following sections:

* `SOURCE`: a list of source files that comprise the test
* `LINK`: a list of libraries that the test needs to link to
* `TAG`: a list of tags for the test

Tests are registered with CTest using the form `[tag1 tag2 ... tagN]:TEST_CASE`,
where `tagX` is the tag-name specified in the argument of the command, and
`TEST_CASE` is the string description of a test case as written in the
Catch2 `TEST_CASE` macro inside the C++ source code itself.

Tests are not built by default. To build all the tests, type:

	$ make tests

The tests can then be run by typing:

	$ ctest

As a convenience, to build all the tests and then run them, type:

	$ make check

Using the `-R` and `-E` flags of CTest, you can specify which tests to run:

	$ ctest -R '\[.*TAG_NAME.*\]'

All the tests corresponding to a given tag name can be built using:

	$ make tests_<TAG_NAME>

Again, to build and run these tests in one go, simply type:

	$ make check_<TAG_NAME>

Doxygen Integration
--------------------------------------------------------------------------------

To build the documentation, call

```txt
make doc
```

Using the stub indside of `doc`, multiple documentation targets can be built up
easily. Simply specify the Doxygen settings as shown in the example and add a
custom target for the new documentation version. To define a list for Doxygen,
simply use the provided `add_doxygen_values` macro.

EditorConfig
--------------------------------------------------------------------------------

A basic `.editorconfig`  file is provided.
