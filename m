Return-Path: <bpf+bounces-31085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EFD8D6DD7
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 05:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8E71C22CF6
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 03:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE13AD53;
	Sat,  1 Jun 2024 03:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S27wqSLq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BAB81AD0
	for <bpf@vger.kernel.org>; Sat,  1 Jun 2024 03:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717213340; cv=none; b=IQI1Xcjvdl+89dJM7sO3+8motHlBh4Ck2xsgtXRqHPqc7PwxMRG3CbhpbSADYgbTjwDil61uJvcY39VQIWMNBrsDA/oovBSo3tV9/SNnmjQCPJaKCra7zqwuMCtmyPu+I4vn0MYz8yJMq0wH0oBRBM0DYN61GRR8tRd8kGpbVxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717213340; c=relaxed/simple;
	bh=wf5FuWn1YLFhJPrUe9v+rZEzkZ0f0ynMcRCaF66G/eg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ARdX/whbHj0HnWfxLr3ve878G7TMW4Jr5mIdb6/yc43I4DamE/Eoh63A2dC0PW2vSrjg0PyxziJbjaw40eAKBpr2+gpqZtZOwqWtsICPAuLg+3SoXviYlr64OJOfypqIiffTzqVSjIrFVx3qGlHSN+hfGHrZy9djcjl53u3vUM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S27wqSLq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f47f07aceaso14468975ad.0
        for <bpf@vger.kernel.org>; Fri, 31 May 2024 20:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717213337; x=1717818137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5AYsoamQ9NsLEteiU2WQBkLN1+FEFj+Qh3WutcNtQGU=;
        b=S27wqSLqjzvGwu/jjks7LemNFBRvckyqdbUO932Y0p13GYPYUR/MlV1tZY2v7faNrp
         8PGbelHkK5McCLzzNS1gT8iJDmpHuNSJyUxNoDnRoTKp/7j6WQGH6CVGtO5G76z+42K8
         xlXR3gHfeUOw9RUNDfOImgM8br3WQkH8XPbDJ/fBjBSPKCsuh+tquPxC4oMRTffIgP4z
         mQR6dvmNiqgLQchkhtJuBrrElQ9wqoknj/XDzTv36JIUzNaOuy6thG6Cc0xLj3mQv5Ub
         fbEzBtsJbnLxyP9iZhkfLVJyrd/J2twg8jj5U76qOr8hOlaLRqwh8dJt6x81jCQjWkzO
         fzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717213337; x=1717818137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5AYsoamQ9NsLEteiU2WQBkLN1+FEFj+Qh3WutcNtQGU=;
        b=GF3H47fQOyYDSEqeMUfQUSd2ChvVkVFq0CBNobQA5gU2Cq4+bB2gHCiHLp9R6GSECN
         plvo+zhnNcgdZAv+S8LUrPUGRMMK+GyohhYOeoP5Y5GydjUd0IDHKR7JipwN3inWEPzp
         h1aAzDWPfYym5HvvBNNJH6mGTL/7biRrOeq7zuu78KkxWDIzSQRaapU9Jkgu+dqxjgow
         V79JIcVdJ4YkT1W4HqUwHFbsEAROh4JHxKqJrUZAXXHwFiXHLHtVC2wOC0/jEGQIZHqj
         LmZViG6sWzLs1sG6uA++Qbj8fSJC7g9pAZbLD1/BMejc2ILqO9ZHcqES4OLDHVQGRmpu
         rdkw==
X-Gm-Message-State: AOJu0YzX4vQlslRZ48tVdxejjZsqN66kuc4sz8NSsh2XymxbC86IgsFC
	ZiVGDhbaYkXOXaVYvT2NtrHtJZHMLZWJ091Ojr/o7SZ+4CBTnERvddEi/A==
X-Google-Smtp-Source: AGHT+IG6MjVEjl7HeXLOzSQHdF07DbejjGFrT87xF+OgGQgAI7N0uL4MShULxlKjWsFTw4JgHhd/fQ==
X-Received: by 2002:a17:902:a38d:b0:1f3:903:5c9a with SMTP id d9443c01a7336-1f6370aa056mr41100935ad.58.1717213336364;
        Fri, 31 May 2024 20:42:16 -0700 (PDT)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::5:428])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63232dde8sm24585425ad.1.2024.05.31.20.42.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 May 2024 20:42:16 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v4 bpf-next 1/2] bpf: Relax precision marking in open coded iters and may_goto loop.
Date: Fri, 31 May 2024 20:42:10 -0700
Message-Id: <20240601034211.63962-1-alexei.starovoitov@gmail.com>
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
v3->v4:
- Fixed widening for Rx < Ry case and added more tests

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

Few extra tests are added to iters_task_vma.bpf.o that demonstrate quick
convergence though they iterate over 100k elements.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   2 +
 kernel/bpf/verifier.c        | 168 +++++++++++++++++++++++++++++------
 2 files changed, 141 insertions(+), 29 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 50aa87f8d77f..4d9c1a863014 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -750,6 +750,8 @@ struct bpf_verifier_env {
 	 * e.g., in reg_type_str() to generate reg_type string
 	 */
 	char tmp_str_buf[TMP_STR_BUF_LEN];
+	/* temp variables that are too big to keep on stack */
+	struct bpf_reg_state saved_src_reg, saved_dst_reg;
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 77da1f438bec..9bd23ab44eb9 100644
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
@@ -15191,6 +15235,22 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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
+	if (pred >= 0 && ignore_pred && has_src_reg) {
+		env->saved_dst_reg = *dst_reg;
+		env->saved_src_reg = *src_reg;
+	}
+
 	if (pred == 1) {
 		/* Only follow the goto, ignore fall-through. If needed, push
 		 * the fall-through branch for simulation under speculative
@@ -15202,8 +15262,33 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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
@@ -15216,23 +15301,50 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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
-		err = reg_set_min_max(env,
-				      &other_branch_regs[insn->dst_reg],
-				      &other_branch_regs[insn->src_reg],
-				      dst_reg, src_reg, opcode, is_jmp32);
+		if (pred >= 0 && ignore_pred) {
+			/*
+			 * In case of Rx < Ry both registers
+			 * were widened to unknown scalar, hence
+			 * call reg_set_min_max() twice to learn bounds
+			 * from values Rx and Ry had before widening.
+			 * Ex:
+			 * r1 = 3
+			 * r2 = 5
+			 * if r1 > r2 goto ...
+			 * fallthrough:
+			 * r1 = [0, 5], r2 = [3, UMAX]
+			 */
+			err = reg_set_min_max(env,
+					      other_dst_reg, &env->saved_src_reg,
+					      dst_reg, &env->saved_src_reg, opcode, is_jmp32);
+			if (err)
+				return err;
+			err = reg_set_min_max(env,
+					      &env->saved_dst_reg, other_src_reg,
+					      &env->saved_dst_reg, src_reg, opcode, is_jmp32);
+		} else {
+			err = reg_set_min_max(env,
+					      other_dst_reg, other_src_reg,
+					      dst_reg, src_reg, opcode, is_jmp32);
+		}
 	} else /* BPF_SRC(insn->code) == BPF_K */ {
 		err = reg_set_min_max(env,
-				      &other_branch_regs[insn->dst_reg],
+				      other_dst_reg,
 				      src_reg /* fake one */,
 				      dst_reg, src_reg /* same fake one */,
 				      opcode, is_jmp32);
@@ -15240,16 +15352,16 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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
@@ -15264,7 +15376,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	 * could be null even without PTR_MAYBE_NULL marking, so
 	 * only propagate nullness when neither reg is that type.
 	 */
-	if (!is_jmp32 && BPF_SRC(insn->code) == BPF_X &&
+	if (!is_jmp32 && has_src_reg &&
 	    __is_pointer_value(false, src_reg) && __is_pointer_value(false, dst_reg) &&
 	    type_may_be_null(src_reg->type) != type_may_be_null(dst_reg->type) &&
 	    base_type(src_reg->type) != PTR_TO_BTF_ID &&
@@ -17409,6 +17521,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * => unsafe memory access at 11 would not be caught.
 			 */
 			if (is_iter_next_insn(env, insn_idx)) {
+				update_loop_entry(cur, &sl->state);
 				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
 					struct bpf_func_state *cur_frame;
 					struct bpf_reg_state *iter_state, *iter_reg;
@@ -17425,18 +17538,15 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
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


