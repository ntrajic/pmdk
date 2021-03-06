#
# SPDX-License-Identifier: BSD-3-Clause
# Copyright 2014-2019, Intel Corporation
#
# Copyright (c) 2016, Microsoft Corporation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in
#       the documentation and/or other materials provided with the
#       distribution.
#
#     * Neither the name of the copyright holder nor the names of its
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

#
# src\test\blk_recovery\TEST0 -- unit test for pmemblk recovery
#

. ..\unittest\unittest.ps1

require_test_type medium

# doesn't make sense to run in local directory
require_fs_type pmem non-pmem
require_build_type nondebug static-nondebug

setup

# single arena case
create_holey_file 2G $DIR\testfile1

#
# Simple case, one write interrupted.  pmemblk_check() should note
# that testfile1 is consistent (after recovery steps were taken).
#
expect_abnormal_exit $Env:EXE_DIR\blk_recovery$Env:EXESUFFIX 4096 $DIR\testfile1 5 10
mv out0.log interrupted0.log

expect_normal_exit $Env:EXE_DIR\blk_recovery$Env:EXESUFFIX 4096 $DIR\testfile1
mv out0.log check0.log

check_pool $DIR\testfile1

check

pass

