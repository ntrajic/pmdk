# SPDX-License-Identifier: BSD-3-Clause
# Copyright 2014-2019, Intel Corporation

#
# src/test/obj_direct/TEST0 -- unit test for direct
#

. ..\unittest\unittest.ps1

require_test_type medium

require_fs_type any

setup

expect_normal_exit $Env:EXE_DIR\obj_direct$Env:EXESUFFIX $DIR 9

pass
