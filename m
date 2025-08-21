Return-Path: <bpf+bounces-66217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3968CB2FBCD
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 16:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08AB1BA48A7
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 14:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0B3248F66;
	Thu, 21 Aug 2025 14:01:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1054B1FAC42;
	Thu, 21 Aug 2025 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784894; cv=none; b=YuMCsllZ20MUOlIic7ztDEMvQmGmUj5Gr2I1m/MKJSTRP8rjNfiW57Zf1/A5Liq5YpTXAPTUucvj13yIrdBq6okSAlgr2yHv6FfsRu0WWCPTAn5sZUr1BKBvG94v6pyrR9lFj40UmJdkuJ+PONmuS8n502H2LlLRFn0zZVMHpNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784894; c=relaxed/simple;
	bh=r/+8ODg0b9YgcL33UXUKZFg5Kqh5wZuQHj1SZZR1Jdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGBEWC4b+ENMRqNXneElJm+wWFXEMlmmpnSnIh1/CZz2O8ruYkAhGHy7ts11sATzf1mP5uHA/K6K5z6cetp8SUMDyM/p4qF8QLGfFs2mPagvhIMMGMByExMlx6cJxYWaNwVs8H0lfEw73Rgaf4LtmnkqF9tLnZxacKZU3q1zV2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxO9K4JqdoAXYBAA--.2704S3;
	Thu, 21 Aug 2025 22:01:28 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxpeSyJqdorsZdAA--.26328S4;
	Thu, 21 Aug 2025 22:01:28 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] LoongArch: BPF: Add 12 function arguments support for trampoline
Date: Thu, 21 Aug 2025 22:01:22 +0800
Message-ID: <20250821140122.29752-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250821140122.29752-1-yangtiezhu@loongson.cn>
References: <20250821140122.29752-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxpeSyJqdorsZdAA--.26328S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gr15uw4DWF4DuFW7WF1fXwc_yoW7uF1kpF
	1qkFsY9F18tFW7Wa97XF4Uur1Ykan3A3y5KrW7Ja92gws8Zr98GayrtF1akFy5Gr1kZr1x
	Aws0vryYkF1xJrbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v2
	6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5l1kUUUUU=

Currently, LoongArch bpf trampoline supports up to 8 function arguments.
According to the statistics from commit 473e3150e30a ("bpf, x86: allow
function arguments up to 12 for TRACING"), there are over 200 functions
accept 9 to 12 arguments, so add 12 arguments support for trampoline.

The initial aim is to pass the following related testcases:

  sudo ./test_progs -a tracing_struct/struct_many_args
  sudo ./test_progs -a fentry_test/fentry_many_args
  sudo ./test_progs -a fexit_test/fexit_many_args

but there exist some other problems now, maybe it is related with
the following failed testcase:

  sudo ./test_progs -t module_attach

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 57 ++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 12 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 7bd4b132755a..805fa6dba2d8 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1340,26 +1340,48 @@ int bpf_arch_text_invalidate(void *dst, size_t len)
 	return ret;
 }
 
-static void store_args(struct jit_ctx *ctx, int nregs, int args_off)
+static void store_args(struct jit_ctx *ctx, int nr_arg_slots, int args_off)
 {
 	int i;
 
-	for (i = 0; i < nregs; i++) {
-		emit_insn(ctx, std, LOONGARCH_GPR_A0 + i, LOONGARCH_GPR_FP, -args_off);
+	for (i = 0; i < nr_arg_slots; i++) {
+		if (i < LOONGARCH_MAX_REG_ARGS) {
+			emit_insn(ctx, std, LOONGARCH_GPR_A0 + i, LOONGARCH_GPR_FP, -args_off);
+		} else {
+			/* skip slots for T0 and FP of traced function */
+			emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP,
+				  16 + (i - LOONGARCH_MAX_REG_ARGS) * 8);
+			emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -args_off);
+		}
 		args_off -= 8;
 	}
 }
 
-static void restore_args(struct jit_ctx *ctx, int nregs, int args_off)
+static void restore_args(struct jit_ctx *ctx, int nr_reg_args, int args_off)
 {
 	int i;
 
-	for (i = 0; i < nregs; i++) {
+	for (i = 0; i < nr_reg_args; i++) {
 		emit_insn(ctx, ldd, LOONGARCH_GPR_A0 + i, LOONGARCH_GPR_FP, -args_off);
 		args_off -= 8;
 	}
 }
 
+static void restore_stk_args(struct jit_ctx *ctx, int nr_stk_args,
+			       int args_off, int stk_arg_off)
+{
+	int i;
+
+	for (i = 0; i < nr_stk_args; i++) {
+		emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP,
+			  -(args_off - LOONGARCH_MAX_REG_ARGS * 8));
+		emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP,
+			  -stk_arg_off);
+		args_off -= 8;
+		stk_arg_off -= 8;
+	}
+}
+
 static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
 			   const struct btf_func_model *m, int args_off,
 			   int retval_off, int run_ctx_off, bool save_ret)
@@ -1477,7 +1499,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 					 void *func_addr, u32 flags)
 {
 	int i, ret, save_ret;
-	int stack_size = 0, nregs = m->nr_args;
+	int stack_size = 0, nr_arg_slots = 0, stk_arg_off;
 	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off, tcc_ptr_off;
 	bool is_struct_ops = flags & BPF_TRAMP_F_INDIRECT;
 	void *orig_call = func_addr;
@@ -1511,9 +1533,13 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	 * FP - sreg_off    [ callee saved reg  ]
 	 *
 	 * FP - tcc_ptr_off [ tail_call_cnt_ptr ]
+	 *
+	 *                  [ stack_argN        ]
+	 *                  [ ...               ]
+	 * FP - stk_arg_off [ stack_arg1        ] BPF_TRAMP_F_CALL_ORIG
 	 */
 
-	if (m->nr_args > LOONGARCH_MAX_REG_ARGS)
+	if (m->nr_args > MAX_BPF_FUNC_ARGS)
 		return -ENOTSUPP;
 
 	/* extra regiters for struct arguments */
@@ -1544,7 +1570,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	/* Room of trampoline frame to store args */
-	stack_size += nregs * 8;
+	stack_size += nr_arg_slots * 8;
 	args_off = stack_size;
 
 	/* Room of trampoline frame to store args number */
@@ -1570,8 +1596,14 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 		tcc_ptr_off = stack_size;
 	}
 
+	if ((flags & BPF_TRAMP_F_CALL_ORIG) && (nr_arg_slots - LOONGARCH_MAX_REG_ARGS > 0))
+		stack_size += (nr_arg_slots - LOONGARCH_MAX_REG_ARGS) * 8;
+
 	stack_size = round_up(stack_size, 16);
 
+	/* Room for args on stack must be at the top of stack */
+	stk_arg_off = stack_size;
+
 	if (is_struct_ops) {
 		/*
 		 * For the trampoline called directly, just handle
@@ -1613,10 +1645,10 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	/* store arg regs count */
-	move_imm(ctx, LOONGARCH_GPR_T1, nregs, false);
+	move_imm(ctx, LOONGARCH_GPR_T1, nr_arg_slots, false);
 	emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -nregs_off);
 
-	store_args(ctx, nregs, args_off);
+	store_args(ctx, nr_arg_slots, args_off);
 
 	/* To traced function */
 	/* Ftrace jump skips 2 NOP instructions */
@@ -1648,7 +1680,8 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_args(ctx, nregs, args_off);
+		restore_args(ctx, min_t(int, nr_arg_slots, LOONGARCH_MAX_REG_ARGS), args_off);
+		restore_stk_args(ctx, nr_arg_slots - LOONGARCH_MAX_REG_ARGS, args_off, stk_arg_off);
 
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
 			emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_FP, -tcc_ptr_off);
@@ -1685,7 +1718,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_args(ctx, nregs, args_off);
+		restore_args(ctx, min_t(int, nr_arg_slots, LOONGARCH_MAX_REG_ARGS), args_off);
 
 	if (save_ret) {
 		emit_insn(ctx, ldd, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -retval_off);
-- 
2.42.0


