Return-Path: <bpf+bounces-66215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB376B2FBCF
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 16:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2E916EE44
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 14:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89565221572;
	Thu, 21 Aug 2025 14:01:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2ED1A9FB7;
	Thu, 21 Aug 2025 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784893; cv=none; b=rao3T3S72k0Y6/N89qLW8xiSmt8PLLafdg98zVfaAiDJSfPMLa2DQjXuFn02t61wqyTrwRKG/dcwC5SIpXnBw9fXq5o/aUuxoj+r4W/ZoBjgyJIWmG2hTNAzVuKsILnW6VeCH03Lh3c9QmG4ZVmUMUBGKV1uT+q5W9LmgsiIKvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784893; c=relaxed/simple;
	bh=PIPpAMMJ1ZSiP7NTsuJsRo0VG6UhzEC6KrlvtQ8eIhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPQrkZyLujKIso8lGCN9wshNQPdO767Xyc15wvSS4IM4PgKOHVZwJMJfCWGm890t/YyPKAWAaKQH5zF4qasdQ2JVegu99izs90DgrJbjnfnbZzxK1MzDgUlVV5OkbFl2YDYJoJg4od5lxXHEINM7F/MvCFZrNrt68u4LHoyBBYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxLvC3Jqdo_XUBAA--.2833S3;
	Thu, 21 Aug 2025 22:01:27 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxpeSyJqdorsZdAA--.26328S3;
	Thu, 21 Aug 2025 22:01:26 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] LoongArch: BPF: Add struct arguments support for trampoline
Date: Thu, 21 Aug 2025 22:01:21 +0800
Message-ID: <20250821140122.29752-2-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJBxpeSyJqdorsZdAA--.26328S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3GF4DGF4rJw4kKr45Ar4UZFc_yoW7ZFy5pF
	1qkr43CF4rJFW7Wa1kXr4UWFyakFZ3A3y3urWUG3ySyw45Wr98JF48KFn0yFy5GrykAryf
	ursYvryqkF1xJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v2
	6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07josjUUUUUU=

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
 arch/loongarch/net/bpf_jit.c | 47 ++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index a87f51f5b708..7bd4b132755a 100644
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
@@ -1516,10 +1516,16 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	if (m->nr_args > LOONGARCH_MAX_REG_ARGS)
 		return -ENOTSUPP;
 
-	/* don't support struct argument */
+	/* extra regiters for struct arguments */
 	for (i = 0; i < m->nr_args; i++) {
-		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
-			return -ENOTSUPP;
+		/*
+		 * The struct argument size is at most 16 bytes,
+		 * enforced by the verifier. The struct argument
+		 * may be passed in a pair of registers if its
+		 * size is more than 8 bytes and no more than 16
+		 * bytes.
+		 */
+		nr_arg_slots += round_up(m->arg_size[i], 8) / 8;
 	}
 
 	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
@@ -1538,13 +1544,12 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
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
@@ -1607,11 +1612,11 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
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
@@ -1643,7 +1648,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_args(ctx, m->nr_args, args_off);
+		restore_args(ctx, nregs, args_off);
 
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
 			emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_FP, -tcc_ptr_off);
@@ -1680,7 +1685,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_args(ctx, m->nr_args, args_off);
+		restore_args(ctx, nregs, args_off);
 
 	if (save_ret) {
 		emit_insn(ctx, ldd, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -retval_off);
-- 
2.42.0


