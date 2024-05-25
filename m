Return-Path: <bpf+bounces-30574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CD58CEDB4
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 05:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7FCDB21257
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 03:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547F11C2D;
	Sat, 25 May 2024 03:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDVLai70"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8AE1862
	for <bpf@vger.kernel.org>; Sat, 25 May 2024 03:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716606722; cv=none; b=X4PORW1/Rdz3R0c00PSF7WBknprj+xFDYN8OccLtmvgNc9ASOdQTCdHu2Jn40hzKZ9eLaoNgaXrbI8aJ/AUf9Mk/bDgsI5+fkkORKNRmmQPyx0b9ZhdE9wOEBmYB+xeGKMVMUHatz6/scOLXDIQkjIPZuju/MIgqp/SXnpMjkvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716606722; c=relaxed/simple;
	bh=R8bIa0p/9/nlW5IUcjocj7nHOP5cYzPJOmEbhpTqeR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bhkRsxksjeM+WbTrI06lZ87AplC682FJRc8Gw93xmxn256AiYjHKJYtbDvMNFNmrT+DkjVi4PJySVBoNnOgCRbzuNaNKI+aI3FMjVqOB69ZAFHr7BIx0PaGqG4Wp8fdB0IKgTP8t/vyyuB3MmMpB1ukagB8Wa64mHmdOBLdRt6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDVLai70; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f855b2499cso1243201a34.1
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 20:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716606720; x=1717211520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u1cWenHKGNOcAkfONZpp05X7/ZH17xfbz6g8LOAUnUM=;
        b=FDVLai70lZlz6U2gwoq1/6uzIGMXKqYeJrY+MLg53RCHmfsVNTk+GuyqWMeuls4Zvw
         s44zjEh9KJiN6sjKjS0Xp8oBfuG7Jcastz0rLr1gG0Xu4HeyotKTcPtRj/qXp84xvu7A
         VgutK5bAW8MHS14rm2GE5sWAai5Df1xvBW6WR/8s4/4dLPqrg1pNuiTnbW/Yy5dYHHBM
         lIfsMR8UIzG70VH+lsSyWy807g+zTOTuWmydIqdN3lQYpOb52CnZqwqQIf1k4DTKWAh0
         Q5LZZPefgdThDcHszrhNIH3HmIqj7jXV74c2FH/fmwswkAdX98SWlsoJRXJ0cHOzWYVH
         THjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716606720; x=1717211520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1cWenHKGNOcAkfONZpp05X7/ZH17xfbz6g8LOAUnUM=;
        b=SuJn2R1lvTIxBLT4VT3flHGSRjDMg5nUuj45MIpGw0aUEk2gfiWhP7AdViNLE949vK
         CGkFrtWD/XtUZsLruijp+wk608wzUODIQCpGE9Udao/jsOVQN6WEVgY0HTABBKfoSHGX
         ydHgvmeS87134YDHgwZwVxHaQwpf7Q0d8FvfxiR5N8cSczyW8anahmDrEkEOlev1+IYu
         NgyyReCbF2wB/B4V2ceHsrwgy/g0/wtWksLC3aDHWDa2uUhHXbgvrNS0RZQGzUScZqF1
         VdKjDQ8NsBMgdbqrjwpJlStVkKR8ocBWvRsDR0q9z9duYtDecb0ulpSQFk1c7Bwh4wZ7
         sgkw==
X-Gm-Message-State: AOJu0YyYZT559COEFTOA6VeeucISzyoEzIKBJZKYQy/YUryXWQQajIbw
	zmfIoqVg+H8O9EPgDmr8CresM/51jUOFrWA0W+rOOmPszhXM+XnzARilpg==
X-Google-Smtp-Source: AGHT+IEGranySAHcluob8bSqHNpsiyhls+ZiHVY46DcPjeuQkEPPfzLkOK0S6H3pSl838KNl21neSA==
X-Received: by 2002:a9d:734e:0:b0:6f6:adc9:9d1b with SMTP id 46e09a7af769-6f8d0a737femr3912759a34.11.1716606719709;
        Fri, 24 May 2024 20:11:59 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:1a8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcbeb128sm1724156b3a.135.2024.05.24.20.11.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 May 2024 20:11:59 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 1/2] bpf: Relax precision marking in open coded iters and may_goto loop.
Date: Fri, 24 May 2024 20:11:55 -0700
Message-Id: <20240525031156.13545-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v1->v2->v3:
- Algorithm changed completely.

Motivation for the patch
------------------------
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

Hence treat != and == conditions specially in the verifier.
Widen only not-predicted branch and keep predict branch as is. Example:
  r1 = 0
  goto L1
L2:
  arr[r1] = 1
  r1++
L1:
  if r1 != 100 goto L2
  fallthrough: r1=100 after widening
  other_branch: r1 stays as-is (0, 1, 2, ..)

Also recognize the case where both LHS and RHS are constant and equal to each
other. In this case don't widen at all and take the predicted path.
This key heuristic allows the verifier detect loop end condition.
Such 'for (i = 0; i != 100; i++)' is validated just like bounded loop.

With that the users can use 'for (i = 0; ...' pattern everywhere
and many i = zero workarounds can be removed.

One tests has drastic improvement. The rest are noise.

File                  Insns (A)  Insns (B)  Insns     (DIFF)  States (A)  States (B)  States    (DIFF)
--------------------  ---------  ---------  ----------------  ----------  ----------  ----------------
iters_task_vma.bpf.o      22043        132  -21911 (-99.40%)        1006          10    -996 (-99.01%)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 136 +++++++++++++++++++++++++++++++++---------
 1 file changed, 109 insertions(+), 27 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 77da1f438bec..2b79b623b492 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2321,6 +2321,14 @@ static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 	reg->precise = !env->bpf_capable;
 }
 
+static void widen_reg(struct bpf_reg_state *reg)
+{
+	u32 id = reg->id;
+
+	__mark_reg_unknown_imprecise(reg);
+	reg->id = id;
+}
+
 static void mark_reg_unknown(struct bpf_verifier_env *env,
 			     struct bpf_reg_state *regs, u32 regno)
 {
@@ -15104,10 +15112,11 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	struct bpf_verifier_state *other_branch;
 	struct bpf_reg_state *regs = this_branch->frame[this_branch->curframe]->regs;
 	struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg = NULL;
-	struct bpf_reg_state *eq_branch_regs;
+	struct bpf_reg_state *eq_branch_regs, *other_dst_reg, *other_src_reg = NULL;
 	struct bpf_reg_state fake_reg = {};
 	u8 opcode = BPF_OP(insn->code);
-	bool is_jmp32;
+	bool is_jmp32, ignore_pred;
+	bool has_src_reg = false;
 	int pred = -1;
 	int err;
 
@@ -15159,6 +15168,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		if (err)
 			return err;
 
+		has_src_reg = true;
 		src_reg = &regs[insn->src_reg];
 		if (!(reg_is_pkt_pointer_any(dst_reg) && reg_is_pkt_pointer_any(src_reg)) &&
 		    is_pointer_value(env, insn->src_reg)) {
@@ -15177,8 +15187,42 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	}
 
 	is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
+	if (dst_reg->type != SCALAR_VALUE || src_reg->type != SCALAR_VALUE)
+		ignore_pred = false;
+	/*
+	 * Compilers often optimize loop exit condition to equality, so
+	 *      for (i = 0; i < 100; i++) arr[i] = 1
+	 * becomes
+	 *      for (i = 0; i != 100; i++) arr[1] = 1
+	 * Hence treat != and == conditions specially in the verifier.
+	 * Widen only not-predicted branch and keep predict branch as is. Example:
+	 *    r1 = 0
+	 *    goto L1
+	 * L2:
+	 *    arr[r1] = 1
+	 *    r1++
+	 * L1:
+	 *    if r1 != 100 goto L2
+	 *    fallthrough: r1=100 after widening
+	 *    other_branch: r1 stays as-is (0, 1, 2, ..)
+	 *
+	 *  Also recognize the case where both LHS and RHS are constant and
+	 *  equal to each other. In this case don't widen at all and take the
+	 *  predicted path. This key heuristic allows the verifier detect loop
+	 *  end condition and 'for (i = 0; i != 100; i++)' is validated just
+	 *  like bounded loop.
+	 */
+	else if (is_reg_const(dst_reg, is_jmp32) && is_reg_const(src_reg, is_jmp32) &&
+	    reg_const_value(dst_reg, is_jmp32) == reg_const_value(src_reg, is_jmp32))
+		ignore_pred = false;
+	else
+		ignore_pred = (get_loop_entry(this_branch) ||
+			       this_branch->may_goto_depth) &&
+				/* Gate widen_reg() logic */
+				env->bpf_capable;
+
 	pred = is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
-	if (pred >= 0) {
+	if (pred >= 0 && !ignore_pred) {
 		/* If we get here with a dst_reg pointer type it is because
 		 * above is_branch_taken() special cased the 0 comparison.
 		 */
@@ -15191,6 +15235,17 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			return err;
 	}
 
+	if (pred < 0 || ignore_pred) {
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
 	if (pred == 1) {
 		/* Only follow the goto, ignore fall-through. If needed, push
 		 * the fall-through branch for simulation under speculative
@@ -15202,8 +15257,33 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			return -EFAULT;
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch->frame[this_branch->curframe]);
-		*insn_idx += insn->off;
-		return 0;
+		if (ignore_pred) {
+			/* dst and src regs are scalars. Widen them */
+			widen_reg(dst_reg);
+			if (has_src_reg)
+				widen_reg(src_reg);
+			/*
+			 * Widen other branch only if not comparing for equlity.
+			 * Example:
+			 *   r1 = 1
+			 *   if (r1 < 100)
+			 * will produce
+			 *   [0, 99] and [100, UMAX] after widening and reg_set_min_max().
+			 *
+			 *   r1 = 1
+			 *   if (r1 == 100)
+			 * will produce
+			 *    [1] and [100] after widening in other_branch and reg_set_min_max().
+			 */
+			if (opcode != BPF_JEQ && opcode != BPF_JNE) {
+				widen_reg(other_dst_reg);
+				if (has_src_reg)
+					widen_reg(other_src_reg);
+			}
+		} else {
+			*insn_idx += insn->off;
+			return 0;
+		}
 	} else if (pred == 0) {
 		/* Only follow the fall-through branch, since that's where the
 		 * program will go. If needed, push the goto branch for
@@ -15216,23 +15296,27 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			return -EFAULT;
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch->frame[this_branch->curframe]);
-		return 0;
+		if (ignore_pred) {
+			if (opcode != BPF_JEQ && opcode != BPF_JNE) {
+				widen_reg(dst_reg);
+				if (has_src_reg)
+					widen_reg(src_reg);
+			}
+			widen_reg(other_dst_reg);
+			if (has_src_reg)
+				widen_reg(other_src_reg);
+		} else {
+			return 0;
+		}
 	}
 
-	other_branch = push_stack(env, *insn_idx + insn->off + 1, *insn_idx,
-				  false);
-	if (!other_branch)
-		return -EFAULT;
-	other_branch_regs = other_branch->frame[other_branch->curframe]->regs;
-
 	if (BPF_SRC(insn->code) == BPF_X) {
 		err = reg_set_min_max(env,
-				      &other_branch_regs[insn->dst_reg],
-				      &other_branch_regs[insn->src_reg],
+				      other_dst_reg, other_src_reg,
 				      dst_reg, src_reg, opcode, is_jmp32);
 	} else /* BPF_SRC(insn->code) == BPF_K */ {
 		err = reg_set_min_max(env,
-				      &other_branch_regs[insn->dst_reg],
+				      other_dst_reg,
 				      src_reg /* fake one */,
 				      dst_reg, src_reg /* same fake one */,
 				      opcode, is_jmp32);
@@ -15240,16 +15324,16 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	if (err)
 		return err;
 
-	if (BPF_SRC(insn->code) == BPF_X &&
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
@@ -15264,7 +15348,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	 * could be null even without PTR_MAYBE_NULL marking, so
 	 * only propagate nullness when neither reg is that type.
 	 */
-	if (!is_jmp32 && BPF_SRC(insn->code) == BPF_X &&
+	if (!is_jmp32 && has_src_reg &&
 	    __is_pointer_value(false, src_reg) && __is_pointer_value(false, dst_reg) &&
 	    type_may_be_null(src_reg->type) != type_may_be_null(dst_reg->type) &&
 	    base_type(src_reg->type) != PTR_TO_BTF_ID &&
@@ -17409,6 +17493,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * => unsafe memory access at 11 would not be caught.
 			 */
 			if (is_iter_next_insn(env, insn_idx)) {
+				update_loop_entry(cur, &sl->state);
 				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
 					struct bpf_func_state *cur_frame;
 					struct bpf_reg_state *iter_state, *iter_reg;
@@ -17425,18 +17510,15 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
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


