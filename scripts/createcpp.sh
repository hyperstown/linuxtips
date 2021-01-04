#!/bin/bash

if ! $1; then
echo "No project name given"
else

file_location=$(pwd)/CMakeLists.txt

mkdir src

touch src/$1.cpp

cat > $file_location <<EOF
cmake_minimum_required (VERSION 3.5)

project ($1)

set (CMAKE_CXX_FLAGS "\${CMAKE_CXX_FLAGS} -Wall -pthread -std=c++14")
set (source_dir "\${PROJECT_SOURCE_DIR}/src/")

file (GLOB source_files "\${source_dir}/*.cpp")

add_executable ($1 \${source_files})

EOF

cmake . -G "CodeLite - Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug
fi
