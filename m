Return-Path: <bpf+bounces-43957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F07C49BBF84
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 22:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764201F22366
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 21:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935CA1FAC2D;
	Mon,  4 Nov 2024 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rERQldnu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3C71C876D
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 21:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754427; cv=none; b=BZyCeZwg7SgBDf6yqGVD3UBjWOZrnSjLhyM1ylmagdPd/3YEe5zyk6nK9QGgtr3S86xtK4iuDvDXon44SAtZyfjXUxHOYHgYzxLD2MiHiisg3fTbt1AGU3B/RtdnZEzCqslBhxJsTYkaYNYPVIg5XNExgoIl3uecGHujKNmYUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754427; c=relaxed/simple;
	bh=GA79hn+wTOFDTjuZiC+96ICiiUr9UEaTALn1R1sk3AU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B0OwDI0iA2HiIRjm/Nigq4toNiWDY1b7BYU7MSbx8dRGYYKzl9yki+20ptlg1jJWHQq0lcIiRSRNK4BTIXwuCypDHicz+spmYvuhB/rtlL5GEwZ/jUKwvkSPTuBM4E/QLUPoV/nUMbbldfEHz1aOnxGw0xaYXVy1Je653NNiRnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rERQldnu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-210e5369b7dso46881185ad.3
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 13:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730754423; x=1731359223; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stFVcuJt/ZkcL8Otl0cpPXXQXnLpJMcTCPAQMUv2B68=;
        b=rERQldnuwSwhoSeW30FIHnUcZ3yX3BlcVKRREhlj4iKKcs7WquBar8wmN67VjvmE3u
         UfAlINXeOw/cJVMjwpkF+us0mvBtVnfZHT/wFnj0ti52DPkpWP+/VAUz3CuUdbRjocSx
         A92+VmOCdeWzC2CJ0rps7TGY8yya4g2Va3Caf6AnZ0iBsNTlFoVvNpMCohWNGPRQf0ro
         bS/ra8AN3FgEOMnRnb0IFk7kghTaVr9qFBv2Pyd+0xrQFg3OMVZgLrJmcd5N3A1Zag+Z
         uyQdK8oQNEjO6/NH2dZ0gTjPFnXCALxuN5Xp2rHe0dY9AVqov9BpU/E/2gF8Po+QNVtl
         5xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730754423; x=1731359223;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stFVcuJt/ZkcL8Otl0cpPXXQXnLpJMcTCPAQMUv2B68=;
        b=az/xJ+CWci+mQKEbtlI4iWvW/itFA+2M24MNN53HcDbR5xvsV0LPhXStL3mp23DnjT
         m6I4TmWkYbW0gr+T+RjUehNSpcbceLd3vohT5flqPIQfwmbBpTWKUgP51b8iPlS6rWU+
         7J4083R8p8oVsx1cgg3MqtAGVWf3rdnKvdneyux/AoTlFEeIXAh65eaI0HLxnbPvcJAx
         JvMw+Tm8tFRONM97rnvtgSyoxe6LtgoJPgSiZErW/IZXCrtRSR1gKLFEohzxIKaUOq6A
         7cPXlpdNIawRhhraz128T/pkfPrtDLxU838wroMCf9Xrfl2jIIolJM+DsYEJOt3xnKWB
         jC3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0Uhmx8ho2xQtVMKftUroc4ksfyP8KSUY/0mj9SqoEq6wy54e2i6Vb8WqoSu5kIr3Emew=@vger.kernel.org
X-Gm-Message-State: AOJu0YynxJSWNNfBOzsmQH3YgmAE8/HKGCApbTT41kII36/YK4BfH/4E
	dkHQPM5Ch0H0iCHMtQbYMmyTdMgvj30xFPsbf1XtynM0pp1ngOi3aYY/f7FOQeM=
X-Google-Smtp-Source: AGHT+IGYwE7Qcp6ard+AxW0xwH8oO4C2P/tenFCGbLvj4DGZFAfX8qIf04CvIEIEIeAi2ohX3NApMw==
X-Received: by 2002:a17:902:f541:b0:20c:ab33:f8b8 with SMTP id d9443c01a7336-2111af2f399mr182958135ad.15.1730754423084;
        Mon, 04 Nov 2024 13:07:03 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee490e08f4sm7248293a12.40.2024.11.04.13.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:07:02 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 04 Nov 2024 13:06:10 -0800
Subject: [PATCH RFT 08/16] perf tools: x86: Use generic syscall scripts
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-perf_syscalltbl-v1-8-9adae5c761ef@rivosinc.com>
References: <20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com>
In-Reply-To: <20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6740; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=GA79hn+wTOFDTjuZiC+96ICiiUr9UEaTALn1R1sk3AU=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7qmecyeoOvK79/XrmnP/COXtGrhqSVfVTk0vB0v9E/f6
 ng/+kxjRykLgxgHg6yYIgvPtQbm1jv6ZUdFyybAzGFlAhnCwMUpABN5Icvwm2VJwgbj9fcYHGew
 fnt81/39xhYlLY58n7I9Pxt7LVZyyTH8r97+1zbvZZTRMRmdXRzs8d8OX9o0U5WpSf/eafHOwKI
 IfgA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Use the generic scripts to generate headers from the syscall table for
both 32- and 64-bit x86.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                         |  4 +--
 tools/perf/Makefile.perf                           |  2 +-
 tools/perf/arch/x86/Build                          |  1 -
 tools/perf/arch/x86/Makefile                       | 25 -------------
 tools/perf/arch/x86/entry/syscalls/Kbuild          |  3 ++
 .../perf/arch/x86/entry/syscalls/Makefile.syscalls |  6 ++++
 tools/perf/arch/x86/entry/syscalls/syscalltbl.sh   | 42 ----------------------
 tools/perf/arch/x86/include/syscall_table.h        |  8 +++++
 tools/perf/util/syscalltbl.c                       | 10 +-----
 9 files changed, 21 insertions(+), 80 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 1894db7845d4..682354d2d4ec 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -31,12 +31,12 @@ $(call detected_var,SRCARCH)
 ifneq ($(NO_SYSCALL_TABLE),1)
   NO_SYSCALL_TABLE := 1
 
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 powerpc arm64 s390 mips loongarch))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc arm64 s390 mips loongarch))
     NO_SYSCALL_TABLE := 0
   endif
 
   # architectures that use the generic syscall table scripts
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86))
     NO_SYSCALL_TABLE := 0
     CFLAGS += -DGENERIC_SYSCALL_TABLE
     CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index bcbb83e0f9fd..b45e3ec8947b 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa))
+ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86))
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
 include Makefile.config
diff --git a/tools/perf/arch/x86/Build b/tools/perf/arch/x86/Build
index 87d057491343..02a1ca780a20 100644
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
index 67b4969a6738..5277d5aeb079 100644
--- a/tools/perf/arch/x86/Makefile
+++ b/tools/perf/arch/x86/Makefile
@@ -5,28 +5,3 @@ endif
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
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
index 000000000000..84c6599b4ea6
--- /dev/null
+++ b/tools/perf/arch/x86/entry/syscalls/Kbuild
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_32.h
+syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/x86/entry/syscalls/Makefile.syscalls b/tools/perf/arch/x86/entry/syscalls/Makefile.syscalls
new file mode 100644
index 000000000000..db3d5d6d4e56
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
index 2b71f99933a5..000000000000
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
index 000000000000..7ff51b783000
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
index 229183e5c55f..094f6d4fffdd 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -13,15 +13,7 @@
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


