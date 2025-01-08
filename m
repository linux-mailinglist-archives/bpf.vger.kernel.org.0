Return-Path: <bpf+bounces-48213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9BFA0503D
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 03:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFDFB3A398E
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 02:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6F7190468;
	Wed,  8 Jan 2025 02:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nTZlJDAK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0021A83F9
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 02:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302121; cv=none; b=GbA89RxzRWuIbEF1djN+3xW62F5HJdFvitho1c3g9o/EUlvzeeu0fyTc+3YX1sQCCjYddMhPx2pSZ7O3BysVnzYqBa4PPWYlMt8glliMBB2+I/XtTgSNeXlLKn01O7zRQTxVxj4rioTOGHTt6q1NyP5URW9msE5r/49GdeDZ/Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302121; c=relaxed/simple;
	bh=L4oRiXOJ86zww3VT7aG+83yHqK1Y5r7akUnGrL/Ll2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X6tqSmhLUj2f+x9SgO6jKMuF1su704FEo76PlDh3rr+OfQqHbjKpyzzJ5L/CmpZ3Bo1b4a513pJoDuqQxndZ5Cb2eiXPXT8/jSieQa1OnpaymQsLWEN+e5KGQvFU75rI0GcwXXlTTaKku+JBjvm0aae2FazXN11za+1QPHTN38Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nTZlJDAK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2163dc5155fso237076345ad.0
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2025 18:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736302118; x=1736906918; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pA0XkH7PdVSxIVYHuuTAafWWIYQPvi18jX0+XT4OOpc=;
        b=nTZlJDAKpLyWfevouNemZvRnUQUCaXBEikE7YPPiQ/7kxD5fymFlNN0A8K/HBb7qR2
         I0jWRSZ+b2SYbFiKSJNHZo72zoYf73rNp3SlWaUOLaLTcPnPCo+fbtEWXL/h7Y8mtfPS
         P0L4s6wY3yN/aQP7FeU7mc58/J1EFm8W6TeqZ3j4aVjwvqilFEIPI6Sh6IGk1pwdB5kx
         RDADrlI7XKdPikPuoQLKkcpsszbSYOYsvRcQLEpjqgeenCoIKrYtYwJxVH+IpaWcaNjA
         gDXTT62aGdbKeGrogxuA9L4Nut5JMjQrwQnTleG+jL9vEFzbd3STkxGEk3leVJX3iKNQ
         sbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736302118; x=1736906918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pA0XkH7PdVSxIVYHuuTAafWWIYQPvi18jX0+XT4OOpc=;
        b=Mkotgfi4SguPqC7ofjzLRosSIAmM5REQxk3WLDTXQVczjC61VpQKgYOLKTg1hyia83
         C+rE/71ZbH7Vv8nO0YChlsbl9cJIOdtylnx4Q7k/7G8YzILtKsZIjIE8GZkO4dRZjh7O
         CmbrZ45UeAE3iPCuHcZwj0/uI4ppqDrz315fJzKHTXtfJCeNOqTpdsSBhcgr9VkkEDce
         PsIaW0z7GGTwXipG3saUvlcy1ZzsKwpSXB6FVNElX91eAHZVR8hyJYeNe+LlRjglMRKH
         qjr3ZhGfNbdTLynvBoYYTcEDthIWYDj0R+0edAjR45qmJilfguouSjYW9Mj1szBg1g87
         Lhvw==
X-Forwarded-Encrypted: i=1; AJvYcCXxH0nOQO4wYfwk8I4Shh31FZ9o8e1YAkrpya2y8Scfa8rqafC1GXfMH64gBS7B9Q8MOGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUQLVCUe3BrwklIzqUUCe+95SGqOySwKnkEB+j7ba0gRFzTX4w
	Rb3kB7/B1Cs57Sd/WAzjpmNIeuUsYzGXWl8yOw7I94fibc0IbEkpHWW+OMAhBS8=
X-Gm-Gg: ASbGncskSHk3ot92pPQsOAS/mRJ5/XiLoRQM7AOuh+VsmFysWX57GXC7f/OnO+ekxVN
	2RJNhHo3AKKlR69MRzWqC+n9YDRWy09jSvYy00OiRYBg76aSmdkXxTfnKtOwyS5k9X70yDcbeNQ
	ByTJzUOY6PYFs6DYxg6fO0EVRr3+bdzPjyEN2PhFLaSAQJp4gFr5dxvnPzysyHZI5pLiNeP742P
	pUc0a/AnJKyZfbtLWIHfi4/5Vpx+WdW43odMb09cgNXX5FVrN2X1xHblEitWX6RU80qy1jU
X-Google-Smtp-Source: AGHT+IEGParDWx7tGlZPv5khaVguAtASGRwsj03/LoHyOukL5lw17Qwcs3eAEQTm1NOjcjaRamVJ5A==
X-Received: by 2002:a17:903:2342:b0:212:1ebf:9a03 with SMTP id d9443c01a7336-21a83f4b0c9mr18572915ad.2.1736302118109;
        Tue, 07 Jan 2025 18:08:38 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca0282fsm316662405ad.259.2025.01.07.18.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 18:08:37 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 07 Jan 2025 18:08:00 -0800
Subject: [PATCH v5 12/16] perf tools: loongarch: Use syscall table
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-perf_syscalltbl-v5-12-935de46d3175@rivosinc.com>
References: <20250107-perf_syscalltbl-v5-0-935de46d3175@rivosinc.com>
In-Reply-To: <20250107-perf_syscalltbl-v5-0-935de46d3175@rivosinc.com>
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
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6453; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=L4oRiXOJ86zww3VT7aG+83yHqK1Y5r7akUnGrL/Ll2Q=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rtPebWY4a7onwZzJL0xcqLZY6cKkmJ387tedAge82//
 BdyLXc7SlkYxDgYZMUUWXiuNTC33tEvOypaNgFmDisTyBAGLk4BmMhVfob/GTevWAS8yJL6Mn29
 /vzHR7imTXidq3B959LEGLbqhf17bjEyrD3C4Hwv/9uHK8rr1zIefVt4TDj16FxO3UvM29ZVi3o
 VMgMA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

loongarch uses a syscall table, use that in perf instead of using unistd.h.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                         |  3 +-
 tools/perf/Makefile.perf                           |  2 +-
 tools/perf/arch/loongarch/Makefile                 | 22 -----------
 tools/perf/arch/loongarch/entry/syscalls/Kbuild    |  2 +
 .../loongarch/entry/syscalls/Makefile.syscalls     |  3 ++
 .../arch/loongarch/entry/syscalls/mksyscalltbl     | 45 ----------------------
 tools/perf/arch/loongarch/include/syscall_table.h  |  2 +
 tools/perf/util/syscalltbl.c                       |  4 --
 8 files changed, 9 insertions(+), 74 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 7cfec8c46a4fb35c80c8b207ef1e94f38fd4fc8d..8b0595da9402c7d69aef1e120e815d320ecf006c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -31,7 +31,7 @@ $(call detected_var,SRCARCH)
 ifneq ($(NO_SYSCALL_TABLE),1)
   NO_SYSCALL_TABLE := 1
 
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc s390 mips loongarch))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc s390 mips))
     NO_SYSCALL_TABLE := 0
   endif
 
@@ -85,7 +85,6 @@ ifeq ($(SRCARCH),arm64)
 endif
 
 ifeq ($(SRCARCH),loongarch)
-  CFLAGS += -I$(OUTPUT)arch/loongarch/include/generated
   ifndef NO_LIBUNWIND
     LIBUNWIND_LIBS = -lunwind -lunwind-loongarch64
   endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 84bda059b417acbeaec4c303acd2eb5ee1b61992..558f1425a09d536c3b85798840e173067c3da463 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64
+generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch
 ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loongarch/Makefile
index 52544d59245bab5a0fb2baa1e962b2ad4bf25332..087e099fb453a9236db34878077a51f711881ce0 100644
--- a/tools/perf/arch/loongarch/Makefile
+++ b/tools/perf/arch/loongarch/Makefile
@@ -1,25 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 PERF_HAVE_JITDUMP := 1
 HAVE_KVM_STAT_SUPPORT := 1
-
-#
-# Syscall table generation for perf
-#
-
-out    := $(OUTPUT)arch/loongarch/include/generated/asm
-header := $(out)/syscalls.c
-incpath := $(srctree)/tools
-sysdef := $(srctree)/tools/arch/loongarch/include/uapi/asm/unistd.h
-sysprf := $(srctree)/tools/perf/arch/loongarch/entry/syscalls/
-systbl := $(sysprf)/mksyscalltbl
-
-# Create output directory if not already present
-$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
-
-$(header): $(sysdef) $(systbl)
-	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(incpath) $(sysdef) > $@
-
-clean::
-	$(call QUIET_CLEAN, loongarch) $(RM) $(header)
-
-archheaders: $(header)
diff --git a/tools/perf/arch/loongarch/entry/syscalls/Kbuild b/tools/perf/arch/loongarch/entry/syscalls/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..9a41e3572c3afd4f202321fd9e492714540e8fd3
--- /dev/null
+++ b/tools/perf/arch/loongarch/entry/syscalls/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls b/tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..47d32da2aed8d67a7ac026271600e84723031a6b
--- /dev/null
+++ b/tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_64 +=
diff --git a/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl b/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
deleted file mode 100755
index c10ad3580aef25e48ff0682eca4217cbafdfa333..0000000000000000000000000000000000000000
--- a/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
+++ /dev/null
@@ -1,45 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-#
-# Generate system call table for perf. Derived from
-# powerpc script.
-#
-# Author(s):  Ming Wang <wangming01@loongson.cn>
-# Author(s):  Huacai Chen <chenhuacai@loongson.cn>
-# Copyright (C) 2020-2023 Loongson Technology Corporation Limited
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
-	echo "#define SYSCALLTBL_LOONGARCH_MAX_ID $max_nr"
-}
-
-create_table()
-{
-	echo "#include \"$input\""
-	echo "static const char *const syscalltbl_loongarch[] = {"
-	create_sc_table
-	echo "};"
-}
-
-$gcc -E -dM -x c -I $incpath/include/uapi $input \
-	|awk '$2 ~ "__NR" && $3 !~ "__NR3264_" {
-		sub("^#define __NR(3264)?_", "");
-		print | "sort -k2 -n"}' \
-	|create_table
diff --git a/tools/perf/arch/loongarch/include/syscall_table.h b/tools/perf/arch/loongarch/include/syscall_table.h
new file mode 100644
index 0000000000000000000000000000000000000000..9d0646d3455cdaf1a3db8c8565af8eba9a8df8c6
--- /dev/null
+++ b/tools/perf/arch/loongarch/include/syscall_table.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/syscall_table_64.h>
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index b7c0a4b9245a94b3b245fea59af79081b1f91081..3001386e13a502be5279aa6e4742af0b96202b35 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -30,10 +30,6 @@ static const char *const *syscalltbl_native = syscalltbl_powerpc_32;
 #include <asm/syscalls_n64.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_MIPS_N64_MAX_ID;
 static const char *const *syscalltbl_native = syscalltbl_mips_n64;
-#elif defined(__loongarch__)
-#include <asm/syscalls.c>
-const int syscalltbl_native_max_id = SYSCALLTBL_LOONGARCH_MAX_ID;
-static const char *const *syscalltbl_native = syscalltbl_loongarch;
 #elif defined(GENERIC_SYSCALL_TABLE)
 #include <syscall_table.h>
 const int syscalltbl_native_max_id = SYSCALLTBL_MAX_ID;

-- 
2.34.1


