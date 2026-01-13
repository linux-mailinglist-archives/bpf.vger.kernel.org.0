Return-Path: <bpf+bounces-78726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D86F8D19DE3
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 16:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B54853015189
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 15:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9CF38E5ED;
	Tue, 13 Jan 2026 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxXIuFWX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25DD257848
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317952; cv=none; b=KLA7Bfvuw47VHgI0KXz6jpwJOHRkgNZNd0oEZST6qZ/wsQ8RkqUBy3GAzLZsR7muasGptqSiDopipP+sZh7quHIQfVe819pZdCBM9NZpi7l+89yU0Voyei3QJoZWcb9Jk/2Dne1dhmGwmASE5VEylALh7iZZ74wVxUwXVmiVna0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317952; c=relaxed/simple;
	bh=IGoiE+F+LDZqSlak9hJSJauJ2DgmB5hO8U2Yxn6+4WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpHopkUIiobB3FjHJyM5BpjrEIvVuzmo629NqHlBrEzr2jRTte0uGjQAjTdosCpB9qnp+/o5gAGz2qDc1AtRqDF8jt/cX3urzO8BOIRaU0+H/YG5F/HFvshlO2oUZeQWd3Qh05tlmpyZpyLruO4GA/hZ0OL8RtV0PEFZhKHQa4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxXIuFWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7EBC116C6;
	Tue, 13 Jan 2026 15:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768317952;
	bh=IGoiE+F+LDZqSlak9hJSJauJ2DgmB5hO8U2Yxn6+4WQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZxXIuFWXGFa81cFDrt+RQGB0UgLvqC8zrrjSBFAbhZ2OjbnTXcoojm6wfLYF/Wh5C
	 kPdHARSa8Ecwuv0PRk6+EJy3iyFljtsJ8/O/bw0AZ50awAdvh+3/ZLS1tXQTM6TBlW
	 Kv7TYJkmaFmdINF1MGHfhR77GGUC+lEZXTeCskSuwSFQfABn1JgRTyG01yck5TgUa4
	 e2z4vPmO53wyf59EhPMY0svxqI9fOQS/Zzf/nbbOyDIHHVn3J1rZfQMBheT9zS406d
	 FXpPM7riMyI6DDVZXzUsgGONoe89R1yIJa74vu20ZlGDwybZIoi/m5oRL9PGzq1MGU
	 NZg5xNwj1kyJA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/2] bpf: Support negative offsets, BPF_SUB, and alu32 for linked register tracking
Date: Tue, 13 Jan 2026 07:25:25 -0800
Message-ID: <20260113152529.3217648-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113152529.3217648-1-puranjay@kernel.org>
References: <20260113152529.3217648-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, the verifier only tracked positive constant deltas between
linked registers using BPF_ADD. This limitation meant patterns like:

  r1 = r0
  r1 += -4
  if r1 s>= 0 goto ...   // r1 >= 0 implies r0 >= 4
  // verifier couldn't propagate bounds back to r0

Similar limitation existed for 32 bit registers.

With this change, the verifier can now track negative deltas in reg->off
enabling bound propagation for the above pattern.

32-bit registers are supported by splitting BPF_ADD_CONST into
BPF_ADD_CONST32 and BPF_ADD_CONST64, adjust_reg_min_max_vals() now
encodes precise information in dst_reg->id about if the value was
created using a 32 or 64 bit ALU operation. sync_linked_regs() uses this
information to zext the register if 32-bit operation was used.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/bpf_verifier.h                  |  8 +++-
 kernel/bpf/verifier.c                         | 39 +++++++++++++------
 .../selftests/bpf/progs/verifier_bounds.c     |  2 +-
 3 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 130bcbd66f60..b938c88f99af 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -146,9 +146,13 @@ struct bpf_reg_state {
 	 * Upper bit of ID is used to remember relationship between "linked"
 	 * registers. Example:
 	 * r1 = r2;    both will have r1->id == r2->id == N
-	 * r1 += 10;   r1->id == N | BPF_ADD_CONST and r1->off == 10
+	 * r1 += 10;   r1->id == N | BPF_ADD_CONST64 and r1->off == 10
+	 * r3 = r2;    both will have r3->id == r2->id == N
+	 * w3 += 10;   r3->id == N | BPF_ADD_CONST32 and r3->off == 10
 	 */
-#define BPF_ADD_CONST (1U << 31)
+#define BPF_ADD_CONST64 (1U << 31)
+#define BPF_ADD_CONST32 (1U << 30)
+#define BPF_ADD_CONST (BPF_ADD_CONST64 | BPF_ADD_CONST32)
 	u32 id;
 	/* PTR_TO_SOCKET and PTR_TO_TCP_SOCK could be a ptr returned
 	 * from a pointer-cast helper, bpf_sk_fullsock() and
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 53635ea2e41b..8a4f00d237ee 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15706,26 +15706,41 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	 * r1 += 0x1
 	 * if r2 < 1000 goto ...
 	 * use r1 in memory access
-	 * So for 64-bit alu remember constant delta between r2 and r1 and
-	 * update r1 after 'if' condition.
+	 * So remember constant delta between r2 and r1 and update r1 after
+	 * 'if' condition.
 	 */
 	if (env->bpf_capable &&
-	    BPF_OP(insn->code) == BPF_ADD && !alu32 &&
-	    dst_reg->id && is_reg_const(src_reg, false)) {
-		u64 val = reg_const_value(src_reg, false);
+	    (BPF_OP(insn->code) == BPF_ADD || BPF_OP(insn->code) == BPF_SUB) &&
+	    dst_reg->id && is_reg_const(src_reg, alu32)) {
+		u64 val = reg_const_value(src_reg, alu32);
+		s32 off;
 
-		if ((dst_reg->id & BPF_ADD_CONST) ||
-		    /* prevent overflow in sync_linked_regs() later */
-		    val > (u32)S32_MAX) {
+		if (!alu32 && ((s64)val < S32_MIN || (s64)val > S32_MAX))
+			goto clear_id;
+
+		off = (s32)val;
+
+		if (BPF_OP(insn->code) == BPF_SUB) {
+			/* Negating S32_MIN would overflow */
+			if (off == S32_MIN)
+				goto clear_id;
+			off = -off;
+		}
+
+		if (dst_reg->id & BPF_ADD_CONST) {
 			/*
 			 * If the register already went through rX += val
 			 * we cannot accumulate another val into rx->off.
 			 */
+clear_id:
 			dst_reg->off = 0;
 			dst_reg->id = 0;
 		} else {
-			dst_reg->id |= BPF_ADD_CONST;
-			dst_reg->off = val;
+			if (alu32)
+				dst_reg->id |= BPF_ADD_CONST32;
+			else
+				dst_reg->id |= BPF_ADD_CONST64;
+			dst_reg->off = off;
 		}
 	} else {
 		/*
@@ -16821,7 +16836,7 @@ static void sync_linked_regs(struct bpf_verifier_state *vstate, struct bpf_reg_s
 			s32 saved_off = reg->off;
 
 			fake_reg.type = SCALAR_VALUE;
-			__mark_reg_known(&fake_reg, (s32)reg->off - (s32)known_reg->off);
+			__mark_reg_known(&fake_reg, (s64)reg->off - (s64)known_reg->off);
 
 			/* reg = known_reg; reg += delta */
 			copy_register_state(reg, known_reg);
@@ -16835,6 +16850,8 @@ static void sync_linked_regs(struct bpf_verifier_state *vstate, struct bpf_reg_s
 			scalar32_min_max_add(reg, &fake_reg);
 			scalar_min_max_add(reg, &fake_reg);
 			reg->var_off = tnum_add(reg->var_off, fake_reg.var_off);
+			if (reg->id & BPF_ADD_CONST32)
+				zext_32_to_64(reg);
 		}
 	}
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 411a18437d7e..560531404bce 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1477,7 +1477,7 @@ __naked void sub64_full_overflow(void)
 SEC("socket")
 __description("64-bit subtraction, partial overflow, result in unbounded reg")
 __success __log_level(2)
-__msg("3: (1f) r3 -= r2 {{.*}} R3=scalar()")
+__msg("3: (1f) r3 -= r2 {{.*}} R3=scalar(id=1-1)")
 __retval(0)
 __naked void sub64_partial_overflow(void)
 {
-- 
2.47.3


