Return-Path: <bpf+bounces-66225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE0CB2FD52
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 16:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34541D009DE
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 14:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ECE23FC42;
	Thu, 21 Aug 2025 14:43:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425631DF749;
	Thu, 21 Aug 2025 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787391; cv=none; b=jpInIfg0wyEQXwzfcWl7/qCsqu6tVu/2ZKf8vOb0+N8h56qtCF754mviFRxtvNn/2r+hV2f8zV9Pgp8jXk15mgJKcn8Wx5m7osblIt/2gUA03rFyxNIM4TY2oJmLcZMPhvkYaDjYXtRa5ZcI1u1gtsOBLzUgkt8KbP7bm6fKlqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787391; c=relaxed/simple;
	bh=lDPUFxvzjX9uelp51IbtN27pRFWfSQD14abwzw2Rr6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZgNtzOLLJFtnh4xibqK5i2KFrmcgKdSR05iE2nKJzQFNlsrd/+vzal/0GvqlJ+1nMBR1N7k5BUcAWbfMw3KqJurRR64jA1LkYKBsYI8pghWism/SHqLKGwfu2zSoATPyRekkmzgj4rp9SclZmojPJeq+w62J/mCmhkwB2IAD0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxP_B6MKdoAXkBAA--.2872S3;
	Thu, 21 Aug 2025 22:43:06 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxzsF3MKdo0NpdAA--.294S3;
	Thu, 21 Aug 2025 22:43:04 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/2] LoongArch: BPF: Add struct arguments support for trampoline
Date: Thu, 21 Aug 2025 22:43:01 +0800
Message-ID: <20250821144302.14010-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250821144302.14010-1-yangtiezhu@loongson.cn>
References: <20250821144302.14010-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxzsF3MKdo0NpdAA--.294S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3GF4DGF4rJw4kKr45Ar4UZFc_yoW7tr1DpF
	1qkr43CF4rJFW7Wa1DXr4UWFyYkFZ3A3ya9rWUG3ySyws8Xr98XF4rKFn0yFy5GrykAFyf
	urs0vryqkF1xJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
	UjIFyTuYvjxUcApnDUUUU

In the current BPF code, the struct argument size is at most 16 bytes,
enforced by the verifier [1]. According to the Procedure Call Standard
for LoongArch [2], struct argument size below 16 bytes are provided as
part of the 8 argument registers, that is to say, the struct argument
may be passed in a pair of registers if its size is more than 8 bytes
and no more than 16 bytes.

Extend the BPF trampoline JIT to support attachment to functions that
take small structures (up to 16 bytes) as argument, save and restore
a number of "argument registers" rather than a number of arguments.

The initial aim is to pass the following related testcase:

  sudo ./test_progs -a tracing_struct/struct_args

but there exist some other problems now, maybe it is related with
the following failed testcase:

  sudo ./test_progs -t module_attach

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/bpf/btf.c#n7383 [1]
Link: https://github.com/loongson/la-abi-specs/blob/release/lapcs.adoc#structures [2]
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 55 ++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index a87f51f5b708..2bdc0e535468 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1340,21 +1340,21 @@ int bpf_arch_text_invalidate(void *dst, size_t len)
 	return ret;
 }
 
-static void store_args(struct jit_ctx *ctx, int nargs, int args_off)
+static void store_args(struct jit_ctx *ctx, int nregs, int args_off)
 {
 	int i;
 
-	for (i = 0; i < nargs; i++) {
+	for (i = 0; i < nregs; i++) {
 		emit_insn(ctx, std, LOONGARCH_GPR_A0 + i, LOONGARCH_GPR_FP, -args_off);
 		args_off -= 8;
 	}
 }
 
-static void restore_args(struct jit_ctx *ctx, int nargs, int args_off)
+static void restore_args(struct jit_ctx *ctx, int nregs, int args_off)
 {
 	int i;
 
-	for (i = 0; i < nargs; i++) {
+	for (i = 0; i < nregs; i++) {
 		emit_insn(ctx, ldd, LOONGARCH_GPR_A0 + i, LOONGARCH_GPR_FP, -args_off);
 		args_off -= 8;
 	}
@@ -1477,8 +1477,8 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 					 void *func_addr, u32 flags)
 {
 	int i, ret, save_ret;
-	int stack_size = 0, nargs = 0;
-	int retval_off, args_off, nargs_off, ip_off, run_ctx_off, sreg_off, tcc_ptr_off;
+	int stack_size = 0, nregs = m->nr_args;
+	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off, tcc_ptr_off;
 	bool is_struct_ops = flags & BPF_TRAMP_F_INDIRECT;
 	void *orig_call = func_addr;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
@@ -1498,11 +1498,11 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	 *
 	 * FP - retval_off  [ return value      ] BPF_TRAMP_F_CALL_ORIG or
 	 *                    BPF_TRAMP_F_RET_FENTRY_RET
-	 *                  [ argN              ]
+	 *                  [ arg regN          ]
 	 *                  [ ...               ]
-	 * FP - args_off    [ arg1              ]
+	 * FP - args_off    [ arg reg1          ]
 	 *
-	 * FP - nargs_off   [ regs count        ]
+	 * FP - nregs_off   [ arg regs count    ]
 	 *
 	 * FP - ip_off      [ traced func   ] BPF_TRAMP_F_IP_ARG
 	 *
@@ -1513,15 +1513,23 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	 * FP - tcc_ptr_off [ tail_call_cnt_ptr ]
 	 */
 
-	if (m->nr_args > LOONGARCH_MAX_REG_ARGS)
-		return -ENOTSUPP;
-
-	/* don't support struct argument */
+	/* extra regiters for struct arguments */
 	for (i = 0; i < m->nr_args; i++) {
-		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
-			return -ENOTSUPP;
+		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG) {
+			/*
+			 * The struct argument size is at most 16 bytes,
+			 * enforced by the verifier. The struct argument
+			 * may be passed in a pair of registers if its
+			 * size is more than 8 bytes and no more than 16
+			 * bytes.
+			 */
+			nregs += round_up(m->arg_size[i], 8) / 8 - 1;
+		}
 	}
 
+	if (nregs > LOONGARCH_MAX_REG_ARGS)
+		return -ENOTSUPP;
+
 	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
 		return -ENOTSUPP;
 
@@ -1538,13 +1546,12 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	/* Room of trampoline frame to store args */
-	nargs = m->nr_args;
-	stack_size += nargs * 8;
+	stack_size += nregs * 8;
 	args_off = stack_size;
 
 	/* Room of trampoline frame to store args number */
 	stack_size += 8;
-	nargs_off = stack_size;
+	nregs_off = stack_size;
 
 	/* Room of trampoline frame to store ip address */
 	if (flags & BPF_TRAMP_F_IP_ARG) {
@@ -1607,11 +1614,11 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 		emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -ip_off);
 	}
 
-	/* store nargs number */
-	move_imm(ctx, LOONGARCH_GPR_T1, nargs, false);
-	emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -nargs_off);
+	/* store arg regs count */
+	move_imm(ctx, LOONGARCH_GPR_T1, nregs, false);
+	emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -nregs_off);
 
-	store_args(ctx, nargs, args_off);
+	store_args(ctx, nregs, args_off);
 
 	/* To traced function */
 	/* Ftrace jump skips 2 NOP instructions */
@@ -1643,7 +1650,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_args(ctx, m->nr_args, args_off);
+		restore_args(ctx, nregs, args_off);
 
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
 			emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_FP, -tcc_ptr_off);
@@ -1680,7 +1687,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_args(ctx, m->nr_args, args_off);
+		restore_args(ctx, nregs, args_off);
 
 	if (save_ret) {
 		emit_insn(ctx, ldd, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -retval_off);
-- 
2.42.0


