Return-Path: <bpf+bounces-33884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F289273F8
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 12:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730E81F24C11
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 10:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAE31ABC40;
	Thu,  4 Jul 2024 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUOHHLbF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CD11AB908
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088673; cv=none; b=FB3jHa7AZG2+fsDVXUKvgsTc81bQ4+YlaYEhWNP/orpSxTskMk+UnNY9obj3bNObkrv0LZ4F+7iXJvrGZNsTwsmpiyZX7V3y+/qGcg30AlePOLaR91DnfQthtj8A3Gn7zh4+D8FLdlSKdnEsevzL5NQ1OjDX6FpI0iwF9m+t13M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088673; c=relaxed/simple;
	bh=FrsdcRoYiA37h8ukuYwcII9Ne5an50W6yB4pbD5OBxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfG+lclNHiVbhEL8E2FyWmGj5WTlCNXUM+mllNxhjgzZIhdqVoGpTfHeNhYdBe3H1YE8AavJwg3ErLkddvpGXHt1KfVfdaYDTXGFNQxvKGsfnhlv87iU0r5NeUweABs0PIbRoOgPJ16/Q5/OrlTbNGXeM6EAD6JY89QDW/RJI3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUOHHLbF; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-761e0f371f5so144811a12.1
        for <bpf@vger.kernel.org>; Thu, 04 Jul 2024 03:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720088670; x=1720693470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5f3QwKJcFbMz2GQRu8VWXW6RzRYSGYhQhXZ6QFSjbTk=;
        b=AUOHHLbFF99ZSTDrx5yovU9FWXohb41ruA0T5qfA/KxZOvuySnUVP1t6NJFdWu0Xao
         Nd+xhstGJmbZHI5+/bTyPpEPFVx9u7YKyJ4spZAeHup2jpvoYOnGz2z0smx+/8k8o0zK
         Ix4tQP4+Uj9NikAjQVuOlRfd7FGzwxAh1nR+dZw9uYc8064cj8sWYgcVEa4DGgCkU8q6
         Gq+Y62YCXsvsmwaPa6dV5acJJ0x8WVaDWBH5+R2AunFkyhoQBjH5gPvBjH8tpayJHCws
         MoCaxIl0YqRcTJ4EPOaIkaInjA8z9jBw6ddxx38W11LtEYPX9hVyRvNOPK7ahlj1x8eE
         bFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720088670; x=1720693470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5f3QwKJcFbMz2GQRu8VWXW6RzRYSGYhQhXZ6QFSjbTk=;
        b=pjQVPPVTMbq9k1cOo7sQEjQ2065zqWLwka0TwMGIgj9vEK5V8UstZM0HkSJWzmrnH0
         qN4448OxjSTn4GiA36Kopa669wT+V5YDpoLhBz0mic97YtqcoYot9o2KJKDXm+rcZeO5
         v+CamRfbjcdsNpG+2winbqgz8tMGwIyjg63BjoTxKPd6PADqvisdHiQIy8hYJLNGDV3J
         bje+GYgkKeFk9vi/HeMsQ7r1pEtMis146qFEfpvg09Ln4WBd/BhTySCGMtTjrfXPo4X2
         2FTDW8db+Zc64VefuuWAfYcF+wXbJXzFSz/kMdS0KPX6tLucOSbxc9MU9QKtpxOmbXjF
         E9Xg==
X-Gm-Message-State: AOJu0YxNCwSF/0KgN7A+z9jsuiVjaoepBvcsep076Iwjdcpo+DHS5HLk
	VrAqjLOh2kw14eBVyMcUc+fy+w9NjS9Gsr4c1yuWe4GhQhCpoWBaasioDQ==
X-Google-Smtp-Source: AGHT+IHl1AAGR48SDQho4s3LSy/4yHAn6F5m5QzyKnLissj23RqznXsphl7wHbupZIaOzDD2DUPwVw==
X-Received: by 2002:a17:90a:d314:b0:2c9:6a0e:6e66 with SMTP id 98e67ed59e1d1-2c99f2fd0e9mr1494017a91.5.1720088670368;
        Thu, 04 Jul 2024 03:24:30 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c9a4c0fe8dsm216693a91.0.2024.07.04.03.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 03:24:29 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next v2 9/9] selftests/bpf: test no_caller_saved_registers spill/fill removal
Date: Thu,  4 Jul 2024 03:24:01 -0700
Message-ID: <20240704102402.1644916-10-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704102402.1644916-1-eddyz87@gmail.com>
References: <20240704102402.1644916-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests for no_caller_saved_registers processing logic
(see verifier.c:match_and_mark_nocsr_pattern()):
- a canary positive test case;
- a canary test case for arm64 and riscv64;
- various tests with broken patterns;
- tests with read/write fixed/varying stack access that violate nocsr
  stack access contract;
- tests with multiple subprograms.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_nocsr.c      | 521 ++++++++++++++++++
 2 files changed, 523 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_nocsr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 6816ff064516..8ca306c28e62 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -53,6 +53,7 @@
 #include "verifier_movsx.skel.h"
 #include "verifier_netfilter_ctx.skel.h"
 #include "verifier_netfilter_retcode.skel.h"
+#include "verifier_nocsr.skel.h"
 #include "verifier_precision.skel.h"
 #include "verifier_prevent_map_lookup.skel.h"
 #include "verifier_raw_stack.skel.h"
@@ -171,6 +172,7 @@ void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
 void test_verifier_movsx(void)                 { RUN(verifier_movsx); }
 void test_verifier_netfilter_ctx(void)        { RUN(verifier_netfilter_ctx); }
 void test_verifier_netfilter_retcode(void)    { RUN(verifier_netfilter_retcode); }
+void test_verifier_nocsr(void)                { RUN(verifier_nocsr); }
 void test_verifier_precision(void)            { RUN(verifier_precision); }
 void test_verifier_prevent_map_lookup(void)   { RUN(verifier_prevent_map_lookup); }
 void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_nocsr.c b/tools/testing/selftests/bpf/progs/verifier_nocsr.c
new file mode 100644
index 000000000000..4e767d768f1c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_nocsr.c
@@ -0,0 +1,521 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("raw_tp")
+__arch_x86_64
+__xlated("4: r5 = 5")
+__xlated("5: w0 = ")
+__xlated("6: r0 = &(void __percpu *)(r0)")
+__xlated("7: r0 = *(u32 *)(r0 +0)")
+__xlated("8: exit")
+__success
+__naked void simple(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"r2 = 2;"
+	"r3 = 3;"
+	"r4 = 4;"
+	"r5 = 5;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"*(u64 *)(r10 - 24) = r2;"
+	"*(u64 *)(r10 - 32) = r3;"
+	"*(u64 *)(r10 - 40) = r4;"
+	"*(u64 *)(r10 - 48) = r5;"
+	"call %[bpf_get_smp_processor_id];"
+	"r5 = *(u64 *)(r10 - 48);"
+	"r4 = *(u64 *)(r10 - 40);"
+	"r3 = *(u64 *)(r10 - 32);"
+	"r2 = *(u64 *)(r10 - 24);"
+	"r1 = *(u64 *)(r10 - 16);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+/* The logic for detecting and verifying nocsr pattern is the same for
+ * any arch, however x86 differs from arm64 or riscv64 in a way
+ * bpf_get_smp_processor_id is rewritten:
+ * - on x86 it is done by verifier
+ * - on arm64 and riscv64 it is done by jit
+ *
+ * Which leads to different xlated patterns for different archs:
+ * - on x86 the call is expanded as 3 instructions
+ * - on arm64 and riscv64 the call remains as is
+ *   (but spills/fills are still removed)
+ *
+ * It is really desirable to check instruction indexes in the xlated
+ * patterns, so add this canary test to check that function rewrite by
+ * jit is correctly processed by nocsr logic, keep the rest of the
+ * tests as x86.
+ */
+SEC("raw_tp")
+__arch_arm64
+__arch_riscv64
+__xlated("0: r1 = 1")
+__xlated("1: call bpf_get_smp_processor_id")
+__xlated("2: exit")
+__success
+__naked void canary_arm64_riscv64(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 16);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__xlated("1: r0 = &(void __percpu *)(r0)")
+__xlated("3: exit")
+__success
+__naked void canary_zero_spills(void)
+{
+	asm volatile (
+	"call %[bpf_get_smp_processor_id];"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__xlated("1: *(u64 *)(r10 -16) = r1")
+__xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("5: r2 = *(u64 *)(r10 -16)")
+__success
+__naked void wrong_reg_in_pattern1(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r2 = *(u64 *)(r10 - 16);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__xlated("1: *(u64 *)(r10 -16) = r6")
+__xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("5: r6 = *(u64 *)(r10 -16)")
+__success
+__naked void wrong_reg_in_pattern2(void)
+{
+	asm volatile (
+	"r6 = 1;"
+	"*(u64 *)(r10 - 16) = r6;"
+	"call %[bpf_get_smp_processor_id];"
+	"r6 = *(u64 *)(r10 - 16);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__xlated("1: *(u64 *)(r10 -16) = r0")
+__xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("5: r0 = *(u64 *)(r10 -16)")
+__success
+__naked void wrong_reg_in_pattern3(void)
+{
+	asm volatile (
+	"r0 = 1;"
+	"*(u64 *)(r10 - 16) = r0;"
+	"call %[bpf_get_smp_processor_id];"
+	"r0 = *(u64 *)(r10 - 16);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__xlated("2: *(u64 *)(r2 -16) = r1")
+__xlated("4: r0 = &(void __percpu *)(r0)")
+__xlated("6: r1 = *(u64 *)(r10 -16)")
+__success
+__naked void wrong_base_in_pattern(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"r2 = r10;"
+	"*(u64 *)(r2 - 16) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 16);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__xlated("1: *(u64 *)(r10 -16) = r1")
+__xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("5: r2 = 1")
+__success
+__naked void wrong_insn_in_pattern(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r2 = 1;"
+	"r1 = *(u64 *)(r10 - 16);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__xlated("2: *(u64 *)(r10 -16) = r1")
+__xlated("4: r0 = &(void __percpu *)(r0)")
+__xlated("6: r1 = *(u64 *)(r10 -8)")
+__success
+__naked void wrong_off_in_pattern1(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__xlated("1: *(u32 *)(r10 -4) = r1")
+__xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("5: r1 = *(u32 *)(r10 -4)")
+__success
+__naked void wrong_off_in_pattern2(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u32 *)(r10 - 4) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u32 *)(r10 - 4);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__xlated("1: *(u32 *)(r10 -16) = r1")
+__xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("5: r1 = *(u32 *)(r10 -16)")
+__success
+__naked void wrong_size_in_pattern(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u32 *)(r10 - 16) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u32 *)(r10 - 16);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__xlated("2: *(u32 *)(r10 -8) = r1")
+__xlated("4: r0 = &(void __percpu *)(r0)")
+__xlated("6: r1 = *(u32 *)(r10 -8)")
+__success
+__naked void partial_pattern(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"r2 = 2;"
+	"*(u32 *)(r10 - 8) = r1;"
+	"*(u64 *)(r10 - 16) = r2;"
+	"call %[bpf_get_smp_processor_id];"
+	"r2 = *(u64 *)(r10 - 16);"
+	"r1 = *(u32 *)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__xlated("0: r1 = 1")
+__xlated("1: r2 = 2")
+/* not patched, spills for -8, -16 not removed */
+__xlated("2: *(u64 *)(r10 -8) = r1")
+__xlated("3: *(u64 *)(r10 -16) = r2")
+__xlated("5: r0 = &(void __percpu *)(r0)")
+__xlated("7: r2 = *(u64 *)(r10 -16)")
+__xlated("8: r1 = *(u64 *)(r10 -8)")
+/* patched, spills for -16, -24 removed */
+__xlated("10: r0 = &(void __percpu *)(r0)")
+__xlated("12: exit")
+__success
+__naked void min_stack_offset(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"r2 = 2;"
+	/* this call won't be patched */
+	"*(u64 *)(r10 - 8) = r1;"
+	"*(u64 *)(r10 - 16) = r2;"
+	"call %[bpf_get_smp_processor_id];"
+	"r2 = *(u64 *)(r10 - 16);"
+	"r1 = *(u64 *)(r10 - 8);"
+	/* this call would be patched */
+	"*(u64 *)(r10 - 16) = r1;"
+	"*(u64 *)(r10 - 24) = r2;"
+	"call %[bpf_get_smp_processor_id];"
+	"r2 = *(u64 *)(r10 - 24);"
+	"r1 = *(u64 *)(r10 - 16);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__xlated("1: *(u64 *)(r10 -8) = r1")
+__xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("5: r1 = *(u64 *)(r10 -8)")
+__success
+__naked void bad_fixed_read(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"r1 = r10;"
+	"r1 += -8;"
+	"r1 = *(u64 *)(r1 - 0);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__xlated("1: *(u64 *)(r10 -8) = r1")
+__xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("5: r1 = *(u64 *)(r10 -8)")
+__success
+__naked void bad_fixed_write(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"r1 = r10;"
+	"r1 += -8;"
+	"*(u64 *)(r1 - 0) = r1;"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__xlated("6: *(u64 *)(r10 -16) = r1")
+__xlated("8: r0 = &(void __percpu *)(r0)")
+__xlated("10: r1 = *(u64 *)(r10 -16)")
+__success
+__naked void bad_varying_read(void)
+{
+	asm volatile (
+	"r6 = *(u64 *)(r1 + 0);" /* random scalar value */
+	"r6 &= 0x7;"		 /* r6 range [0..7] */
+	"r6 += 0x2;"		 /* r6 range [2..9] */
+	"r7 = 0;"
+	"r7 -= r6;"		 /* r7 range [-9..-2] */
+	"r1 = 1;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 16);"
+	"r1 = r10;"
+	"r1 += r7;"
+	"r1 = *(u8 *)(r1 - 0);" /* touches slot [-16..-9] where spills are stored */
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__xlated("6: *(u64 *)(r10 -16) = r1")
+__xlated("8: r0 = &(void __percpu *)(r0)")
+__xlated("10: r1 = *(u64 *)(r10 -16)")
+__success
+__naked void bad_varying_write(void)
+{
+	asm volatile (
+	"r6 = *(u64 *)(r1 + 0);" /* random scalar value */
+	"r6 &= 0x7;"		 /* r6 range [0..7] */
+	"r6 += 0x2;"		 /* r6 range [2..9] */
+	"r7 = 0;"
+	"r7 -= r6;"		 /* r7 range [-9..-2] */
+	"r1 = 1;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 16);"
+	"r1 = r10;"
+	"r1 += r7;"
+	"*(u8 *)(r1 - 0) = r7;" /* touches slot [-16..-9] where spills are stored */
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__xlated("1: *(u64 *)(r10 -8) = r1")
+__xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("5: r1 = *(u64 *)(r10 -8)")
+__success
+__naked void bad_write_in_subprog(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call bad_write_in_subprog_aux;"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+__used
+__naked static void bad_write_in_subprog_aux(void)
+{
+	asm volatile (
+	"r0 = 1;"
+	"*(u64 *)(r1 - 0) = r0;"	/* invalidates nocsr contract for caller: */
+	"exit;"				/* caller stack at -8 used outside of the pattern */
+	::: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+/* main, not patched */
+__xlated("1: *(u64 *)(r10 -8) = r1")
+__xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("5: r1 = *(u64 *)(r10 -8)")
+__xlated("9: call pc+1")
+__xlated("10: exit")
+/* subprogram, patched */
+__xlated("11: r1 = 1")
+__xlated("13: r0 = &(void __percpu *)(r0)")
+__xlated("15: exit")
+__success
+__naked void invalidate_one_subprog(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"r1 = r10;"
+	"r1 += -8;"
+	"r1 = *(u64 *)(r1 - 0);"
+	"call invalidate_one_subprog_aux;"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+__used
+__naked static void invalidate_one_subprog_aux(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+/* main */
+__xlated("0: r1 = 1")
+__xlated("2: r0 = &(void __percpu *)(r0)")
+__xlated("4: call pc+1")
+__xlated("5: exit")
+/* subprogram */
+__xlated("6: r1 = 1")
+__xlated("8: r0 = &(void __percpu *)(r0)")
+__xlated("10: *(u64 *)(r10 -16) = r1")
+__xlated("11: exit")
+__success
+__naked void subprogs_use_independent_offsets(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 16);"
+	"call subprogs_use_independent_offsets_aux;"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+__used
+__naked static void subprogs_use_independent_offsets_aux(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 24) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 24);"
+	"*(u64 *)(r10 - 16) = r1;"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.45.2


