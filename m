Return-Path: <bpf+bounces-43962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0FF9BBFAB
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 22:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76A41F21DF8
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 21:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550801FCC78;
	Mon,  4 Nov 2024 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jFnpIdpI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6B11FCC7D
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754447; cv=none; b=e8dJ3Ar/IIIVqrWwdA5AXTy18qDuDXdQi7Zsj6nSDV96Yi6eCxl41UIOkNSmBEEEZii+D3FjrRqjyDPajOczzhXn+OuFAHcEUEXlbskAleYjCHtv/5PmGCDGRT0B+D+VQuVjaJEi2nD1qWXEVHPyKwzibk8thMq1Rls7sk+wSNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754447; c=relaxed/simple;
	bh=OoyBSoSR0YKW97xqx60uS1tbyNrKDGxM4Vocad6xjfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NE6tFtumzAN2HxCWDan8x8SL1uXyVUshFHSzyIpAnJTxSuYXgo3eYbiAe6eJYcYk/2Xf+V/T4MSOLl9/+LkYQ4oxfEH9dgOMvGe9IeN5BUd3/iHcpBJLRb2jlwfHzddWIhYrEYxZEQuBhh3M4ELZ4Hc2fwKCVl7Mb5A7RbWZcT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jFnpIdpI; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e619057165so2272302b6e.1
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 13:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730754445; x=1731359245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=92GrRLDgka7EWUObBkAeZ/OwF0Pa5ocJ0bqq37OhKZU=;
        b=jFnpIdpIcYo0Giy+0B5TxmWYZRsCfg5QbP/oWvJHy+kAGEKqW4aynIc80Lf1khCl3I
         fcNb14iJbXpG/8dmIZ/U4pJJaINQg/aSCXg5LpN3HyrgL/pP8V29kPz4JSKNpB/2KwKe
         P+WtTOz6J2sJ9j2Vqazng5/DprYwc6gTkv1TkSVXYBNCnGxnp61r1RYuESRCwUjvC4d4
         sWXv+YB+w11uJf3sYxfBbs5n0DexWhxEcmfqXHVqzL5Z3s2HB7SjF5g9okfBLlZ9Lkmy
         vmT5IkbKvniXRWh60VjFYd2GvVDoSYvGfxHT4Y2aGRZDXaXUGPUL8uMIUjIbEZwKu4IF
         EGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730754445; x=1731359245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92GrRLDgka7EWUObBkAeZ/OwF0Pa5ocJ0bqq37OhKZU=;
        b=a5kduSx38l2idrAg06k0FGraFev7w6Xd/7PB1GMdr9o0zVNXy7JMDAr/pIakGKLq5s
         C5CUZWLB8eeXUB2gAQv9r72mvdn2KvyivasMfFIKe2B/w2UuEaKp7YkHaMbRvNCi5xM6
         Uw2NHMmgohGZ04Ewt3dhnPkqSoFxGnUGuQB56rFUCyI8WOWdq0r5wegD9DXjq6cGSddk
         dCFpynhc9JfcvE8dNKaSixOeEvDWAFJRfmbT+3x8nZ3wJXhnaYUFgDDLgXUqEFrebCbi
         OyuHQaYh9Bix4Dq4pKJqFgVQGwL/EXaBLTxxO85m0/Rfxs2GOadPTZgfi7zG4GQC/piy
         56CA==
X-Forwarded-Encrypted: i=1; AJvYcCWq4jP2QUsJnRPnc5E76375gScnSC1xLvqBZPM2FcQ9mdyIe5ab5UIPejhTZOcn2Uki+Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIaPI0JrSvygDkFkGz1wy3EPhaMoUjqagBzATzdtsYe/waMwKd
	9FMDM4RDWGFDSPCRALQ3ege3lXaVt59F+SGsAVfuNKd+Wv3uSV04GVo56n4JIyg=
X-Google-Smtp-Source: AGHT+IHwghEtsWHSIgna9eRpd6cfglYULyLkTu6aW9WjgN7UGabPnfWIpz8Ez2eA6OMZ9FOUKr0wsQ==
X-Received: by 2002:a05:6808:2dc6:b0:3e5:d5c3:e88b with SMTP id 5614622812f47-3e638252a38mr30658820b6e.20.1730754443278;
        Mon, 04 Nov 2024 13:07:23 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee490e08f4sm7248293a12.40.2024.11.04.13.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:07:22 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 04 Nov 2024 13:06:15 -0800
Subject: [PATCH RFT 13/16] perf tools: mips: Use generic syscall scripts
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-perf_syscalltbl-v1-13-9adae5c761ef@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5807; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=OoyBSoSR0YKW97xqx60uS1tbyNrKDGxM4Vocad6xjfw=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7qmeVzDqo9uN3/P0e+Y+X1GiiP7lWxnO5VU4cipb0t8O
 5kz3nN1lLIwiHEwyIopsvBca2BuvaNfdlS0bALMHFYmkCEMXJwCMBEGAYb/defFH23OC3SMv36g
 U1NugXWUcNuMmNgu5wCu+wzKvy8FMzLs5BRVS1Z/f++7lcHm5Gu/D77wY1nimvjxivmqdWe+3k/
 lAAA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Use the generic scripts to generate headers from the syscall table for
mips.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                         |  4 +--
 tools/perf/Makefile.perf                           |  2 +-
 tools/perf/arch/mips/Makefile                      | 18 ------------
 tools/perf/arch/mips/entry/syscalls/Kbuild         |  2 ++
 .../arch/mips/entry/syscalls/Makefile.syscalls     |  5 ++++
 tools/perf/arch/mips/entry/syscalls/mksyscalltbl   | 32 ----------------------
 tools/perf/arch/mips/include/syscall_table.h       |  2 ++
 tools/perf/util/syscalltbl.c                       |  4 ---
 8 files changed, 12 insertions(+), 57 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 2cf45e3f2659..ce7e9ae276e8 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -31,12 +31,12 @@ $(call detected_var,SRCARCH)
 ifneq ($(NO_SYSCALL_TABLE),1)
   NO_SYSCALL_TABLE := 1
 
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc s390 mips))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc s390))
     NO_SYSCALL_TABLE := 0
   endif
 
   # architectures that use the generic syscall table scripts
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips))
     NO_SYSCALL_TABLE := 0
     CFLAGS += -DGENERIC_SYSCALL_TABLE
     CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index ce2c4e1c0623..c9b78518c9a5 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch))
+ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips))
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
 include Makefile.config
diff --git a/tools/perf/arch/mips/Makefile b/tools/perf/arch/mips/Makefile
index cd0b011b3be5..6e1106fab26e 100644
--- a/tools/perf/arch/mips/Makefile
+++ b/tools/perf/arch/mips/Makefile
@@ -2,21 +2,3 @@
 ifndef NO_DWARF
 PERF_HAVE_DWARF_REGS := 1
 endif
-
-# Syscall table generation for perf
-out    := $(OUTPUT)arch/mips/include/generated/asm
-header := $(out)/syscalls_n64.c
-sysprf := $(srctree)/tools/perf/arch/mips/entry/syscalls
-sysdef := $(sysprf)/syscall_n64.tbl
-systbl := $(sysprf)/mksyscalltbl
-
-# Create output directory if not already present
-$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
-
-$(header): $(sysdef) $(systbl)
-	$(Q)$(SHELL) '$(systbl)' $(sysdef) > $@
-
-clean::
-	$(call QUIET_CLEAN, mips) $(RM) $(header)
-
-archheaders: $(header)
diff --git a/tools/perf/arch/mips/entry/syscalls/Kbuild b/tools/perf/arch/mips/entry/syscalls/Kbuild
new file mode 100644
index 000000000000..9a41e3572c3a
--- /dev/null
+++ b/tools/perf/arch/mips/entry/syscalls/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/mips/entry/syscalls/Makefile.syscalls b/tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
new file mode 100644
index 000000000000..9ee914bdfb05
--- /dev/null
+++ b/tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_64 += n64
+
+syscalltbl = $(srctree)/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
diff --git a/tools/perf/arch/mips/entry/syscalls/mksyscalltbl b/tools/perf/arch/mips/entry/syscalls/mksyscalltbl
deleted file mode 100644
index c0d93f959c4e..000000000000
--- a/tools/perf/arch/mips/entry/syscalls/mksyscalltbl
+++ /dev/null
@@ -1,32 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-#
-# Generate system call table for perf. Derived from
-# s390 script.
-#
-# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
-# Changed by: Tiezhu Yang <yangtiezhu@loongson.cn>
-
-SYSCALL_TBL=$1
-
-if ! test -r $SYSCALL_TBL; then
-	echo "Could not read input file" >&2
-	exit 1
-fi
-
-create_table()
-{
-	local max_nr nr abi sc discard
-
-	echo 'static const char *const syscalltbl_mips_n64[] = {'
-	while read nr abi sc discard; do
-		printf '\t[%d] = "%s",\n' $nr $sc
-		max_nr=$nr
-	done
-	echo '};'
-	echo "#define SYSCALLTBL_MIPS_N64_MAX_ID $max_nr"
-}
-
-grep -E "^[[:digit:]]+[[:space:]]+(n64)" $SYSCALL_TBL	\
-	|sort -k1 -n					\
-	|create_table
diff --git a/tools/perf/arch/mips/include/syscall_table.h b/tools/perf/arch/mips/include/syscall_table.h
new file mode 100644
index 000000000000..b53e31c15805
--- /dev/null
+++ b/tools/perf/arch/mips/include/syscall_table.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/syscalls_64.h>
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 7c8550ef0d7b..724e1391893f 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -25,10 +25,6 @@ static const char *const *syscalltbl_native = syscalltbl_powerpc_64;
 #include <asm/syscalls_32.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_POWERPC_32_MAX_ID;
 static const char *const *syscalltbl_native = syscalltbl_powerpc_32;
-#elif defined(__mips__)
-#include <asm/syscalls_n64.c>
-const int syscalltbl_native_max_id = SYSCALLTBL_MIPS_N64_MAX_ID;
-static const char *const *syscalltbl_native = syscalltbl_mips_n64;
 #elif defined(GENERIC_SYSCALL_TABLE)
 #include <syscall_table.h>
 const int syscalltbl_native_max_id = SYSCALLTBL_MAX_ID;

-- 
2.34.1


