Return-Path: <bpf+bounces-46784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211B99F010C
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD4B285889
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62FC185B58;
	Fri, 13 Dec 2024 00:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JyOHhwtM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8804E186E52
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734050022; cv=none; b=Hd389W4q0uHd2Uuih5UYXJiBNhbOsWRANap6lxzGS5TP7VInmvt0r8RDy1eQhGSdbjEocbBAY6xPkr7GJeU2Rxgha6chaZHAZ/O+rUUhfSyxfVb3woYfNcfxt6mSzdScaQ4a9IFqVlP0umNpQjwwmGD7yVFlMaGK+sxRIZ7MxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734050022; c=relaxed/simple;
	bh=7ttteN6jJNiJ743CBfUquONgd/7tisg0Po/62UU9U2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rVSJVz2Qjm0rrFnQGwEZ7Q5fFh8MO2bzIRoaIb+OOuZWys4I3kALqfRHFvzaZv9HBfaTWeq/wlDfGWstuWt5YAdrzDavVE52Wj0kR/905AER5DzVOf0hZsyeFAcTAeXKAIGxiFbt8/mXjjPgdx0TB5aRfAtyvt1H1cexS9PwqY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JyOHhwtM; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-728eccf836bso1114705b3a.1
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 16:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734050017; x=1734654817; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HenWMeGh4kAbYR9t7BvDO7+uAdDd2bkf5B0cZ/CzUA=;
        b=JyOHhwtMqjL6DzWSW5sUedaoUlm34zoPCgXCm6xMEjdKF6zTQ/46U2LHDsHD07FQl1
         3d7XJnYx1ko2VswuRzHltMlSMiXNZV7QQ1mdJNkyOqjOgS5c/SLUgf5YEghq0wsn/Rcq
         LQkGDhRzOPmE12ZQy1dZh9JMUgFbOh/Kisnotw6UipWqngNm8GDRpM8WKMm6jiZAInuv
         kst05p9W120g+nu8KSTEBIwyYPX8ofuK86x6A5T9zl80PfqhqqwDUbm9NBBuGgKmy3rD
         3Lzwj02ftTbdTmjny5kjXajy1gHtlnfDBVWrbqEMCzv4UUfUIonRkM9lx0JzCZFTpPUA
         CIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734050017; x=1734654817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HenWMeGh4kAbYR9t7BvDO7+uAdDd2bkf5B0cZ/CzUA=;
        b=SDvYu8rBcl0e6joHFOk5HntjaBH3hvORTEwUumHCWw7iwu+uny6KVKOQHf8x3C8D8Q
         89siUnoazEw8uXUjKC24QKAbf7jcEoDVgIgnzdNoM9NzN0S4aRQdljSinWavtePbctp5
         BW9nOd/3EwlC8KihG4SkyPdaD4FB9BmKJXKiaEeIPo0l4CLn1250o9x7UB3eF3LODsYr
         UzwpPtGU3OElDElozZzNMGrTUh2K7OzKH7+Tjq0CkjyRhWZ5oCbt4ba2kddGHru+jBFb
         EDBUSv12cICDGNLCG4WW6rV3EGVhzJg5yE9YGRURvhJ4FWvHx07kBpVMd05HRAuCAH/Q
         iNMw==
X-Forwarded-Encrypted: i=1; AJvYcCU0PssXzXK9Qooj8dfotkee9xoGf+az6gULToGXJ3JnwKPGK6qhwhZcvkmVKxx0bxAQlaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKWf9mkwBz0pTEKdZ2QW77de1gTzcJuPuHduqCLJZl+5HqyppQ
	I/e54tMFZd2Rcrgk7OyqhBsM3E//t/iti9/6JvNIqkTypcunUfiI9he3umO7lBBge8wm0QiwvfE
	6
X-Gm-Gg: ASbGncsdMkNLQxf48vaNpHslDes7KDvRx8G2ZBuRk5hju2hRHcvg7IBA25/tgk/X10l
	OvrAKDAXXV1ek0L3/snze0kmR+Q7S+iHWD2nrFSdNdeduJzYpS3dpmEK9GGog8VtN1sx2lA2igb
	3hBcicW++kMnfPmXUpaC7fhHrshAsvH/ixDdxNqllfCuUOG/6bhd0PkrcbSb0oduef740Por92+
	91dmM/Vzh9WZ0LK8dSjfY3EblnjXGyyQQeZ1QK2Y2Qy0kV5lnvzZ1LCNh3nmSghrFvypbez
X-Google-Smtp-Source: AGHT+IGFr7iD0oVKjTfkj6Egz2p76t/e5Kg7od7ykJe2c9o+wAfbD5N/hgAssXC8jLb4S6T4Qwzuvw==
X-Received: by 2002:a17:90b:4a09:b0:2ee:5bc9:75c7 with SMTP id 98e67ed59e1d1-2f28fa55c38mr1117715a91.5.1734050016653;
        Thu, 12 Dec 2024 16:33:36 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142e0ce50sm1934462a91.39.2024.12.12.16.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 16:33:35 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 12 Dec 2024 16:33:01 -0800
Subject: [PATCH v2 11/16] perf tools: arm64: Use syscall table
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-perf_syscalltbl-v2-11-f8ca984ffe40@rivosinc.com>
References: <20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com>
In-Reply-To: <20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=28964; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=7ttteN6jJNiJ743CBfUquONgd/7tisg0Po/62UU9U2Y=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3p0wwGVgK3Sn9c8XJ4u3e0xYcO3pQdes/wJqZsWmnBEf
 K/g0ZLEjlIWBjEOBlkxRRaeaw3MrXf0y46Klk2AmcPKBDKEgYtTACbyp4bhf/aKWfzuISpi0lFn
 ljxkPDHb5euiSausxO+n61lfdM9qCGX47xN5+pTkmYLDXy8dOTyt+o/Qg0fv8n3nfU5+9pRTsX2
 HNBsA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

arm64 uses a syscall table, use that in perf instead of using unistd.h.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                         |   5 +-
 tools/perf/Makefile.perf                           |   2 +-
 tools/perf/arch/arm64/Makefile                     |  22 -
 tools/perf/arch/arm64/entry/syscalls/Kbuild        |   3 +
 .../arch/arm64/entry/syscalls/Makefile.syscalls    |   6 +
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl  |  46 --
 .../perf/arch/arm64/entry/syscalls/syscall_32.tbl  | 476 +++++++++++++++++++++
 .../perf/arch/arm64/entry/syscalls/syscall_64.tbl  |   1 +
 tools/perf/arch/arm64/include/syscall_table.h      |   8 +
 tools/perf/check-headers.sh                        |   2 +
 tools/perf/util/syscalltbl.c                       |   4 -
 11 files changed, 499 insertions(+), 76 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index bf88840528a2e700983bd6ca4ca8b199ce93bc21..aefcbed7cdfac7c2a5d8db5cb111513f2d7c74ed 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -31,12 +31,12 @@ $(call detected_var,SRCARCH)
 ifneq ($(NO_SYSCALL_TABLE),1)
   NO_SYSCALL_TABLE := 1
 
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc arm64 s390 mips loongarch))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc s390 mips loongarch))
     NO_SYSCALL_TABLE := 0
   endif
 
   # architectures that use the generic syscall table scripts
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64))
     NO_SYSCALL_TABLE := 0
     CFLAGS += -DGENERIC_SYSCALL_TABLE
     CFLAGS += -I$(OUTPUT)/tools/perf/arch/$(SRCARCH)/include/generated
@@ -71,7 +71,6 @@ ifeq ($(SRCARCH),arm)
 endif
 
 ifeq ($(SRCARCH),arm64)
-  CFLAGS += -I$(OUTPUT)arch/arm64/include/generated
   LIBUNWIND_LIBS = -lunwind -lunwind-aarch64
 endif
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b64d06a999f679b64a158d73a213954f30ae4702..6a287f15fa1da5e8957558ee0a73b297d347f00d 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc))
+ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64))
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
 include Makefile.config
diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index 91570d5d428e401d940e1c31332ebb40c4b998d8..087e099fb453a9236db34878077a51f711881ce0 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -1,25 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 PERF_HAVE_JITDUMP := 1
 HAVE_KVM_STAT_SUPPORT := 1
-
-#
-# Syscall table generation for perf
-#
-
-out    := $(OUTPUT)arch/arm64/include/generated/asm
-header := $(out)/syscalls.c
-incpath := $(srctree)/tools
-sysdef := $(srctree)/tools/arch/arm64/include/uapi/asm/unistd.h
-sysprf := $(srctree)/tools/perf/arch/arm64/entry/syscalls/
-systbl := $(sysprf)/mksyscalltbl
-
-# Create output directory if not already present
-$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
-
-$(header): $(sysdef) $(systbl)
-	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(incpath) $(sysdef) > $@
-
-clean::
-	$(call QUIET_CLEAN, arm64) $(RM) $(header)
-
-archheaders: $(header)
diff --git a/tools/perf/arch/arm64/entry/syscalls/Kbuild b/tools/perf/arch/arm64/entry/syscalls/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..84c6599b4ea6a160217a3496449b205f2263f0fb
--- /dev/null
+++ b/tools/perf/arch/arm64/entry/syscalls/Kbuild
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_32.h
+syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls b/tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..e7e78c2d1c025b6954a1a22d44a744012e1ca3d4
--- /dev/null
+++ b/tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_32 +=
+syscall_abis_64 += renameat rlimit memfd_secret
+
+syscalltbl = $(srctree)/tools/perf/arch/arm64/entry/syscalls/syscall_%.tbl
diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
deleted file mode 100755
index 27d747c92d44c04f26ce7aef766a50e3f896f5ff..0000000000000000000000000000000000000000
--- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
+++ /dev/null
@@ -1,46 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-#
-# Generate system call table for perf. Derived from
-# powerpc script.
-#
-# Copyright IBM Corp. 2017
-# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
-# Changed by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
-# Changed by: Kim Phillips <kim.phillips@arm.com>
-
-gcc=$1
-hostcc=$2
-incpath=$3
-input=$4
-
-if ! test -r $input; then
-	echo "Could not read input file" >&2
-	exit 1
-fi
-
-create_sc_table()
-{
-	local sc nr max_nr
-
-	while read sc nr; do
-		printf "%s\n" "	[$nr] = \"$sc\","
-		max_nr=$nr
-	done
-
-	echo "#define SYSCALLTBL_ARM64_MAX_ID $max_nr"
-}
-
-create_table()
-{
-	echo "#include \"$input\""
-	echo "static const char *const syscalltbl_arm64[] = {"
-	create_sc_table
-	echo "};"
-}
-
-$gcc -E -dM -x c -I $incpath/include/uapi $input \
-	|awk '$2 ~ "__NR" && $3 !~ "__NR3264_" {
-		sub("^#define __NR(3264)?_", "");
-		print | "sort -k2 -n"}' \
-	|create_table
diff --git a/tools/perf/arch/arm64/entry/syscalls/syscall_32.tbl b/tools/perf/arch/arm64/entry/syscalls/syscall_32.tbl
new file mode 100644
index 0000000000000000000000000000000000000000..9a37930d4e26f0c6cb8fe78f76bb1a4f32cbea16
--- /dev/null
+++ b/tools/perf/arch/arm64/entry/syscalls/syscall_32.tbl
@@ -0,0 +1,476 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# AArch32 (compat) system call definitions.
+#
+# Copyright (C) 2001-2005 Russell King
+# Copyright (C) 2012 ARM Ltd.
+#
+# This file corresponds to arch/arm/tools/syscall.tbl
+# for the native EABI syscalls and should be kept in sync
+# Instead of the OABI syscalls, it contains pointers to
+# the compat entry points where they differ from the native
+# syscalls.
+#
+0	common	restart_syscall		sys_restart_syscall
+1	common	exit			sys_exit
+2	common	fork			sys_fork
+3	common	read			sys_read
+4	common	write			sys_write
+5	common	open			sys_open		compat_sys_open
+6	common	close			sys_close
+# 7 was sys_waitpid
+8	common	creat			sys_creat
+9	common	link			sys_link
+10	common	unlink			sys_unlink
+11	common	execve			sys_execve		compat_sys_execve
+12	common	chdir			sys_chdir
+# 13 was sys_time
+14	common	mknod			sys_mknod
+15	common	chmod			sys_chmod
+16	common	lchown			sys_lchown16
+# 17 was sys_break
+# 18 was sys_stat
+19	common	lseek			sys_lseek		compat_sys_lseek
+20	common	getpid			sys_getpid
+21	common	mount			sys_mount
+# 22 was sys_umount
+23	common	setuid			sys_setuid16
+24	common	getuid			sys_getuid16
+# 25 was sys_stime
+26	common	ptrace			sys_ptrace		compat_sys_ptrace
+# 27 was sys_alarm
+# 28 was sys_fstat
+29	common	pause			sys_pause
+# 30 was sys_utime
+# 31 was sys_stty
+# 32 was sys_gtty
+33	common	access			sys_access
+34	common	nice			sys_nice
+# 35 was sys_ftime
+36	common	sync			sys_sync
+37	common	kill			sys_kill
+38	common	rename			sys_rename
+39	common	mkdir			sys_mkdir
+40	common	rmdir			sys_rmdir
+41	common	dup			sys_dup
+42	common	pipe			sys_pipe
+43	common	times			sys_times		compat_sys_times
+# 44 was sys_prof
+45	common	brk			sys_brk
+46	common	setgid			sys_setgid16
+47	common	getgid			sys_getgid16
+# 48 was sys_signal
+49	common	geteuid			sys_geteuid16
+50	common	getegid			sys_getegid16
+51	common	acct			sys_acct
+52	common	umount2			sys_umount
+# 53 was sys_lock
+54	common	ioctl			sys_ioctl		compat_sys_ioctl
+55	common	fcntl			sys_fcntl		compat_sys_fcntl
+# 56 was sys_mpx
+57	common	setpgid			sys_setpgid
+# 58 was sys_ulimit
+# 59 was sys_olduname
+60	common	umask			sys_umask
+61	common	chroot			sys_chroot
+62	common	ustat			sys_ustat		compat_sys_ustat
+63	common	dup2			sys_dup2
+64	common	getppid			sys_getppid
+65	common	getpgrp			sys_getpgrp
+66	common	setsid			sys_setsid
+67	common	sigaction		sys_sigaction		compat_sys_sigaction
+# 68 was sys_sgetmask
+# 69 was sys_ssetmask
+70	common	setreuid		sys_setreuid16
+71	common	setregid		sys_setregid16
+72	common	sigsuspend		sys_sigsuspend
+73	common	sigpending		sys_sigpending		compat_sys_sigpending
+74	common	sethostname		sys_sethostname
+75	common	setrlimit		sys_setrlimit		compat_sys_setrlimit
+# 76 was compat_sys_getrlimit
+77	common	getrusage		sys_getrusage		compat_sys_getrusage
+78	common	gettimeofday		sys_gettimeofday	compat_sys_gettimeofday
+79	common	settimeofday		sys_settimeofday	compat_sys_settimeofday
+80	common	getgroups		sys_getgroups16
+81	common	setgroups		sys_setgroups16
+# 82 was compat_sys_select
+83	common	symlink			sys_symlink
+# 84 was sys_lstat
+85	common	readlink		sys_readlink
+86	common	uselib			sys_uselib
+87	common	swapon			sys_swapon
+88	common	reboot			sys_reboot
+# 89 was sys_readdir
+# 90 was sys_mmap
+91	common	munmap			sys_munmap
+92	common	truncate		sys_truncate		compat_sys_truncate
+93	common	ftruncate		sys_ftruncate		compat_sys_ftruncate
+94	common	fchmod			sys_fchmod
+95	common	fchown			sys_fchown16
+96	common	getpriority		sys_getpriority
+97	common	setpriority		sys_setpriority
+# 98 was sys_profil
+99	common	statfs			sys_statfs		compat_sys_statfs
+100	common	fstatfs			sys_fstatfs		compat_sys_fstatfs
+# 101 was sys_ioperm
+# 102 was sys_socketcall
+103	common	syslog			sys_syslog
+104	common	setitimer		sys_setitimer		compat_sys_setitimer
+105	common	getitimer		sys_getitimer		compat_sys_getitimer
+106	common	stat			sys_newstat		compat_sys_newstat
+107	common	lstat			sys_newlstat		compat_sys_newlstat
+108	common	fstat			sys_newfstat		compat_sys_newfstat
+# 109 was sys_uname
+# 110 was sys_iopl
+111	common	vhangup			sys_vhangup
+# 112 was sys_idle
+# 113 was sys_syscall
+114	common	wait4			sys_wait4		compat_sys_wait4
+115	common	swapoff			sys_swapoff
+116	common	sysinfo			sys_sysinfo		compat_sys_sysinfo
+# 117 was sys_ipc
+118	common	fsync			sys_fsync
+119	common	sigreturn		sys_sigreturn_wrapper	compat_sys_sigreturn
+120	common	clone			sys_clone
+121	common	setdomainname		sys_setdomainname
+122	common	uname			sys_newuname
+# 123 was sys_modify_ldt
+124	common	adjtimex		sys_adjtimex_time32
+125	common	mprotect		sys_mprotect
+126	common	sigprocmask		sys_sigprocmask		compat_sys_sigprocmask
+# 127 was sys_create_module
+128	common	init_module		sys_init_module
+129	common	delete_module		sys_delete_module
+# 130 was sys_get_kernel_syms
+131	common	quotactl		sys_quotactl
+132	common	getpgid			sys_getpgid
+133	common	fchdir			sys_fchdir
+134	common	bdflush			sys_ni_syscall
+135	common	sysfs			sys_sysfs
+136	common	personality		sys_personality
+# 137 was sys_afs_syscall
+138	common	setfsuid		sys_setfsuid16
+139	common	setfsgid		sys_setfsgid16
+140	common	_llseek			sys_llseek
+141	common	getdents		sys_getdents		compat_sys_getdents
+142	common	_newselect		sys_select		compat_sys_select
+143	common	flock			sys_flock
+144	common	msync			sys_msync
+145	common	readv			sys_readv
+146	common	writev			sys_writev
+147	common	getsid			sys_getsid
+148	common	fdatasync		sys_fdatasync
+149	common	_sysctl			sys_ni_syscall
+150	common	mlock			sys_mlock
+151	common	munlock			sys_munlock
+152	common	mlockall		sys_mlockall
+153	common	munlockall		sys_munlockall
+154	common	sched_setparam		sys_sched_setparam
+155	common	sched_getparam		sys_sched_getparam
+156	common	sched_setscheduler	sys_sched_setscheduler
+157	common	sched_getscheduler	sys_sched_getscheduler
+158	common	sched_yield		sys_sched_yield
+159	common	sched_get_priority_max	sys_sched_get_priority_max
+160	common	sched_get_priority_min	sys_sched_get_priority_min
+161	common	sched_rr_get_interval	sys_sched_rr_get_interval_time32
+162	common	nanosleep		sys_nanosleep_time32
+163	common	mremap			sys_mremap
+164	common	setresuid		sys_setresuid16
+165	common	getresuid		sys_getresuid16
+# 166 was sys_vm86
+# 167 was sys_query_module
+168	common	poll			sys_poll
+169	common	nfsservctl		sys_ni_syscall
+170	common	setresgid		sys_setresgid16
+171	common	getresgid		sys_getresgid16
+172	common	prctl			sys_prctl
+173	common	rt_sigreturn		sys_rt_sigreturn_wrapper	compat_sys_rt_sigreturn
+174	common	rt_sigaction		sys_rt_sigaction	compat_sys_rt_sigaction
+175	common	rt_sigprocmask		sys_rt_sigprocmask	compat_sys_rt_sigprocmask
+176	common	rt_sigpending		sys_rt_sigpending	compat_sys_rt_sigpending
+177	common	rt_sigtimedwait		sys_rt_sigtimedwait_time32	compat_sys_rt_sigtimedwait_time32
+178	common	rt_sigqueueinfo		sys_rt_sigqueueinfo	compat_sys_rt_sigqueueinfo
+179	common	rt_sigsuspend		sys_rt_sigsuspend	compat_sys_rt_sigsuspend
+180	common	pread64			sys_pread64		compat_sys_aarch32_pread64
+181	common	pwrite64		sys_pwrite64		compat_sys_aarch32_pwrite64
+182	common	chown			sys_chown16
+183	common	getcwd			sys_getcwd
+184	common	capget			sys_capget
+185	common	capset			sys_capset
+186	common	sigaltstack		sys_sigaltstack		compat_sys_sigaltstack
+187	common	sendfile		sys_sendfile		compat_sys_sendfile
+# 188 reserved
+# 189 reserved
+190	common	vfork			sys_vfork
+# SuS compliant getrlimit
+191	common	ugetrlimit		sys_getrlimit		compat_sys_getrlimit
+192	common	mmap2			sys_mmap2		compat_sys_aarch32_mmap2
+193	common	truncate64		sys_truncate64		compat_sys_aarch32_truncate64
+194	common	ftruncate64		sys_ftruncate64		compat_sys_aarch32_ftruncate64
+195	common	stat64			sys_stat64
+196	common	lstat64			sys_lstat64
+197	common	fstat64			sys_fstat64
+198	common	lchown32		sys_lchown
+199	common	getuid32		sys_getuid
+200	common	getgid32		sys_getgid
+201	common	geteuid32		sys_geteuid
+202	common	getegid32		sys_getegid
+203	common	setreuid32		sys_setreuid
+204	common	setregid32		sys_setregid
+205	common	getgroups32		sys_getgroups
+206	common	setgroups32		sys_setgroups
+207	common	fchown32		sys_fchown
+208	common	setresuid32		sys_setresuid
+209	common	getresuid32		sys_getresuid
+210	common	setresgid32		sys_setresgid
+211	common	getresgid32		sys_getresgid
+212	common	chown32			sys_chown
+213	common	setuid32		sys_setuid
+214	common	setgid32		sys_setgid
+215	common	setfsuid32		sys_setfsuid
+216	common	setfsgid32		sys_setfsgid
+217	common	getdents64		sys_getdents64
+218	common	pivot_root		sys_pivot_root
+219	common	mincore			sys_mincore
+220	common	madvise			sys_madvise
+221	common	fcntl64			sys_fcntl64		compat_sys_fcntl64
+# 222 for tux
+# 223 is unused
+224	common	gettid			sys_gettid
+225	common	readahead		sys_readahead		compat_sys_aarch32_readahead
+226	common	setxattr		sys_setxattr
+227	common	lsetxattr		sys_lsetxattr
+228	common	fsetxattr		sys_fsetxattr
+229	common	getxattr		sys_getxattr
+230	common	lgetxattr		sys_lgetxattr
+231	common	fgetxattr		sys_fgetxattr
+232	common	listxattr		sys_listxattr
+233	common	llistxattr		sys_llistxattr
+234	common	flistxattr		sys_flistxattr
+235	common	removexattr		sys_removexattr
+236	common	lremovexattr		sys_lremovexattr
+237	common	fremovexattr		sys_fremovexattr
+238	common	tkill			sys_tkill
+239	common	sendfile64		sys_sendfile64
+240	common	futex			sys_futex_time32
+241	common	sched_setaffinity	sys_sched_setaffinity	compat_sys_sched_setaffinity
+242	common	sched_getaffinity	sys_sched_getaffinity	compat_sys_sched_getaffinity
+243	common	io_setup		sys_io_setup		compat_sys_io_setup
+244	common	io_destroy		sys_io_destroy
+245	common	io_getevents		sys_io_getevents_time32
+246	common	io_submit		sys_io_submit		compat_sys_io_submit
+247	common	io_cancel		sys_io_cancel
+248	common	exit_group		sys_exit_group
+249	common	lookup_dcookie		sys_ni_syscall
+250	common	epoll_create		sys_epoll_create
+251	common	epoll_ctl		sys_epoll_ctl
+252	common	epoll_wait		sys_epoll_wait
+253	common	remap_file_pages	sys_remap_file_pages
+# 254 for set_thread_area
+# 255 for get_thread_area
+256	common	set_tid_address		sys_set_tid_address
+257	common	timer_create		sys_timer_create	compat_sys_timer_create
+258	common	timer_settime		sys_timer_settime32
+259	common	timer_gettime		sys_timer_gettime32
+260	common	timer_getoverrun	sys_timer_getoverrun
+261	common	timer_delete		sys_timer_delete
+262	common	clock_settime		sys_clock_settime32
+263	common	clock_gettime		sys_clock_gettime32
+264	common	clock_getres		sys_clock_getres_time32
+265	common	clock_nanosleep		sys_clock_nanosleep_time32
+266	common	statfs64		sys_statfs64_wrapper	compat_sys_aarch32_statfs64
+267	common	fstatfs64		sys_fstatfs64_wrapper	compat_sys_aarch32_fstatfs64
+268	common	tgkill			sys_tgkill
+269	common	utimes			sys_utimes_time32
+270	common	arm_fadvise64_64	sys_arm_fadvise64_64	compat_sys_aarch32_fadvise64_64
+271	common	pciconfig_iobase	sys_pciconfig_iobase
+272	common	pciconfig_read		sys_pciconfig_read
+273	common	pciconfig_write		sys_pciconfig_write
+274	common	mq_open			sys_mq_open		compat_sys_mq_open
+275	common	mq_unlink		sys_mq_unlink
+276	common	mq_timedsend		sys_mq_timedsend_time32
+277	common	mq_timedreceive		sys_mq_timedreceive_time32
+278	common	mq_notify		sys_mq_notify		compat_sys_mq_notify
+279	common	mq_getsetattr		sys_mq_getsetattr	compat_sys_mq_getsetattr
+280	common	waitid			sys_waitid		compat_sys_waitid
+281	common	socket			sys_socket
+282	common	bind			sys_bind
+283	common	connect			sys_connect
+284	common	listen			sys_listen
+285	common	accept			sys_accept
+286	common	getsockname		sys_getsockname
+287	common	getpeername		sys_getpeername
+288	common	socketpair		sys_socketpair
+289	common	send			sys_send
+290	common	sendto			sys_sendto
+291	common	recv			sys_recv		compat_sys_recv
+292	common	recvfrom		sys_recvfrom		compat_sys_recvfrom
+293	common	shutdown		sys_shutdown
+294	common	setsockopt		sys_setsockopt
+295	common	getsockopt		sys_getsockopt
+296	common	sendmsg			sys_sendmsg		compat_sys_sendmsg
+297	common	recvmsg			sys_recvmsg		compat_sys_recvmsg
+298	common	semop			sys_semop
+299	common	semget			sys_semget
+300	common	semctl			sys_old_semctl		compat_sys_old_semctl
+301	common	msgsnd			sys_msgsnd		compat_sys_msgsnd
+302	common	msgrcv			sys_msgrcv		compat_sys_msgrcv
+303	common	msgget			sys_msgget
+304	common	msgctl			sys_old_msgctl		compat_sys_old_msgctl
+305	common	shmat			sys_shmat		compat_sys_shmat
+306	common	shmdt			sys_shmdt
+307	common	shmget			sys_shmget
+308	common	shmctl			sys_old_shmctl		compat_sys_old_shmctl
+309	common	add_key			sys_add_key
+310	common	request_key		sys_request_key
+311	common	keyctl			sys_keyctl		compat_sys_keyctl
+312	common	semtimedop		sys_semtimedop_time32
+313	common	vserver			sys_ni_syscall
+314	common	ioprio_set		sys_ioprio_set
+315	common	ioprio_get		sys_ioprio_get
+316	common	inotify_init		sys_inotify_init
+317	common	inotify_add_watch	sys_inotify_add_watch
+318	common	inotify_rm_watch	sys_inotify_rm_watch
+319	common	mbind			sys_mbind
+320	common	get_mempolicy		sys_get_mempolicy
+321	common	set_mempolicy		sys_set_mempolicy
+322	common	openat			sys_openat		compat_sys_openat
+323	common	mkdirat			sys_mkdirat
+324	common	mknodat			sys_mknodat
+325	common	fchownat		sys_fchownat
+326	common	futimesat		sys_futimesat_time32
+327	common	fstatat64		sys_fstatat64
+328	common	unlinkat		sys_unlinkat
+329	common	renameat		sys_renameat
+330	common	linkat			sys_linkat
+331	common	symlinkat		sys_symlinkat
+332	common	readlinkat		sys_readlinkat
+333	common	fchmodat		sys_fchmodat
+334	common	faccessat		sys_faccessat
+335	common	pselect6		sys_pselect6_time32	compat_sys_pselect6_time32
+336	common	ppoll			sys_ppoll_time32	compat_sys_ppoll_time32
+337	common	unshare			sys_unshare
+338	common	set_robust_list		sys_set_robust_list	compat_sys_set_robust_list
+339	common	get_robust_list		sys_get_robust_list	compat_sys_get_robust_list
+340	common	splice			sys_splice
+341	common	arm_sync_file_range	sys_sync_file_range2	compat_sys_aarch32_sync_file_range2
+342	common	tee			sys_tee
+343	common	vmsplice		sys_vmsplice
+344	common	move_pages		sys_move_pages
+345	common	getcpu			sys_getcpu
+346	common	epoll_pwait		sys_epoll_pwait		compat_sys_epoll_pwait
+347	common	kexec_load		sys_kexec_load		compat_sys_kexec_load
+348	common	utimensat		sys_utimensat_time32
+349	common	signalfd		sys_signalfd		compat_sys_signalfd
+350	common	timerfd_create		sys_timerfd_create
+351	common	eventfd			sys_eventfd
+352	common	fallocate		sys_fallocate		compat_sys_aarch32_fallocate
+353	common	timerfd_settime		sys_timerfd_settime32
+354	common	timerfd_gettime		sys_timerfd_gettime32
+355	common	signalfd4		sys_signalfd4		compat_sys_signalfd4
+356	common	eventfd2		sys_eventfd2
+357	common	epoll_create1		sys_epoll_create1
+358	common	dup3			sys_dup3
+359	common	pipe2			sys_pipe2
+360	common	inotify_init1		sys_inotify_init1
+361	common	preadv			sys_preadv		compat_sys_preadv
+362	common	pwritev			sys_pwritev		compat_sys_pwritev
+363	common	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo	compat_sys_rt_tgsigqueueinfo
+364	common	perf_event_open		sys_perf_event_open
+365	common	recvmmsg		sys_recvmmsg_time32	compat_sys_recvmmsg_time32
+366	common	accept4			sys_accept4
+367	common	fanotify_init		sys_fanotify_init
+368	common	fanotify_mark		sys_fanotify_mark	compat_sys_fanotify_mark
+369	common	prlimit64		sys_prlimit64
+370	common	name_to_handle_at	sys_name_to_handle_at
+371	common	open_by_handle_at	sys_open_by_handle_at	compat_sys_open_by_handle_at
+372	common	clock_adjtime		sys_clock_adjtime32
+373	common	syncfs			sys_syncfs
+374	common	sendmmsg		sys_sendmmsg		compat_sys_sendmmsg
+375	common	setns			sys_setns
+376	common	process_vm_readv	sys_process_vm_readv
+377	common	process_vm_writev	sys_process_vm_writev
+378	common	kcmp			sys_kcmp
+379	common	finit_module		sys_finit_module
+380	common	sched_setattr		sys_sched_setattr
+381	common	sched_getattr		sys_sched_getattr
+382	common	renameat2		sys_renameat2
+383	common	seccomp			sys_seccomp
+384	common	getrandom		sys_getrandom
+385	common	memfd_create		sys_memfd_create
+386	common	bpf			sys_bpf
+387	common	execveat		sys_execveat		compat_sys_execveat
+388	common	userfaultfd		sys_userfaultfd
+389	common	membarrier		sys_membarrier
+390	common	mlock2			sys_mlock2
+391	common	copy_file_range		sys_copy_file_range
+392	common	preadv2			sys_preadv2		compat_sys_preadv2
+393	common	pwritev2		sys_pwritev2		compat_sys_pwritev2
+394	common	pkey_mprotect		sys_pkey_mprotect
+395	common	pkey_alloc		sys_pkey_alloc
+396	common	pkey_free		sys_pkey_free
+397	common	statx			sys_statx
+398	common	rseq			sys_rseq
+399	common	io_pgetevents		sys_io_pgetevents_time32	compat_sys_io_pgetevents
+400	common	migrate_pages		sys_migrate_pages
+401	common	kexec_file_load		sys_kexec_file_load
+# 402 is unused
+403	common	clock_gettime64			sys_clock_gettime
+404	common	clock_settime64			sys_clock_settime
+405	common	clock_adjtime64			sys_clock_adjtime
+406	common	clock_getres_time64		sys_clock_getres
+407	common	clock_nanosleep_time64		sys_clock_nanosleep
+408	common	timer_gettime64			sys_timer_gettime
+409	common	timer_settime64			sys_timer_settime
+410	common	timerfd_gettime64		sys_timerfd_gettime
+411	common	timerfd_settime64		sys_timerfd_settime
+412	common	utimensat_time64		sys_utimensat
+413	common	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
+414	common	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
+416	common	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
+417	common	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
+418	common	mq_timedsend_time64		sys_mq_timedsend
+419	common	mq_timedreceive_time64		sys_mq_timedreceive
+420	common	semtimedop_time64		sys_semtimedop
+421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
+422	common	futex_time64			sys_futex
+423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
+428	common	open_tree			sys_open_tree
+429	common	move_mount			sys_move_mount
+430	common	fsopen				sys_fsopen
+431	common	fsconfig			sys_fsconfig
+432	common	fsmount				sys_fsmount
+433	common	fspick				sys_fspick
+434	common	pidfd_open			sys_pidfd_open
+435	common	clone3				sys_clone3
+436	common	close_range			sys_close_range
+437	common	openat2				sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	faccessat2			sys_faccessat2
+440	common	process_madvise			sys_process_madvise
+441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
+442	common	mount_setattr			sys_mount_setattr
+443	common	quotactl_fd			sys_quotactl_fd
+444	common	landlock_create_ruleset		sys_landlock_create_ruleset
+445	common	landlock_add_rule		sys_landlock_add_rule
+446	common	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	common	process_mrelease		sys_process_mrelease
+449	common	futex_waitv			sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
+452	common	fchmodat2			sys_fchmodat2
+453	common	map_shadow_stack		sys_map_shadow_stack
+454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
+457	common	statmount			sys_statmount
+458	common	listmount			sys_listmount
+459	common	lsm_get_self_attr		sys_lsm_get_self_attr
+460	common	lsm_set_self_attr		sys_lsm_set_self_attr
+461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal				sys_mseal
diff --git a/tools/perf/arch/arm64/entry/syscalls/syscall_64.tbl b/tools/perf/arch/arm64/entry/syscalls/syscall_64.tbl
new file mode 120000
index 0000000000000000000000000000000000000000..4fdd58f10c155ee45b8d4f6ab1ca4e36ea677c75
--- /dev/null
+++ b/tools/perf/arch/arm64/entry/syscalls/syscall_64.tbl
@@ -0,0 +1 @@
+../../../../../scripts/syscall.tbl
\ No newline at end of file
diff --git a/tools/perf/arch/arm64/include/syscall_table.h b/tools/perf/arch/arm64/include/syscall_table.h
new file mode 100644
index 0000000000000000000000000000000000000000..7ff51b783000d727ec48be960730b81ecdb05575
--- /dev/null
+++ b/tools/perf/arch/arm64/include/syscall_table.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/bitsperlong.h>
+
+#if __BITS_PER_LONG == 64
+#include <asm/syscalls_64.h>
+#else
+#include <asm/syscalls_32.h>
+#endif
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index ae9f00ae79f34fec75ef2c91300ccd771c030529..d3c6e10dce73f122cfbaa6ca75ea82bec38c6a16 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -208,6 +208,8 @@ check_2 tools/perf/arch/sparc/entry/syscalls/syscall.tbl arch/sparc/kernel/sysca
 check_2 tools/perf/arch/xtensa/entry/syscalls/syscall.tbl arch/xtensa/kernel/syscalls/syscall.tbl
 check_2 tools/perf/arch/alpha/entry/syscalls/syscall.tbl arch/alpha/entry/syscalls/syscall.tbl
 check_2 tools/perf/arch/parisc/entry/syscalls/syscall.tbl arch/parisc/entry/syscalls/syscall.tbl
+check_2 tools/perf/arch/arm64/entry/syscalls/syscall_32.tbl arch/arm64/entry/syscalls/syscall_32.tbl
+check_2 tools/perf/arch/arm64/entry/syscalls/syscall_64.tbl arch/arm64/entry/syscalls/syscall_64.tbl
 
 for i in "${BEAUTY_FILES[@]}"
 do
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 02f23483bfff83809c4e649a2d054dba6975d12c..b7c0a4b9245a94b3b245fea59af79081b1f91081 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -26,10 +26,6 @@ static const char *const *syscalltbl_native = syscalltbl_powerpc_64;
 #include <asm/syscalls_32.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_POWERPC_32_MAX_ID;
 static const char *const *syscalltbl_native = syscalltbl_powerpc_32;
-#elif defined(__aarch64__)
-#include <asm/syscalls.c>
-const int syscalltbl_native_max_id = SYSCALLTBL_ARM64_MAX_ID;
-static const char *const *syscalltbl_native = syscalltbl_arm64;
 #elif defined(__mips__)
 #include <asm/syscalls_n64.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_MIPS_N64_MAX_ID;

-- 
2.34.1


