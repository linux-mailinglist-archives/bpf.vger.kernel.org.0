Return-Path: <bpf+bounces-48215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41559A05047
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 03:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9859E3A1651
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 02:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01921AAE13;
	Wed,  8 Jan 2025 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kzSGELqy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30111AAA11
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302126; cv=none; b=cd8DPN4C8FVRy/h6KiQrEXP5fE2POY4o5mNinpj0n5KVZA73x52rDc7cYraDuIb8tP2cNImauyOaIxHBfZ4k6+rpWfREpSegTn/dpAHPVOKRPH80Q6SCyd9l193gxIrvwowc91QsyNKmTR6UTDwVkUflBmxdU5HzsoV9rtHQqBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302126; c=relaxed/simple;
	bh=oRK0NTjr3v6Mh0jMlSaE9maqBmXa4a6/G9BsJTG/8Tw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ig1KBOqofKFxOKq+nnd6RlCt76nnxw+CvTayR5a2CxwDB2Zd8Ku3lHbb3qwn8cjkL9VHa3Xc64rea/3P67MsEno6oqk5BA7EZd1okpof42kJy71FtV2f544LK8JMHj+zbLydVlldERQRxYHr6snEJ7qIHqVg5Vbjlo+XJpNTbmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kzSGELqy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2165448243fso43052785ad.1
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2025 18:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736302123; x=1736906923; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqeHuZiQk8n4MlJOPbQsxVRUlw8T5DqruaOf4SH+hxw=;
        b=kzSGELqyUnIVE+xuMON92ux2L5C7wC85lkml2twBfWWmzaIGoJAROKvXkMnecQLter
         FLMA5r9iuqMwTbmU8UXe1Eto8zwMR5cSTGM4GQfY02plQcXEHZerOzoNfhPB2ymTddtS
         ZXG7DJd8u3HK+9RZleBhtFJ7VpfnQEGxXWYF1CZRWBCEGbA3r/NuHacpynkEkfPIhiSD
         wORodiQ1NieavcsYA+QqCZaq8lBIG1NqVreIkz9+Y2Sj/ewOUggYxrp8WnxJ01Lo4DNP
         QcVOe1/xoLQfYXW7gxmSCajsZ+KkScVfsIa3/zx2IYmG6aDBwbAv9kLODDQNjuO5zQ1a
         BEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736302123; x=1736906923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqeHuZiQk8n4MlJOPbQsxVRUlw8T5DqruaOf4SH+hxw=;
        b=W/6mLu/e9WVJG/De+IB6qGeNq0XjxLrGNo4OWabUMZBZMuJzLieswkNTVc2UrU9uqN
         6HGOl9kD3VcXcPeQsfzXKynra4zva5h/NoyFzRDDgMGZrTThgIdU9Fa/iWy93bNa144r
         QUXbDXhcSEHRm+1smEVvM2UD0WDHjKrRHKv9UMG7G4pVXJtJuOc0qqaPqetgp5idgXOx
         tDaRWjGPJAFM4VDLZDQoZlLJ+4+QOXpTT/8sX5VR9p9m3cJg+0Bpmmvw+0oJrUN16k4x
         TYRfWpozxO2PKlA2F9a6nL5s8CEjP0g3t9ryDbdGMKIfCBSdg0Xg916LZnYxT/85KWVR
         1eKw==
X-Forwarded-Encrypted: i=1; AJvYcCUfOZDyr8JdvlDPdDftRPaygdie/Z2B7QAPPZHtKNwfAho0pbHlqgRWL31Bk0Y7tN/+qIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx60Bg2nkPikkUbn0kNVtjIWHjhrEaEvPDtuEaPIpTg7Q6H02Jx
	XznlPZqUE0MNvIVB72T/96OcPmR1NEn2/3hUrg0L4ZbqoXnyNjwr2zrp8L/YNN4=
X-Gm-Gg: ASbGnctZ+bvi9KU0178fzO+BHX8ZdrIc3uLoXwbvh3j24uQJIF7kLZSarZFRPmdJmIK
	ZmZ67Qyc5/ujw/xtJKBNsLV1AayjuVzCBzjN9PVwKdDA992U+yxMW70sIevpQ/iyk/1l9b+YfGa
	U4NCA9VPCgCmsKyATSRDavtk1e0CMtOxAQHRN/AL4pmhHxfYfBzvqzY/uAw9L0XNO1/nnbk757Y
	gNEid9NC7gPLw0zqzCFeYFoo+Q1uB8TI0AqDaoZyAtDbhCtvYJV4C5dbSEZ61t8Be0Iydf7
X-Google-Smtp-Source: AGHT+IF2phcx8fV1G/3aE9QrPs6fy3sYExRIe4UGlaiTAcwwv2hm2T+9cWhMCTRAvX6QVwgE5t4Fvg==
X-Received: by 2002:a17:902:e545:b0:216:61d2:46b6 with SMTP id d9443c01a7336-21a83f6dae1mr16244155ad.25.1736302123077;
        Tue, 07 Jan 2025 18:08:43 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca0282fsm316662405ad.259.2025.01.07.18.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 18:08:42 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 07 Jan 2025 18:08:02 -0800
Subject: [PATCH v5 14/16] perf tools: powerpc: Use generic syscall table
 scripts
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-perf_syscalltbl-v5-14-935de46d3175@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6924; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=oRK0NTjr3v6Mh0jMlSaE9maqBmXa4a6/G9BsJTG/8Tw=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rtPZaq1+evnbzZd/p5ae4ShlMPCs0ZnAJ+Sd4KibGzt
 67ft+RRRykLgxgHg6yYIgvPtQbm1jv6ZUdFyybAzGFlAhnCwMUpABNhvsvIMPfn/b9ekwOPB9zI
 L79w4fUbvSNRC09N2TBr9pSws7zdvHMYGQ7v4O71+nREL5lRwmd7nOL729+qurbzlL7bv7Vw999
 ZmVwA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Use the generic scripts to generate headers from the syscall table
instead of the custom ones for powerpc.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                         |  3 +-
 tools/perf/Makefile.perf                           |  2 +-
 tools/perf/arch/powerpc/Makefile                   | 25 --------------
 tools/perf/arch/powerpc/entry/syscalls/Kbuild      |  3 ++
 .../arch/powerpc/entry/syscalls/Makefile.syscalls  |  6 ++++
 .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  | 39 ----------------------
 tools/perf/arch/powerpc/include/syscall_table.h    |  8 +++++
 tools/perf/util/syscalltbl.c                       |  8 -----
 8 files changed, 19 insertions(+), 75 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index e053a2304f40f6cd06a9fd022ba863b5bf2efa5e..7213f6d806e5497309524cacb16bd8313e9bc5cb 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -31,7 +31,7 @@ $(call detected_var,SRCARCH)
 ifneq ($(NO_SYSCALL_TABLE),1)
   NO_SYSCALL_TABLE := 1
 
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc s390))
+  ifeq ($(SRCARCH),s390)
     NO_SYSCALL_TABLE := 0
   endif
 
@@ -49,7 +49,6 @@ endif
 
 # Additional ARCH settings for ppc
 ifeq ($(SRCARCH),powerpc)
-  CFLAGS += -I$(OUTPUT)arch/powerpc/include/generated
   ifndef NO_LIBUNWIND
     LIBUNWIND_LIBS := -lunwind -lunwind-ppc64
   endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 84d23f147365d5a57c83fe16a2faedf45f4e2f70..0e30da3b781b5a51ea179ab15993391ff7055635 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips
+generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips powerpc
 ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
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


