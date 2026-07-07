preset := "dev"

alias b := build
build:
    @if [ ! -f ./build/build.ninja ]; then \
        cmake --preset {{preset}}; \
    fi
    @cmake --build --preset {{preset}}

run *args: build
    @./build/{{preset}}/ns {{ args }}

alias c:= clean
clean:
    @[[ -d ./build/ ]] && rm -fr ./build/

configure: clean
    @cmake --preset dev
