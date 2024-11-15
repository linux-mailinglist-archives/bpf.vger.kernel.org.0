Return-Path: <bpf+bounces-44982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9879CF541
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 20:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E4E2815E8
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 19:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBE61E282C;
	Fri, 15 Nov 2024 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HCD6Pozk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36201E2825
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700162; cv=none; b=PKWTu1fbyDs+pqxHDnJv+SN5qVXmmD+GC1gk2+GsKy0jIIP9GelEhHyNjcYdn6wAgK6+PeYG09sKEp0cymNLhBx1Mzsnl45M01b5/QAGDzsZm7cKRYmsMqYd5NLKhCUFO38Ru0jUIaQObtjigZb9diIN1xSHr2I8CypXO7ng2jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700162; c=relaxed/simple;
	bh=1LM3XQI/axhXguys4hdF1f+RdSsjelzNmHQYbDLQeA0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E5HiE34r7TbKUHJK5UtHYsS9RAE2D32BPK48+qrtbCqowGr229S872qrKmnR8jGrBka5C+9Iu203aVlZWV5DwPRAfwaoQ9sruc3i31qdHi5ABBeAkWyz7/6scFp+Hp/iBHod/Q3MSw0J4J7LoZ3llQuhRNxsKbTy+DE5H5xWELA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HCD6Pozk; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFIVHoH001670;
	Fri, 15 Nov 2024 11:48:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=2TGLFnlUSnezmRDeSMMl+ID1dDKmBatRzG5qVbv6ayo=; b=HCD6Pozk6m1J
	WWzA5wr8Hi6Uuv2SIR2fqSmZenYZIPCVCYUi8XHQCASEiyBXuZI9RvsXeaFGBMVZ
	AaoWGnONmwIBPmCqNF1muf50Mwt2TZH+FXLi8GElS53BMAUFAbrzlFEkjeCrG2dm
	qA8jcuJkKc5NJzBxRIdYjnqCO+g+x/HA7GHFJsRdoJyr5c+uPgTB5SHR9iq18Qng
	saOmngfTyRnw7djW6B8trx8Ro3FThTrLfd531r4LbnDC6A8ctX6L7A3D/jBb8U1a
	eNfPG60sMFLHhOSOqzH4NZedCDgCfxJP437bQEKeSjYv9qoax2AYc5AhsbxTU2en
	iLl2pzuymg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42x6cmk29d-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 15 Nov 2024 11:48:54 -0800 (PST)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Fri, 15 Nov 2024 19:48:52 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman
	<eddyz87@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vadim Fedorenko
	<vadim.fedorenko@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>
CC: <x86@kernel.org>, <bpf@vger.kernel.org>,
        Vadim Fedorenko
	<vadfed@meta.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v6 3/4] selftests/bpf: add selftest to check rdtsc jit
Date: Fri, 15 Nov 2024 11:48:40 -0800
Message-ID: <20241115194841.2108634-4-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241115194841.2108634-1-vadfed@meta.com>
References: <20241115194841.2108634-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: tCAGgfrQRu85o9Yco-Zd8oDDrFADUtdd
X-Proofpoint-ORIG-GUID: tCAGgfrQRu85o9Yco-Zd8oDDrFADUtdd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

get_cpu_cycles() is replaced with rdtsc instruction on x86_64. Add
tests to check it.

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
index 000000000000..88bfa7211858
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
+extern u64 bpf_cpu_cycles_to_ns(u64 cycles) __weak __ksym;
+extern u64 bpf_get_cpu_cycles(void) __weak __ksym;
+
+SEC("syscall")
+__arch_x86_64
+__xlated("0: call kernel-function")
+__naked int bpf_rdtsc(void)
+{
+	asm volatile(
+	"call %[bpf_get_cpu_cycles];"
+	"exit"
+	:
+	: __imm(bpf_get_cpu_cycles)
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
+	"call %[bpf_get_cpu_cycles];"
+	"exit"
+	:
+	: __imm(bpf_get_cpu_cycles)
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
+	"call %[bpf_cpu_cycles_to_ns];"
+	"exit"
+	:
+	: __imm(bpf_cpu_cycles_to_ns)
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
+	"call %[bpf_cpu_cycles_to_ns];"
+	"exit"
+	:
+	: __imm(bpf_cpu_cycles_to_ns)
+	: __clobber_all
+	);
+}
+
+void rdtsc(void)
+{
+	bpf_get_cpu_cycles();
+	bpf_cpu_cycles_to_ns(42);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.5


