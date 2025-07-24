Return-Path: <bpf+bounces-64259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F04B10ABF
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 14:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1CCD1C265C3
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 12:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFE82D0C9F;
	Thu, 24 Jul 2025 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIbL8Lb7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E7C2836BF
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361694; cv=none; b=oJV3p92XCn8RJWhN3cjku5kxFvO3e6sJLzpIH9fd86qdjKWJGxkPkH1mf9Ut7a6ErkMQaQlIewomeD1oJS1A4L8IArkhf8zwCct1t4z2s91LdWrJZRoARqnDlvDd+RA+/jyQAaYVvo94m8MXTJm6lpqGJeTgo6kklPquBYiJFTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361694; c=relaxed/simple;
	bh=+lMsOUuv4Am49zadYRXtVF17h+qizJudD0/nWPzHviI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C65o+ASyt3Vdwmc0I5FHMPsRD7rfBY4mJ9g2WMb86l9x2rl72o9y0rx8/smX+6KM1ldfJyazNY1w/90tbpL7GMqz6YQgvRZDusAnJAGCsDhUZbgkG7Jf0Hm18k/n4RkHnKfeWm0NyLS0O5yhBmNeeLNpQgV9CUlcfPsc2KEnUlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIbL8Lb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB1AC4CEEF;
	Thu, 24 Jul 2025 12:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753361693;
	bh=+lMsOUuv4Am49zadYRXtVF17h+qizJudD0/nWPzHviI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JIbL8Lb7fWD1PDLOb909TvJESCUC3Etw75Hzuz3SVBFfdrr/T5o7N7sjhuCIIADmf
	 C1JbWC+o15EiufPabYaf6Hq8Ch6dyZyQlQgrDQuK0xWtBHLwH4rLDTbvpwNdIUdrcR
	 JIdghK236QrlZNWtSTBK3vJSBYmQL8whKQJTik7fTCp6stAF1IZMwrSCy/xSqu/nqw
	 1X26yfKKYumPNIQpzGgIjoBcfsSI3+Ghy1/vUZhw4Y7B5sc8NKAqELcoOaYmT37uyQ
	 CGM91LBiwn1r14Gi2iVR8Urr0NJjupZc7ER41cWQekVPNQjZ1/X3b4GZEpUB7tYyrf
	 1y/MM7gdsLJSA==
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
Subject: [PATCH bpf-next 1/2] bpf, arm64: Add JIT support for timed may_goto
Date: Thu, 24 Jul 2025 12:54:39 +0000
Message-ID: <20250724125443.26182-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250724125443.26182-1-puranjay@kernel.org>
References: <20250724125443.26182-1-puranjay@kernel.org>
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
---
 arch/arm64/net/Makefile             |  2 +-
 arch/arm64/net/bpf_jit_comp.c       | 13 ++++++++++-
 arch/arm64/net/bpf_timed_may_goto.S | 36 +++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 2 deletions(-)
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
index 89b1b8c248c62..6c954b36f57ea 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1505,7 +1505,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
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
@@ -2914,6 +2920,11 @@ bool bpf_jit_bypass_spec_v4(void)
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
index 0000000000000..45f80e752345c
--- /dev/null
+++ b/arch/arm64/net/bpf_timed_may_goto.S
@@ -0,0 +1,36 @@
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
+	 */
+	add	x0, x9, x25
+	bl	bpf_check_timed_may_goto
+	/* BPF_REG_AX(x9) will be stored into count, so move return value to it. */
+	mov	x9, x0
+
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


