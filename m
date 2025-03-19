Return-Path: <bpf+bounces-54390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 027F2A6951B
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 17:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0CD19C2F03
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 16:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06151DF738;
	Wed, 19 Mar 2025 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="H30VXEHj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BE61DE3A3
	for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402282; cv=none; b=g3jEcJgW2m4HMWWI4GiQNFSHBeQnm2LIWTp5X34v5R0HeEs/UlsI382ty2945cvoVapZeFL4Jpm6vTS2uH8UVgUFn7JqAbPFdQ/or5OuwGO82PaS4S7csxjiGMH7qT8sM+IcAI9TFDs/rtPd8v1PjTAjYKhPvhrVUcwiilkQ8dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402282; c=relaxed/simple;
	bh=dJnPrBaNWDajEGZjANm7VHYNZwzO2MZUg2YsF82+9I4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMzebCjMx9ElUJyFdx0hmgtMUbglohtvyPsE4UwI4B9ftIhwUm/GATayGIPZAVcTy2/ZGRQYGqS3Tmrn+yjv3ISG36ErNKw8cBTSNp0HhjeDFJXVJo4pzrHENEvzVXDI5wvQ0TvKZ1ljSzeFSt0t637O7TXF1cqbRTi/YBy9v04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=H30VXEHj; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 52JGCVZ1020382;
	Wed, 19 Mar 2025 09:37:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=ZXqfrRQJLQ6WxpJ9Z049ew42YD1XhBNSedrcZPMBwBI=; b=H30VXEHj61La
	rLQne1SUbHIf2w/cyI2HhrMcKZBnVyorS/9hsswaTKxUw6K6tf5NbZ3AS8Wcz9tF
	gvgt7tG0g27U0SWngXFRsJsHp/RU8Y0mV78aeXFodpVgUJq9LZKmh1ZwH6I0K6Mq
	pG0JLtnFlmLAQWxmyzTnDnfgBGFDwkXptbHVDVVv4HMhUjk78UPvEIE/TqTKJ6cz
	aUgqN3iiLiDTBfBtbBvQewnOP9Z7RB6O4cKw8XENxzhhtbMjtqUs8Gx0VbDmb0zw
	2tVVeUusu2s+BJhws+h1PcXwsCkKy5wy01VpomUSWGfSxReacCy+cFtkPy0blQQw
	DVFdHotHgg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 45fn4mmb9n-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 19 Mar 2025 09:37:25 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.14; Wed, 19 Mar 2025 16:36:52 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yonghong Song <yonghong.song@linux.dev>,
        Vadim Fedorenko
	<vadim.fedorenko@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>
CC: <x86@kernel.org>, <bpf@vger.kernel.org>,
        Peter Zijlstra
	<peterz@infradead.org>,
        Vadim Fedorenko <vadfed@meta.com>,
        Martin KaFai Lau
	<martin.lau@linux.dev>
Subject: [PATCH bpf-next v12 4/5] selftests/bpf: add selftest to check bpf_get_cpu_time_counter jit
Date: Wed, 19 Mar 2025 09:36:37 -0700
Message-ID: <20250319163638.3607043-5-vadfed@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319163638.3607043-1-vadfed@meta.com>
References: <20250319163638.3607043-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: peQiA4MhotkHidMPfRzbRz4U_Rf2UT58
X-Proofpoint-GUID: peQiA4MhotkHidMPfRzbRz4U_Rf2UT58
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01

bpf_get_cpu_time_counter() is replaced with rdtsc instruction on x86_64.
Add tests to check that JIT works as expected. When JIT is not
supported, bpf_cpu_time_counter_to_ns() can be inlined by verifier.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_cpu_cycles.c | 120 ++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index e66a57970d28..d5e7e302a344 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -102,6 +102,7 @@
 #include "verifier_xdp_direct_packet_access.skel.h"
 #include "verifier_bits_iter.skel.h"
 #include "verifier_lsm.skel.h"
+#include "verifier_cpu_cycles.skel.h"
 #include "irq.skel.h"
 
 #define MAX_ENTRIES 11
@@ -236,6 +237,7 @@ void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
 void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
 void test_irq(void)			      { RUN(irq); }
 void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
+void test_verifier_cpu_cycles(void)	      { RUN(verifier_cpu_cycles); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c b/tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c
new file mode 100644
index 000000000000..26c02010ccf1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Inc. */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+extern u64 bpf_cpu_time_counter_to_ns(u64 cycles) __weak __ksym;
+extern u64 bpf_get_cpu_time_counter(void) __weak __ksym;
+
+SEC("syscall")
+__arch_x86_64
+__xlated("0: call kernel-function")
+__naked int bpf_rdtsc(void)
+{
+	asm volatile(
+	"call %[bpf_get_cpu_time_counter];"
+	"exit"
+	:
+	: __imm(bpf_get_cpu_time_counter)
+	: __clobber_all
+	);
+}
+
+SEC("syscall")
+__arch_x86_64
+/* program entry for bpf_rdtsc_jit_x86_64(), regular function prologue */
+__jited("	endbr64")
+__jited("	nopl	(%rax,%rax)")
+__jited("	nopl	(%rax)")
+__jited("	pushq	%rbp")
+__jited("	movq	%rsp, %rbp")
+__jited("	endbr64")
+/* save RDX in R11 as it will be overwritten */
+__jited("	movq	%rdx, %r11")
+/* lfence may not be executed depending on cpu features */
+__jited("	{{(lfence|)}}")
+__jited("	rdtsc")
+/* combine EDX:EAX into RAX */
+__jited("	shlq	${{(32|0x20)}}, %rdx")
+__jited("	orq	%rdx, %rax")
+/* restore RDX from R11 */
+__jited("	movq	%r11, %rdx")
+__jited("	leave")
+__naked int bpf_rdtsc_jit_x86_64(void)
+{
+	asm volatile(
+	"call %[bpf_get_cpu_time_counter];"
+	"exit"
+	:
+	: __imm(bpf_get_cpu_time_counter)
+	: __clobber_all
+	);
+}
+
+SEC("syscall")
+__arch_arm64
+__xlated("0: r1 = 42")
+__xlated("1: r0 = r1")
+__naked int bpf_cyc2ns_arm(void)
+{
+	asm volatile(
+	"r1=0x2a;"
+	"call %[bpf_cpu_time_counter_to_ns];"
+	"exit"
+	:
+	: __imm(bpf_cpu_time_counter_to_ns)
+	: __clobber_all
+	);
+}
+
+SEC("syscall")
+__arch_x86_64
+__xlated("0: r1 = 42")
+__xlated("1: call kernel-function")
+__naked int bpf_cyc2ns(void)
+{
+	asm volatile(
+	"r1=0x2a;"
+	"call %[bpf_cpu_time_counter_to_ns];"
+	"exit"
+	:
+	: __imm(bpf_cpu_time_counter_to_ns)
+	: __clobber_all
+	);
+}
+
+SEC("syscall")
+__arch_x86_64
+/* program entry for bpf_rdtsc_jit_x86_64(), regular function prologue */
+__jited("	endbr64")
+__jited("	nopl	(%rax,%rax)")
+__jited("	nopl	(%rax)")
+__jited("	pushq	%rbp")
+__jited("	movq	%rsp, %rbp")
+__jited("	endbr64")
+/* save RDX in R11 as it will be overwritten */
+__jited("	movabsq	$0x2a2a2a2a2a, %rdi")
+__jited("	imulq	${{.*}}, %rdi, %rax")
+__jited("	shrq	${{.*}}, %rax")
+__jited("	leave")
+__naked int bpf_cyc2ns_jit_x86(void)
+{
+	asm volatile(
+	"r1=0x2a2a2a2a2a ll;"
+	"call %[bpf_cpu_time_counter_to_ns];"
+	"exit"
+	:
+	: __imm(bpf_cpu_time_counter_to_ns)
+	: __clobber_all
+	);
+}
+
+void rdtsc(void)
+{
+	bpf_get_cpu_time_counter();
+	bpf_cpu_time_counter_to_ns(42);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.1


