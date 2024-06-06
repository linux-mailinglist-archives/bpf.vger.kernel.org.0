Return-Path: <bpf+bounces-31473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E7E8FDBAD
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 02:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A0D1F23F43
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 00:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1931FDDDC;
	Thu,  6 Jun 2024 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmu/j9ht"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83C0D528
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 00:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635276; cv=none; b=bV3Eq++cWiBbpwCNXTwTY0+v2brc5qKvfq9aCzmRNQpuXJ2Zkqv9bH7jzzLM36+N6DEuKLPpu6jTrfPSbAchJvilw5kLuqsrKudmlMKBj6kEsVXQXOHPUizb9aMGDE+DzZ/z/7Buo7vvv8sJsyJvSzkyGBEo21wlTrAuXPJW5K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635276; c=relaxed/simple;
	bh=gteROIpTVyoEaqhQdHXZv7b+6Iu7goooQ2Q3rVlw5PQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GdmfHAGZVj+KrlMxMp4+eW3hwweizfmBJwaM5iYvyRP2aMVuYsene0aRCSReRGcoVIC6oua3gQnNY4tmQfIF5MLaYias3YVgWO9po4UtDZ0yOegzIvY1eiyBFp/3N/L1uExQbVMwAIOjdeuB6PrJcoAY+7FbjImnMiKOV9hIFLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmu/j9ht; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c1a99b75d8so313197a91.3
        for <bpf@vger.kernel.org>; Wed, 05 Jun 2024 17:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717635273; x=1718240073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L936NufUn/2BJfFq8Tp98ADzgIgCfWnlpdPPNS1eijY=;
        b=cmu/j9htq1togYc65aayLgX/jx/RWi7m5Cgf1/kiHKToTAvHSaWHlq+AtKe0p9N10L
         xw/kttjun6l+3gvxtUZ6NAlXeNwqAPZ0Xq71C4fuZs20YUymA20bL/UK06qaSvqwDORU
         DiuHtWhBjcRzVkF1kDmRl3zZOZrYC9XTO8oITgW4spsrMV2WkOfAAczFP/McYFiwZ2CV
         PHpOBYipb1HAceu+9hUaJvtoaJxFfPz9mfhj2G+k8UzO95U0PLzbYrOpBNY21GrutjGH
         o7yp7LQ5mtmJC9ZvxCE6/DzwrZLEi7bk/CQVwZOpbw1g4Xegq/7Rb1xzgJk05coLTO12
         W7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717635273; x=1718240073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L936NufUn/2BJfFq8Tp98ADzgIgCfWnlpdPPNS1eijY=;
        b=ccqm6MI9HSuYpIc+Kily4MGh2Fjv/K+W7U35qEpH1L8ok2JivkB95OH8hRSn3lrqN/
         zWzjSuHdreZxIjmn+Ng0XNrOFXC909rAM8cJtZPFSxuHskgMIBJxhlFAm40GqZh/1G2S
         wF9dBuK0OnwYWcgAtIorsUu/r+3i2fCl/hgle349MkVB8brwitUel+9JmGawCDz9m9nq
         j+owK0WwyJ2jQrbNm+dPobHazKBCCWwJhye8W6nHbWbdSqbNcv4i+s0Hhbt4s9ppgBFq
         8JM3f1TRtV61n/LtzIgeWyxPXjvcez8VSTGDYmtub+HKGL0GSHHQONut6etJzdq2oWY2
         DboA==
X-Gm-Message-State: AOJu0Yxi/e8vXd0gKbFdFDDX/qUCZg2x7hMVmIBaawSiZJ5nRFPGniyK
	KE4baTO5MstLpwN2NW087nAVBe0G3mjohlXAhI8ON+b5DIk9K5lAEByM4A==
X-Google-Smtp-Source: AGHT+IFR9JFmdFxO5kYhRII6Rg6nD9jy8H7spxj8+cT/IFjVcidUALur+2pBigia9L0D3/MuHEu8Nw==
X-Received: by 2002:a17:90a:3489:b0:2b5:6e92:1096 with SMTP id 98e67ed59e1d1-2c27db19e2amr4119580a91.28.1717635272831;
        Wed, 05 Jun 2024 17:54:32 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:5ca2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2806399c5sm2178658a91.9.2024.06.05.17.54.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Jun 2024 17:54:32 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v5 bpf-next 2/3] bpf: Relax precision marking in open coded iters and may_goto loop.
Date: Wed,  5 Jun 2024 17:54:24 -0700
Message-Id: <20240606005425.38285-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240606005425.38285-1-alexei.starovoitov@gmail.com>
References: <20240606005425.38285-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v1->v2->v3:
- Algorithm changed completely between revisions:
  v1: https://lore.kernel.org/bpf/20240522024713.59136-1-alexei.starovoitov@gmail.com/
  v2: https://lore.kernel.org/bpf/20240523064219.42465-1-alexei.starovoitov@gmail.com/
v3->v4:
- Fixed widening for Rx < Ry case and added more tests
  v4: https://lore.kernel.org/bpf/20240601034211.63962-1-alexei.starovoitov@gmail.com/
v4->v5:
- Algorithm changed again:
. Widen either lower or upper scalar range instead of both. See widen_reg().
. Recognize predicted == or != and convert to <, > when possible
  and follow that branch only after propagating precision.
. Apply to scalar constant only.
These changes made big difference for arena progs. In v4 arena tests were in the noise.

Motivations for the patch
-------------------------
1.
Open coded iterators and may_goto is a great mechanism to implement loops,
but counted loops are problematic. For example:
  for (i = 0; i < 100 && can_loop; i++)
is verified as a bounded loop, since i < 100 condition forces the verifier to
mark 'i' as precise and loop states at different iterations are not equivalent.
That removes the benefit of open coded iterators and may_goto.
The workaround is to do:
  int zero = 0; /* global or volatile variable */
  for (i = zero; i < 100 && can_loop; i++)
to hide from the verifier the value of 'i'.
It's unnatural and so far users didn't learn such odd programming pattern.

This patch aims to improve the verifier to support
  for (i = 0; i < 100000 && can_loop; i++)
as open coded iter loop (when 'i' doesn't need to be precise).

Note, i = zero workaround disables bounded loop logic.
Open coded iterator bpf_for(i, 0, 100) also disables bounded loop logic,
hence apply heuristic in this patch only for iters and may_goto.

2.
Arena based program spent significant amount of verification time
propagating precision due to predicted conditional branches,
but this precision is useless work, since arena access doesn't
require precision unlike regular map access.
The difference before/after:
File                    Insns (A)  Insns (B)  Insns     (DIFF)
----------------------  ---------  ---------  ----------------
arena_htab.bpf.o            18656        781  -17875 (-95.81%)
arena_htab_asm.bpf.o        18523        598  -17925 (-96.77%)
arena_list.bpf.o             1685       1780      +95 (+5.64%)

Algorithm
---------
First of all:
   if (is_may_goto_insn_at(env, insn_idx)) {
+          update_loop_entry(cur, &sl->state);
           if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
-                  update_loop_entry(cur, &sl->state);

It changes the definition of the verifier states loop.
Previously, we considered a state loop to be such a sequence of states
Si -> ... -> Sj -> ... -> Sk that states_equal(Si, Sk, RANGE_WITHIN)
is true.

With this change Si -> ... -> Sj -> ... Sk is a loop if call sites and
instruction pointers for Si and Sk match.

Whether or not Si and Sk are in the loop influences two things:
(a) if exact comparison is needed for states cache;
(b) if widening transformation could be applied to some scalars.

All pairs (Si, Sk) marked as a loop using old definition would be
marked as such using new definition (in a addition to some new pairs).

Hence it is safe to apply (a) and (b) in strictly more cases.

Note that update_loop_entry() relies on the following properties:
- every state in the current DFS path (except current)
  has branches > 0;
- states not in the DFS path are either:
  - in explored_states, are fully explored and have branches == 0;
  - in env->stack, are not yet explored and have branches == 0
    (and also not reachable from is_state_visited()).

With that the get_loop_entry() can be used to gate is_branch_taken() logic.
When the verifier sees 'r1 > 1000' inside the loop and it can predict it
instead of marking r1 as precise it widens both branches, so r1 becomes
[0, 1000] in fallthrough and [1001, UMAX] in other_branch.

Consider the loop:
    bpf_for_each(...) {
       if (r1 > 1000)
          break;

       arr[r1] = ..;
    }
At arr[r1] access the r1 is bounded and the loop can quickly converge.

Unfortunately compilers (both GCC and LLVM) often optimize loop exit
condition to equality, so
 for (i = 0; i < 100; i++) arr[i] = 1
becomes
 for (i = 0; i != 100; i++) arr[1] = 1

Hence treat != and == conditions specially in the verifier. When equality
condition is predicted check whether dst is < or > than src. Example:
  r1 = 10
  goto L1
L2:
  arr[r1] = 1
  r1++
L1:
  if r1 != 100 goto L2

This branch will be predicted as fallthrough, check that r1 < 100
and if so, widen r1 = [10, 99] in fallthrough and
r1 = [100, UMAX] in other branch.

With that the users can use 'for (i = 0; ...' pattern everywhere
and many i = zero workarounds can be removed.

The tests with open coded iters see dramatic improvement. The rest are noise.
File                  Program                          Insns (A)  Insns (B)  Insns       (DIFF)  Verdict (A)  Verdict (B)
--------------------  -------------------------------  ---------  ---------  ------------------  -----------  -----------
iters_task_vma.bpf.o  iter_task_vma_for_each               22043        132    -21911 (-99.40%)  success      success
iters_task_vma.bpf.o  iter_task_vma_for_each_eq            22043        131    -21912 (-99.41%)  success      success
iters_task_vma.bpf.o  loop_inside_iter                   1000001        148   -999853 (-99.99%)  failure      success
iters_task_vma.bpf.o  loop_inside_iter_signed            1000001        148   -999853 (-99.99%)  failure      success
iters_task_vma.bpf.o  loop_inside_iter_subprog           1000001         64   -999937 (-99.99%)  failure      success
iters_task_vma.bpf.o  loop_inside_iter_volatile_limit    1000001        134   -999867 (-99.99%)  failure      success

The bottom 4 tests were unverifiable before due to limitations of bounded loop
logic.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 330 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 302 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 81a3d2ced78d..79e356ac02ab 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2321,6 +2321,7 @@ static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 	reg->precise = !env->bpf_capable;
 }
 
+
 static void mark_reg_unknown(struct bpf_verifier_env *env,
 			     struct bpf_reg_state *regs, u32 regno)
 {
@@ -14704,6 +14705,165 @@ static u8 rev_opcode(u8 opcode)
 	}
 }
 
+/* Similar to mark_reg_unknown() and should only be called from cap_bpf path */
+static void mark_unknown(struct bpf_reg_state *reg)
+{
+	u32 id = reg->id;
+
+	__mark_reg_unknown_imprecise(reg);
+	reg->id = id;
+}
+/*
+ * Similar to regs_refine_cond_op(), but instead of tightening the range
+ * widen the upper bound of reg1 based on reg2 and
+ * lower bound of reg2 based on reg1.
+ */
+static void widen_reg_bounds(struct bpf_reg_state *reg1,
+			     struct bpf_reg_state *reg2,
+			     u8 opcode, bool is_jmp32)
+{
+	switch (opcode) {
+	case BPF_JGE:
+	case BPF_JGT:
+	case BPF_JSGE:
+	case BPF_JSGT:
+		opcode = flip_opcode(opcode);
+		swap(reg1, reg2);
+		break;
+	default:
+		break;
+	}
+
+	switch (opcode) {
+	case BPF_JLE:
+		if (is_jmp32) {
+			reg1->u32_max_value = reg2->u32_max_value;
+			reg1->s32_max_value = S32_MAX;
+			reg1->umax_value = U64_MAX;
+			reg1->smax_value = S64_MAX;
+
+			reg2->u32_min_value = reg1->u32_min_value;
+			reg2->s32_min_value = S32_MIN;
+			reg2->umin_value = 0;
+			reg2->smin_value = S64_MIN;
+		} else {
+			reg1->umax_value = reg2->umax_value;
+			reg1->smax_value = S64_MAX;
+			reg1->u32_max_value = U32_MAX;
+			reg1->s32_max_value = S32_MAX;
+
+			reg2->umin_value = reg1->umin_value;
+			reg2->smin_value = S64_MIN;
+			reg2->u32_min_value = U32_MIN;
+			reg2->s32_min_value = S32_MIN;
+		}
+		reg1->var_off = tnum_unknown;
+		reg2->var_off = tnum_unknown;
+		break;
+	case BPF_JLT:
+		if (is_jmp32) {
+			reg1->u32_max_value = reg2->u32_max_value - 1;
+			reg1->s32_max_value = S32_MAX;
+			reg1->umax_value = U64_MAX;
+			reg1->smax_value = S64_MAX;
+
+			reg2->u32_min_value = reg1->u32_min_value + 1;
+			reg2->s32_min_value = S32_MIN;
+			reg2->umin_value = 0;
+			reg2->smin_value = S64_MIN;
+		} else {
+			reg1->umax_value = reg2->umax_value - 1;
+			reg1->smax_value = S64_MAX;
+			reg1->u32_max_value = U32_MAX;
+			reg1->s32_max_value = S32_MAX;
+
+			reg2->umin_value = reg1->umin_value + 1;
+			reg2->smin_value = S64_MIN;
+			reg2->u32_min_value = U32_MIN;
+			reg2->s32_min_value = S32_MIN;
+		}
+		reg1->var_off = tnum_unknown;
+		reg2->var_off = tnum_unknown;
+		break;
+	case BPF_JSLE:
+		if (is_jmp32) {
+			reg1->u32_max_value = U32_MAX;
+			reg1->s32_max_value = reg2->s32_max_value;
+			reg1->umax_value = U64_MAX;
+			reg1->smax_value = S64_MAX;
+
+			reg2->u32_min_value = U32_MIN;
+			reg2->s32_min_value = reg1->s32_min_value;
+			reg2->umin_value = 0;
+			reg2->smin_value = S64_MIN;
+		} else {
+			reg1->umax_value = U64_MAX;
+			reg1->smax_value = reg2->smax_value;
+			reg1->u32_max_value = U32_MAX;
+			reg1->s32_max_value = S32_MAX;
+
+			reg2->umin_value = 0;
+			reg2->smin_value = reg1->smin_value;
+			reg2->u32_min_value = U32_MIN;
+			reg2->s32_min_value = S32_MIN;
+		}
+		reg1->var_off = tnum_unknown;
+		reg2->var_off = tnum_unknown;
+		break;
+	case BPF_JSLT:
+		if (is_jmp32) {
+			reg1->u32_max_value = U32_MAX;
+			reg1->s32_max_value = reg2->s32_max_value - 1;
+			reg1->umax_value = U64_MAX;
+			reg1->smax_value = S64_MAX;
+
+			reg2->u32_min_value = U32_MIN;
+			reg2->s32_min_value = reg1->s32_min_value + 1;
+			reg2->umin_value = 0;
+			reg2->smin_value = S64_MIN;
+		} else {
+			reg1->umax_value = U64_MAX;
+			reg1->smax_value = reg2->smax_value - 1;
+			reg1->u32_max_value = U32_MAX;
+			reg1->s32_max_value = S32_MAX;
+
+			reg2->umin_value = 0;
+			reg2->smin_value = reg1->smin_value + 1;
+			reg2->u32_min_value = U32_MIN;
+			reg2->s32_min_value = S32_MIN;
+		}
+		reg1->var_off = tnum_unknown;
+		reg2->var_off = tnum_unknown;
+		break;
+	default:
+		break;
+	}
+}
+
+/*
+ * Widen reg bounds. Example:
+ *   r1 = 3
+ *   r2 = 100
+ *   if (r1 < r2)
+ * will produce
+ *   r1 = [3, 99] r2 = [100, UMAX]
+ */
+static int widen_reg(struct bpf_verifier_env *env,
+		     struct bpf_reg_state *reg1,
+		     struct bpf_reg_state *reg2,
+		     u8 opcode, bool is_jmp32, bool branch_taken)
+{
+	int err;
+
+	widen_reg_bounds(reg1, reg2, branch_taken ? opcode : rev_opcode(opcode), is_jmp32);
+	reg_bounds_sync(reg1);
+	reg_bounds_sync(reg2);
+
+	err = reg_bounds_sanity_check(env, reg1, "widen reg1");
+	err = err ?: reg_bounds_sanity_check(env, reg2, "widen reg2");
+	return err;
+}
+
 /* Refine range knowledge for <reg1> <op> <reg>2 conditional operation. */
 static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state *reg2,
 				u8 opcode, bool is_jmp32)
@@ -15104,10 +15264,11 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	struct bpf_verifier_state *other_branch;
 	struct bpf_reg_state *regs = this_branch->frame[this_branch->curframe]->regs;
 	struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg = NULL;
-	struct bpf_reg_state *eq_branch_regs;
+	struct bpf_reg_state *eq_branch_regs, *other_dst_reg = NULL, *other_src_reg = NULL;
 	struct bpf_reg_state fake_reg = {};
 	u8 opcode = BPF_OP(insn->code);
-	bool is_jmp32;
+	bool is_jmp32, do_widen;
+	bool has_src_reg = false;
 	int pred = -1;
 	int err;
 
@@ -15159,6 +15320,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		if (err)
 			return err;
 
+		has_src_reg = true;
 		src_reg = &regs[insn->src_reg];
 		if (!(reg_is_pkt_pointer_any(dst_reg) && reg_is_pkt_pointer_any(src_reg)) &&
 		    is_pointer_value(env, insn->src_reg)) {
@@ -15177,8 +15339,78 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	}
 
 	is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
+	if (dst_reg->type != SCALAR_VALUE || src_reg->type != SCALAR_VALUE ||
+	    /* Widen scalars only if they're constants */
+	    !is_reg_const(dst_reg, is_jmp32) || !is_reg_const(src_reg, is_jmp32))
+		do_widen = false;
+	else if (reg_const_value(dst_reg, is_jmp32) == reg_const_value(src_reg, is_jmp32))
+		/* And not equal */
+		do_widen = false;
+	else
+		do_widen = (get_loop_entry(this_branch) ||
+			    this_branch->may_goto_depth) &&
+				/* Gate widen_reg() logic */
+				env->bpf_capable;
+
 	pred = is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
-	if (pred >= 0) {
+
+	if (do_widen && ((opcode == BPF_JNE && pred == 1) ||
+			 (opcode == BPF_JEQ && pred == 0))) {
+		/*
+		 * != is too vague. let's try < and > and widen. Example:
+		 *
+		 * R6=2
+		 * 21: (15) if r6 == 0x3e8 goto pc+14
+		 * Predicted == not-taken, but < is also true
+		 * 21: R6=scalar(smin=umin=smin32=umin32=2,smax=umax=smax32=umax32=999,var_off=(0x0; 0x3ff))
+		 */
+		int refine_pred;
+		u8 opcode2 = BPF_JLT;
+
+		refine_pred = is_branch_taken(dst_reg, src_reg, BPF_JLT, is_jmp32);
+		if (refine_pred == 1) {
+			widen_reg(env, dst_reg, src_reg, BPF_JLT, is_jmp32, true);
+
+		} else {
+			opcode2 = BPF_JGT;
+			refine_pred = is_branch_taken(dst_reg, src_reg, BPF_JGT, is_jmp32);
+			if (refine_pred == 1)
+				widen_reg(env, dst_reg, src_reg, BPF_JGT, is_jmp32, true);
+		}
+
+		if (refine_pred == 1) {
+			if (dst_reg->id)
+				find_equal_scalars(this_branch, dst_reg);
+			if (env->log.level & BPF_LOG_LEVEL) {
+				verbose(env, "Predicted %s, but %s is also true\n",
+					opcode == BPF_JNE ? "!= taken" : "== not-taken",
+					opcode2 == BPF_JLT ? "<" : ">");
+				print_insn_state(env, this_branch->frame[this_branch->curframe]);
+			}
+			err = mark_chain_precision(env, insn->dst_reg);
+			if (err)
+				return err;
+			if (has_src_reg) {
+				err = mark_chain_precision(env, insn->src_reg);
+				if (err)
+					return err;
+			}
+			if (pred == 1)
+				*insn_idx += insn->off;
+			return 0;
+		}
+		/*
+		 * No luck. Predicted dst != src taken or dst == src not-taken,
+		 * but !(dst < src) and !(dst > src).
+		 * Constants must have been negative.
+		 */
+	}
+
+	if (do_widen && (opcode == BPF_JNE || opcode == BPF_JEQ || opcode == BPF_JSET))
+		/* widen_reg() algorithm works for <, <=, >, >= only */
+		do_widen = false;
+
+	if (pred >= 0 && !do_widen) {
 		/* If we get here with a dst_reg pointer type it is because
 		 * above is_branch_taken() special cased the 0 comparison.
 		 */
@@ -15189,6 +15421,60 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			err = mark_chain_precision(env, insn->src_reg);
 		if (err)
 			return err;
+	} else {
+		/*
+		 * The verifier has to propagate precision if it's going to
+		 * continue exploring only one branch of conditional jump.
+		 * Otherwise push_stack() to explore both branches.
+		 */
+		other_branch = push_stack(env, *insn_idx + insn->off + 1, *insn_idx,
+					  false);
+		if (!other_branch)
+			return -EFAULT;
+		other_branch_regs = other_branch->frame[other_branch->curframe]->regs;
+		other_dst_reg = &other_branch_regs[insn->dst_reg];
+		if (has_src_reg)
+			other_src_reg = &other_branch_regs[insn->src_reg];
+	}
+
+	if (do_widen && pred >= 0) {
+		/*
+		 * Widen predicted <, <=, >, >= comparison of constant scalars. Example:
+		 *
+		 * R7=0x186a0
+		 * 21: (25) if r7 > 0x1869f goto pc-10
+		 * Predicted branch taken
+		 * 21: R7=scalar(smin=smin32=0,smax=umax=smax32=umax32=0x1869f,var_off=(0x0; 0x1ffff))
+		 * other branch:
+		 * R7=0x186a0
+		 *
+		 * R7=2
+		 * 21: (25) if r7 > 0x1869f goto pc-10
+		 * Predicted branch not-taken
+		 * 21: R7=scalar(smin=umin=smin32=umin32=2,smax=umax=smax32=umax32=0x1869f,var_off=(0x0; 0x1ffff))
+		 * other branch:
+		 * R7=scalar(umin=0x186a0)
+		 */
+		if (pred == 1)
+			mark_unknown(dst_reg);
+		widen_reg(env, dst_reg, src_reg, opcode, is_jmp32, false);
+		if (!has_src_reg) {
+			other_src_reg = &fake_reg;
+			other_src_reg->type = SCALAR_VALUE;
+			__mark_reg_known(other_src_reg, insn->imm);
+		}
+		if (pred == 0)
+			mark_unknown(other_dst_reg);
+		widen_reg(env, other_dst_reg, other_src_reg, opcode, is_jmp32, true);
+
+		if (env->log.level & BPF_LOG_LEVEL) {
+			verbose(env, "Predicted branch %s\n", pred == 1 ? "taken" : "not-taken");
+			print_insn_state(env, this_branch->frame[this_branch->curframe]);
+			verbose(env, "other branch:\n");
+			mark_reg_scratched(env, insn->dst_reg);
+			print_verifier_state(env, other_branch->frame[other_branch->curframe], false);
+		}
+		goto skip_min_max;
 	}
 
 	if (pred == 1) {
@@ -15219,37 +15505,27 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		return 0;
 	}
 
-	other_branch = push_stack(env, *insn_idx + insn->off + 1, *insn_idx,
-				  false);
-	if (!other_branch)
-		return -EFAULT;
-	other_branch_regs = other_branch->frame[other_branch->curframe]->regs;
-
 	if (BPF_SRC(insn->code) == BPF_X) {
-		err = reg_set_min_max(env,
-				      &other_branch_regs[insn->dst_reg],
-				      &other_branch_regs[insn->src_reg],
+		err = reg_set_min_max(env, other_dst_reg, other_src_reg,
 				      dst_reg, src_reg, opcode, is_jmp32);
 	} else /* BPF_SRC(insn->code) == BPF_K */ {
-		err = reg_set_min_max(env,
-				      &other_branch_regs[insn->dst_reg],
-				      src_reg /* fake one */,
+		err = reg_set_min_max(env, other_dst_reg, src_reg /* fake one */,
 				      dst_reg, src_reg /* same fake one */,
 				      opcode, is_jmp32);
 	}
 	if (err)
 		return err;
-
-	if (BPF_SRC(insn->code) == BPF_X &&
+skip_min_max:
+	if (has_src_reg &&
 	    src_reg->type == SCALAR_VALUE && src_reg->id &&
-	    !WARN_ON_ONCE(src_reg->id != other_branch_regs[insn->src_reg].id)) {
+	    !WARN_ON_ONCE(src_reg->id != other_src_reg->id)) {
 		find_equal_scalars(this_branch, src_reg);
-		find_equal_scalars(other_branch, &other_branch_regs[insn->src_reg]);
+		find_equal_scalars(other_branch, other_src_reg);
 	}
 	if (dst_reg->type == SCALAR_VALUE && dst_reg->id &&
-	    !WARN_ON_ONCE(dst_reg->id != other_branch_regs[insn->dst_reg].id)) {
+	    !WARN_ON_ONCE(dst_reg->id != other_dst_reg->id)) {
 		find_equal_scalars(this_branch, dst_reg);
-		find_equal_scalars(other_branch, &other_branch_regs[insn->dst_reg]);
+		find_equal_scalars(other_branch, other_dst_reg);
 	}
 
 	/* if one pointer register is compared to another pointer
@@ -15264,7 +15540,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	 * could be null even without PTR_MAYBE_NULL marking, so
 	 * only propagate nullness when neither reg is that type.
 	 */
-	if (!is_jmp32 && BPF_SRC(insn->code) == BPF_X &&
+	if (!is_jmp32 && has_src_reg &&
 	    __is_pointer_value(false, src_reg) && __is_pointer_value(false, dst_reg) &&
 	    type_may_be_null(src_reg->type) != type_may_be_null(dst_reg->type) &&
 	    base_type(src_reg->type) != PTR_TO_BTF_ID &&
@@ -17409,6 +17685,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * => unsafe memory access at 11 would not be caught.
 			 */
 			if (is_iter_next_insn(env, insn_idx)) {
+				update_loop_entry(cur, &sl->state);
 				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
 					struct bpf_func_state *cur_frame;
 					struct bpf_reg_state *iter_state, *iter_reg;
@@ -17425,18 +17702,15 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 					 */
 					spi = __get_spi(iter_reg->off + iter_reg->var_off.value);
 					iter_state = &func(env, iter_reg)->stack[spi].spilled_ptr;
-					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE) {
-						update_loop_entry(cur, &sl->state);
+					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE)
 						goto hit;
-					}
 				}
 				goto skip_inf_loop_check;
 			}
 			if (is_may_goto_insn_at(env, insn_idx)) {
-				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
-					update_loop_entry(cur, &sl->state);
+				update_loop_entry(cur, &sl->state);
+				if (states_equal(env, &sl->state, cur, RANGE_WITHIN))
 					goto hit;
-				}
 				goto skip_inf_loop_check;
 			}
 			if (calls_callback(env, insn_idx)) {
-- 
2.43.0


