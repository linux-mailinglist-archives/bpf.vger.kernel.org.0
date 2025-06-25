Return-Path: <bpf+bounces-61547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0084AE8A13
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 18:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E68018870C1
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 16:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E502D4B66;
	Wed, 25 Jun 2025 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJKZEigC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5322C3769
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869636; cv=none; b=fWfFnxnA/gq0X+qC+J+WcEqCPNAraRaXJUXjNwZd1eqQTm5Pt77oUc9cMbNM5tCNBqt9+RPeqdccUIeuskmIhNk9bMd0NETlVqOYiA69G7aw1OwFSuBAfwYh4NB8PbwIzcl9i308AiOt1f8LENmD3M1p7EOXA0FHwNU5xYimamA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869636; c=relaxed/simple;
	bh=pFg/En6WFfo3z1aCgdXGpUon+Bc4CQCKKruQBdnnJPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mc5foj7LUp/BmnnWUOUmgyjRrEfX58ST+JTtYvEuSHm3WeqriACiqag+0ue3eEwPQ9g0xMaGpSys23E4/s7TG6HFIarAsY1ijvjfz4dsI2fSepJ1ZJLzw9zeSDU1cw2tcUmQ/b6VwkItSmuJFP9n8SVwE13S7fvQ7r6fPPJ8rSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJKZEigC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14316C4CEEA;
	Wed, 25 Jun 2025 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750869636;
	bh=pFg/En6WFfo3z1aCgdXGpUon+Bc4CQCKKruQBdnnJPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cJKZEigCxbdRXqu27yBuoccF0WoAniPQc3D8U5x/rDnV7DXjbP5ixBpyNzvuvQiY9
	 GFgr8hxWYVRHoizS2Zu3ipi9rckM39waHhghESTiCZZlHNum7B/92lmo+tFGq1NnTy
	 Fh6xnlwzQYMPAtVu/I4Bg1O3UuOKTSMpOBzTm4Ois/P44QEwNH7o/vDAon36bfbafi
	 j75rGYxXFQUUaDrD8qAdLJwmU9bxdALK5+WCxtohCoWBxefnU6LYd0wbdnPROewZU9
	 ZTa8UUe94iALdKo1zd4yHVLm8i8TCxn0hRBUa+Uk8eihIIq+wmpK3x0X/ZWNqn2WWp
	 ngzrCD6g08dvg==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Song Liu <song@kernel.org>
Subject: [PATCH v4 bpf-next 1/2] bpf: Add range tracking for BPF_NEG
Date: Wed, 25 Jun 2025 09:40:24 -0700
Message-ID: <20250625164025.3310203-2-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250625164025.3310203-1-song@kernel.org>
References: <20250625164025.3310203-1-song@kernel.org>
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
 include/linux/tnum.h                          |  2 ++
 kernel/bpf/tnum.c                             |  5 +++++
 kernel/bpf/verifier.c                         | 17 +++++++++++++-
 .../bpf/progs/verifier_bounds_deduction.c     | 11 ++++++----
 .../bpf/progs/verifier_value_ptr_arith.c      | 22 ++++++++++++++-----
 5 files changed, 46 insertions(+), 11 deletions(-)

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
index f403524bd215..2ff22ef42348 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15182,6 +15182,7 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 	switch (BPF_OP(insn->code)) {
 	case BPF_ADD:
 	case BPF_SUB:
+	case BPF_NEG:
 	case BPF_AND:
 	case BPF_XOR:
 	case BPF_OR:
@@ -15250,6 +15251,13 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
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
@@ -15473,7 +15481,14 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
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
index fcea9819e359..af7938ce56cb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
@@ -231,6 +231,10 @@ __retval(1)
 __naked void ptr_unknown_vs_unknown_lt(void)
 {
 	asm volatile ("					\
+	r8 = r1;					\
+	call %[bpf_get_prandom_u32];			\
+	r9 = r0;					\
+	r1 = r8;					\
 	r0 = *(u32*)(r1 + %[__sk_buff_len]);		\
 	r1 = 0;						\
 	*(u64*)(r10 - 8) = r1;				\
@@ -245,11 +249,11 @@ l1_%=:	call %[bpf_map_lookup_elem];			\
 	r4 = *(u8*)(r0 + 0);				\
 	if r4 == 1 goto l3_%=;				\
 	r1 = 6;						\
-	r1 = -r1;					\
+	r1 = r9;					\
 	r1 &= 0x3;					\
 	goto l4_%=;					\
 l3_%=:	r1 = 6;						\
-	r1 = -r1;					\
+	r1 = r9;					\
 	r1 &= 0x7;					\
 l4_%=:	r1 += r0;					\
 	r0 = *(u8*)(r1 + 0);				\
@@ -259,7 +263,8 @@ l2_%=:	r0 = 1;						\
 	: __imm(bpf_map_lookup_elem),
 	  __imm_addr(map_array_48b),
 	  __imm_addr(map_hash_16b),
-	  __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len))
+	  __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len)),
+	  __imm(bpf_get_prandom_u32)
 	: __clobber_all);
 }
 
@@ -271,6 +276,10 @@ __retval(1)
 __naked void ptr_unknown_vs_unknown_gt(void)
 {
 	asm volatile ("					\
+	r8 = r1;					\
+	call %[bpf_get_prandom_u32];			\
+	r9 = r0;					\
+	r1 = r8;					\
 	r0 = *(u32*)(r1 + %[__sk_buff_len]);		\
 	r1 = 0;						\
 	*(u64*)(r10 - 8) = r1;				\
@@ -285,11 +294,11 @@ l1_%=:	call %[bpf_map_lookup_elem];			\
 	r4 = *(u8*)(r0 + 0);				\
 	if r4 == 1 goto l3_%=;				\
 	r1 = 6;						\
-	r1 = -r1;					\
+	r1 = r9;					\
 	r1 &= 0x7;					\
 	goto l4_%=;					\
 l3_%=:	r1 = 6;						\
-	r1 = -r1;					\
+	r1 = r9;					\
 	r1 &= 0x3;					\
 l4_%=:	r1 += r0;					\
 	r0 = *(u8*)(r1 + 0);				\
@@ -299,7 +308,8 @@ l2_%=:	r0 = 1;						\
 	: __imm(bpf_map_lookup_elem),
 	  __imm_addr(map_array_48b),
 	  __imm_addr(map_hash_16b),
-	  __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len))
+	  __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len)),
+	  __imm(bpf_get_prandom_u32)
 	: __clobber_all);
 }
 
-- 
2.47.1


