Return-Path: <bpf+bounces-53142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90CCA4CFF3
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 01:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D851896AFB
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 00:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797002AD25;
	Tue,  4 Mar 2025 00:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqJvlUqU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9D1847C
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 00:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048367; cv=none; b=LYSBP/rpw3Un26ATj+VCqp8XqUwBu7tyVjPcv4R8Jm0DH1IDNhGsBXjuBRCgvtBfBkWBkSiDqq6RgTeu+g5EbSg+BTAuyjBoIi0o+pnUIerOPJE2Q8xivvevrRtHupRl6cEZmLUJ6nuUiffhmCREVRkjDGfBaNtlTO9oHywpixk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048367; c=relaxed/simple;
	bh=qFoOCPGc8iCvWU53V6BGSxuE+vZSEASH2Zz/8y+fz5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEqWLfTyOCoEwkBWpF3LRXOirNc0SNMszDowd/AnCbgQIQSRUkjdq0bR3KhU2KktmHzLWSxSeIzXwfdTH9dAufO9+Yc9pC4rr1IcnMj/jThrL37MMTHW3eWdMB/jCrVr/DI2hYD/fXQC4j1WI00DBx+x+8pc3jUVw5rDa85EkI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqJvlUqU; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4394036c0efso32391605e9.2
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 16:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741048364; x=1741653164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eh0+1guvjX8NMrmS2ddf3cUxBdk6rSfM9jrmWQa5LEI=;
        b=LqJvlUqUqERdyCfr0sLzz/tbyLOPC8NLRKiRiNkP3jdnYd+iK3gaWfuqbaI7hPlLSx
         6JmVPUrMdEIwSN1FfjO+XhOj87QZbQgytX8MOtbtF5celszyEIK9Kupae6/doDeLeag0
         2RXclsrXRvsY839VBLhjHkws2EzOVqN0OzrN6Ql+5g3pvlsDRyO/ZNErxSnXYszy/30l
         FhgtOTio5LOejudrj+ZCIbpfyn33RySC2TnJEIAkP2KrUdcWs9VEw0OwlzyDXG8hNRx8
         qlpKZ1IVw7akqoj7S8nndOqB20+LZkgWYUwNUbwFQeoB1oZi+ky5YOX2pdCI2IIVNyCP
         HMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048364; x=1741653164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eh0+1guvjX8NMrmS2ddf3cUxBdk6rSfM9jrmWQa5LEI=;
        b=HaFk1u50hVShzLgbqddc5UX5p15rrkqNSzwZ1bp2ga4k8NkClxp5J6R50oHEAsXqbR
         O/sNSbdIMCSgBPKrBeqPD/a/eh0KoO0D7flTo/jhlk8m4RZVlOmROWhU+Ekaw32awpZ5
         IqXRwcBzTUtCsH3D1hQ/U4GU+8cA/B+b2bD+n/9p6snlLjatGWb4Uxmq3VGvb6kFxMHo
         Ne8uLvVgM1LnICpUVOZmZqQrRXUqYgADbuy8pV9T2JbyQyHeM8Qq59N9ipY2v92a6WNI
         GemjKIrAeR302mo87vTzLBMeXiCNsb1zZut0xUHymYg0WmX7Y1M6ZHhnwjyqB7AS05zq
         HPRA==
X-Gm-Message-State: AOJu0YwVSrVwgSlYFAlB6vewLoG9Ev3LOYK2BeYA8RHMlmB/BirJp55d
	+5MduYsmOXEiZJ2m8IKicB5CTjG/5ly2EoF72abIrtZappAdxNMV5cLuUVslBWQ=
X-Gm-Gg: ASbGnctOaAC6834BGHgQLxj0WRPkZJEtXGQhuDn/S71QXs5PUc+/4HMDKwzHN6aj9mV
	FARFTP8N97ECK1sYJWTMy3i8P1g3zsuXyQGOslwdezHxGvXTVk1Aa6V5R6wo2p51BHJ5X8WFKi5
	XJEOg0fEqSONJA2/UKPP/RqC2iW6iAdkYXT+/0t0lP87/FCwfIdg9IY4+kwshnww3fxpKmdGo2r
	67rg3vt4QKJ/NIAqV9Rw0yrfckrIpnC87Nl1y5suVCzLbwyTnlHVOoXBcioVJQ93Bs1cMRMXTvj
	9+vmxD1CTYro1TCw7tnKOub1b5L6qm4YdQ==
X-Google-Smtp-Source: AGHT+IFBhR4Mh3u8mACWR77I/JdochbxraU1gDrIg8YPa+a8yQXnyV6RdJ8ndWKhX3kqkBj1rUNYkA==
X-Received: by 2002:a5d:6da3:0:b0:38f:3ee0:7012 with SMTP id ffacd0b85a97d-390ec7c925fmr13010863f8f.3.1741048363530;
        Mon, 03 Mar 2025 16:32:43 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:5::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6ce3sm15644223f8f.43.2025.03.03.16.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:32:42 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/2] bpf, x86: Add x86 JIT support for timed may_goto
Date: Mon,  3 Mar 2025 16:32:39 -0800
Message-ID: <20250304003239.2390751-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250304003239.2390751-1-memxor@gmail.com>
References: <20250304003239.2390751-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7414; h=from:subject; bh=qFoOCPGc8iCvWU53V6BGSxuE+vZSEASH2Zz/8y+fz5A=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxklfCrYSS08GUx73vZQrNsJg+Ng3SW8mGh4HZaSN pp2r1aSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8ZJXwAKCRBM4MiGSL8RyppGD/ 48xRErrDJHJR5NL1WaabNqEKls596mNr3kiLBqu6Lh7Ym3MoH1z1oDnoFGbhxFL/Y56bq2rDyLK/Aj g7d4qSp9gpiK78hB7LF/qvuyNNe0l8R9GnoI3/Exe8qpIkqJtpIjgybuLPq3hcOgt6RYF0AIpyVv1u ow/xYVIr01omDmnCUGsFLZLjEDG7W9Sm5JvGkmOWAPODa0KxTLUrjeWlWXmtxPukmMFMU5E31pe4SH FNPFSdLTIs8+bF1iutM0AbNUEhHbObFO79CTQPNno4t7n6nlctfiidQgHCAhHR+tNC6aWO4dLBmwlb FzG1fmWy8iXJt450gfTVzOIAEbEV2V/VwcJRemgP4twpqwye6JR3KbUFVF8Kl/pJDwBSZZjj0rM2zd mV44S9Xe032pOL8Uvsmx6PInGaCPwTqM0DEjCyRy9YjC2lEvsCnvSmrA5riseEAznFsbG/mG/l9cV6 boxKJUvXA6W+PKDfJjsk9RV5xIhBmUFMp5r3s0eaJAV3iJ23sY3fGnTStK+9GCSBKVXg3WQteBcufH LMHn2z6yUDga+C6b5hYCFD55+HkP/zMjJQ3GetmP1qePekXAt836g0Ka0J3zJeSbA9fQMExs12syFp Vj4Lb22vrjxmveMumdcLsZyncm6yL3t0x+wgixIJ/X4z5hfC8IKOxYYriDiw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Implement the arch_bpf_timed_may_goto function using inline assembly to
have control over which registers are spilled, and use our special
protocol of using BPF_REG_AX as an argument into the function, and as
the return value when going back.

Emit call depth accounting for the call made from this stub, and ensure
we don't have naked returns (when rethunk mitigations are enabled) by
falling back to the RET macro (instead of retq). After popping all saved
registers, the return address into the BPF program should be on top of
the stack.

Since the JIT support is now enabled, ensure selftests which are
checking the produced may_goto sequences do not break by adjusting them.
Make sure we still test the old may_goto sequence on other
architectures, while testing the new sequence on x86_64.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/Makefile                         |  2 +-
 arch/x86/net/bpf_jit_comp.c                   |  5 ++
 arch/x86/net/bpf_timed_may_goto.S             | 52 +++++++++++++++++
 .../bpf/progs/verifier_bpf_fastcall.c         | 58 +++++++++++++++----
 .../selftests/bpf/progs/verifier_may_goto_1.c | 34 ++++++++++-
 5 files changed, 138 insertions(+), 13 deletions(-)
 create mode 100644 arch/x86/net/bpf_timed_may_goto.S

diff --git a/arch/x86/net/Makefile b/arch/x86/net/Makefile
index 383c87300b0d..dddbefc0f439 100644
--- a/arch/x86/net/Makefile
+++ b/arch/x86/net/Makefile
@@ -6,5 +6,5 @@
 ifeq ($(CONFIG_X86_32),y)
         obj-$(CONFIG_BPF_JIT) += bpf_jit_comp32.o
 else
-        obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o
+        obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o bpf_timed_may_goto.o
 endif
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a43fc5af973d..f3e9ef6b5329 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3791,3 +3791,8 @@ u64 bpf_arch_uaddress_limit(void)
 {
 	return 0;
 }
+
+bool bpf_jit_supports_timed_may_goto(void)
+{
+	return true;
+}
diff --git a/arch/x86/net/bpf_timed_may_goto.S b/arch/x86/net/bpf_timed_may_goto.S
new file mode 100644
index 000000000000..547140ebcd10
--- /dev/null
+++ b/arch/x86/net/bpf_timed_may_goto.S
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/export.h>
+#include <linux/linkage.h>
+#include <asm/nospec-branch.h>
+
+	.code64
+	.section .text, "ax"
+
+SYM_FUNC_START(arch_bpf_timed_may_goto)
+	ANNOTATE_NOENDBR
+
+	/*
+	 * Save r0-r5.
+	 */
+	pushq %rax
+	pushq %rdi
+	pushq %rsi
+	pushq %rdx
+	pushq %rcx
+	pushq %r8
+
+	/*
+	 * r10 passes us stack depth, load the pointer to count and timestamp as
+	 * first argument to the call below.
+	 */
+	leaq (%rbp, %r10, 1), %rdi
+
+	/*
+	 * Emit call depth accounting for call below.
+	 */
+	CALL_DEPTH_ACCOUNT
+	call bpf_check_timed_may_goto
+
+	/*
+	 * BPF_REG_AX=r10 will be stored into count, so move return value to it.
+	 */
+	movq %rax, %r10
+
+	/*
+	 * Restore r5-r0.
+	 */
+	popq %r8
+	popq %rcx
+	popq %rdx
+	popq %rsi
+	popq %rdi
+	popq %rax
+
+	RET
+SYM_FUNC_END(arch_bpf_timed_may_goto)
diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index 5094c288cfd7..a9be6ae49454 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -620,23 +620,61 @@ __naked void helper_call_does_not_prevent_bpf_fastcall(void)
 
 SEC("raw_tp")
 __arch_x86_64
+__log_level(4) __msg("stack depth 24")
+/* may_goto counter at -24 */
+__xlated("0: *(u64 *)(r10 -24) =")
+/* may_goto timestamp at -16 */
+__xlated("1: *(u64 *)(r10 -16) =")
+__xlated("2: r1 = 1")
+__xlated("...")
+__xlated("4: r0 = &(void __percpu *)(r0)")
+__xlated("...")
+/* may_goto expansion starts */
+__xlated("6: r11 = *(u64 *)(r10 -24)")
+__xlated("7: if r11 == 0x0 goto pc+6")
+__xlated("8: r11 -= 1")
+__xlated("9: if r11 != 0x0 goto pc+2")
+__xlated("10: r11 = -24")
+__xlated("11: call unknown")
+__xlated("12: *(u64 *)(r10 -24) = r11")
+/* may_goto expansion ends */
+__xlated("13: *(u64 *)(r10 -8) = r1")
+__xlated("14: exit")
+__success
+__naked void may_goto_interaction_x86_64(void)
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
+SEC("raw_tp")
+__arch_arm64
 __log_level(4) __msg("stack depth 16")
 /* may_goto counter at -16 */
 __xlated("0: *(u64 *)(r10 -16) =")
 __xlated("1: r1 = 1")
-__xlated("...")
-__xlated("3: r0 = &(void __percpu *)(r0)")
-__xlated("...")
+__xlated("2: call bpf_get_smp_processor_id")
 /* may_goto expansion starts */
-__xlated("5: r11 = *(u64 *)(r10 -16)")
-__xlated("6: if r11 == 0x0 goto pc+3")
-__xlated("7: r11 -= 1")
-__xlated("8: *(u64 *)(r10 -16) = r11")
+__xlated("3: r11 = *(u64 *)(r10 -16)")
+__xlated("4: if r11 == 0x0 goto pc+3")
+__xlated("5: r11 -= 1")
+__xlated("6: *(u64 *)(r10 -16) = r11")
 /* may_goto expansion ends */
-__xlated("9: *(u64 *)(r10 -8) = r1")
-__xlated("10: exit")
+__xlated("7: *(u64 *)(r10 -8) = r1")
+__xlated("8: exit")
 __success
-__naked void may_goto_interaction(void)
+__naked void may_goto_interaction_arm64(void)
 {
 	asm volatile (
 	"r1 = 1;"
diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
index e81097c96fe2..3966d827f288 100644
--- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
@@ -69,8 +69,38 @@ __naked void may_goto_batch_1(void)
 }
 
 SEC("raw_tp")
-__description("may_goto batch with offsets 2/0")
+__description("may_goto batch with offsets 2/0 - x86_64")
 __arch_x86_64
+__xlated("0: *(u64 *)(r10 -16) = 65535")
+__xlated("1: *(u64 *)(r10 -8) = 0")
+__xlated("2: r11 = *(u64 *)(r10 -16)")
+__xlated("3: if r11 == 0x0 goto pc+6")
+__xlated("4: r11 -= 1")
+__xlated("5: if r11 != 0x0 goto pc+2")
+__xlated("6: r11 = -16")
+__xlated("7: call unknown")
+__xlated("8: *(u64 *)(r10 -16) = r11")
+__xlated("9: r0 = 1")
+__xlated("10: r0 = 2")
+__xlated("11: exit")
+__success
+__naked void may_goto_batch_2_x86_64(void)
+{
+	asm volatile (
+	".8byte %[may_goto1];"
+	".8byte %[may_goto3];"
+	"r0 = 1;"
+	"r0 = 2;"
+	"exit;"
+	:
+	: __imm_insn(may_goto1, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 2 /* offset */, 0)),
+	  __imm_insn(may_goto3, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 0 /* offset */, 0))
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__description("may_goto batch with offsets 2/0 - arm64")
+__arch_arm64
 __xlated("0: *(u64 *)(r10 -8) = 8388608")
 __xlated("1: r11 = *(u64 *)(r10 -8)")
 __xlated("2: if r11 == 0x0 goto pc+3")
@@ -80,7 +110,7 @@ __xlated("5: r0 = 1")
 __xlated("6: r0 = 2")
 __xlated("7: exit")
 __success
-__naked void may_goto_batch_2(void)
+__naked void may_goto_batch_2_arm64(void)
 {
 	asm volatile (
 	".8byte %[may_goto1];"
-- 
2.43.5


