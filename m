Return-Path: <bpf+bounces-45310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841499D44DF
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 01:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CEDD1F22843
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 00:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D854633F9;
	Thu, 21 Nov 2024 00:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DHGAzbeO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D2A33D8
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 00:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732148055; cv=none; b=gPFvj5jPch2ip3b5n0WCaSIZvOucmaZYoXLiq8lu4GMdYU+DsguLqlx50liY60OlWrM4wEtuJUsmv/QBVS9+/icmW72k7uBuRutgwnqQwMwJoiq0yGDKachrOeQ+ItmMg1/j/gTEwbw8c9kgxa7wxL31jgrWOyyMDEk0jjkGzhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732148055; c=relaxed/simple;
	bh=xUWr+0qkISItOBfwcoa9DwfYXWHED5wx8aS3483aOCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUIpGg1PfjmbgdK07t+yhCNdABr7lM3eyQ5D1k2AsGpeU449Zt4hcnlkYOi1UojpL0Qm3Y4Zs/OGolmSJaFaON2Gbf5uDe5cSpuzSEReeJTI4qamFeUbbJ53FJZ055PQnURsZCv+cVyu3FqjesHIpnlj1cOmA1tzlncrpl6BeeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DHGAzbeO; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKKZ2mZ001523;
	Wed, 20 Nov 2024 16:08:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=wf/D/EcSrogfjXEOCn36KW8Q4Mu2zhxdFqhFawT85go=; b=DHGAzbeOdwjS
	Ua+wPnPGLKcKFFATfyGwfZq6qUoKY/I/2KTMQ481FVuekkL/VDaPaWRjDJsFu384
	IPChgrtJCjTLBVBK/mkfpTL/QSq8Ye2ZZhaw8sDkfnjQ/VNMSpazrfEbjDsG1vxU
	d8MSsDhl+mtKfV9Vw2/DgOnQGBkB6Wc23r0XmYbAbA0ghsWGz6qFshujkO2DfAdT
	xYRBtPXiUDROiKyUOsvB6BodO6LCTxv1hF8Vov8G8aMiWutEp8N35aJE+DmSMzZk
	EYgKiknl3UePnwIbGbUhC4eKsShIOSXiLgCL4jxrPbVVDTPOHa2V7Rg26dzZq72G
	kMpC7v0myg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 431pxah760-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 20 Nov 2024 16:08:35 -0800 (PST)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 21 Nov 2024 00:08:31 +0000
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
Subject: [PATCH bpf-next v8 3/4] selftests/bpf: add selftest to check rdtsc jit
Date: Wed, 20 Nov 2024 16:08:13 -0800
Message-ID: <20241121000814.3821326-4-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241121000814.3821326-1-vadfed@meta.com>
References: <20241121000814.3821326-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xw_Xzz6g5Vl479w0CFqj7Q0ItZZXRhUW
X-Proofpoint-ORIG-GUID: xw_Xzz6g5Vl479w0CFqj7Q0ItZZXRhUW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

bpf_get_cpu_time_counter() is replaced with rdtsc instruction on x86_64.
Add tests to check it.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_cpu_cycles.c | 104 ++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index d9f65adb456b..6cbb8949164a 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -98,6 +98,7 @@
 #include "verifier_xdp_direct_packet_access.skel.h"
 #include "verifier_bits_iter.skel.h"
 #include "verifier_lsm.skel.h"
+#include "verifier_cpu_cycles.skel.h"
 
 #define MAX_ENTRIES 11
 
@@ -225,6 +226,7 @@ void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
 void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_packet_access); }
 void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
 void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
+void test_verifier_cpu_cycles(void)           { RUN(verifier_cpu_cycles); }
 
 void test_verifier_mtu(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c b/tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c
new file mode 100644
index 000000000000..5b62e3690362
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Inc. */
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
2.43.5


