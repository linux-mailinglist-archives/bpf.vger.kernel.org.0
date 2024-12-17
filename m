Return-Path: <bpf+bounces-47104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F78C9F4435
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 07:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A87717A5728
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 06:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1123C1F03E0;
	Tue, 17 Dec 2024 06:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="T8NAyyw2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA281EF097
	for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417593; cv=none; b=N1u2yeh81Pqs/YEDpP+S2Mez3diUgHz59z90EpUc0gx2Uk8Fuqe4Sya469MCkeP7EEfPV37bkB5XlRwjIr2//2i0J/Ak/9y41U288hOWXW84Y2y5/ceIfJaysAF+Qq3FJ9Sh/5rYZ+S3mTIb0jRvHSXJN0fBnAEKjRZg4XsOxmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417593; c=relaxed/simple;
	bh=MIo59IrbdQbH0NyZA4l6qrAvL03PMN+AQ410Ellv3Vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RKqMKKHqaMvHcNAw6a3hV4MQ7y3VihGp/SY7/eC54jCyusJc838ZRuUNbO9UmqE9SkoN9I6IJzJ/j6UHLyc4/PmjuIvzN3UCJtgOw+qO4Eb8wgB00+/IEUX8wTkL2LaO5rvEh6N7th//zHSI1Bff44J+84bmPxfhAowULkFlH54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=T8NAyyw2; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fd51285746so2836354a12.3
        for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 22:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734417591; x=1735022391; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUzrFPrme/3rFzK9ZgzFRmgWi2r4uAa7RriZgqt2ItI=;
        b=T8NAyyw2YeKDh1JCs9werZG1P3e7njldEysTqLD/VwmTjyoLTi+ImKyIySNGiOg9EZ
         dtqva6EIuqdBIKDZ9lcrY44EsP9KgP+epAvWPTfm0290IelEtZ/TQrWoVxGgbzg8/H0H
         1rjEcxrUfd6Oty6o/K3BiM2MDD2dhfBgZkd1NQ1OwOoIscpLSLOOYp+LSxsJMxekGCvp
         XXMadU0W3gm95BSbiF6Slaq2l/wSDD97jqD2UdbPzF1wUquhNrahFTzzI92H567o2BBL
         Sjsq0563AljuYSAiNDcLfgNL4bcvv5RWEmay27pGFsmHjXkdZB+Phkm08lNOXC2lpj2m
         9+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734417591; x=1735022391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUzrFPrme/3rFzK9ZgzFRmgWi2r4uAa7RriZgqt2ItI=;
        b=seC2JJFhKS1O/VnlEeaAJTmVCawwxj1zfhn+m76qxqV0umIXnsbGliNjPYyNLtl9HC
         5lR8QPohfLptCflBcEzJEr+aC83oLPXLqof9RuvyNiY8JCXT5XfSB8O+t8telGk07GDs
         20nlysU3GHliJaCQZ+87Ff/gFRfunqZdJaHGoJSB//mRBQYSP7oteKD7O3NjQLAPu6cP
         v0Qf7+LjvWc5mR53+Vnr1ymkBZISzCKgLaQptBKrCEo2+JXm7nCXZg+1FsBb2og4X25Z
         2GpKWVXM2ZH77QX2egkds7ykBZqPLNsokzZLdJKYoEnd4V3ElJHQdEYxPd/VHkY1Y970
         k8iA==
X-Forwarded-Encrypted: i=1; AJvYcCV+fmt8+D/63et4YLxJS3tYheT+2kWxj1ziyqspLQq7InO1XEqMnduEgNTDzZuwd7SM0L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOX9jbXMY3qHJMewQukbRchliHQJKY+0p1wSJffZb165t9Ot2C
	HvqVUkN2xy2+6S4HqXIWPp6+akkcJUNrqijd7/AsxAjMuWZs7l9mpZyhCP56QCI=
X-Gm-Gg: ASbGnct2ZIJUO9RGU47o72ef+BNWqrH/o69ncWAMfgqInz/civzRCLJopua4DR8gby2
	7/Zd6qUuAGIWKmX+cwx7B42/VWyXsoEodYLUtyVQMpIZ8Kht0C16BMdoY/u/2QYWCexXghCQIfb
	1itYU8HLvNDPOJk2YOdQJ5J1X3HA3Lx7FVtSNfGMGTFprNtPGAYK1nXUlZxSdHNopiMiz56g2rn
	gW8yJy+68qM280UKmTV06MN1WU7vPsuBKrbAUxJqgehMHW6x2OmWgU2tya86Ln6OwjP2F0x
X-Google-Smtp-Source: AGHT+IG9pN/zyZVcJMURb7JTX2yG8brX6tuMMjOJP6SfPe5RtqdTeCcVI9SbLKnmp6ageh2z/wymVg==
X-Received: by 2002:a17:90b:1e0b:b0:2ee:a58d:cd8b with SMTP id 98e67ed59e1d1-2f28fd6a584mr20201432a91.18.1734417590649;
        Mon, 16 Dec 2024 22:39:50 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d90d6bsm9179551a91.2.2024.12.16.22.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 22:39:49 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 16 Dec 2024 22:32:57 -0800
Subject: [PATCH v3 12/16] perf tools: loongarch: Use syscall table
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-perf_syscalltbl-v3-12-239f032481d5@rivosinc.com>
References: <20241216-perf_syscalltbl-v3-0-239f032481d5@rivosinc.com>
In-Reply-To: <20241216-perf_syscalltbl-v3-0-239f032481d5@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6428; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=MIo59IrbdQbH0NyZA4l6qrAvL03PMN+AQ410Ellv3Vw=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3qizISnR7ji5zFa6FwW5kib98xIJ7s9wXVX9j7P63k+5
 dV7Fb91lLIwiHEwyIopsvBca2BuvaNfdlS0bALMHFYmkCEMXJwCMBFbU0aGm0z5k1YtOmZsr9gd
 0rXTpPyaV2aT72nzN6++cT3IimhyYvjvdlNp7b0rH9e3pp//yBO44tfRHmnDVg1DP2bXRqHjl3T
 4AA==
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
index 1865be464221a4101c0de65942c2b719c2a50e37..d5e1bd03ae0f9d10df2da25a75eab50eb7334b45 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -31,7 +31,7 @@ $(call detected_var,SRCARCH)
 ifneq ($(NO_SYSCALL_TABLE),1)
   NO_SYSCALL_TABLE := 1
 
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc s390 mips loongarch))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc s390 mips))
     NO_SYSCALL_TABLE := 0
   endif
 
@@ -75,7 +75,6 @@ ifeq ($(SRCARCH),arm64)
 endif
 
 ifeq ($(SRCARCH),loongarch)
-  CFLAGS += -I$(OUTPUT)arch/loongarch/include/generated
   LIBUNWIND_LIBS = -lunwind -lunwind-loongarch64
 endif
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index bedf58d2a10f1faccb3579c023d5722cfeaae4cf..c85262db770d18828fc3d9dc65eca00733645d41 100644
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


