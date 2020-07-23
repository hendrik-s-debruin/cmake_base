CMake Project Base
================================================================================

This repository contains a bare-bones CMake project to quick-start a new C++
project. It takes care of some tedious integrations that often need to be set up
for new projects.

Clang-Format Integration
--------------------------------------------------------------------------------

The project comes with a `.clang-format` file preconfigured. This file can be
used as is, or replaced with a different file, depending on the style that needs
to be followed in the project.

To run `clang-format` automatically on all targets that are defined by this
project, type:

	$ make format

This will print a warning of all the areas of the code that are nonconforming.
Caveat: this only works for source files, not header files.

In order for this to work, you need to add executables and libraries with the
functions `cwrap_executable` and `cwrap_library`. These work exactly the same as
pure CMake `add_executable` and `add_library`, but also register their source
files for the `make format` command.

Note that the `format` target is made available by the call to
`include(format)`. This needs to be done after all targets have been declared,
otherwise some will be skipped in the call to `make format`.

If you want to run the auto-formatting on all the code and not just print out
the warnings, type:

	$ make format-force-inplace

Note that this will overwrite your source files. Be sure to commit any changes
before running this.

Clang-Tidy Integration
--------------------------------------------------------------------------------

A preconfigured `.clang-tidy` file is provided. `clang-tidy` is run
automatically on each compilation.

Include-What-You-Use Integration
--------------------------------------------------------------------------------

CMake will automatically run `include-what-you-use` on each compilation.

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
