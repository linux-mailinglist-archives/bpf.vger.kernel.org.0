Return-Path: <bpf+bounces-61464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9A1AE734A
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 01:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DD617FA58
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 23:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA8B26B2D2;
	Tue, 24 Jun 2025 23:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tr+iEO+a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05163190664
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 23:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750808017; cv=none; b=RqOdqwYu40dewKGF4vkSVHRi8sH3BBwf6Kd7/O18qa9fS/OG3gYzqpc4l+QrpuS23N/jRzTU8e/6is1u+zZwMXsh7SJcPanGmwZHyfsWksI4qf/ChjkzirwyyHxEkc9HusTWYWz6UmrP7oc24+SE/NznTSXn1FM6kWVFtl+Fp6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750808017; c=relaxed/simple;
	bh=KBZ/Rn3dI5Yz5nZQ8Qe0CEX6HvhgcKKP5F7gWe+ZRk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBGV8UIQ36Ns2IzOf0JW7KW+AwNe/G2iVZi4FmK1+5ftpRALOJzd1REm9aRI70tvzQtn/GL6Yk13kYq+duixf6ECpacZLMzTIGy/R0f3PRPPio0k1rmJKFdwNEKQw/qGbPQZkI2jwFRsg50WqovvZccK5Q4DG238YpQSeYqxbyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tr+iEO+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE06BC4CEE3;
	Tue, 24 Jun 2025 23:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750808016;
	bh=KBZ/Rn3dI5Yz5nZQ8Qe0CEX6HvhgcKKP5F7gWe+ZRk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tr+iEO+aNLOTHUIEGwjXSVn7SQzOy5uL0h7Uh9EsGVJ8wth04uF3CyMhvx61Txlky
	 6F7juBFZPaRgFHQvRoegibKlpuiiz86uK2gJgH1JKyI/Ay3r3Da5fqct70rC93GOg3
	 7G/E+bbNt+WoaP0qh9uPLqoCX7a27AFsWjJYtaWv5EOK7khUOOnhK2I5qIgwTUsWLR
	 +Npaxox6piyulf4MaxuYfOI5S7NuBFSJ7aqdnPAmuBSraAbhdmwklT1HSQ8tcEhuuU
	 ugvuZWkTVYYyjP4EhVbiutDQw6Q5dqC4uDslCgx4QA1F6WmZL1HRq6EnDtZBTwqoL/
	 y5okTGD4f9zZw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 bpf-next 1/2] bpf: Add range tracking for BPF_NEG
Date: Tue, 24 Jun 2025 16:33:27 -0700
Message-ID: <20250624233328.313573-2-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624233328.313573-1-song@kernel.org>
References: <20250624233328.313573-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add range tracking for instruction BPF_NEG. Without this logic, a trivial
program like the following will fail

    volatile bool found_value_b;
    SEC("lsm.s/socket_connect")
    int BPF_PROG(test_socket_connect)
    {
        if (!found_value_b)
                return -1;
        return 0;
    }

with verifier log:

"At program exit the register R0 has smin=0 smax=4294967295 should have
been in [-4095, 0]".

This is because range information is lost in BPF_NEG:

0: R1=ctx() R10=fp0
; if (!found_value_b) @ xxxx.c:24
0: (18) r1 = 0xffa00000011e7048       ; R1_w=map_value(...)
2: (71) r0 = *(u8 *)(r1 +0)           ; R0_w=scalar(smin32=0,smax=255)
3: (a4) w0 ^= 1                       ; R0_w=scalar(smin32=0,smax=255)
4: (84) w0 = -w0                      ; R0_w=scalar(range info lost)

Note that, the log above is manually modified to highlight relevant bits.

Fix this by maintaining proper range information with BPF_NEG, so that
the verifier will know:

4: (84) w0 = -w0                      ; R0_w=scalar(smin32=-255,smax=0)

Also updated selftests based on the expected behavior.

Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/tnum.h                            |  2 ++
 kernel/bpf/tnum.c                               |  5 +++++
 kernel/bpf/verifier.c                           | 17 ++++++++++++++++-
 .../bpf/progs/verifier_bounds_deduction.c       | 11 +++++++----
 .../bpf/progs/verifier_value_ptr_arith.c        |  8 ++------
 5 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/include/linux/tnum.h b/include/linux/tnum.h
index 3c13240077b8..57ed3035cc30 100644
--- a/include/linux/tnum.h
+++ b/include/linux/tnum.h
@@ -40,6 +40,8 @@ struct tnum tnum_arshift(struct tnum a, u8 min_shift, u8 insn_bitness);
 struct tnum tnum_add(struct tnum a, struct tnum b);
 /* Subtract two tnums, return @a - @b */
 struct tnum tnum_sub(struct tnum a, struct tnum b);
+/* Neg of a tnum, return  0 - @a */
+struct tnum tnum_neg(struct tnum a);
 /* Bitwise-AND, return @a & @b */
 struct tnum tnum_and(struct tnum a, struct tnum b);
 /* Bitwise-OR, return @a | @b */
diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index 9dbc31b25e3d..fa353c5d550f 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -83,6 +83,11 @@ struct tnum tnum_sub(struct tnum a, struct tnum b)
 	return TNUM(dv & ~mu, mu);
 }
 
+struct tnum tnum_neg(struct tnum a)
+{
+	return tnum_sub(TNUM(0, 0), a);
+}
+
 struct tnum tnum_and(struct tnum a, struct tnum b)
 {
 	u64 alpha, beta, v;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 279a64933262..ef5ed37e03b6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15146,6 +15146,7 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 	switch (BPF_OP(insn->code)) {
 	case BPF_ADD:
 	case BPF_SUB:
+	case BPF_NEG:
 	case BPF_AND:
 	case BPF_XOR:
 	case BPF_OR:
@@ -15214,6 +15215,13 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		scalar_min_max_sub(dst_reg, &src_reg);
 		dst_reg->var_off = tnum_sub(dst_reg->var_off, src_reg.var_off);
 		break;
+	case BPF_NEG:
+		env->fake_reg[0] = *dst_reg;
+		__mark_reg_known(dst_reg, 0);
+		scalar32_min_max_sub(dst_reg, &env->fake_reg[0]);
+		scalar_min_max_sub(dst_reg, &env->fake_reg[0]);
+		dst_reg->var_off = tnum_neg(env->fake_reg[0].var_off);
+		break;
 	case BPF_MUL:
 		dst_reg->var_off = tnum_mul(dst_reg->var_off, src_reg.var_off);
 		scalar32_min_max_mul(dst_reg, &src_reg);
@@ -15437,7 +15445,14 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		}
 
 		/* check dest operand */
-		err = check_reg_arg(env, insn->dst_reg, DST_OP);
+		if (opcode == BPF_NEG) {
+			err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
+			err = err ?: adjust_scalar_min_max_vals(env, insn,
+							 &regs[insn->dst_reg],
+							 regs[insn->dst_reg]);
+		} else {
+			err = check_reg_arg(env, insn->dst_reg, DST_OP);
+		}
 		if (err)
 			return err;
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
index c506afbdd936..260a6df264e3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
@@ -159,13 +159,16 @@ __failure_unpriv
 __naked void deducing_bounds_from_const_10(void)
 {
 	asm volatile ("					\
+	r6 = r1;					\
 	r0 = 0;						\
 	if r0 s<= 0 goto l0_%=;				\
-l0_%=:	/* Marks reg as unknown. */			\
-	r0 = -r0;					\
-	r0 -= r1;					\
+l0_%=: /* Marks r0 as unknown. */			\
+	call %[bpf_get_prandom_u32];			\
+	r0 -= r6;					\
 	exit;						\
-"	::: __clobber_all);
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
 }
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
index fcea9819e359..799eccd181b5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
@@ -225,9 +225,7 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: known scalar += value_ptr unknown vs unknown (lt)")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
-__retval(1)
+__success __success_unpriv __retval(1)
 __naked void ptr_unknown_vs_unknown_lt(void)
 {
 	asm volatile ("					\
@@ -265,9 +263,7 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: known scalar += value_ptr unknown vs unknown (gt)")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
-__retval(1)
+__success __success_unpriv __retval(1)
 __naked void ptr_unknown_vs_unknown_gt(void)
 {
 	asm volatile ("					\
-- 
2.47.1


