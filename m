Return-Path: <bpf+bounces-79256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D09DD326D9
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88D843042243
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39132FE58C;
	Fri, 16 Jan 2026 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9Hf92ga"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CCF2E9759
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768572894; cv=none; b=OBa+7HycZkt6+hnk9VtHmsaWQyYkrwq/WGkcmQwL06M0nFc7XgIhK+P0OFRexJ9H64Wc0ZCIvfaFaLQwIlKd2R5bBbv+XrY3LZkU7R3fFlK9AUl3XiLUzIVPs9BeBy+bTpkCwn7mZ+f7mJ21vC60/Cjy7tW/NSBcMoBbo5h2kn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768572894; c=relaxed/simple;
	bh=su9nfqjzN1/lTmpnRSuhwOkfhP8+tDk/VYv64gBLUGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4ZCowJ1clyr4rIs2NXRQbOXolMMbzYu2IbBTNYMdi8wKjTkjSwMUePl0fSNvZFhXet6QoT5kLLQ/AX3mHAZVgqtxQZBt8tD9Qdj5L5EgCeL8atOMIJjYxW+viC0BgXGE6MwXVMd7+aTtEmm/wFSAK/CfDcpbq6rKhzxwcQjoAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9Hf92ga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F3AC116C6;
	Fri, 16 Jan 2026 14:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768572892;
	bh=su9nfqjzN1/lTmpnRSuhwOkfhP8+tDk/VYv64gBLUGw=;
	h=From:To:Cc:Subject:Date:From;
	b=i9Hf92gaPCu3NgzQHXV3FAlvFJEb9jImfdVughJwbNGlNdWsxtP6uXur17xCKAXm6
	 317PaAZypJofPFxs9qbUlyXqFjhMIOFgLFyGs6pf5hKs+Yt5zRfrwynw2SYxATaJ47
	 8aDDabnLhGJhfYQxBwi1OyLVId2aqtaRlXOrU32eAe3yfFEu9ahnIu9l/f61UsZjIa
	 a373EtKLliJ3t71GRfgY5JbSanoAk67y6eSTaBTbHk5CPBdL1tNYdS2xi05p8TutRA
	 x10Wn/6NSt0OVDAywjDe5vm9xYSsAonznlCOvqI0T21rMSOv+fuLCwFNPl9xmhrVBM
	 R+jWhwPoHQPEw==
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
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next] bpf: verifier: Make sync_linked_regs() scratch registers
Date: Fri, 16 Jan 2026 06:14:35 -0800
Message-ID: <20260116141436.3715322-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sync_linked_regs() is called after a conditional jump to propagate new
bounds of a register to all its liked registers. But the verifier log
only prints the state of the register that is part of the conditional
jump.

Make sync_linked_regs() scratch the registers whose bounds have been
updated by propagation from a known register.

Before:

0: (85) call bpf_get_prandom_u32#7    ; R0=scalar()
1: (57) r0 &= 255                     ; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
2: (bf) r1 = r0                       ; R0=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff)) R1=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
3: (07) r1 += 4                       ; R1=scalar(id=1+4,smin=umin=smin32=umin32=4,smax=umax=smax32=umax32=259,var_off=(0x0; 0x1ff))
4: (a5) if r1 < 0xa goto pc+2         ; R1=scalar(id=1+4,smin=umin=smin32=umin32=10,smax=umax=smax32=umax32=259,var_off=(0x0; 0x1ff))
5: (35) if r0 >= 0x6 goto pc+1

After:

0: (85) call bpf_get_prandom_u32#7    ; R0=scalar()
1: (57) r0 &= 255                     ; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
2: (bf) r1 = r0                       ; R0=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff)) R1=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
3: (07) r1 += 4                       ; R1=scalar(id=1+4,smin=umin=smin32=umin32=4,smax=umax=smax32=umax32=259,var_off=(0x0; 0x1ff))
4: (a5) if r1 < 0xa goto pc+2         ; R0=scalar(id=1+0,smin=umin=smin32=umin32=6,smax=umax=smax32=umax32=255) R1=scalar(id=1+4,smin=umin=smin32=umin32=10,smax=umax=smax32=umax32=259,var_off=(0x0; 0x1ff))
5: (35) if r0 >= 0x6 goto pc+1

The conditional jump in 4 updates the bound of R1 and the new bounds are
propogated to R0 as it is linked with the same id, before this change,
verifier only printed the state for R1 but after it prints for both R0
and R1.

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7a375f608263..111d27d68d97 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16846,8 +16846,8 @@ static void collect_linked_regs(struct bpf_verifier_state *vstate, u32 id,
 /* For all R in linked_regs, copy known_reg range into R
  * if R->id == known_reg->id.
  */
-static void sync_linked_regs(struct bpf_verifier_state *vstate, struct bpf_reg_state *known_reg,
-			     struct linked_regs *linked_regs)
+static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_state *vstate,
+			     struct bpf_reg_state *known_reg, struct linked_regs *linked_regs)
 {
 	struct bpf_reg_state fake_reg;
 	struct bpf_reg_state *reg;
@@ -16888,6 +16888,10 @@ static void sync_linked_regs(struct bpf_verifier_state *vstate, struct bpf_reg_s
 			scalar_min_max_add(reg, &fake_reg);
 			reg->var_off = tnum_add(reg->var_off, fake_reg.var_off);
 		}
+		if (e->is_reg)
+			mark_reg_scratched(env, e->regno);
+		else
+			mark_stack_slot_scratched(env, e->spi);
 	}
 }
 
@@ -17074,13 +17078,15 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	if (BPF_SRC(insn->code) == BPF_X &&
 	    src_reg->type == SCALAR_VALUE && src_reg->id &&
 	    !WARN_ON_ONCE(src_reg->id != other_branch_regs[insn->src_reg].id)) {
-		sync_linked_regs(this_branch, src_reg, &linked_regs);
-		sync_linked_regs(other_branch, &other_branch_regs[insn->src_reg], &linked_regs);
+		sync_linked_regs(env, this_branch, src_reg, &linked_regs);
+		sync_linked_regs(env, other_branch, &other_branch_regs[insn->src_reg],
+				 &linked_regs);
 	}
 	if (dst_reg->type == SCALAR_VALUE && dst_reg->id &&
 	    !WARN_ON_ONCE(dst_reg->id != other_branch_regs[insn->dst_reg].id)) {
-		sync_linked_regs(this_branch, dst_reg, &linked_regs);
-		sync_linked_regs(other_branch, &other_branch_regs[insn->dst_reg], &linked_regs);
+		sync_linked_regs(env, this_branch, dst_reg, &linked_regs);
+		sync_linked_regs(env, other_branch, &other_branch_regs[insn->dst_reg],
+				 &linked_regs);
 	}
 
 	/* if one pointer register is compared to another pointer

base-commit: 934d9746ed0206e93506a68c838fe82ef748576a
-- 
2.47.3


