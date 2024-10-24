Return-Path: <bpf+bounces-43103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C1C9AF417
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F0A1C21977
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 20:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2066216A3E;
	Thu, 24 Oct 2024 20:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ajdBMnkJ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2D5215025
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803123; cv=none; b=QyzwqpH0sfugR5VhyFB+We7MJQTr1bh15tXYp80G1rEYuAB7Sd8YJ+CNS+3BPEL7eAilkd2OL/2Iv1ha/FhTXs6stLFN4iywlwJ0Tjwd4yNvUG0Tl/oHifE7OVhR9OtZdBFDp2dDz3M2/r2RLJfD3UTFgUbDRWIfwsl/CMVDY0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803123; c=relaxed/simple;
	bh=4aq8cAmOOLThn0ZG8gC0BkUwc7X+p1kAoghsmHej8NU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fe8gsJ6SEqGpwBIya/uhExpxBw1+h4Hwv7tuKyBSgjnRaygefmOLBDlOm+zyJB7hvtygV50Rq0H6yeXl0sJLeTWeFcTFvXbx9YkVDq08w20/UI2OVGJ0oKAllEmYZ5qejhuIASFOhqzHNrJS6UOb7U63FrfcNQdcc3FBXP/slWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ajdBMnkJ; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 49OJxs74017583;
	Thu, 24 Oct 2024 13:51:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=iSt+bq47JyAtkvMpw1+k5sDlCLQHwMmThOfOCD6wEb4=; b=ajdBMnkJ8J+a
	eRmb51fRCY/BuAFPzI7cujmq4RynRunzNNdkpDeZhkxjAfbZ5E/Kkpg7VNhoICXv
	Lp8Vf+1Ae8NlVoodG3krVLPZWjT8cTP4mlAfZSyX/qU66haHclGSkw8pgZZr/m/y
	hJt3VGVKXl/v/nFtUfiPtC/QktYR+9oTFFEvdBwoScah7WFFAuknhUyFkw6O2EnV
	59YfqHadNCZFY7uUb9tVhFrAQ7933ZgehRoe7PUBUtIqDi//mKN+cAnaxDPWaQxA
	F4rNg6ugCIaaTsizWlnlmhA4yrIOhJrVECyqwJogzWi4SQ0hfLrI/Uwq+it6PKxl
	A5c/YPWmvQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 42fubcs74u-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 24 Oct 2024 13:51:30 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 24 Oct 2024 20:51:21 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman
	<eddyz87@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vadim Fedorenko
	<vadim.fedorenko@linux.dev>
CC: <x86@kernel.org>, <bpf@vger.kernel.org>, Vadim Fedorenko <vadfed@meta.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: add selftest to check rdtsc jit
Date: Thu, 24 Oct 2024 13:51:13 -0700
Message-ID: <20241024205113.762622-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241024205113.762622-1-vadfed@meta.com>
References: <20241024205113.762622-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: kw7rHJLHCMtMxvD0mHZSERisz7YsuwfK
X-Proofpoint-GUID: kw7rHJLHCMtMxvD0mHZSERisz7YsuwfK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

get_hw_counter() is replaced with rdtsc instruction on x86_64. Add
tests to check it.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_rdtsc.c      | 58 +++++++++++++++++++
 2 files changed, 60 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_rdtsc.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index e26b5150fc43..cf7417465010 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -95,6 +95,7 @@
 #include "verifier_xdp_direct_packet_access.skel.h"
 #include "verifier_bits_iter.skel.h"
 #include "verifier_lsm.skel.h"
+#include "verifier_rdtsc.skel.h"
 
 #define MAX_ENTRIES 11
 
@@ -220,6 +221,7 @@ void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
 void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_packet_access); }
 void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
 void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
+void test_verifier_rdtsc(void)                { RUN(verifier_rdtsc); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_rdtsc.c b/tools/testing/selftests/bpf/progs/verifier_rdtsc.c
new file mode 100644
index 000000000000..cfce4172c9ab
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_rdtsc.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Inc. */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+SEC("syscall")
+__arch_x86_64
+__xlated("0: call kernel-function")
+__naked int bpf_rdtsc(void)
+{
+	asm volatile(
+	"call %[bpf_get_hw_counter];"
+	"exit"
+	:
+	: __imm(bpf_get_hw_counter)
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
+	"call %[bpf_get_hw_counter];"
+	"exit"
+	:
+	: __imm(bpf_get_hw_counter)
+	: __clobber_all
+	);
+}
+
+void rdtsc(void)
+{
+	bpf_get_hw_counter();
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.5


