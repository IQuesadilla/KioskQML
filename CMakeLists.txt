cmake_minimum_required(VERSION 3.21.1)

option(LINK_INSIGHT "Link Qt Insight Tracker library" ON)
option(BUILD_QDS_COMPONENTS "Build design studio components" ON)

project(KioskQMLApp LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)

find_package(Qt6 6.2 REQUIRED COMPONENTS Core Gui Qml Quick)

if (Qt6_VERSION VERSION_GREATER_EQUAL 6.3)
    qt_standard_project_setup()
endif()

qt_add_executable(KioskQMLApp src/main.cpp
    src/qmlshell.h src/qmlshell.cpp)

qt_add_resources(KioskQMLApp "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)

target_link_libraries(KioskQMLApp PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)

if (BUILD_QDS_COMPONENTS)
    include(${CMAKE_CURRENT_SOURCE_DIR}/qmlcomponents)
endif()

include(${CMAKE_CURRENT_SOURCE_DIR}/qmlmodules)

if (LINK_INSIGHT)
    include(${CMAKE_CURRENT_SOURCE_DIR}/insight)
endif ()

install(TARGETS KioskQMLApp
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
