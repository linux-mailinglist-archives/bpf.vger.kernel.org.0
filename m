Return-Path: <bpf+bounces-48203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5C9A05005
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 03:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B5857A25F6
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 02:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5F5197A7E;
	Wed,  8 Jan 2025 02:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zPgMDrYr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364AB175D48
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 02:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302095; cv=none; b=hl32Dpfp0NZ2FRspwkqJxc+XymyX1ivWfwuSJH0Mh+Pq5yjAhTz51YsWriDhurmf3NTMQIsaC+Q4nK+alxTWsEJ24TdATXRIRiF7O0WcI/EmBgA3zLcyAR6TJn4/wCU78DtnHI6jkqPLI+mmMyYBdM7Fz5RazsPmaxmzaPmjyBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302095; c=relaxed/simple;
	bh=In4WKSPDuGrXSsW1qi6BwC8Z5UQ8yZH/Gn59zCTgjRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gOOGVKKz+P9r3cuMMnbkyKKGycvNa/jIUgpar+IfFq9CRam6OSg5nui7s9FwS37FXDweZTWgxa3CBcMYYN/QsiAMzHwIhc6jfNu6GZDkMLygWaMNUfwVHWo+bMGSrpSlEKdFR+PPAn1R1MF/vXsALnHylpZbWlKa9AVmQMM7dr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zPgMDrYr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216728b1836so219727865ad.0
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2025 18:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736302092; x=1736906892; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10LmYqKv19aje8sntIFV/R2i9EqxMFmjtiwpp8rrMlU=;
        b=zPgMDrYr8zY6659X1iImU/3j7P/5zfRNXwwTdajXkh9pfW/mAbpN5S7upmFgN5UzqT
         +WpnBM1z7SJUVDujt2EmWsvXBp8wF6rQ8RyC3gVGvg9mCSmVYcrq3aMleQ7iLVxAOq0d
         5di3CgmMngtyqcpNBtofWDI/YnBPRDg++7D6yA9XDJyYtHYVgj3mfHLS8i4yWy8icdxQ
         9aW6xFbc7/CqbQUPNMRynZM+YeJGLWfeNRKM3lOFoXV56QTdTr/2j1dbliZgj4Kfb3sd
         WRzYWQsI0tR3O7DFjwhXzWZ4NZuFrIPstL/QV8Icib3ldLRogjz9Hy9MWSbYSZ8dJsOR
         68MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736302092; x=1736906892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10LmYqKv19aje8sntIFV/R2i9EqxMFmjtiwpp8rrMlU=;
        b=tjwhPXKEPEpj08AZ1kkgiChpIgRtJjIBnCJ4nxNerTuB52dQc8Rjs5MO5xZKsFszue
         qXqMoCyyHVEVs/rcAX+k9ksvWmUupE525qAKFnp47KBiaV8f9+ymOdz/8qdor+X2OVGy
         EcvOuRC4Vq6DBJuV5uAmT7mVLe/zusMPvBBuie2rIApXT5PgBH4He/nRJ3A8hV4jt0qi
         I3vano1Miawm09ClKuZR/ZyaR9poSjaeK8FiJHgI1LMQ/tq5C7CntxNx4pKzGEOUdm3q
         Hb+E11w+eSq48eBZTFPYWuqWTijanFD+aiMY19ACGW7TsIyZJ2L5aIbsqs1QMTtfn89u
         mzSw==
X-Forwarded-Encrypted: i=1; AJvYcCXDvg0mQfbjSaZjFosIp5IJJ8ION/zruJ0xD3GcquBdFipYwYzG7usiRvW2dsjyPAg0n9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrb7SA1exOZYCqopMSyL8ZTHZIWLAiiZYARZFoaukiz7rp1XmA
	8SuB2uFR8C2OkdoePNPtLyedcx6wBgKeKUZueQfGrtbcHzGkBJpfE64tRRsqpkY=
X-Gm-Gg: ASbGncs15438M2Bq8E5kMcpavbJ8SnypXnoWImu+u5F2xhLDcYyhTc7aZ+QQPxuRpzC
	K0lDAISuMSOE5+wJrZpp0pAFob8DMUO4Ekz1Wv2CwtjQBj3JEezKuI/LVzqnhJ4v3YV6ilkeNpv
	UVYWyExaKiW3JTYTvcz6JbzqtrMDQNEMwfJXBiSqYb1rdOLFtfqslIaTxJtRedlMGLKs77Cnrpr
	kCEp+3CT1zufYd6rd/vS4PWkJBnh9MHHkTZfWmTntoMipajI7qH5g22I+Sq7WEchmOJzlut
X-Google-Smtp-Source: AGHT+IEofSRP/rbAD1y/Csx4ENQMqaTL0WI/3zDA2H7TL6yv9dR01QAT8JELG079U4b/zZPbnpn11Q==
X-Received: by 2002:a17:902:f546:b0:216:51b0:6600 with SMTP id d9443c01a7336-21a83f691eamr17725355ad.24.1736302092587;
        Tue, 07 Jan 2025 18:08:12 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca0282fsm316662405ad.259.2025.01.07.18.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 18:08:11 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 07 Jan 2025 18:07:50 -0800
Subject: [PATCH v5 02/16] perf tools: arc: Support generic syscall headers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-perf_syscalltbl-v5-2-935de46d3175@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2826; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=In4WKSPDuGrXSsW1qi6BwC8Z5UQ8yZH/Gn59zCTgjRk=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rtPYbJF9PnLLZt76psZFr7QUrcLVOV2ddpylubxgOZk
 5KLr1p3lLIwiHEwyIopsvBca2BuvaNfdlS0bALMHFYmkCEMXJwCMBHNTEaGrxbaUd35NzKnN99Z
 lr25n+tbUk/GlH+rxb7Xl+fO+pN4kuG/64xvX+/oLW7eunPepZM19WdDvJ+8ez3R6q3xh5vRXZJ
 H+AA=
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


