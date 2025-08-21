Return-Path: <bpf+bounces-66226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFF4B2FD55
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 16:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93219189E7CA
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 14:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612E51C8633;
	Thu, 21 Aug 2025 14:43:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637F3215175;
	Thu, 21 Aug 2025 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787392; cv=none; b=hDmUR0VVlNLjAgKil5tsluDib/AsJvILzFhRohAEIpLb1FnGTWFfm7qWyatkRRS4YM9tyYYiOAywp48favCukWOy7Ew0yWe2zPpN+5eWk7HPMqCKrYD9XFo+VJ5Gq9QqOMHUu7KlxGxfSts3VNvtBs3H33VZ+nxIb9QKaGl6He0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787392; c=relaxed/simple;
	bh=nqN0eKRTGHrfWvACIIjuTnOAdlvzHw7y/Yc2sXNZMY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBRemhbBmVPNGmF5cE/VhPfQH28TyUokXr2LR4vWPdUm7lZWrNr2KhlUm7BIHapuA2dXQAKMVlE4WtG0VG5QWkDuAcr6TaQ6VVCnzlnJj5eDryfJAOCTsJcU6nBtNrEI3HK2jN4k6NSLuW3w2Wbl3S4FUN7eHyXj8vANPMqwd8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx1tB6MKdoBXkBAA--.2734S3;
	Thu, 21 Aug 2025 22:43:06 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxzsF3MKdo0NpdAA--.294S4;
	Thu, 21 Aug 2025 22:43:06 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/2] LoongArch: BPF: Add 12 function arguments support for trampoline
Date: Thu, 21 Aug 2025 22:43:02 +0800
Message-ID: <20250821144302.14010-3-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJBxzsF3MKdo0NpdAA--.294S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gr15uw4DWF4DuFW7WF1fXwc_yoWxWrW8pF
	1qkan09F18tFW7WaykJF4Uur1YkFs3A3yYgrW7Ja92gw45ur98XayrKFnIkFy5Gr1kAr1x
	Aws0vrWYyF1xJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v2
	6F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwNVyUUUUU

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
 arch/loongarch/net/bpf_jit.c | 79 +++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 24 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 2bdc0e535468..805fa6dba2d8 100644
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
@@ -1511,25 +1533,27 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	 * FP - sreg_off    [ callee saved reg  ]
 	 *
 	 * FP - tcc_ptr_off [ tail_call_cnt_ptr ]
+	 *
+	 *                  [ stack_argN        ]
+	 *                  [ ...               ]
+	 * FP - stk_arg_off [ stack_arg1        ] BPF_TRAMP_F_CALL_ORIG
 	 */
 
+	if (m->nr_args > MAX_BPF_FUNC_ARGS)
+		return -ENOTSUPP;
+
 	/* extra regiters for struct arguments */
 	for (i = 0; i < m->nr_args; i++) {
-		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG) {
-			/*
-			 * The struct argument size is at most 16 bytes,
-			 * enforced by the verifier. The struct argument
-			 * may be passed in a pair of registers if its
-			 * size is more than 8 bytes and no more than 16
-			 * bytes.
-			 */
-			nregs += round_up(m->arg_size[i], 8) / 8 - 1;
-		}
+		/*
+		 * The struct argument size is at most 16 bytes,
+		 * enforced by the verifier. The struct argument
+		 * may be passed in a pair of registers if its
+		 * size is more than 8 bytes and no more than 16
+		 * bytes.
+		 */
+		nr_arg_slots += round_up(m->arg_size[i], 8) / 8;
 	}
 
-	if (nregs > LOONGARCH_MAX_REG_ARGS)
-		return -ENOTSUPP;
-
 	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
 		return -ENOTSUPP;
 
@@ -1546,7 +1570,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	/* Room of trampoline frame to store args */
-	stack_size += nregs * 8;
+	stack_size += nr_arg_slots * 8;
 	args_off = stack_size;
 
 	/* Room of trampoline frame to store args number */
@@ -1572,8 +1596,14 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
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
@@ -1615,10 +1645,10 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	/* store arg regs count */
-	move_imm(ctx, LOONGARCH_GPR_T1, nregs, false);
+	move_imm(ctx, LOONGARCH_GPR_T1, nr_arg_slots, false);
 	emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -nregs_off);
 
-	store_args(ctx, nregs, args_off);
+	store_args(ctx, nr_arg_slots, args_off);
 
 	/* To traced function */
 	/* Ftrace jump skips 2 NOP instructions */
@@ -1650,7 +1680,8 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_args(ctx, nregs, args_off);
+		restore_args(ctx, min_t(int, nr_arg_slots, LOONGARCH_MAX_REG_ARGS), args_off);
+		restore_stk_args(ctx, nr_arg_slots - LOONGARCH_MAX_REG_ARGS, args_off, stk_arg_off);
 
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
 			emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_FP, -tcc_ptr_off);
@@ -1687,7 +1718,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_args(ctx, nregs, args_off);
+		restore_args(ctx, min_t(int, nr_arg_slots, LOONGARCH_MAX_REG_ARGS), args_off);
 
 	if (save_ret) {
 		emit_insn(ctx, ldd, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -retval_off);
-- 
2.42.0


