cmake_minimum_required(VERSION 3.8)
project(serial)

set(CMAKE_BUILD_TYPE "RelWithDebInfo")

# Default to C99
if(NOT CMAKE_C_STANDARD)
  set(CMAKE_C_STANDARD 99)
endif()

# Default to C++17
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 17)
endif()

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

if(APPLE)
  find_library(IOKIT_LIBRARY IOKit)
  find_library(FOUNDATION_LIBRARY Foundation)
endif()

if(UNIX AND NOT APPLE)
  # If Linux, add rt and pthread
  set(rt_LIBRARIES rt)
  set(pthread_LIBRARIES pthread)
endif()

# Sources
set(serial_SRCS
  src/serial.cc
  include/serial/serial.h
  include/serial/v8stdint.h)
if(APPLE)
  list(APPEND serial_SRCS src/impl/unix.cc)
  list(APPEND serial_SRCS src/impl/list_ports/list_ports_osx.cc)
elseif(UNIX)
  list(APPEND serial_SRCS src/impl/unix.cc)
  list(APPEND serial_SRCS src/impl/list_ports/list_ports_linux.cc)
else()
  list(APPEND serial_SRCS src/impl/win.cc)
  list(APPEND serial_SRCS src/impl/list_ports/list_ports_win.cc)
endif()

# Headers
include_directories(include)

# serial library
add_library(${PROJECT_NAME} SHARED ${serial_SRCS})
if(APPLE)
  target_link_libraries(${PROJECT_NAME} ${FOUNDATION_LIBRARY} ${IOKIT_LIBRARY})
elseif(UNIX)
  target_link_libraries(${PROJECT_NAME} rt pthread)
else()
  target_link_libraries(${PROJECT_NAME} setupapi)
endif()

# Examples
# add_executable(serial_example examples/serial_example.cc)
# add_dependencies(serial_example ${PROJECT_NAME})
# target_link_libraries(serial_example ${PROJECT_NAME})

# Install build products
install(TARGETS ${PROJECT_NAME}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
  LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
  RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)

# Install headers
install(FILES include/serial/serial.h include/serial/v8stdint.h
  DESTINATION ${CMAKE_INSTALL_PREFIX}/include/serial)
