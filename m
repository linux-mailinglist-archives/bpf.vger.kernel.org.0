Return-Path: <bpf+bounces-77728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAEFCEFA3B
	for <lists+bpf@lfdr.de>; Sat, 03 Jan 2026 03:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2D5A3016CCC
	for <lists+bpf@lfdr.de>; Sat,  3 Jan 2026 02:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A38A1F4190;
	Sat,  3 Jan 2026 02:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiocAv5z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB3B1E9906
	for <bpf@vger.kernel.org>; Sat,  3 Jan 2026 02:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767407050; cv=none; b=mOCiBdmETLYZkbwJWY6TPLCWABLWshi3R5usL3et6yhUTzxI6J9samsZmYkW5w3791O9VI34yaM5G+4233qy80tiddUCNGPpAW4fwHVuh3Vly2Cjp0JuxOJQDP9qly73IzE0bcRy2U3XskWJe84jRuWQsoTEPWYgG4hMi88bxts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767407050; c=relaxed/simple;
	bh=zzM2TP3ymOFNsHM1n1TYkBrSbCyoUviTxNifXwBnRfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWnuFkG4FbDmgcGOTU9WV1AFwjG3QYerkcf00W+tIyrqSeU9Mm8nPRr2seZzRZknqQM5B1I5KspaXReZ8rc050IqhkcXCPK/h+bBYKKUSE35H1R9LmKobL9mqD7CVNiBuH2P/ROVNiWLAI4P3yK7aSM6/eokaAeNfJy4mmcjEuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiocAv5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC08BC116B1;
	Sat,  3 Jan 2026 02:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767407048;
	bh=zzM2TP3ymOFNsHM1n1TYkBrSbCyoUviTxNifXwBnRfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JiocAv5zlguwzNaY98eQZxfiLWBkxNDtn4fEl0XdwuNprry7juDFttkB41WR8UZ4V
	 DAn+zDe4C7uFeF38KiXfNVq8rgHQH6UpHVyelBKo/rtQQRaJrPFRDGuZVBcOwT+FYK
	 5nM7Otpas81V1N9/7RiFOZ/s+TlfSMzQ9L8FevpiwbhXkR4bUWSsmkIxJH7I/VgzWk
	 srhd6JWrejxmY6L64jehrRQI/g7Zjr+4cu2IFmpOx5WvbVyUsO2fJ1fETpPh4b2P/R
	 EdIYsM931nMvkwXuUkGYZByQxHOmbcLHJIeUnxCH6e5mku3nRen0KoDvhlvhAOIH6O
	 imf6K1RlIWRCA==
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
	kernel-team@meta.com,
	sunhao.th@gmail.com
Subject: [PATCH bpf-next v3 1/2] bpf: Recognize special arithmetic shift in the verifier
Date: Fri,  2 Jan 2026 18:23:06 -0800
Message-ID: <20260103022310.935686-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260103022310.935686-1-puranjay@kernel.org>
References: <20260103022310.935686-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

cilium bpf_wiregard.bpf.c when compiled with -O1 fails to load
with the following verifier log:

192: (79) r2 = *(u64 *)(r10 -304)     ; R2=pkt(r=40) R10=fp0 fp-304=pkt(r=40)
...
227: (85) call bpf_skb_store_bytes#9          ; R0=scalar()
228: (bc) w2 = w0                     ; R0=scalar() R2=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
229: (c4) w2 s>>= 31                  ; R2=scalar(smin=0,smax=umax=0xffffffff,smin32=-1,smax32=0,var_off=(0x0; 0xffffffff))
230: (54) w2 &= -134                  ; R2=scalar(smin=0,smax=umax=umax32=0xffffff7a,smax32=0x7fffff7a,var_off=(0x0; 0xffffff7a))
...
232: (66) if w2 s> 0xffffffff goto pc+125     ; R2=scalar(smin=umin=umin32=0x80000000,smax=umax=umax32=0xffffff7a,smax32=-134,var_off=(0x80000000; 0x7fffff7a))
...
238: (79) r4 = *(u64 *)(r10 -304)     ; R4=scalar() R10=fp0 fp-304=scalar()
239: (56) if w2 != 0xffffff78 goto pc+210     ; R2=0xffffff78 // -136
...
258: (71) r1 = *(u8 *)(r4 +0)
R4 invalid mem access 'scalar'

The error might confuse most bpf authors, since fp-304 slot had 'pkt'
pointer at insn 192 and became 'scalar' at 238. That happened because
bpf_skb_store_bytes() clears all packet pointers including those in
the stack. On the first glance it might look like a bug in the source
code, since ctx->data pointer should have been reloaded after the call
to bpf_skb_store_bytes().

The relevant part of cilium source code looks like this:

// bpf/lib/nodeport.h
int dsr_set_ipip6()
{
	if (ctx_adjust_hroom(...))
		return DROP_INVALID; // -134
	if (ctx_store_bytes(...))
		return DROP_WRITE_ERROR; // -141
	return 0;
}

bool dsr_fail_needs_reply(int code)
{
	if (code == DROP_FRAG_NEEDED) // -136
		return true;
	return false;
}

tail_nodeport_ipv6_dsr()
{
	ret = dsr_set_ipip6(...);
	if (!IS_ERR(ret)) {
		...
	} else {
		if (dsr_fail_needs_reply(ret))
			return dsr_reply_icmp6(...);
	}
}

The code doesn't have arithmetic shift by 31 and it reloads ctx->data
every time it needs to access it. So it's not a bug in the source code.

The reason is DAGCombiner::foldSelectCCToShiftAnd() LLVM transformation:

  // If this is a select where the false operand is zero and the compare is a
  // check of the sign bit, see if we can perform the "gzip trick":
  // select_cc setlt X, 0, A, 0 -> and (sra X, size(X)-1), A
  // select_cc setgt X, 0, A, 0 -> and (not (sra X, size(X)-1)), A

The conditional branch in dsr_set_ipip6() and its return values
are optimized into BPF_ARSH plus BPF_AND:

227: (85) call bpf_skb_store_bytes#9
228: (bc) w2 = w0
229: (c4) w2 s>>= 31   ; R2=scalar(smin=0,smax=umax=0xffffffff,smin32=-1,smax32=0,var_off=(0x0; 0xffffffff))
230: (54) w2 &= -134   ; R2=scalar(smin=0,smax=umax=umax32=0xffffff7a,smax32=0x7fffff7a,var_off=(0x0; 0xffffff7a))

after insn 230 the register w2 can only be 0 or -134,
but the verifier approximates it, since there is no way to
represent two scalars in bpf_reg_state.
After fallthough at insn 232 the w2 can only be -134,
hence the branch at insn
239: (56) if w2 != -136 goto pc+210
should be always taken, and trapping insn 258 should never execute.
LLVM generated correct code, but the verifier follows impossible
path and rejects valid program. To fix this issue recognize this
special LLVM optimization and fork the verifier state.
So after insn 229: (c4) w2 s>>= 31
the verifier has two states to explore:
one with w2 = 0 and another with w2 = 0xffffffff
which makes the verifier accept bpf_wiregard.c

Note there are 20+ such patterns in bpf_wiregard.o compiled
with -O1 and -O2, but they're rarely seen in other production
bpf programs, so push_stack() approach is not a concern.

Reported-by: Hao Sun <sunhao.th@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c9da70dd3e72..6dbcfae5615b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15490,6 +15490,35 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 	}
 }
 
+static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			      struct bpf_reg_state *dst_reg)
+{
+	struct bpf_verifier_state *branch;
+	struct bpf_reg_state *regs;
+	bool alu32;
+
+	if (dst_reg->smin_value == -1 && dst_reg->smax_value == 0)
+		alu32 = false;
+	else if (dst_reg->s32_min_value == -1 && dst_reg->s32_max_value == 0)
+		alu32 = true;
+	else
+		return 0;
+
+	branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
+	if (IS_ERR(branch))
+		return PTR_ERR(branch);
+
+	regs = branch->frame[branch->curframe]->regs;
+	if (alu32) {
+		__mark_reg32_known(&regs[insn->dst_reg], 0);
+		__mark_reg32_known(dst_reg, -1ull);
+	} else {
+		__mark_reg_known(&regs[insn->dst_reg], 0);
+		__mark_reg_known(dst_reg, -1ull);
+	}
+	return 0;
+}
+
 /* WARNING: This function does calculations on 64-bit values, but the actual
  * execution may occur on 32-bit values. Therefore, things like bitshifts
  * need extra checks in the 32-bit case.
@@ -15552,6 +15581,11 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		scalar_min_max_mul(dst_reg, &src_reg);
 		break;
 	case BPF_AND:
+		if (tnum_is_const(src_reg.var_off)) {
+			ret = maybe_fork_scalars(env, insn, dst_reg);
+			if (ret)
+				return ret;
+		}
 		dst_reg->var_off = tnum_and(dst_reg->var_off, src_reg.var_off);
 		scalar32_min_max_and(dst_reg, &src_reg);
 		scalar_min_max_and(dst_reg, &src_reg);
-- 
2.47.3


