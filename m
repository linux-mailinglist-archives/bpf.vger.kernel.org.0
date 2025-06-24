Return-Path: <bpf+bounces-61450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B7AAE7200
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1ABA7B1ACB
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 21:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D45D25A330;
	Tue, 24 Jun 2025 22:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYBBrWgo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895EA3D994
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 22:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750802451; cv=none; b=BIoOqqjCzdrltOH+KPJic6wisaEPSnoWImKcNrzfjUpAnWm/yMYER80736c89vcMHj0CFlcFNnr+IKhWQkVD5Zj513kokAC365vwfxHI/2l/5N6kailFJsV+s5FGfqUmtcPWaGtQv5eaWYX8bYEXlqAgwo/2TF8YOOoj5nxsC10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750802451; c=relaxed/simple;
	bh=gK+mCizgJ6+ZcVQi7Y/LCORz+wH5toYwgjBEnemcN2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kT92Yfmi2sTw0sEex9ukVpJAD4PYoxExufnuHPg02AtRewhcMYaeZ5f5u5qRTColZgX6TeKYvVlvpIQlNjoEg8ycMEd0LT+YcfgQTEH2xNP2Slu20SEUmsjnCubEcHYronZrq0J8/+uAP5rbwiuP9lprhnBPa0YvhNEVWgQ8Hqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYBBrWgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A82C4CEE3;
	Tue, 24 Jun 2025 22:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750802450;
	bh=gK+mCizgJ6+ZcVQi7Y/LCORz+wH5toYwgjBEnemcN2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eYBBrWgoGPQ1KVRECQMG5MQ3PinB7NNcOJxv/v1qrKMmmgAmVu6M41AZhuPUCGkqk
	 m6qU7PO/qZUnELh+4+tLinFwvgGqMeEhHUR/4qoc44eEkXAPOvKHZ9v7Nh9sQ3ANc9
	 8t5XkNtdT5TrhmSeScyMwFTvHviCpCxgVjM8hDFmlBjnfzXF42e5f0k87FEgslm+fq
	 HkFxQDpADW/eOQsTeD12Ou5F6JqaTGE1v0CY7Xcow9sY58PMp//dRQXPyYnRgAlFZ/
	 frPhqdFfSuSJdwwFuZdxMA6xemv+5KX+ZGw1GwFv+mxvnWhNk51c70CWkj/K+FeKKH
	 Suf7nuvv8gJPw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 1/2] bpf: Add range tracking for BPF_NEG
Date: Tue, 24 Jun 2025 15:00:37 -0700
Message-ID: <20250624220038.656646-2-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624220038.656646-1-song@kernel.org>
References: <20250624220038.656646-1-song@kernel.org>
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
 .../bpf/progs/verifier_bounds_deduction.c       | 17 -----------------
 .../bpf/progs/verifier_value_ptr_arith.c        |  8 ++------
 5 files changed, 25 insertions(+), 24 deletions(-)

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
index c506afbdd936..8d886c15fdcc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
@@ -151,21 +151,4 @@ l0_%=:	r0 -= r1;					\
 "	::: __clobber_all);
 }
 
-SEC("socket")
-__description("check deducing bounds from const, 10")
-__failure
-__msg("math between ctx pointer and register with unbounded min value is not allowed")
-__failure_unpriv
-__naked void deducing_bounds_from_const_10(void)
-{
-	asm volatile ("					\
-	r0 = 0;						\
-	if r0 s<= 0 goto l0_%=;				\
-l0_%=:	/* Marks reg as unknown. */			\
-	r0 = -r0;					\
-	r0 -= r1;					\
-	exit;						\
-"	::: __clobber_all);
-}
-
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


