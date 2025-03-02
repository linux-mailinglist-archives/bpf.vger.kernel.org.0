Return-Path: <bpf+bounces-53000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464DAA4B4A2
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 21:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D17016C9E3
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 20:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E3A1EDA28;
	Sun,  2 Mar 2025 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4rQtyaS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736D31EDA11
	for <bpf@vger.kernel.org>; Sun,  2 Mar 2025 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740946441; cv=none; b=XVjwvmYzPpzdl0DHKlP/CJeu8dVXL34aWLb5DRvHkA9thiOKcv8+nhxr6TA49FH6Nf++sKfWnW17rszm45QMJv2BOB+rAbaE83ycDVGuzMOjci25nsehPiblVH5YT7xkEwcnhR+cVOL2yLQHSdVX1Ql4u4G5qBtcdHjlgRqIvbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740946441; c=relaxed/simple;
	bh=BpThu9YEyK8ELgHxAjpc5AHU0SdHE8WoCJpNtk/b5hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPqGequxdrmrobl0uqzP5EsltcHvXNApR9+dS/1Tn8P76nK4YPYmFFjc82VopXhvAl0vTdADhCA61KLNKfbw0pRDwV5XflD3EWCXVO2SKQJ/iQy1eJ/X1T3xuc7fSIvGsfhWH9Rm5PyM5sazfv/PS7A8pdyh3V6NrgEhQsSc8BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4rQtyaS; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43996e95114so25382515e9.3
        for <bpf@vger.kernel.org>; Sun, 02 Mar 2025 12:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740946436; x=1741551236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPaJiTRgHSYRKB4KuNqOKHe41VKxkig5Z9cneGFrPjo=;
        b=A4rQtyaSBvq/BH2XclU38lEH1eeKLJRjnpJ3dF11xpnjh0U9qc36cpBmxrypnNIeR7
         2Bg3kQmbvQZmJ1eBIk2KbO/PUdaqTZHlf39vanJjypd0D95fCaAVNTyxOIuvJGonZ/mt
         ysROF7pA4wplGHdLtAKjXk6hfCr0WvGf1c6yVP59jl7D/nTNm+ATKlzM3hVVFXiUNfI/
         rr8wzmFArLtv3wXdW/UTPYXcAsPxPiFpe29fvpQjSkx5CbZHzbbPLV8koIHeSMFPDrm7
         nYzwkmWLrcYFHgW02cdRqGCXEXGeD693/oD2CDXHdvSSE8p7lxk1PM9/3kssVUHYPdQo
         ekQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740946436; x=1741551236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPaJiTRgHSYRKB4KuNqOKHe41VKxkig5Z9cneGFrPjo=;
        b=QY7oe4i+rL0RNlmwJU8hF5TAUsa57AEDKv9CyTdfhql8y69juFihdILNB0+lHrhgd+
         DQQT6bYMLL2D1WeKGylB/e24Taozq5wWtR/KGbxWoO/RVwd0VCdn2uFR63yxZxF0v4C2
         TVBGzqe7jxqv9C4bBLlI7En3BIChNYFacPW3+v+4oIr9zsbjAPSwfLYxPpwfD+K7yGyF
         K0a4NIWdVAJDCTtOBzdpPkbo//H9ZeS23BborfnuD+SOrxWD0NBi7WiQ/Kdqqx/rU86x
         O0PHlXkVpiJB3TOTmHbH6OnzwalAVkR1ur3Br0I/sm8q/1bx1sR9EB7emhCHnpFEJYpl
         PdOw==
X-Gm-Message-State: AOJu0YzqCoDmZ/xZHEP6U2IoBmiBoLABTqp+StQ+JylRyUcP7JrdQhVK
	bdkFWS/ELkH84VwxSXvIBQUlzfBwQiHbMYv0Fs1efYb8Eya3cYADQ/AF9GGTsio=
X-Gm-Gg: ASbGncumkeqVp3gRINV6RRBkNc2NjbFTVK8fUYt0UJr7vKEtOCCnBClpSOUy9CczUsh
	EbQHRvl0UXfBh6NBPGUS7feqOJvYn4008p2HYde9rS+r4YBeWB1C46PDrHjenq519DkWQcTvYib
	Gya1EtqGORN+Xx7XnH1oy6h8jlXgnkbK2dc1Y+G+bklISgabEWfCkW6w1EIznJvY8CnTcjgr9bj
	DLqklDu9tiZx0rWO4ev3JWgRyFInohYCAzq4LNTLrYu7krRGLg8j3LmGAqtMt/co2l896Y/fWgr
	06TQfG+9Y6LzdvDvBt1s3TRa7+fpttdwtRA=
X-Google-Smtp-Source: AGHT+IEU73Eq4TMZYCZXMof8m/DxeMZNVry7xAERXk3ibvdqeCDOAK6j4eD2M2yJGEeoHDqOtS4J9g==
X-Received: by 2002:a05:600c:468e:b0:439:8e3e:b0d6 with SMTP id 5b1f17b1804b1-43ba67045femr91791985e9.13.1740946436090;
        Sun, 02 Mar 2025 12:13:56 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:4e::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a28b285sm135396195e9.33.2025.03.02.12.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 12:13:55 -0800 (PST)
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
Subject: [PATCH bpf-next v1 2/2] bpf, x86: Add x86 JIT support for timed may_goto
Date: Sun,  2 Mar 2025 12:13:48 -0800
Message-ID: <20250302201348.940234-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250302201348.940234-1-memxor@gmail.com>
References: <20250302201348.940234-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7361; h=from:subject; bh=BpThu9YEyK8ELgHxAjpc5AHU0SdHE8WoCJpNtk/b5hc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxLhMNgnqz+TsTt4STyL1kTCgF+Z7qN7sAyxwgwaD kf/n/4CJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8S4TAAKCRBM4MiGSL8RysYfD/ 44O03jt4b3V6aF98nLVDTkareaHk2Mt0VXRL4/IX5DcN3jYmhKqQKcHqbtqhjYB1m7zCXwIpPnpPuM 2cZbm4BRkgnA0pJ5QbCjKkQ4w0hK4wSlj+2w6dSXkqSPRbXMaBitA9JZCQ1X7RcbKk3y/9qZBDe5SW W7t8HKSUOg1zXmM539hR6bih/nx4mDHu/yRffHlCL5KXmLibN5/YYanUy8Q3Xd9fs+HyPZz4Uhp+mM u0ZzIBNdMHuHDRY6tCUg/JwT7Jruxp8L7Ok6qpeYMq1w9HKOY+uTPhblFJ47h1pojuZoAuFPD85vLo MEPi13/ZLjslGmv2HxsRjfv1h2Fo0M0leIZQ2Ta8sV0/ZmlAg9Nl/bmL9Cvzp4cLbM9N61vcKqGazW e0qjUxmdLQ2RP+SXLJyHTqbLZ6IaUK4iyroA92DUrLZVDbkWmPg/e6Pg71qXhNmWPBPqYcSIydRxt9 QcTVdbJ3fBzWTOtKV5iLQyvlno5xfA5caLCghuiI+4JE/odSUPjHzoTk66nhEtMT0Q0CxyGhyTVTXK 8IE1RDvylukMh438iXMHtgSHDi2AiXjNqCb1Ih0gWmvePhLTHZyfPpTZUAhOAFEBNlH0Bo5Whqh9uA wAwmvZedY0EsiAInoj9ZGiA9m8+wLKYS0UUHRKn7QGSe9qPv0uHEV8AIYHmg==
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
 arch/x86/net/bpf_timed_may_goto.S             | 43 ++++++++++++++
 .../bpf/progs/verifier_bpf_fastcall.c         | 58 +++++++++++++++----
 .../selftests/bpf/progs/verifier_may_goto_1.c | 34 ++++++++++-
 5 files changed, 129 insertions(+), 13 deletions(-)
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
index 000000000000..c35e00b93ac6
--- /dev/null
+++ b/arch/x86/net/bpf_timed_may_goto.S
@@ -0,0 +1,43 @@
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
+	/* Save r0-r5 */
+	pushq %rax
+	pushq %rdi
+	pushq %rsi
+	pushq %rdx
+	pushq %rcx
+	pushq %r8
+
+	/* r10 passes us stack depth, load the pointer to count and timestamp as
+	 * first argument to the call below.
+	 */
+	leaq (%rbp, %r10, 1), %rdi
+
+	/* Emit call depth accounting for call below */
+	CALL_DEPTH_ACCOUNT
+	call bpf_check_timed_may_goto
+
+	/* BPF_REG_AX=r10 will be stored into count, so move return value to it */
+	movq %rax, %r10
+
+	/* Restore r5-r0 */
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
index 5094c288cfd7..67e6980cd722 100644
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
+__xlated("9: if r11 != 0x1 goto pc+2")
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
index e81097c96fe2..b75548a52658 100644
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
+__xlated("5: if r11 != 0x1 goto pc+2")
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


