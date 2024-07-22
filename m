Return-Path: <bpf+bounces-35288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BD3939711
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1AA21F221FB
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 23:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BAF73465;
	Mon, 22 Jul 2024 23:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQzbKb2L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B47571B47
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721691559; cv=none; b=WoZ+aROpZr/hZ2WFLAt+WvveGD2QL2B7KgflsMK2ge6/o3jVm+Q9WZ42piMZS5eUAoUREUyqCQfPx7pvn4KfydhhpdFApqv98OVlHtIIHsXzZ/wRm9o/Na+xoyCkNoLNrqxKO/CKBlryd2FRGnKOnTXj0E4GazCIYadgkbGon6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721691559; c=relaxed/simple;
	bh=5RtIdBt4Id7NofpvfXlmCKhbUqOy2I+idSqN2fohiuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1KGv40BOVA1Jzj/CpwwGLhkOROEsY+pEVA1L8uRvv7ObnpvLAFYjua/TAilg+hqimvjX1ghWiD44dZNlQpSFACrC0UgtTPJUwZhgPSvDUX1vDzQmuEXWUdtbB6+v/jL+GejPrbjkF32R1IvIAS21O9j2q4vhbhUutyDVBpQyAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQzbKb2L; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d357040dbso678237b3a.1
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 16:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721691556; x=1722296356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyvTc+OKfGRe5NI53AW5xe+21vYj7n1zFFczvrwE7ic=;
        b=EQzbKb2LTEWW4B99xXGFrGPi/PlYFuB4F/Ga6fIdzqPISEk4oWcoe1giaKyOJHg5Xq
         /zPj30HSHyNg/1UMAYXfyOKJtlGlld9aXgvFYpcciG485QXlcLKUBK8m6laEmcxZNthk
         ETPf5p8G4W/8TyS0utLm0iyq3ha4bfbOG8sWhgaWJotycdQWOpv7QMGYAkrjEy65qEz5
         n8mVktI86zdxXcfy5wsglnz+oRQouQb+/Sd68xuCZYF/pQGuXuC7640T6Uw4Hi9wE4WB
         37B64KD9a4pmjMD5tHnxJNvjYoB2vtj8MkNHmzGfEQJBNN4wTTzYqBv4jpGsja1hreXh
         mZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721691556; x=1722296356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyvTc+OKfGRe5NI53AW5xe+21vYj7n1zFFczvrwE7ic=;
        b=jYUh40n0LifpN2KgQC0Z6phgPMrV0L3+rfAcaTWrI9dxbSPwuoM5oxS+9gxeo+Mh/g
         4XFMZg5di17amuO/fj7prCO9zH6LerO7H5PRzHfB40d6rxZrF/vzYKldeY4FEm2HcFQp
         BjURblYYXd8mLEPWgsQVbnlZntU8yc5Tc8TgBm7vo7CpjIv1B22s495z74szE0a5BwSH
         nSDM8zZV7hVEyTdXtpsC9jwCj7GIH8477UoTi/Tc2W95O/g9fkY+EEgp3vBHNH5LMxXz
         5kx2+g1sdgEcUGHQ36B6Y0IAhY/Y7XESq1rS3Qa5krKtxz8LbVS0nQWDxjJpxHnoUJbg
         Xl1w==
X-Gm-Message-State: AOJu0YzdB5rRVQ4qWLIq1FGd4oy1kgHULfAvIeA62GK5diKHbMk92PcJ
	Se40gEFbewvW28r+HoFlxbCagZPErjDU/NRVxkO4OwI5Fzr2Z18mkZlfIxtGl2M=
X-Google-Smtp-Source: AGHT+IEj/2LaRZIPqkD9prIsbj8PWgwTFqnb/YlWuPeVrgarKheH/6TDLDNMZsp63BoFpHUT/4NpdA==
X-Received: by 2002:a05:6a00:3d03:b0:70d:1b17:3c5e with SMTP id d2e1a72fcca58-70d1b173cfdmr5073247b3a.6.1721691555840;
        Mon, 22 Jul 2024 16:39:15 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2707fe14sm2479500b3a.163.2024.07.22.16.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 16:39:15 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 10/10] selftests/bpf: test no_caller_saved_registers spill/fill removal
Date: Mon, 22 Jul 2024 16:38:44 -0700
Message-ID: <20240722233844.1406874-11-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722233844.1406874-1-eddyz87@gmail.com>
References: <20240722233844.1406874-1-eddyz87@gmail.com>
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
- tests with multiple subprograms;
- tests using nocsr in combination with may_goto/bpf_loop,
  as all of these features affect stack depth;
- tests for nocsr stack spills below max stack depth.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_nocsr.c      | 796 ++++++++++++++++++
 2 files changed, 798 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_nocsr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 9dc3687bc406..a3c2c5da3e0e 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -53,6 +53,7 @@
 #include "verifier_movsx.skel.h"
 #include "verifier_netfilter_ctx.skel.h"
 #include "verifier_netfilter_retcode.skel.h"
+#include "verifier_nocsr.skel.h"
 #include "verifier_or_jmp32_k.skel.h"
 #include "verifier_precision.skel.h"
 #include "verifier_prevent_map_lookup.skel.h"
@@ -172,6 +173,7 @@ void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
 void test_verifier_movsx(void)                 { RUN(verifier_movsx); }
 void test_verifier_netfilter_ctx(void)        { RUN(verifier_netfilter_ctx); }
 void test_verifier_netfilter_retcode(void)    { RUN(verifier_netfilter_retcode); }
+void test_verifier_nocsr(void)                { RUN(verifier_nocsr); }
 void test_verifier_or_jmp32_k(void)           { RUN(verifier_or_jmp32_k); }
 void test_verifier_precision(void)            { RUN(verifier_precision); }
 void test_verifier_prevent_map_lookup(void)   { RUN(verifier_prevent_map_lookup); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_nocsr.c b/tools/testing/selftests/bpf/progs/verifier_nocsr.c
new file mode 100644
index 000000000000..a7fe277e5167
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_nocsr.c
@@ -0,0 +1,796 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+SEC("raw_tp")
+__arch_x86_64
+__log_level(4) __msg("stack depth 8")
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
+__log_level(4) __msg("stack depth 16")
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
+/* patched, spills for -24, -32 removed */
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
+	"*(u64 *)(r10 - 24) = r1;"
+	"*(u64 *)(r10 - 32) = r2;"
+	"call %[bpf_get_smp_processor_id];"
+	"r2 = *(u64 *)(r10 - 32);"
+	"r1 = *(u64 *)(r10 - 24);"
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
+__xlated("1: *(u64 *)(r10 -8) = r1")
+__xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("5: r1 = *(u64 *)(r10 -8)")
+__success
+__naked void bad_helper_write(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	/* nocsr pattern with stack offset -8 */
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"r1 = r10;"
+	"r1 += -8;"
+	"r2 = 1;"
+	"r3 = 42;"
+	/* read dst is fp[-8], thus nocsr rewrite not applied */
+	"call %[bpf_probe_read_kernel];"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id),
+	  __imm(bpf_probe_read_kernel)
+	: __clobber_all);
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
+SEC("raw_tp")
+__arch_x86_64
+__log_level(4) __msg("stack depth 8")
+__xlated("2: r0 = &(void __percpu *)(r0)")
+__success
+__naked void helper_call_does_not_prevent_nocsr(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_prandom_u32];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__log_level(4) __msg("stack depth 16")
+/* may_goto counter at -16 */
+__xlated("0: *(u64 *)(r10 -16) =")
+__xlated("1: r1 = 1")
+__xlated("3: r0 = &(void __percpu *)(r0)")
+/* may_goto expansion starts */
+__xlated("5: r11 = *(u64 *)(r10 -16)")
+__xlated("6: if r11 == 0x0 goto pc+3")
+__xlated("7: r11 -= 1")
+__xlated("8: *(u64 *)(r10 -16) = r11")
+/* may_goto expansion ends */
+__xlated("9: *(u64 *)(r10 -8) = r1")
+__xlated("10: exit")
+__success
+__naked void may_goto_interaction(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 16);"
+	".8byte %[may_goto];"
+	/* just touch some stack at -8 */
+	"*(u64 *)(r10 - 8) = r1;"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id),
+	  __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, +1 /* offset */, 0))
+	: __clobber_all);
+}
+
+__used
+__naked static void dummy_loop_callback(void)
+{
+	asm volatile (
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__log_level(4) __msg("stack depth 32+0")
+__xlated("2: r1 = 1")
+__xlated("3: w0 =")
+__xlated("4: r0 = &(void __percpu *)(r0)")
+__xlated("5: r0 = *(u32 *)(r0 +0)")
+/* bpf_loop params setup */
+__xlated("6: r2 =")
+__xlated("7: r3 = 0")
+__xlated("8: r4 = 0")
+/* ... part of the inlined bpf_loop */
+__xlated("12: *(u64 *)(r10 -32) = r6")
+__xlated("13: *(u64 *)(r10 -24) = r7")
+__xlated("14: *(u64 *)(r10 -16) = r8")
+/* ... */
+__xlated("21: call pc+8") /* dummy_loop_callback */
+/* ... last insns of the bpf_loop_interaction1 */
+__xlated("28: r0 = 0")
+__xlated("29: exit")
+/* dummy_loop_callback */
+__xlated("30: r0 = 0")
+__xlated("31: exit")
+__success
+__naked int bpf_loop_interaction1(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	/* nocsr stack region at -16, but could be removed */
+	"*(u64 *)(r10 - 16) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 16);"
+	"r2 = %[dummy_loop_callback];"
+	"r3 = 0;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_ptr(dummy_loop_callback),
+	  __imm(bpf_get_smp_processor_id),
+	  __imm(bpf_loop)
+	: __clobber_common
+	);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__log_level(4) __msg("stack depth 40+0")
+/* call bpf_get_smp_processor_id */
+__xlated("2: r1 = 42")
+__xlated("3: w0 =")
+__xlated("4: r0 = &(void __percpu *)(r0)")
+__xlated("5: r0 = *(u32 *)(r0 +0)")
+/* call bpf_get_prandom_u32 */
+__xlated("6: *(u64 *)(r10 -16) = r1")
+__xlated("7: call")
+__xlated("8: r1 = *(u64 *)(r10 -16)")
+/* ... */
+/* ... part of the inlined bpf_loop */
+__xlated("15: *(u64 *)(r10 -40) = r6")
+__xlated("16: *(u64 *)(r10 -32) = r7")
+__xlated("17: *(u64 *)(r10 -24) = r8")
+__success
+__naked int bpf_loop_interaction2(void)
+{
+	asm volatile (
+	"r1 = 42;"
+	/* nocsr stack region at -16, cannot be removed */
+	"*(u64 *)(r10 - 16) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 16);"
+	"*(u64 *)(r10 - 16) = r1;"
+	"call %[bpf_get_prandom_u32];"
+	"r1 = *(u64 *)(r10 - 16);"
+	"r2 = %[dummy_loop_callback];"
+	"r3 = 0;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_ptr(dummy_loop_callback),
+	  __imm(bpf_get_smp_processor_id),
+	  __imm(bpf_get_prandom_u32),
+	  __imm(bpf_loop)
+	: __clobber_common
+	);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__log_level(4)
+__msg("stack depth 512+0")
+/* just to print xlated version when debugging */
+__xlated("r0 = &(void __percpu *)(r0)")
+__success
+/* cumulative_stack_depth() stack usage is MAX_BPF_STACK,
+ * called subprogram uses an additional slot for nocsr spill/fill,
+ * since nocsr spill/fill could be removed the program still fits
+ * in MAX_BPF_STACK and should be accepted.
+ */
+__naked int cumulative_stack_depth(void)
+{
+	asm volatile(
+	"r1 = 42;"
+	"*(u64 *)(r10 - %[max_bpf_stack]) = r1;"
+	"call cumulative_stack_depth_subprog;"
+	"exit;"
+	:
+	: __imm_const(max_bpf_stack, MAX_BPF_STACK)
+	: __clobber_all
+	);
+}
+
+__used
+__naked static void cumulative_stack_depth_subprog(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"exit;"
+	:: __imm(bpf_get_smp_processor_id) : __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__log_level(4)
+__msg("stack depth 512")
+__xlated("0: r1 = 42")
+__xlated("1: *(u64 *)(r10 -512) = r1")
+__xlated("2: w0 = ")
+__xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("4: r0 = *(u32 *)(r0 +0)")
+__xlated("5: exit")
+__success
+__naked int nocsr_max_stack_ok(void)
+{
+	asm volatile(
+	"r1 = 42;"
+	"*(u64 *)(r10 - %[max_bpf_stack]) = r1;"
+	"*(u64 *)(r10 - %[max_bpf_stack_8]) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - %[max_bpf_stack_8]);"
+	"exit;"
+	:
+	: __imm_const(max_bpf_stack, MAX_BPF_STACK),
+	  __imm_const(max_bpf_stack_8, MAX_BPF_STACK + 8),
+	  __imm(bpf_get_smp_processor_id)
+	: __clobber_all
+	);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__log_level(4)
+__msg("stack depth 520")
+__failure
+__naked int nocsr_max_stack_fail(void)
+{
+	asm volatile(
+	"r1 = 42;"
+	"*(u64 *)(r10 - %[max_bpf_stack]) = r1;"
+	"*(u64 *)(r10 - %[max_bpf_stack_8]) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - %[max_bpf_stack_8]);"
+	/* call to prandom blocks nocsr rewrite */
+	"*(u64 *)(r10 - %[max_bpf_stack_8]) = r1;"
+	"call %[bpf_get_prandom_u32];"
+	"r1 = *(u64 *)(r10 - %[max_bpf_stack_8]);"
+	"exit;"
+	:
+	: __imm_const(max_bpf_stack, MAX_BPF_STACK),
+	  __imm_const(max_bpf_stack_8, MAX_BPF_STACK + 8),
+	  __imm(bpf_get_smp_processor_id),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all
+	);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.45.2


