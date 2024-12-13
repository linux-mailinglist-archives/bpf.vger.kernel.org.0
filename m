Return-Path: <bpf+bounces-46787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EADA9F011B
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4792843AA
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FB5190471;
	Fri, 13 Dec 2024 00:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qQWdqSJ0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6855918DF8D
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 00:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734050027; cv=none; b=kZnMzvB/cHh1VIY5ENtMqhhZ4D+a/IGoExDAEss81gHeljbpR2Qe3yXr5G94eoDtiMB6/vS/1cCRmQD2jNfjbCJLQ2rssLk+7kYVDogNYao+PEAxCofOSIZBFagNkIiaRuRE5+QYMS/A1B+Mq9oOrBcP9gDDa62xvQ8YGON+Mgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734050027; c=relaxed/simple;
	bh=B7CjLdEjn+XJO5k/0LWt6HVgppvF+ZXnE1rzsG8ipcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ULS08sLLIp8eWKc1YQJ5O8EjElb5hpOy5VgA2lIyVeTjUMSDCxlRS4lb30xipb3PHUgbg00SS92sbm9Go1Bwx57r0GPvQiwUjp3dfCYawm2xSst26VoN+2C6a0jeDupQBvRjRRHs/VncUqWpmQ63QiCb6HaTc2oTEGKlSpzHhLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qQWdqSJ0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21683192bf9so12014065ad.3
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 16:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734050024; x=1734654824; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4vXJvJ3mIUcBb12Ttbo2EsIEKGGovy2mgOHG3jKO+Yc=;
        b=qQWdqSJ09qZkxltkS5IhKZXNxOW6d1eT2Ne79tkY8Lhxj4UmIxLE/oIfxp5PkKlwMd
         aqJhqI8Dvqff9xfQf0kR/JhHiT4Omaz7pY/QxCM+9b15hSR6otvDboUkXBdBvFL7nRFL
         bKeZjgCFRctOYCDKhQsNVSNV/ISjWFnHdGLUSLUgBPDep2zb2AZeiUeN99tVQHtp17r6
         Hhx+ysovTw71fxx+jrlGqGq8NiWIxaLQ10tscbHbuhIPnFNsqTNxZO776085OrR+2jUL
         CTIZiGovzCYrIRg90zQgc3CgE0MKUW/2gg2u8Mgjx6TpFV/ju4VSWGjgaRA1mOiLdwAy
         F9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734050024; x=1734654824;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vXJvJ3mIUcBb12Ttbo2EsIEKGGovy2mgOHG3jKO+Yc=;
        b=ZQfWd5yRC7v34s025PEiMZYH4KxT8RxE7bpDoQUWy/WZgPnmoEAbi82UUXp5SUJuel
         qOoREuOar2n0YADUpVnUU8yjaEjoJgnPB0L5fmJ2B97r4oXnqc7G1RHc/s2JJDnZtyYl
         OqBucWRCUcjJzC20sDgmzw2GZLKFo+6DzY/zilEye4nKw0c0fskarSiGZ1hWqtPwE8wQ
         8LNAWvzjnO7Qw9b1xOGTgLUvbYgHXmal2a4R3ui8koD2npqkJEvmDKXqSPinPwP4/P10
         bntaZO4PDIpOTr8PHFf4UToftt9XODWHzOtmO7BXaVrE58lD7J7wcxRMQEDCbxg3DxCp
         pLjg==
X-Forwarded-Encrypted: i=1; AJvYcCVQLG1w1pKKdoC7qsdA+N9y2ZwTG0ZUoFXyMWmjCC7rJFjM6+kgk+UiZ+q4xFpuC8z31Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgjO9gu/BRcIK0E781cAJh17JqXjHnghNbHH8+HKUSY2fTQiD0
	xlQnyEmx5ggWiOc3YXeT/Jf9N4DcBXvVfSakMDk99ttLMCI6JRFWzo7ce/R9E7gh9oKEe+k6x8v
	9
X-Gm-Gg: ASbGncv5N26EuP2cwJlFNbYKDmddh0VTaczHI3G9VXcYJ4DkboWCj1tNDSCfAY3H0eJ
	XqscuWkIkfIwZ2Hb6UgCjgirKM5hXhTx05NBri4kkyiN+Q6cbe1qYniKIl+QDrrMYT6BThAiPLK
	FtKswv+Ar81WP/PmucFD06px57kMYR/Zmj68Gwhspk77PmXNsnWGpElIjD6mZgn0MEmL4q/IgR5
	OiJDhLDhymGpyvW+zHaLGCZSteUFQhivShG8jkbxTAmCAebYOsFZfefQi8BchYil4phEfc/
X-Google-Smtp-Source: AGHT+IEzsJkrkvZjhcNTbfFitMp64ScIhwN+0t5UI0qHMQ0Vghn8zjM6v3okefS/Uc0Xl6xQ7mXg8g==
X-Received: by 2002:a17:902:e748:b0:215:577b:ab77 with SMTP id d9443c01a7336-21892a40509mr9643405ad.39.1734050024248;
        Thu, 12 Dec 2024 16:33:44 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142e0ce50sm1934462a91.39.2024.12.12.16.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 16:33:43 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 12 Dec 2024 16:33:04 -0800
Subject: [PATCH v2 14/16] perf tools: powerpc: Use generic syscall table
 scripts
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-perf_syscalltbl-v2-14-f8ca984ffe40@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7324; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=B7CjLdEjn+XJO5k/0LWt6HVgppvF+ZXnE1rzsG8ipcY=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3p0w4GX73doXq5eeV7tGl9x8OZjcYUrnHq9ZbqWFux+K
 TiBUa2vo5SFQYyDQVZMkYXnWgNz6x39sqOiZRNg5rAygQxh4OIUgIncPsvwh9M95YtH4/mf1uEx
 hWLZrTZlRcwnqoPurAi3v5b48EbRRIa/Anz1poKbNXQKme79bpA03xMa2XFC/9IepenbLf49n9H
 EDwA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Use the generic scripts to generate headers from the syscall table
instead of the custom ones for powerpc.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                         |  5 ++-
 tools/perf/Makefile.perf                           |  2 +-
 tools/perf/arch/powerpc/Makefile                   | 25 --------------
 tools/perf/arch/powerpc/entry/syscalls/Kbuild      |  3 ++
 .../arch/powerpc/entry/syscalls/Makefile.syscalls  |  6 ++++
 .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  | 39 ----------------------
 tools/perf/arch/powerpc/include/syscall_table.h    |  8 +++++
 tools/perf/util/syscalltbl.c                       |  8 -----
 8 files changed, 20 insertions(+), 76 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 09c4bb713648a9ca3c5223910bd7634fe8234e52..1ca8c9814cbffbc4bbed3b40e0d6e53f0f9b77f1 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -31,12 +31,12 @@ $(call detected_var,SRCARCH)
 ifneq ($(NO_SYSCALL_TABLE),1)
   NO_SYSCALL_TABLE := 1
 
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc s390))
+  ifeq ($(SRCARCH),s390)
     NO_SYSCALL_TABLE := 0
   endif
 
   # architectures that use the generic syscall table scripts
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips powerpc))
     NO_SYSCALL_TABLE := 0
     CFLAGS += -DGENERIC_SYSCALL_TABLE
     CFLAGS += -I$(OUTPUT)/tools/perf/arch/$(SRCARCH)/include/generated
@@ -49,7 +49,6 @@ endif
 
 # Additional ARCH settings for ppc
 ifeq ($(SRCARCH),powerpc)
-  CFLAGS += -I$(OUTPUT)arch/powerpc/include/generated
   LIBUNWIND_LIBS := -lunwind -lunwind-ppc64
 endif
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b5a5f04a373e174269fe5ae8a7e8707e0b7e5835..45bccc88e0087b57e4d9549e281cdbafc152a2fd 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips))
+ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips powerpc))
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
 include Makefile.config
diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index dc8f4fb8e324ab6679d78b5fee3636ba7d2ff7c0..a295a80ea078199547e816d18531820bfdba7961 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -1,28 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_JITDUMP := 1
-
-#
-# Syscall table generation for perf
-#
-
-out    := $(OUTPUT)arch/powerpc/include/generated/asm
-header32 := $(out)/syscalls_32.c
-header64 := $(out)/syscalls_64.c
-sysprf := $(srctree)/tools/perf/arch/powerpc/entry/syscalls
-sysdef := $(sysprf)/syscall.tbl
-systbl := $(sysprf)/mksyscalltbl
-
-# Create output directory if not already present
-$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
-
-$(header64): $(sysdef) $(systbl)
-	$(Q)$(SHELL) '$(systbl)' '64' $(sysdef) > $@
-
-$(header32): $(sysdef) $(systbl)
-	$(Q)$(SHELL) '$(systbl)' '32' $(sysdef) > $@
-
-clean::
-	$(call QUIET_CLEAN, powerpc) $(RM) $(header32) $(header64)
-
-archheaders: $(header32) $(header64)
diff --git a/tools/perf/arch/powerpc/entry/syscalls/Kbuild b/tools/perf/arch/powerpc/entry/syscalls/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..84c6599b4ea6a160217a3496449b205f2263f0fb
--- /dev/null
+++ b/tools/perf/arch/powerpc/entry/syscalls/Kbuild
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_32.h
+syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls b/tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..f7e87a61401c14a1d3a8a04fe2c8ecc8bedcc1b0
--- /dev/null
+++ b/tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_32 += spu nospu
+syscall_abis_64 += spu nospu
+
+syscalltbl = $(srctree)/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
diff --git a/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl b/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl
deleted file mode 100755
index 0eb316fe6dd1175a86035f76f9f3cf7501c376bd..0000000000000000000000000000000000000000
--- a/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl
+++ /dev/null
@@ -1,39 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-#
-# Generate system call table for perf. Derived from
-# s390 script.
-#
-# Copyright IBM Corp. 2017
-# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
-# Changed by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
-
-wordsize=$1
-SYSCALL_TBL=$2
-
-if ! test -r $SYSCALL_TBL; then
-	echo "Could not read input file" >&2
-	exit 1
-fi
-
-create_table()
-{
-	local wordsize=$1
-	local max_nr nr abi sc discard
-	max_nr=-1
-	nr=0
-
-	echo "static const char *const syscalltbl_powerpc_${wordsize}[] = {"
-	while read nr abi sc discard; do
-		if [ "$max_nr" -lt "$nr" ]; then
-			printf '\t[%d] = "%s",\n' $nr $sc
-			max_nr=$nr
-		fi
-	done
-	echo '};'
-	echo "#define SYSCALLTBL_POWERPC_${wordsize}_MAX_ID $max_nr"
-}
-
-grep -E "^[[:digit:]]+[[:space:]]+(common|spu|nospu|${wordsize})" $SYSCALL_TBL \
-	|sort -k1 -n                                                           \
-	|create_table ${wordsize}
diff --git a/tools/perf/arch/powerpc/include/syscall_table.h b/tools/perf/arch/powerpc/include/syscall_table.h
new file mode 100644
index 0000000000000000000000000000000000000000..7ff51b783000d727ec48be960730b81ecdb05575
--- /dev/null
+++ b/tools/perf/arch/powerpc/include/syscall_table.h
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
index 675702d686d0d1b53dd3ee2017cc9695686b9c63..8869fed1a58946c590484816354d8c74aff52ee3 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -18,14 +18,6 @@
 #include <asm/syscalls_64.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_S390_64_MAX_ID;
 static const char *const *syscalltbl_native = syscalltbl_s390_64;
-#elif defined(__powerpc64__)
-#include <asm/syscalls_64.c>
-const int syscalltbl_native_max_id = SYSCALLTBL_POWERPC_64_MAX_ID;
-static const char *const *syscalltbl_native = syscalltbl_powerpc_64;
-#elif defined(__powerpc__)
-#include <asm/syscalls_32.c>
-const int syscalltbl_native_max_id = SYSCALLTBL_POWERPC_32_MAX_ID;
-static const char *const *syscalltbl_native = syscalltbl_powerpc_32;
 #elif defined(GENERIC_SYSCALL_TABLE)
 #include <syscall_table.h>
 const int syscalltbl_native_max_id = SYSCALLTBL_MAX_ID;

-- 
2.34.1


