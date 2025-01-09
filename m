Return-Path: <bpf+bounces-48330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A030DA06B42
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 03:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 691807A0449
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 02:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4B916DC28;
	Thu,  9 Jan 2025 02:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AGHPw4tb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FF31474A9
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 02:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736390202; cv=none; b=FPe7ikH0xTwt2DSxsnLj1XSbGKrh8iMGqmSyDnCMELckt9zr4RSIZjAbNDWkDs2RjqM1s6ocdg6d3o3gRsJ2kfvWyQOn7Gc5zy2swfUjwzSbnTQG7GI3l0IOBlyCnNo/k+wfJZZUJAVTq5rilskWrKBcSCeelRKoslWRNrS4LFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736390202; c=relaxed/simple;
	bh=In4WKSPDuGrXSsW1qi6BwC8Z5UQ8yZH/Gn59zCTgjRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mSJ6/CIDm4fhSfG/KOlwh1Q0JnCjmVNS2k2AiFAHBSGsCXeXfPjPTSfs4hf4M6mL0CNlGMxscIIiSLuA0bJ9LWZuy8Lqrsc4WbAo+u/yzJTxViKOrWdZbd4Njn444ZhUvlqzc5F4XufN9PnjOOjAwtpIHYFuRjGHvOOmU4geb+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=AGHPw4tb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21628b3fe7dso5553285ad.3
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 18:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736390200; x=1736995000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10LmYqKv19aje8sntIFV/R2i9EqxMFmjtiwpp8rrMlU=;
        b=AGHPw4tb5n7VNmqNFi4EuDF/LJn477RJXdn/EUYRax70iKIMoNjPBiAkPJSc6KVu2m
         QmIfPycp+mj4Ryt8V7dE5dYj8sEL5jN/9sr4g3kS2gg8OEVwEdO+wjVnWzlLN0mmL7RK
         e6U8nCV9akydsvoHzEdJEdk/a4vo2sqwfDLsjjNpP5eQrKEU8ZLJ5BNhJSP4HjzMwPrf
         /ZZBzgtW1L9XFp4jk1MRXMgruawtgs01WcpkFyLy3NnLfEEphpkTw417xrkvs198/7YB
         Z6+DvRRJ0H2VPZY/xzrH5isOG57EadVNogTYes7eDZJbtIv3MheI1FJ8E7RDXVOGdtU0
         F1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736390200; x=1736995000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10LmYqKv19aje8sntIFV/R2i9EqxMFmjtiwpp8rrMlU=;
        b=aVF5nqCis4BA+rOCgVIz8GvhD89jDMnE31/oe/o0bf0hItfPz3jizWqfKXP2Xfp6cf
         ODwpVh012NJXTIuH31uKetO3arSjEhZilcRDiUilcHN8GE4NPetkbAVZ8ydLY0qHF/Ld
         C+1ZDpsSdBCwOM5SEefh0L1qEwG/WFaXDcN5CthkwORZ41RDb6nDZPt6Gejpto1LBcK7
         Gn6Cu6E5eCKWjy0hi1dCR+A3GfYe9F5P+oMhEubjxiIyoHNR8qFaezHunrbVdjieBnzM
         mPab8MKE6rEhoPTMouxNWgdDFyzXjrNPZNSezxivYFmabG9bhp18vwnQeP7qrpVmq7+o
         PCqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdOUmCwDOhULZ5k7wKCZNxhe3RDOw9GI6Fm31eJYL7YE7/q9kbhURnjW/lqvvSLEr8qmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwThCailL49R52o42bOOfmiPYgKHvPsog77xKIndLj08PGMOVo6
	zyaxwf0aA5lg0mVLIhundDrw1cR++ZhKSU4uVam3dGtm1hjv4UawjiqV3F7V7Jo=
X-Gm-Gg: ASbGncuv5nSE9Pj7tjpyaq1udS8vZZu2CJDbobZHSxJnpb7Vm+VDvxz0c2dTNzxvef+
	f3HlUNZISLI8YzFOt0kkg4rsszUqWgFeD2r1CSDjHJwm6DbYYzS9uw+nPPKVpMv11F0b3kshxRk
	1/9vBPOMXkoef4QIPgLbYflourgJVdPARWH+lkaUQw5uJEfZQLW/NlZJik4b/NjrCRFqHASsqu2
	ZNCP/TM4EvdTD1WrI1gV91NCWISWRm0c/RQDZUfO/jcaXTrJIg248BjRChDwnQ+R5msBCNK
X-Google-Smtp-Source: AGHT+IEZTcNWbZZzy3+uRZAgWCe1ByNgJiDdl7GdfQUoOUVQV9Ol8zkdwVR6pXRVpk94+KTROujofg==
X-Received: by 2002:a17:903:2b08:b0:216:70b6:8723 with SMTP id d9443c01a7336-21a83fb5af8mr82871475ad.44.1736390199846;
        Wed, 08 Jan 2025 18:36:39 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9176bed6sm1434365ad.12.2025.01.08.18.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 18:36:38 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 08 Jan 2025 18:36:17 -0800
Subject: [PATCH v6 02/16] perf tools: arc: Support generic syscall headers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-perf_syscalltbl-v6-2-7543b5293098@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2826; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=In4WKSPDuGrXSsW1qi6BwC8Z5UQ8yZH/Gn59zCTgjRk=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3q9mba3RPKtbbI+Yud8xVZbf71lJHdfU+yx3qxpC0M52
 Msuf1nUUcrCIMbBICumyMJzrYG59Y5+2VHRsgkwc1iZQIYwcHEKwEQ8exn+e9Y/6xCYxCgj3fDD
 WmNq7ZV1zEunqs9+VZto5SRQOv3sDIbf7Pvnq0X3h1ivcK47xCHyaosby845F21/MjDsChCd79v
 JAgA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Arc uses the generic syscall table, use that in perf instead of
requiring libaudit.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                           | 2 +-
 tools/perf/Makefile.perf                             | 3 ++-
 tools/perf/arch/arc/entry/syscalls/Kbuild            | 2 ++
 tools/perf/arch/arc/entry/syscalls/Makefile.syscalls | 3 +++
 tools/perf/arch/arc/include/syscall_table.h          | 2 ++
 5 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6d66a7bad30d184d871ef85b09091e2720d09787..4e05dd2e9596e87cdd0dc91f4c5b071b4545c574 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -36,7 +36,7 @@ ifneq ($(NO_SYSCALL_TABLE),1)
   endif
 
   # architectures that use the generic syscall table scripts
-  ifeq ($(SRCARCH),riscv)
+  ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
     NO_SYSCALL_TABLE := 0
     CFLAGS += -DGENERIC_SYSCALL_TABLE
     CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index bf0516e328aa4f8a251b4f3eb172fd191772b00a..44b9e33b9568f638ba12ad688833fdb661c16c16 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,8 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-ifeq ($(SRCARCH),riscv)
+generic_syscall_table_archs := riscv arc
+ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
 include Makefile.config
diff --git a/tools/perf/arch/arc/entry/syscalls/Kbuild b/tools/perf/arch/arc/entry/syscalls/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..11707c481a24ecf4e220e51eb1aca890fe929a13
--- /dev/null
+++ b/tools/perf/arch/arc/entry/syscalls/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_32.h
diff --git a/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls b/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..391d30ab7a831b72d2ed3f2e7966fdbf558a9ed7
--- /dev/null
+++ b/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_32 += arc time32 renameat stat64 rlimit
diff --git a/tools/perf/arch/arc/include/syscall_table.h b/tools/perf/arch/arc/include/syscall_table.h
new file mode 100644
index 0000000000000000000000000000000000000000..4c942821662d95216765b176a84d5fc7974e1064
--- /dev/null
+++ b/tools/perf/arch/arc/include/syscall_table.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/syscalls_32.h>

-- 
2.34.1


