Return-Path: <bpf+bounces-65302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9B3B1F639
	for <lists+bpf@lfdr.de>; Sat,  9 Aug 2025 22:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7384620581
	for <lists+bpf@lfdr.de>; Sat,  9 Aug 2025 20:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4F323C4FC;
	Sat,  9 Aug 2025 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mi62tTWK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13E535959
	for <bpf@vger.kernel.org>; Sat,  9 Aug 2025 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754772525; cv=none; b=DgBaJ8qoOD+PlH99GXu2cjU/f4yb530Gglmn1PYOlGSJXLj67bH5KcptqCh5VYIDmQU6jufENRdGHDFvmVsLxIQW0iZ86QnH8afVVqUjmqPnZBPtaY8mt7sLLbV6NQwELi9FDQCPD7iwKqTp8QmdixIVhEs2Ien0/UVFUvOfmH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754772525; c=relaxed/simple;
	bh=x++fkya3y4iz+zfBmAFQzoNDYSYedNeRFDUi4KfNSiQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INP3fDMqgrZS+7pg5rVta3Ry1Yl/QXgbovpxh4Ppok2Wgvn5GM4zWgpkeGeRFSvR+3Xo/n35CLhFAftwUlaKU+c6oG1g8gioUmf2qSZXzo5MLVoNyMT6G8NecSa8FH6zAUPDwWj520zS5M/89N7ESEQdQCQ0GWxyUpB0wTN2/AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mi62tTWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C760BC4CEE7;
	Sat,  9 Aug 2025 20:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754772525;
	bh=x++fkya3y4iz+zfBmAFQzoNDYSYedNeRFDUi4KfNSiQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mi62tTWKiN/8U14rUF0L5JXkdeV+5kaZMxkF4tDiIbBJM3wMI9ibtOQecNOYnVw3p
	 2pgcDS4tc7Y/uN/0bu0Ao88pou00viAQxzAMwwm6dmCHN02qtHEsLbAX8JwhZItcuy
	 evZ+SteTn90xAxLg27gu8IzIJ5NzdVgDDH16+ssnKSSGpW9tXEPqemIxMWBOan3eNl
	 F99oqzHhJQDH9AYRbF1XnOg/eXWF2LpCHs2N0frI4q55ZTPeepEmzL4T1JKmlBdKJo
	 dSKg8IoZYdQ5jvPBmAaFNjqChQ1tD2eqbSxnDBXD+emDUW1j9x9w81YQRZjuUfOvDn
	 pTyACQYfodn+g==
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
Subject: [PATCH bpf-next v2 1/2] bpf, arm64: Add JIT support for timed may_goto
Date: Sat,  9 Aug 2025 20:48:30 +0000
Message-ID: <20250809204833.44803-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250809204833.44803-1-puranjay@kernel.org>
References: <20250809204833.44803-1-puranjay@kernel.org>
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


