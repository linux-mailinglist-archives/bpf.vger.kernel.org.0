Return-Path: <bpf+bounces-61412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC85AE6D71
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 19:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991373B9DCF
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 17:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7759E2E2F19;
	Tue, 24 Jun 2025 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KacyuA0T"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F138A13A86C
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750785805; cv=none; b=HHoCaLa5mlNyn6qrXRJxTVGQ414DkLqlg9niKfcWnVo5Gpkenus0gMMozKg1mr6yGT34iOLlQbc+EqMmB5/hxWuuPGbA87euEMZ6XyusEljbIfWYz0LdDE+n6C9aSHaeLsLKpkmUnxYlyWnTo4naKTIJfuYnmG/CEK+NC7L1BVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750785805; c=relaxed/simple;
	bh=4lNwum/fiLXIYrURhlroipKGnEHrsV0juTqt15sflYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jFAuEhLzczY05UbXWWSgJs9GHuEV74Hb7TXwgvpRLvZzAVlemDBgDP1I2CAAGmH5+RiAGJX+psufyHW/G4AVj66+b+94JIQw1mmh/Atbw7KA1sSvwQJzGsj5FRH5Ol3uF4vKAfouZxkeIKdi3PAsHz1LoZGKbiaRI4tyRRmMNb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KacyuA0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7B4C4CEE3;
	Tue, 24 Jun 2025 17:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750785803;
	bh=4lNwum/fiLXIYrURhlroipKGnEHrsV0juTqt15sflYo=;
	h=From:To:Cc:Subject:Date:From;
	b=KacyuA0TDPlxXYiFydObDdQExb/SZk1xur3bXLV9L3fs8sUijSf0v+73/jhBt/LGl
	 3p986GtyIkpKlBNAfSUY4Ltm8cMn4dqAWmj/33MzkhiPGYgI0u/EWmbRzfhcAuqA4E
	 6E9yvbFOz1naU06BRMG2vK7XX16FBEOjywmeiBTcDNwTFDTFCdEYjqDzo6BWijmCv7
	 fdn4s675U0Qt392zxQRWTopv9RNog/J5H2DWIRdvZoWe1y5Octb2Md6+R/O9YjjT4a
	 w6cBtzoNAGCZQ7uGQG9uaP7Cfb8G/Kj1byRTZRs/50rwSz5E5PmFulHbhfHKlIpdSH
	 xiB46femyzFZw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next] bpf: Add range tracking for BPF_NEG
Date: Tue, 24 Jun 2025 10:23:20 -0700
Message-ID: <20250624172320.2923031-1-song@kernel.org>
X-Mailer: git-send-email 2.47.1
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

Also add selftests to make sure the logic works as expected.

Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/tnum.h                          |  2 ++
 kernel/bpf/tnum.c                             |  5 ++++
 kernel/bpf/verifier.c                         | 18 ++++++++++-
 .../selftests/bpf/progs/verifier_precision.c  | 30 +++++++++++++++++++
 4 files changed, 54 insertions(+), 1 deletion(-)

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
index 279a64933262..93512596a590 100644
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
@@ -15214,6 +15215,14 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		scalar_min_max_sub(dst_reg, &src_reg);
 		dst_reg->var_off = tnum_sub(dst_reg->var_off, src_reg.var_off);
 		break;
+	case BPF_NEG:
+		struct bpf_reg_state dst_reg_copy = *dst_reg;
+
+		___mark_reg_known(dst_reg, 0);
+		scalar32_min_max_sub(dst_reg, &dst_reg_copy);
+		scalar_min_max_sub(dst_reg, &dst_reg_copy);
+		dst_reg->var_off = tnum_neg(dst_reg_copy.var_off);
+		break;
 	case BPF_MUL:
 		dst_reg->var_off = tnum_mul(dst_reg->var_off, src_reg.var_off);
 		scalar32_min_max_mul(dst_reg, &src_reg);
@@ -15437,7 +15446,14 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
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
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
index 9fe5d255ee37..bcff70f8cebb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -231,4 +231,34 @@ __naked void bpf_cond_op_not_r10(void)
 	::: __clobber_all);
 }
 
+SEC("lsm.s/socket_connect")
+__success
+__naked int bpf_neg_2(void)
+{
+	/*
+	 * lsm.s/socket_connect requires a return value within [-4095, 0].
+	 * Returning -1 is allowed
+	 */
+	asm volatile (
+	"r0 = 1;"
+	"w0 = -w0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("lsm.s/socket_connect")
+__failure __msg("At program exit the register R0 has")
+__naked int bpf_neg_3(void)
+{
+	/*
+	 * lsm.s/socket_connect requires a return value within [-4095, 0].
+	 * Returning -10000 is not allowed.
+	 */
+	asm volatile (
+	"r0 = 10000;"
+	"w0 = -w0;"
+	"exit;"
+	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.1


