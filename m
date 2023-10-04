Return-Path: <bpf+bounces-11363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3634F7B7EB4
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 14:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 0B1851C20A61
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 12:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E128B13ADB;
	Wed,  4 Oct 2023 12:07:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809CC13AC5;
	Wed,  4 Oct 2023 12:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE09AC433C9;
	Wed,  4 Oct 2023 12:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696421244;
	bh=vLvgsGAj3vc8B6/nSYNfFLo6uk+g4NpV7dEmI8AKTYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ffk7vBFT5mbKfpS4JsRj1/srW+OQBeawmaCbwedd64L5PBIXa35ukJio0aGa/79fP
	 XDBl5Dqtggjo+cBwBIOgZTuARLyykM12k507R6ubzMvE42nQ2mkhwyn5J80OENEIO8
	 m3Ag+25W74eAEFvJu1mfdI0GdG/B/l7fx9eOkhl+fRhEy9EzutvfDB7IuH3+cAM2Dp
	 rUGeixzlVrVfIeeL3wZ6TSW0xUq9zLGPiBBeXGSRM+tE98wA3fqllIR+Q+IQHDCZ7A
	 tCqaAqP3sb47Cf8hd462KfH4XTV8ZZxs1LSp6O2MSpCWgVNURx7xWbhuHNyFOqRwej
	 CJSmc1nrCsyhQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Pu Lehui <pulehui@huawei.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-kernel@vger.kernel.org,
	Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	linux-riscv@lists.infradead.org
Subject: [PATCH bpf 2/2] riscv, bpf: Track both a0 (RISC-V ABI) and a5 (BPF) return values
Date: Wed,  4 Oct 2023 14:07:06 +0200
Message-Id: <20231004120706.52848-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004120706.52848-1-bjorn@kernel.org>
References: <20231004120706.52848-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

The RISC-V BPF uses a5 for BPF return values, which are zero-extended,
whereas the RISC-V ABI uses a0 which is sign-extended. In other words,
a5 and a0 can differ, and are used in different context.

The BPF trampoline are used for both BPF programs, and regular kernel
functions.

Make sure that the RISC-V BPF trampoline saves, and restores both a0
and a5.

Fixes: 49b5e77ae3e2 ("riscv, bpf: Add bpf trampoline support for RV64")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index de4c9957d223..8581693e62d3 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -759,8 +759,10 @@ static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_of
 	if (ret)
 		return ret;
 
-	if (save_ret)
-		emit_sd(RV_REG_FP, -retval_off, regmap[BPF_REG_0], ctx);
+	if (save_ret) {
+		emit_sd(RV_REG_FP, -retval_off, RV_REG_A0, ctx);
+		emit_sd(RV_REG_FP, -(retval_off - 8), regmap[BPF_REG_0], ctx);
+	}
 
 	/* update branch with beqz */
 	if (ctx->insns) {
@@ -853,7 +855,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 
 	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
 	if (save_ret) {
-		stack_size += 8;
+		stack_size += 16; /* Save both A5 (BPF R0) and A0 */
 		retval_off = stack_size;
 	}
 
@@ -957,6 +959,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		if (ret)
 			goto out;
 		emit_sd(RV_REG_FP, -retval_off, RV_REG_A0, ctx);
+		emit_sd(RV_REG_FP, -(retval_off - 8), regmap[BPF_REG_0], ctx);
 		im->ip_after_call = ctx->insns + ctx->ninsns;
 		/* 2 nops reserved for auipc+jalr pair */
 		emit(rv_nop(), ctx);
@@ -988,8 +991,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
 		restore_args(nregs, args_off, ctx);
 
-	if (save_ret)
+	if (save_ret) {
 		emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
+		emit_ld(regmap[BPF_REG_0], -(retval_off - 8), RV_REG_FP, ctx);
+	}
 
 	emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
 
-- 
2.39.2


