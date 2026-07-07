cmake_minimum_required(VERSION 3.30)

project(ns
    VERSION 0.1.0
    LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_SCAN_FOR_MODULES OFF)

add_executable(ns
    src/main.cc
    src/cli.cc
)

target_include_directories(ns
    PRIVATE
        include
)

target_compile_options(ns
    PRIVATE
        -Wall -Wextra -Wpedantic -Werror
)

if (CMAKE_EXPORT_COMPILE_COMMANDS)
    execute_process(
        COMMAND ${CMAKE_COMMAND} -E create_symlink
            ${CMAKE_BINARY_DIR}/compile_commands.json
            ${CMAKE_SOURCE_DIR}/compile_commands.json
    )
endif()
