#!/bin/sh

set -e

exec 1>&2

redo-ifchange sdx-20110317.kit tclkit-8.6.3-win32-x86_64.exe dir_save.tcl main.tcl

mkdir -p myapp.vfs
cp dir_save.tcl myapp.vfs
cp main.tcl myapp.vfs

tclkit-8.6.3-win32-x86_64.exe sdx-20110317.kit wrap myapp -runtime tclkit-8.6.3-win32-x86_64.exe

mv myapp "$3"
