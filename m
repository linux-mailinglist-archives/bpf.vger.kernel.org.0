Return-Path: <bpf+bounces-47221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 109F29F619F
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 10:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C8777A65E0
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 09:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CB01B4241;
	Wed, 18 Dec 2024 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cENezvH6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862811B0407
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513902; cv=none; b=mhLra29WWBlgz93LxydBTqnK/YNjCW6+1coGCb+0Vnsl+UJk+A+j1XEsEtTP21TFu9fFB6JVMa56oPvrAMJ5dnA8MtN4UUhwGyanrnpm1bwrlwzU9kO0RquN7b0HrjPCkd+tMCuGGfC4LngIksUvJE2xvf0PBqP/0Z36H/PraSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513902; c=relaxed/simple;
	bh=is9FYISiat5AYS980WdW4N4P9TdensPaYepjcGMxbQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D5x6rPV6PhbIa4niCM7jsNyJNckKovAK58ACyVI3CDUKHmb5cFBL0BnM8wgAEZAqxCo9Zqa8ci4HyR6046zFoafeOMPSpTsylkMJiDAAJb4V6ufGWvrtf+oVlyKSW4zVd69cev/lCp8sw+buIdmn8GjwQiONG/+ucwXd8Jw5bR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cENezvH6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216395e151bso3693015ad.0
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 01:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734513900; x=1735118700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBqkFCMdH3+jdvoDRHBtQZx+ObIe0EXhgSiQvwPIqpY=;
        b=cENezvH6jdu8ZFYEni7aLkn4wPHJ2NRWWHrTeXCf1PqtWjPKmOu/AT2TBmWP7s+omL
         kX2bfLs6+Jh6VSRrw3auT1v4XmvUCEJ65kLy1rkdTs7s7UIFAWslJM7mWLuJE5n13Y6r
         oIh5rC6QdQsWwl+KzzVj+wRS+b+0UWSelJOrDknFoZvQxDpB8LWZ934iGB3m45ACNV5C
         l1lNmBmlzFOjB0UJfLwx57xOX6b3b4BkEgK8md5v6A46yzgx+6ohgZYFvOg1LzxZCOmp
         Nsr+R3K8vpptvX4OVRE+JEhU2wQA1K6bsDJPrnDfidyopJFMf/PndrOWS1yHkXMK2TSA
         yDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734513900; x=1735118700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBqkFCMdH3+jdvoDRHBtQZx+ObIe0EXhgSiQvwPIqpY=;
        b=SX5xNZiBfZbv9ey3AFQyb0fQH5+D/tm27CJLCAFGw79Fj1xm1aeZOOwiZY5i1VSAoz
         IHuda57FHh0FSBqDfe8AQetGAZ4obV96LdWgiHU/T9ys65COGgiH7KGgUp26oUTT+7RM
         J/3dzFlSNjwvSu6VKmKHYpnqeaWgRWwkocWvp1+nClr63ALY02G+6sPJdG4oYYObYVNJ
         XrK9MBQOvkc2EcYZHJRxYaqFNa2Gh3ojX1jz6YdrCsN32FEthsRDiaONCz9+jDYI37Uh
         arBQQQhj9U3OueZ5ElcHcKi5FWcOfJ+4C0KHsGhaxL9oRvlv9iuAAJiVSwS4oPlL/uUt
         6TZw==
X-Forwarded-Encrypted: i=1; AJvYcCXE+KKYyUkiXFnb1/1NXKZNiEKSR/OeLxklI0iso/bd33qyit8p7dqoDhBF8TkxdB3qWYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Udf6rg1ObsfwsI5We0NoGNOXmd2VLk8wEwSXluDBwfm9/rFF
	fgkrIbzajeRIVFRiy4qPw+/c9BZtdDyhPIrm3gVhQbh6htar+RsNGlw4eBnzebo=
X-Gm-Gg: ASbGncsjI9jNmRflxGESwl9sRTs7NzUNL+fkk/hcwvCiYAx07EMOMLOmBOhHlxNXrXG
	PPB1AlkGOlJd2GHUoqwV4SkzbT7lbwSS5P4ScUaEEezTriTpLhIZQxyc1iCpbwKUTnwa2Dr7/1r
	XhqPzepY7M9HO3498Kg8DZJT10Sj0hukm/Nm+XKygVeNMXkQzt59i2hQvZSg4S5hVq8MMyIopG+
	X0lr3xiTByahzk89NB3+OSD97wh56YYL/FHa8eU//7ruP2bgSgAkMwvYegGqVd1KVz3l+1m
X-Google-Smtp-Source: AGHT+IGhki4D/fVTrZfACkQCC+ZPAd1EGCnfZhfXJEnPdrCf3jJBD3gCOdw6VPVFI+fJQSASFPpuuQ==
X-Received: by 2002:a17:902:f68e:b0:215:8fd3:d1b6 with SMTP id d9443c01a7336-218d7551929mr31801275ad.23.1734513900043;
        Wed, 18 Dec 2024 01:25:00 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e64f90sm72119995ad.241.2024.12.18.01.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 01:24:59 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 18 Dec 2024 01:24:11 -0800
Subject: [PATCH v4 13/16] perf tools: mips: Use generic syscall scripts
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-perf_syscalltbl-v4-13-bc8caef2ca8e@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5143; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=is9FYISiat5AYS980WdW4N4P9TdensPaYepjcGMxbQY=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rSlOMW1iavm+rDpOa+fr8pOnmp9+Ko+97tXr87NIzyv
 +SFV97oKGVhEONgkBVTZOG51sDceke/7Kho2QSYOaxMIEMYuDgFYCLquYwM/TWL1iVfD5B3FDrd
 cc71ot8K71pDP8HSynnLN3vlT3BhBKootufMi/cyjTv2ZuY/oaXMAhUVlq3xfQ1R086wlYQ/4wQ A
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Use the generic scripts to generate headers from the syscall table for
mips.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                         |  3 +-
 tools/perf/Makefile.perf                           |  2 +-
 tools/perf/arch/mips/entry/syscalls/Kbuild         |  2 ++
 .../arch/mips/entry/syscalls/Makefile.syscalls     |  5 ++++
 tools/perf/arch/mips/entry/syscalls/mksyscalltbl   | 32 ----------------------
 tools/perf/arch/mips/include/syscall_table.h       |  2 ++
 tools/perf/util/syscalltbl.c                       |  4 ---
 7 files changed, 11 insertions(+), 39 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index dd1a5409e65ef38eb4132cd74c2e18dd2c8af920..972af3a363c7bbbf5f5226377fea9bd0d306fa38 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -31,7 +31,7 @@ $(call detected_var,SRCARCH)
 ifneq ($(NO_SYSCALL_TABLE),1)
   NO_SYSCALL_TABLE := 1
 
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc s390 mips))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc s390))
     NO_SYSCALL_TABLE := 0
   endif
 
@@ -95,7 +95,6 @@ ifeq ($(ARCH),s390)
 endif
 
 ifeq ($(ARCH),mips)
-  CFLAGS += -I$(OUTPUT)arch/mips/include/generated
   ifndef NO_LIBUNWIND
     LIBUNWIND_LIBS = -lunwind -lunwind-mips
   endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c85262db770d18828fc3d9dc65eca00733645d41..74c1097f790cba5abfd1f2fbdaf4e7540c553482 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch
+generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips
 ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
diff --git a/tools/perf/arch/mips/entry/syscalls/Kbuild b/tools/perf/arch/mips/entry/syscalls/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..9a41e3572c3afd4f202321fd9e492714540e8fd3
--- /dev/null
+++ b/tools/perf/arch/mips/entry/syscalls/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/mips/entry/syscalls/Makefile.syscalls b/tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..9ee914bdfb05860fdd37a49f1ced03fcf2c9ed78
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
index c0d93f959c4e1b8c12edcb5624bbc131231df7e3..0000000000000000000000000000000000000000
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
index 0000000000000000000000000000000000000000..b53e31c15805319a01719c22d489c4037378b02b
--- /dev/null
+++ b/tools/perf/arch/mips/include/syscall_table.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/syscalls_64.h>
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 3001386e13a502be5279aa6e4742af0b96202b35..675702d686d0d1b53dd3ee2017cc9695686b9c63 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -26,10 +26,6 @@ static const char *const *syscalltbl_native = syscalltbl_powerpc_64;
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


