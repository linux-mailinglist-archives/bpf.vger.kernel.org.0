Return-Path: <bpf+bounces-42958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6069AD64E
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 23:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9FCC1F264CB
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 21:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DAC1D5AA4;
	Wed, 23 Oct 2024 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="EY9dkfJL"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B161CC144
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717529; cv=none; b=FefMY78nnDCScJiB9m91kzFOq8rS5gik7rDYRe5oklVXUImwnz9JyPOSmMn6Rn+5dYUv9jeJl3+yRRNoi52C8p1uWTZ+M5tKaNJPXcpVeHkGesvE9ofRZjIP9HhcbxYgsZHm+c+Zll4paHljI6xcLnfs6C+aUHLPctR0bgsmJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717529; c=relaxed/simple;
	bh=xNUms87J8/U9w0QWf3DzfP8zCm2vbBgYW7raZOt9oGQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDVM66hqlW8wblpHgICKhJbIqkiJ6d+iDYFgcbuOFoxVuNjLwACJBAYSxNBQEpe3gOJPM4/R9CSNz2MSu+rDEQbguOhqbhqWMrKtPC/LrIVyUI4t4XyerWIu5kmfdGFWtWpYFhB92vbvP3bq5TvmMVEp+fZJPFxTLAcD6oqh1Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=EY9dkfJL; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NJHkhJ002240;
	Wed, 23 Oct 2024 14:04:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=aqyde/dI21Fn15odZvW6ISsyNpaWRPc8ZXFh1tVuE3M=; b=EY9dkfJLCk1m
	edHIE5HUkk6bvefCLfMegH8mW+BHP1yikrFDyCzhWkcCaHI8HAbz5sATn4bNtiel
	qqe0Vhax0TO6IufqBrY5o7pprqBwtte0OrWmjqaxxgo+YXRqzSH0kSBMqnf6L80w
	KTd1CQDjiyXBxcFuZ06uRH1pXqGXUke+cgdCYgChYvQSAbXwnGFlP/f2PDmRJEx1
	mcdiTO9envqbkFHqR6Qdu+agC+KQODL8QfbTNNuOYJ18OUdnjyJEgvGf6TlJhEjx
	7tzZh1xlEAZuZKqynR0RVSQsq1XK6u2hYy5qIsWzJOmHw7dqE2fRSHcOLVLZEmNJ
	BqDIOs1hqQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42f6mph4sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 23 Oct 2024 14:04:52 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Wed, 23 Oct 2024 21:04:50 +0000
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: add selftest to check rdtsc jit
Date: Wed, 23 Oct 2024 14:04:37 -0700
Message-ID: <20241023210437.2266063-2-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241023210437.2266063-1-vadfed@meta.com>
References: <20241023210437.2266063-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 0Za3wQNG2Nat_krfHVggCd8YB3qCk7kG
X-Proofpoint-ORIG-GUID: 0Za3wQNG2Nat_krfHVggCd8YB3qCk7kG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

get_hw_counter() is replaced with rdtsc instruction on x86_64. Add
tests to check it.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_rdtsc.c      | 63 +++++++++++++++++++
 2 files changed, 65 insertions(+)
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
index 000000000000..2cc52a1c4ca0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_rdtsc.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Inc. */
+#include "vmlinux.h"
+// #include <time.h>
+// #include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+//u64 g1 =0, g2 = 0, g3 = 0;
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
+
+void rdtsc(void)
+{
+	bpf_get_hw_counter();
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.5


