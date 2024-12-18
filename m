Return-Path: <bpf+bounces-47216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3DE9F6186
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 10:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C203C7A5AE8
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 09:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A761A23A0;
	Wed, 18 Dec 2024 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="waN6VyeM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4051F19F487
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513890; cv=none; b=UwV25kH8hNaw56WXSrb1Wc4sDGpvM1Pa3j+EBamQdCRw7zTCTTydE/FF7HuKmhwmTDkbJlVkabUP+HJvLv+WKkqju78LFYaMErARLIppIC+9xgU8BRmVVmJrg9a21sZdqQS6xicVwfINrQA/k90Pc2PCSv2UJPAl8r9OU7ui7GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513890; c=relaxed/simple;
	bh=iQ/ut7mVjV4B2SKqji8uHlm+XnjbUkJfvO8D33/ins4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=meNqgPem+1q2jRkRusNe2SaAtCyxi06dbLIhao0/z8Kfe7sMDVLf1iTAWIr+YCYgzR9Gvy8+IShGEAEOK2OtlQxnFd1w4z1QDSk+piLSlkyN5DsbvQHOlv2pizT5Z/wcrnXwuhrc+luDog28eLI1CZeVXCcvwjIx8+CfFnYFxsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=waN6VyeM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21628b3fe7dso48206495ad.3
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 01:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734513887; x=1735118687; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDhKwzrUe5Roy/zDCl6lSLCddVlMAa7MrVUXUhom5gI=;
        b=waN6VyeMZZ2C/Ihno7WxArcU//dImMuopCL/rnS0thEd20zGD+LgmUp2QCxR9FtwKP
         xHLWrWB76rlnrrZWixnMIXdgPRBhfdkygCcbL0Ha0sFNhGpcOLpcmMDXk+G21Rz/WwWp
         pCDphCc+rANeSN6/JWaXfyFNvQkGEhquMoFCiF2peBhRylqm08oVoX2Ai/WHnTTdRsBg
         3i4rVUbCZlj4L+bMgkO+gkcQUkSphPq9HO0xivME8GH3m3G1x1YDd+MtYRBuaTNRT1fo
         f7/ScnJfnDGZAyW8pqmUGBsnsFd1HM0a5aYSKwMAfMydVsDaZQ29tsR09glyh+OZ6sHO
         eLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734513887; x=1735118687;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDhKwzrUe5Roy/zDCl6lSLCddVlMAa7MrVUXUhom5gI=;
        b=E18iHPjYej7GwLCy71UNDF2UN4UM76Vm+Bh1um9lG6R8GBjmAHDiR2/8iPG567Mka2
         1EYzuQaatj4MHtG+dDsxTDO8iX2XHAET9+fczh9N/OAJoK0pniKb1EItCYSKUfeMlpZY
         zo3BMHBU0M0DyfXnRMQaXgN4+FgpgQd4EYe4XH4ZkHs6Dto6ZFLu/nsohgNxkZFsqq+w
         GAFuB4XEMVym83xaUKt/AqHcDJ9LNgKebH1K7OBn6YYAfbwDiaWP3IAJSfdyNVum+oAc
         TC6TeXcJiztpShkLbUhKZ3J9WYLHD2CajFC6q1Uv1GBT/QkQPUKRsb/Cn9oA39vaGbLG
         jVsA==
X-Forwarded-Encrypted: i=1; AJvYcCWqhj9JDBPUD0X0YRwlEz7slBQnOA875ULNBnhR2h7mXc6vP/2aCwhS886LaxIiRO71+jE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuOqk+rEjgaYuU6lzxa57nXAh5ucWFroSn5/9rmAEe7vYEVF3c
	910HsS0Ke1d8Qv1Qz0cp8ZxiBxMq8A+NqHK1/dhA9KmZ12xv5rtsz+9snK3blb4=
X-Gm-Gg: ASbGncsoH4flfvGp1u2yxV3j0EReebQhSE23wnwNH+d1giqU6yzhQA92tLhy07dsjbg
	mfHW/W00X1L5CV1OuvdPhPmqHDEFAwEuJNogdjjHtIOywyHqw/Ybezd7mN1VN0YMi+9BsSA5m4m
	kdmWCa29zawo1zE/2xxcDt7fqI2O3IZFliswyA5cs9H6TXs1+0UagiMBR1mgmPnd68NVp6C/vAu
	cEciTlvQZjIV/gw3s0Q5Pd1Nek8lw0JtHHNneRIH13Quhg7rdzCSYVmSOFr9z7j/6kVhjSR
X-Google-Smtp-Source: AGHT+IHNUI1AHBQoBga0aAezTy/Vvg/AQiVn3J8vR7Lw+QWhOSCt+vF+YMZsBNQ3jjFCPSUN68skeA==
X-Received: by 2002:a17:902:ec91:b0:218:a5a8:431a with SMTP id d9443c01a7336-218d727e5efmr31917135ad.49.1734513887569;
        Wed, 18 Dec 2024 01:24:47 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e64f90sm72119995ad.241.2024.12.18.01.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 01:24:46 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 18 Dec 2024 01:24:06 -0800
Subject: [PATCH v4 08/16] perf tools: x86: Use generic syscall scripts
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-perf_syscalltbl-v4-8-bc8caef2ca8e@rivosinc.com>
References: <20241218-perf_syscalltbl-v4-0-bc8caef2ca8e@rivosinc.com>
In-Reply-To: <20241218-perf_syscalltbl-v4-0-bc8caef2ca8e@rivosinc.com>
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
 Arnd Bergmann <arnd@arndb.de>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7222; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=iQ/ut7mVjV4B2SKqji8uHlm+XnjbUkJfvO8D33/ins4=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rSlKPZhtX6zouW7NxsLpi+VfzerZYLa+ZcDZ30IKDnx
 54F/s1xHaUsDGIcDLJiiiw81xqYW+/olx0VLZsAM4eVCWQIAxenAEzkgwXD/1LviyLXj67Z5ilw
 7Lvp1N1J8yYUn3Oey3bZm+frVedw/zuMDB3Os/cGnRP8+erKZ1f+qXMO/TNJ3vI6fkPm4t9ZEi9
 +yfICAA==
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Use the generic scripts to generate headers from the syscall table for
both 32- and 64-bit x86.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                         |  3 +-
 tools/perf/Makefile.perf                           |  2 +-
 tools/perf/arch/x86/Build                          |  1 -
 tools/perf/arch/x86/Makefile                       | 25 -------------
 tools/perf/arch/x86/entry/syscalls/Kbuild          |  3 ++
 .../perf/arch/x86/entry/syscalls/Makefile.syscalls |  6 ++++
 tools/perf/arch/x86/entry/syscalls/syscalltbl.sh   | 42 ----------------------
 tools/perf/arch/x86/include/syscall_table.h        |  8 +++++
 tools/perf/util/syscalltbl.c                       | 10 +-----
 9 files changed, 20 insertions(+), 80 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a09e2245a9ba00db79cf3a65e8772a6cb9b6c78e..7accb54e60aac2e615ddf03e8f4ffa8cff539aaa 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -31,7 +31,7 @@ $(call detected_var,SRCARCH)
 ifneq ($(NO_SYSCALL_TABLE),1)
   NO_SYSCALL_TABLE := 1
 
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 powerpc arm64 s390 mips loongarch riscv))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc arm64 s390 mips loongarch))
     NO_SYSCALL_TABLE := 0
   endif
 
@@ -58,7 +58,6 @@ endif
 # Additional ARCH settings for x86
 ifeq ($(SRCARCH),x86)
   $(call detected,CONFIG_X86)
-  CFLAGS += -I$(OUTPUT)arch/x86/include/generated
   ifeq (${IS_64_BIT}, 1)
     CFLAGS += -DHAVE_ARCH_X86_64_SUPPORT
     ARCH_INCLUDE = ../../arch/x86/lib/memcpy_64.S ../../arch/x86/lib/memset_64.S
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 47fe3c41fa13a388803ba804a7c3a4aac81d20ae..698967f50ceb5cfc29dc5c2947c995980120e64e 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa
+generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86
 ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
diff --git a/tools/perf/arch/x86/Build b/tools/perf/arch/x86/Build
index 87d0574913431b7c4505caf78f41d48b180a2fbc..02a1ca780a2071d322f75fb2885c3a36bc278e8d 100644
--- a/tools/perf/arch/x86/Build
+++ b/tools/perf/arch/x86/Build
@@ -2,7 +2,6 @@ perf-util-y += util/
 perf-test-y += tests/
 
 ifdef SHELLCHECK
-  SHELL_TESTS := entry/syscalls/syscalltbl.sh
   TEST_LOGS := $(SHELL_TESTS:%=%.shellcheck_log)
 else
   SHELL_TESTS :=
diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
index a6b6e0a9308a8e401c65eb802e5815a41fbdefe9..a295a80ea078199547e816d18531820bfdba7961 100644
--- a/tools/perf/arch/x86/Makefile
+++ b/tools/perf/arch/x86/Makefile
@@ -1,28 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_JITDUMP := 1
-
-###
-# Syscall table generation
-#
-
-generated := $(OUTPUT)arch/x86/include/generated
-out       := $(generated)/asm
-header    := $(out)/syscalls_64.c
-header_32 := $(out)/syscalls_32.c
-sys       := $(srctree)/tools/perf/arch/x86/entry/syscalls
-systbl    := $(sys)/syscalltbl.sh
-
-# Create output directory if not already present
-$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
-
-$(header): $(sys)/syscall_64.tbl $(systbl)
-	$(Q)$(SHELL) '$(systbl)' $(sys)/syscall_64.tbl 'x86_64' > $@
-
-$(header_32): $(sys)/syscall_32.tbl $(systbl)
-	$(Q)$(SHELL) '$(systbl)' $(sys)/syscall_32.tbl 'x86' > $@
-
-clean::
-	$(call QUIET_CLEAN, x86) $(RM) -r $(header) $(generated)
-
-archheaders: $(header) $(header_32)
diff --git a/tools/perf/arch/x86/entry/syscalls/Kbuild b/tools/perf/arch/x86/entry/syscalls/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..84c6599b4ea6a160217a3496449b205f2263f0fb
--- /dev/null
+++ b/tools/perf/arch/x86/entry/syscalls/Kbuild
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_32.h
+syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/x86/entry/syscalls/Makefile.syscalls b/tools/perf/arch/x86/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..db3d5d6d4e5699d338afc55f6415612ef924d985
--- /dev/null
+++ b/tools/perf/arch/x86/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_32 += i386
+syscall_abis_64 +=
+
+syscalltbl = $(srctree)/tools/perf/arch/x86/entry/syscalls/syscall_%.tbl
diff --git a/tools/perf/arch/x86/entry/syscalls/syscalltbl.sh b/tools/perf/arch/x86/entry/syscalls/syscalltbl.sh
deleted file mode 100755
index 2b71f99933a549607b0c18aa2b8be16b860f603c..0000000000000000000000000000000000000000
--- a/tools/perf/arch/x86/entry/syscalls/syscalltbl.sh
+++ /dev/null
@@ -1,42 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-in="$1"
-arch="$2"
-
-syscall_macro() {
-    nr="$1"
-    name="$2"
-
-    echo "	[$nr] = \"$name\","
-}
-
-emit() {
-    nr="$1"
-    entry="$2"
-
-    syscall_macro "$nr" "$entry"
-}
-
-echo "static const char *const syscalltbl_${arch}[] = {"
-
-sorted_table=$(mktemp /tmp/syscalltbl.XXXXXX)
-grep '^[0-9]' "$in" | sort -n > $sorted_table
-
-max_nr=0
-# the params are: nr abi name entry compat
-# use _ for intentionally unused variables according to SC2034
-while read nr _ name _ _; do
-    if [ $nr -ge 512 ] ; then # discard compat sycalls
-        break
-    fi
-
-    emit "$nr" "$name"
-    max_nr=$nr
-done < $sorted_table
-
-rm -f $sorted_table
-
-echo "};"
-
-echo "#define SYSCALLTBL_${arch}_MAX_ID ${max_nr}"
diff --git a/tools/perf/arch/x86/include/syscall_table.h b/tools/perf/arch/x86/include/syscall_table.h
new file mode 100644
index 0000000000000000000000000000000000000000..7ff51b783000d727ec48be960730b81ecdb05575
--- /dev/null
+++ b/tools/perf/arch/x86/include/syscall_table.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/bitsperlong.h>
+
+#if __BITS_PER_LONG == 64
+#include <asm/syscalls_64.h>
+#else
+#include <asm/syscalls_32.h>
+#endif
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index ccf234a54366f9921c3b9a02ffb0a365d17244bc..02f23483bfff83809c4e649a2d054dba6975d12c 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -14,15 +14,7 @@
 #include <string.h>
 #include "string2.h"
 
-#if defined(__x86_64__)
-#include <asm/syscalls_64.c>
-const int syscalltbl_native_max_id = SYSCALLTBL_x86_64_MAX_ID;
-static const char *const *syscalltbl_native = syscalltbl_x86_64;
-#elif defined(__i386__)
-#include <asm/syscalls_32.c>
-const int syscalltbl_native_max_id = SYSCALLTBL_x86_MAX_ID;
-static const char *const *syscalltbl_native = syscalltbl_x86;
-#elif defined(__s390x__)
+#if defined(__s390x__)
 #include <asm/syscalls_64.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_S390_64_MAX_ID;
 static const char *const *syscalltbl_native = syscalltbl_s390_64;

-- 
2.34.1


