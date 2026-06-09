cmake_minimum_required(VERSION 3.22)
project(RimWorldMobile)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_library(vulkan-lib vulkan)
find_library(egl-lib EGL)
find_library(gles-lib GLESv3)
find_library(android-lib android)
find_library(log-lib log)

add_library(rimworld SHARED
    src/main.cpp
    src/ecs_core.cpp
    src/pathfinding.cpp
    src/storyteller.cpp
    src/combat_system.cpp
    src/building_system.cpp
    src/save_system.cpp
)

target_include_directories(rimworld PRIVATE src/)

target_link_libraries(rimworld
    ${vulkan-lib}
    ${egl-lib}
    ${gles-lib}
    ${android-lib}
    ${log-lib}
    z
    c++_static
)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -DNDEBUG -flto=thin -march=armv8.2a+fp16+rcpc+dotprod")
