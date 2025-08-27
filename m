Return-Path: <bpf+bounces-66653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B73CFB3811A
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 13:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41F01BA26FB
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 11:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDC32D1F7E;
	Wed, 27 Aug 2025 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igiMMjru"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EA62BE641
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294375; cv=none; b=ERoQwChfVtlM0Y/MI4FY3b4A9/Zjx/Fi8pokWLo7MMOwlu1Z5UoftYadmIpAXz7spwFAKThKKY7qa9BRLPPAcswMe820Qn3LK2IehbSHd9F6tDm4M3MfuyVpHIja0wD7a+MT13qjFuuTIaOiuryOO6E8rUHaJsVD5z6qOsHn/tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294375; c=relaxed/simple;
	bh=7StUn0vWe6d7wRECJ3LU4KriSVPmo4Fu3GyqND4yk9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPomEHnC2HJKQ5LEHIubmTahSJ0s4WZ4Muh+Sg71TAOOJUV57UCgMbOxMyBegCI68qlNJXUl4G8kGtr5qEMq2eEmqErR0tXCMM/5NUSP8TrKJXUnCUibGmaNHQT/81J9L3W9e25d2rlNcgG+GNECkf3/K3mmz30uXuTy8E1/FuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igiMMjru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B5DC4CEEB;
	Wed, 27 Aug 2025 11:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756294374;
	bh=7StUn0vWe6d7wRECJ3LU4KriSVPmo4Fu3GyqND4yk9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=igiMMjruFdBheFd/U/i8DiD9zy6zWUBWuiL6zbn7qULuzwKxys50khwduyQUyG2nw
	 XUouLweUqsgWFoXRCLvtw+RRjo9zGLkZ46qNZrUqElRT2OzcpFNslNG6brYwI/js9s
	 yIlKLUDRYv9hWU2QUhiRpfaDx+JX0PPCieXZnckLisKPbMWlQ5emqBgRoOe1KEKIJz
	 oUiwpM6KCd/kqzeVOi0IKPL62MgyOnMNGmpRkoJWzuzE/f9UzCHeqiAnea4r9qPlC3
	 bRDBdd1Hozf3tgS5aWGHiJkE5vNdmnWKD0oGz4p2h4p+yUVaaNVIx9KEqkjePSpJP9
	 Pq31sBl28M49g==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org
Cc: Xu Kuohai <xukuohai@huawei.com>
Subject: [PATCH bpf-next v3 1/2] bpf, arm64: Add JIT support for timed may_goto
Date: Wed, 27 Aug 2025 11:32:43 +0000
Message-ID: <20250827113245.52629-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250827113245.52629-1-puranjay@kernel.org>
References: <20250827113245.52629-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When verifier sees a timed may_goto instruction, it emits a call to
arch_bpf_timed_may_goto() with a stack offset in BPF_REG_AX (arm64 r9)
and expects a count value to be returned in the same register. The
verifier doesn't save or restore any registers before emitting this
call.

arch_bpf_timed_may_goto() should act as a trampoline to call
bpf_check_timed_may_goto() with AAPCS64 calling convention.

To support this custom calling convention, implement
arch_bpf_timed_may_goto() in assembly and make sure BPF caller saved
registers are saved and restored, call bpf_check_timed_may_goto with
arm64 calling convention where first argument and return value both are
in x0, then put the result back into BPF_REG_AX before returning.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/net/Makefile             |  2 +-
 arch/arm64/net/bpf_jit_comp.c       | 13 +++++++++-
 arch/arm64/net/bpf_timed_may_goto.S | 40 +++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/net/bpf_timed_may_goto.S

diff --git a/arch/arm64/net/Makefile b/arch/arm64/net/Makefile
index 5c540efb7d9b9..3ae382bfca879 100644
--- a/arch/arm64/net/Makefile
+++ b/arch/arm64/net/Makefile
@@ -2,4 +2,4 @@
 #
 # ARM64 networking code
 #
-obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o
+obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o bpf_timed_may_goto.o
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 52ffe115a8c47..a98b8132479a7 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1558,7 +1558,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		if (ret < 0)
 			return ret;
 		emit_call(func_addr, ctx);
-		emit(A64_MOV(1, r0, A64_R(0)), ctx);
+		/*
+		 * Call to arch_bpf_timed_may_goto() is emitted by the
+		 * verifier and called with custom calling convention with
+		 * first argument and return value in BPF_REG_AX (x9).
+		 */
+		if (func_addr != (u64)arch_bpf_timed_may_goto)
+			emit(A64_MOV(1, r0, A64_R(0)), ctx);
 		break;
 	}
 	/* tail call */
@@ -3038,6 +3044,11 @@ bool bpf_jit_bypass_spec_v4(void)
 	return true;
 }
 
+bool bpf_jit_supports_timed_may_goto(void)
+{
+	return true;
+}
+
 bool bpf_jit_inlines_helper_call(s32 imm)
 {
 	switch (imm) {
diff --git a/arch/arm64/net/bpf_timed_may_goto.S b/arch/arm64/net/bpf_timed_may_goto.S
new file mode 100644
index 0000000000000..894cfcd7b2416
--- /dev/null
+++ b/arch/arm64/net/bpf_timed_may_goto.S
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Puranjay Mohan <puranjay@kernel.org> */
+
+#include <linux/linkage.h>
+
+SYM_FUNC_START(arch_bpf_timed_may_goto)
+	/* Allocate stack space and emit frame record */
+	stp     x29, x30, [sp, #-64]!
+	mov     x29, sp
+
+	/* Save BPF registers R0 - R5 (x7, x0-x4)*/
+	stp	x7, x0, [sp, #16]
+	stp	x1, x2, [sp, #32]
+	stp	x3, x4, [sp, #48]
+
+	/*
+	 * Stack depth was passed in BPF_REG_AX (x9), add it to the BPF_FP
+	 * (x25) to get the pointer to count and timestamp and pass it as the
+	 * first argument in x0.
+	 *
+	 * Before generating the call to arch_bpf_timed_may_goto, the verifier
+	 * generates a load instruction using FP, i.e. REG_AX = *(u64 *)(FP -
+	 * stack_off_cnt), so BPF_REG_FP (x25) is always set up by the arm64
+	 * jit in this case.
+	 */
+	add	x0, x9, x25
+	bl	bpf_check_timed_may_goto
+	/* BPF_REG_AX(x9) will be stored into count, so move return value to it. */
+	mov	x9, x0
+
+	/* Restore BPF registers R0 - R5 (x7, x0-x4) */
+	ldp	x7, x0, [sp, #16]
+	ldp	x1, x2, [sp, #32]
+	ldp	x3, x4, [sp, #48]
+
+	/* Restore FP and LR */
+	ldp     x29, x30, [sp], #64
+
+	ret
+SYM_FUNC_END(arch_bpf_timed_may_goto)
-- 
2.47.3


