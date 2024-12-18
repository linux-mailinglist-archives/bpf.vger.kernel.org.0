Return-Path: <bpf+bounces-47223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 845C49F61AB
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 10:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3165D188F517
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 09:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981681C5CDD;
	Wed, 18 Dec 2024 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="whOB6dpw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4DF1BEF8A
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513908; cv=none; b=pNBjCdDM/pdHEfoYg0ivQDX3AsejeZsxO5ZtVn08GEKoPp6UU/mPMwLGIvzmvgVjs2pCbZzTlMpsahPhJ2QlUJt9AWaxuCM+P9pYZmakSP+xAGKQ6lcHg90L0vqBu6m2RaipxfZOhTIhZojFFvcfHJk2bR9joySD03Lu6xZOccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513908; c=relaxed/simple;
	bh=ruomBTLVbkEus1mH9Pi/e3VHIlRXT4ldlwTEOV4wnqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KaXojq9xtd4L7ZW3iwQhsqwT0nL/yOUIKuMYAnewXlAFEYjxerAox4xd/p9yUfBagU5IMenxrao9mR3QCUGUyJAPhK34TTzOvKcKp7TdANLJo7q/irs73jLDHt8G8cUyflNWpsbToC7FxBYGjfUBhOa+a+isihieEN65+p2Gtvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=whOB6dpw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725ef0397aeso5574642b3a.2
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 01:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734513905; x=1735118705; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLczyqAvq5zDTnn91O7cKSL/uksfThuxSWXKQGlMzo4=;
        b=whOB6dpwIKGM6vBhQILomcRd2fA/eG2S35mch2lmA4PNUVkLIQNh6yNTn/Om5IwiWl
         ubSdyZ+Es0Zv+WbDBYFGrUQIp79JR0IMTsN9j46UY3j73akuXW/D1dJTcMl9UTZDfrp8
         /gOlB+p5NK9s+iAfTJmzEn2Ki4dFjXaReDLVBUODCfwcKacnFEqzlUT9h1oTOuMZeFjg
         JO7EfgnEeDPWVQzalQTukSsTnWCG12+DCNDKA/EShLzupMgeEZdrjswh7mUednmMWi4f
         mQbUweyawO12YIuR8rHd1AKwYKVMWlXf0shX9q5lSvSR8dp6v4Z1rJrYUhp4iwhxW0xD
         Ln5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734513905; x=1735118705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLczyqAvq5zDTnn91O7cKSL/uksfThuxSWXKQGlMzo4=;
        b=eTeeS1xVmqBjafZG9u1cB/M+RJJqo9NRxuebztn1A4aW9D0hS6Qq/m+IHEbAQYgsM8
         FAwxZVK9qxkVmQRhAK2EcSIMG/T14Id9vOwAH+l/SfopUAbPRLfHizp+A2a2oqFN7S6s
         4zJuYobR4F7NvZ8Ok0VfVkcnMNjxXZdqnNExgn5rY6yrsRRZwI7yJrQpGNEOb1MxHqp7
         38QPNEILA1Ft4YCOWrixX3vMgrrOM/8/wO+V0VkKP0JukFftPZgWGR91J57e2jB0cQ07
         WBqwxhKhYwdT6iOl1v5o2qhje0L1p3L1VAhwKiQ2elXACw37XNHOtjtyXOJAlqwGGa9F
         1RTw==
X-Forwarded-Encrypted: i=1; AJvYcCV3RtBG7ruCbMnQHsvLFwqoP1KEezqA0GpyAwXKaFln5oOpk3IAB9kkezohrwX0IaW2DEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxSOEIqnEw5+D35rUsT5s424K8xXyFFamDNPzwBvwXNlOx4/5U
	fyXEL+8JmbHBm7bG+f2Skh4of8Ew/Z9GBqEJZTVwYWZ3A6hVgY6O7E8e/DrvfEU=
X-Gm-Gg: ASbGnct05177SU9YCY5wKuEJGIRzM3k8+WiGyszT4Ywe+3yKaBsJyCUtg8jOT/SKhUa
	vzvUJou+Kz9FOJM78ScH1pHMeUpRIi4H+RQoafbAREoiHwCrIsY89CLY+Patbamn+CRAESnddrH
	kaGPbqxuCu5Mnz9AumjJClpNm/Z0anvl0eV31rDVBZzRxDnjd3u/2TefNbI+eihtLAxP01qKzVA
	G53mGi0/3kSONHqZ2p2rI2soX/vOlvieg3onlU4lxKPl0jscwYLc/bRs37S1sWT5m7j2bIe
X-Google-Smtp-Source: AGHT+IHQFXbvnwqiN/dTh3yv4wTINNj3qFkZEZ0WT2GLng6IkqQQjamsQzXKh3KF114KR8CIR1eRnA==
X-Received: by 2002:a17:90b:1d48:b0:2ee:b2be:f390 with SMTP id 98e67ed59e1d1-2f2e9352b0emr2762005a91.28.1734513905063;
        Wed, 18 Dec 2024 01:25:05 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e64f90sm72119995ad.241.2024.12.18.01.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 01:25:04 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 18 Dec 2024 01:24:13 -0800
Subject: [PATCH v4 15/16] perf tools: s390: Use generic syscall table
 scripts
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-perf_syscalltbl-v4-15-bc8caef2ca8e@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6102; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=ruomBTLVbkEus1mH9Pi/e3VHIlRXT4ldlwTEOV4wnqw=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rSlOP+PH2WLvtsOfOnrm2yZKzr2vm7pvKw0KJU9gXCZ
 1bNX/C7o5SFQYyDQVZMkYXnWgNz6x39sqOiZRNg5rAygQxh4OIUgIlM9GVk+Lj4/o9LKpzPvod8
 fX9Yd8LLV0cMT8zctLT6hX3gRcc5aZqMDJuvuD4UMdM5ZPP0zr/N3eXzZuqcTLnK2PG77SWHt06
 4NScA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Use the generic scripts to generate headers from the syscall table
instead of the custom ones for s390.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                         |  6 +---
 tools/perf/Makefile.perf                           |  2 +-
 tools/perf/arch/s390/Makefile                      | 21 --------------
 tools/perf/arch/s390/entry/syscalls/Kbuild         |  2 ++
 .../arch/s390/entry/syscalls/Makefile.syscalls     |  5 ++++
 tools/perf/arch/s390/entry/syscalls/mksyscalltbl   | 32 ----------------------
 tools/perf/arch/s390/include/syscall_table.h       |  2 ++
 tools/perf/util/syscalltbl.c                       |  6 +---
 8 files changed, 12 insertions(+), 64 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 478045f29b04e2f848e76cf86bc8bc457e37b07a..2da9fd705f187a8e4881b3b6ebbe5e0ec8584474 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -31,10 +31,6 @@ $(call detected_var,SRCARCH)
 ifneq ($(NO_SYSCALL_TABLE),1)
   NO_SYSCALL_TABLE := 1
 
-  ifeq ($(SRCARCH),s390)
-    NO_SYSCALL_TABLE := 0
-  endif
-
   # architectures that use the generic syscall table scripts
   ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
     NO_SYSCALL_TABLE := 0
@@ -90,7 +86,7 @@ ifeq ($(SRCARCH),loongarch)
 endif
 
 ifeq ($(ARCH),s390)
-  CFLAGS += -fPIC -I$(OUTPUT)arch/s390/include/generated
+  CFLAGS += -fPIC
 endif
 
 ifeq ($(ARCH),mips)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f76b23d96fc91aa56807fc581bf820a117c2bda0..2c6a509c800d3037933c9b49e5a7dafbf78fda0c 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips powerpc
+generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips powerpc s390
 ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefile
index c431c21b11ef824535c1b9fb6ca4246d666fc97b..0033698a65ce5d5d7ebcc280399957561dd9d2c6 100644
--- a/tools/perf/arch/s390/Makefile
+++ b/tools/perf/arch/s390/Makefile
@@ -1,24 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_JITDUMP := 1
-
-#
-# Syscall table generation for perf
-#
-
-out    := $(OUTPUT)arch/s390/include/generated/asm
-header := $(out)/syscalls_64.c
-sysprf := $(srctree)/tools/perf/arch/s390/entry/syscalls
-sysdef := $(sysprf)/syscall.tbl
-systbl := $(sysprf)/mksyscalltbl
-
-# Create output directory if not already present
-$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
-
-$(header): $(sysdef) $(systbl)
-	$(Q)$(SHELL) '$(systbl)' $(sysdef) > $@
-
-clean::
-	$(call QUIET_CLEAN, s390) $(RM) $(header)
-
-archheaders: $(header)
diff --git a/tools/perf/arch/s390/entry/syscalls/Kbuild b/tools/perf/arch/s390/entry/syscalls/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..9a41e3572c3afd4f202321fd9e492714540e8fd3
--- /dev/null
+++ b/tools/perf/arch/s390/entry/syscalls/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/s390/entry/syscalls/Makefile.syscalls b/tools/perf/arch/s390/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..9762d7abf17c3f79a6213e7306a5f7b56e833a78
--- /dev/null
+++ b/tools/perf/arch/s390/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_64 += renameat rlimit memfd_secret
+
+syscalltbl = $(srctree)/tools/perf/arch/s390/entry/syscalls/syscall.tbl
diff --git a/tools/perf/arch/s390/entry/syscalls/mksyscalltbl b/tools/perf/arch/s390/entry/syscalls/mksyscalltbl
deleted file mode 100755
index 52eb88a77c94727aeb8c15427cdd43dfe5f9f2bd..0000000000000000000000000000000000000000
--- a/tools/perf/arch/s390/entry/syscalls/mksyscalltbl
+++ /dev/null
@@ -1,32 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-#
-# Generate system call table for perf
-#
-# Copyright IBM Corp. 2017, 2018
-# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
-#
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
-	echo 'static const char *const syscalltbl_s390_64[] = {'
-	while read nr abi sc discard; do
-		printf '\t[%d] = "%s",\n' $nr $sc
-		max_nr=$nr
-	done
-	echo '};'
-	echo "#define SYSCALLTBL_S390_64_MAX_ID $max_nr"
-}
-
-grep -E "^[[:digit:]]+[[:space:]]+(common|64)" $SYSCALL_TBL	\
-	|sort -k1 -n					\
-	|create_table
diff --git a/tools/perf/arch/s390/include/syscall_table.h b/tools/perf/arch/s390/include/syscall_table.h
new file mode 100644
index 0000000000000000000000000000000000000000..b53e31c15805319a01719c22d489c4037378b02b
--- /dev/null
+++ b/tools/perf/arch/s390/include/syscall_table.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/syscalls_64.h>
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 8869fed1a58946c590484816354d8c74aff52ee3..210f61b0a7a264a427ebb602185d3a9da2f426f4 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -14,11 +14,7 @@
 #include <string.h>
 #include "string2.h"
 
-#if defined(__s390x__)
-#include <asm/syscalls_64.c>
-const int syscalltbl_native_max_id = SYSCALLTBL_S390_64_MAX_ID;
-static const char *const *syscalltbl_native = syscalltbl_s390_64;
-#elif defined(GENERIC_SYSCALL_TABLE)
+#if defined(GENERIC_SYSCALL_TABLE)
 #include <syscall_table.h>
 const int syscalltbl_native_max_id = SYSCALLTBL_MAX_ID;
 static const char *const *syscalltbl_native = syscalltbl;

-- 
2.34.1


