# serial

This is a cross-platform library for interfacing with RS-232 serial-like ports written in C++. It provides a modern C++ interface with a workflow designed to look and feel like PySerial, but with the speed and control provided by C++.

This library can be built and installed to the OS like most UNIX libraries with `make` and then `sudo make install`.

`Serial` is a class that provides the basic interface common to serial libraries (`open`, `close`, `read`, `write`, etc..) and requires no extra dependencies. It also provides tight control over timeouts and control over handshaking lines.

## Changes to the original version

**This is a fork of [`wjwwood/serial`](https://github.com/wjwwood/serial) maintained by [`dotX-Automation`](https://github.com/dotX-Automation).**

This software is republished retaining the original license and liability disclaimers. The original software is provided as is and without any warranty. All the authors are not responsible for any issues arising from the use of this software.

This version is mainly aimed towards UNIX systems, development on Visual Studio Code, and system-wide installations with Make and CMake. Many original features may have been removed, deprecated, or commented out.

## Installation

Build:

    make

Build and run the tests:

    make test

Install:

    make install

You may have to run `sudo ldconfig` afterwards.

## License and authors

[MIT License](LICENSE)

Roberto Masocco <r.masocco@dotxautomation.com>

William Woodall <wjwwood@gmail.com>

John Harrison <ash.gti@gmail.com>
