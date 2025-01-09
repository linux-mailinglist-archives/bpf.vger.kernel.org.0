Return-Path: <bpf+bounces-48340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9A3A06B75
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 03:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF086164D78
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 02:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43763155744;
	Thu,  9 Jan 2025 02:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="d5gyz13t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5218A19DFA4
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 02:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736390229; cv=none; b=MkOV7HZlFSI6VaIS5YIz9XduZNFqD9OGqlfcYMoJXUl9aF98wUF04uXeoTepD8Rd5H6/sICAT90yfrPlh0RA09w5ZCKTl7ry8mpvVT8EN1PcMRsusFhB0HL0bUBuJ9gTLcIhFK3MlE0b0g1vU2mlL7BLs+3F3+kY7DVmiOesjRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736390229; c=relaxed/simple;
	bh=L4oRiXOJ86zww3VT7aG+83yHqK1Y5r7akUnGrL/Ll2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZYQMZWNQkFFbx+rqf+Y2RQfHXQA74OIG1fATHZxRv2rE2oPKj0QdzzWaN7VOB1miSivZuA4U9YEGvFgEC05TUSpA30qECO63Vs/p1oK9SGf151m/8va/3xrG86nPeNSsrrU2pWKOAZ8ElBEhKKjMnXm4+AW8FCff7mBsnSMCNlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=d5gyz13t; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2165cb60719so6604025ad.0
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 18:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736390227; x=1736995027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pA0XkH7PdVSxIVYHuuTAafWWIYQPvi18jX0+XT4OOpc=;
        b=d5gyz13t3EmQuWhQorqbxIQ2EzjVVRE7HjmXV/J2yTe49Kkk83MDMBO8o0sCtsqPFT
         9Pa7wIu9WW1AEEKqcm2Tb/hhksDNiAq6GpJYDobIaJ5YfGlSdB3hgVpe3UxEPZqOgGs+
         eT14sYyJMl1+RPXBWYY9NUaQEf0RCTobdPymNiLK33vT1nMEBET9YegHQcCWq63IA9VV
         OJkZ6xrlOT1/goWQIzepXqV+yZw6sIBX15IFWJX8Ao+gIn92gZaNajJXys/nToH4+rCx
         Bya8x7+ioVMRA6/yNYgI+6oASpriFh/km9l9OJpTyjlFfhIqasfAVJj3eosGGvUToqE7
         AP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736390227; x=1736995027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pA0XkH7PdVSxIVYHuuTAafWWIYQPvi18jX0+XT4OOpc=;
        b=sPkQUznHArTqkPOvTrRKznm8jNN+7C5e/94T7Bfy0fiTfOQcOn6ALEUhPp/Q17stt0
         jN8Daz5ckc6hpSgJmFeGGoGy70Dkt4XKlKo6AwflKD+VSa11hKbokBNSMxm2WDrZ0DTP
         uQXfHlGSVMW85r0TtcoKKu4orkstCnR+wYinQhmuRHAmAgXjfJV8DDJUrMf7UDCK3Vgd
         L0Fvd4L3Udo70BV5xkfmV++dvr97FI0S9lfXa0ar/3i0zMBnmv1wRQa0K64F4DNPReIX
         UctB96G6lqihpC2z7FZvLB+QEgkxYRhqAvN0+7WxF1okCO7wuJ2FwPGiaU7obgVpAAx6
         vckA==
X-Forwarded-Encrypted: i=1; AJvYcCWu3bkuZTWYS5Ws+koBxSUOQw3LAiGKNxYTtXFbbbaTqn9wiWQPutmNNZnIzJ0joD+RL0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh9UN5GFKagrZGRpmOG9DCg0/6BNce/FtqOMF4JluBZ2ks/ZXl
	4pBaxrUtvE+q9TdydtC+exGBdVDuX1FwYt84bAFEcGrU6xaxwWby6oIdz3/+rts=
X-Gm-Gg: ASbGncvzBUnIWhRg+Vu9N4uTys+lL/YoO7HQGqhXNdTt7SoHYal/fksfZilE+MCJMgc
	7b4iA+7TlwgA2MgASu+zw260jQSoLFiJYqGWHYAI2KM07QfCkwilzwjJpIgAeFq5qjLSMYjLSFY
	yMsFVAd6n9v/RRXKmw7CTisd4Cy/ll83ONocLBF0fpvX9Xfl4h3YX91BzvtXo1zjlCAFxgBrfZG
	2ngVpNeU8XyT+lmzhhuuSt09QKURMmS4ATXI4P9QiRNjdyO5u28zq3upy2x/J/JlWydcbHX
X-Google-Smtp-Source: AGHT+IGRmDK0V3p3bzrQGIXhNTBwd8ChTW9bQMRNCfzQMxhyTGUlIjIqYFTVAx3mJIYTRKPptCpwng==
X-Received: by 2002:a17:902:fc8f:b0:215:787a:f91a with SMTP id d9443c01a7336-21a83fd1e96mr87183455ad.44.1736390226693;
        Wed, 08 Jan 2025 18:37:06 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9176bed6sm1434365ad.12.2025.01.08.18.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 18:37:05 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 08 Jan 2025 18:36:27 -0800
Subject: [PATCH v6 12/16] perf tools: loongarch: Use syscall table
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-perf_syscalltbl-v6-12-7543b5293098@rivosinc.com>
References: <20250108-perf_syscalltbl-v6-0-7543b5293098@rivosinc.com>
In-Reply-To: <20250108-perf_syscalltbl-v6-0-7543b5293098@rivosinc.com>
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
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3q9md4j51Wse64b6lTahz/0nW9sUed30GqFhtGxj4snX
 HcSnXWho5SFQYyDQVZMkYXnWgNz6x39sqOiZRNg5rAygQxh4OIUgImEZzP8j7TVdDUqWnr1SJCM
 1IZvn+p57DhvL5h6g7nUWM05WfiXMCPD2nk+M7VuLt2/5WqZYlcFk+Ns3rUXikwyd8n68p9b+ky
 PHQA=
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


