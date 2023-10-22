Return-Path: <bpf+bounces-12910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9BC7D2096
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 03:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72AD11C20909
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 01:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9237F8;
	Sun, 22 Oct 2023 01:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDdAgm0Q"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093F6A3F
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 01:08:53 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE04199
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 18:08:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so3090549a12.0
        for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 18:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697936928; x=1698541728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cxnVJi7lX7GON77puqo9dHBnsE1tPt6Idtl/ZWF2A0=;
        b=GDdAgm0QgJXyfSx9CFO1ijwLamkt2fTZS94PKPZiKmL+/dVU4hDCr6XJ6UyVVAG9Pn
         qnShAhbi9j/eZtJs5liSxV4K7AkdKoGUUsGesc0a5JRWL8WLCQYuEuLtNBfA6H/wYDXy
         6M51CLR0RrTaWrfMhW/lZ17kHJ7Qu5HnZXVGWo7V/fjQ4/CW8EsjRk7N4wCwUuXK/alj
         Og3WgPXu91Xgv2Q/1Bcfet5OUdZsS1bMVgAgaXoUC64UpfAcjEtzEsSKOD5inr1MxAfG
         Eq1Jotn91rrLQaPzN+mYmoTgSt/dhQNlsZC+claNblrlEyT4xPgI0LQ+UtbyP5Ev1gGq
         gPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697936928; x=1698541728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cxnVJi7lX7GON77puqo9dHBnsE1tPt6Idtl/ZWF2A0=;
        b=OuoOmvFAvbfGe8GS6GO5abKnUaKtcQ7jw4AWHLgnuUAYs5un2pZ/ampec2MjJ6ZJwm
         N34UCI2uqsaPE0V8CEd9vqJvqsiVQgUOJdKhr8igFeMpb8DglZZ1gBeXSs0jwDC5Wdxc
         uzl+lEE7TsoFdFd1HhjP4yZqQftouyq+zN5EcN6rg5WL5vLNQPWqZsYlrx9XZ3cruTmJ
         /0KNrgXrIt6SipK/CTfhwwBPmhh/Xwt4rs9nSv0w+2gOFMxD7DqAe+FytP5nK2PTy3vl
         g7U5B/SMEqk0wm956r8mCMalylohFzgs1lhsWMvuja9LeiS8ucG/CMN7fB0X0fFAy3FX
         OL9w==
X-Gm-Message-State: AOJu0YwBjcGj6N79OH448PTxDn8kcZoN5bDkNIIqIVSwVDjp2obA8xUa
	pT9iygYoRy7pZm6H5kpV0RO+4xqt2ETcbrGO
X-Google-Smtp-Source: AGHT+IEEpKN1dwJkbpU3rvg2wwUZzd1MK2qz56s1TF70aPGtwBuZucw9U6E9iSK1jRNQvJrOAoCx2Q==
X-Received: by 2002:a17:906:c115:b0:9be:839a:3372 with SMTP id do21-20020a170906c11500b009be839a3372mr4221394ejc.59.1697936927649;
        Sat, 21 Oct 2023 18:08:47 -0700 (PDT)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id u16-20020a170906655000b009c3f1b3e988sm4276143ejn.90.2023.10.21.18.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 18:08:47 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	awerner32@gmail.com,
	john.fastabend@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next v2 3/7] bpf: exact states comparison for iterator convergence checks
Date: Sun, 22 Oct 2023 04:08:08 +0300
Message-ID: <20231022010812.9201-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231022010812.9201-1-eddyz87@gmail.com>
References: <20231022010812.9201-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convergence for open coded iterators is computed in is_state_visited()
by examining states with branches count > 1 and using states_equal().
states_equal() computes sub-state relation using read and precision marks.
Read and precision marks are propagated from children states,
thus are not guaranteed to be complete inside a loop when branches
count > 1. This could be demonstrated using the following unsafe program:

     1. r7 = -16
     2. r6 = bpf_get_prandom_u32()
     3. while (bpf_iter_num_next(&fp[-8])) {
     4.   if (r6 != 42) {
     5.     r7 = -32
     6.     r6 = bpf_get_prandom_u32()
     7.     continue
     8.   }
     9.   r0 = r10
    10.   r0 += r7
    11.   r8 = *(u64 *)(r0 + 0)
    12.   r6 = bpf_get_prandom_u32()
    13. }

Here verifier would first visit path 1-3, create a checkpoint at 3
with r7=-16, continue to 4-7,3 with r7=-32.

Because instructions at 9-12 had not been visitied yet existing
checkpoint at 3 does not have read or precision mark for r7.
Thus states_equal() would return true and verifier would discard
current state, thus unsafe memory access at 11 would not be caught.

This commit fixes this loophole by introducing exact state comparisons
for iterator convergence logic:
- registers are compared using regs_exact() regardless of read or
  precision marks;
- stack slots have to have identical type.

Unfortunately, this is too strict even for simple programs like below:

    i = 0;
    while(iter_next(&it))
      i++;

At each iteration step i++ would produce a new distinct state and
eventually instruction processing limit would be reached.

To avoid such behavior speculatively forget (widen) range for
imprecise scalar registers, if those registers were not precise at the
end of the previous iteration and do not match exactly.

This a conservative heuristic that allows to verify wide range of
programs, however it precludes verification of programs that conjure
an imprecise value on the first loop iteration and use it as precise
on the second.

Test case iter_task_vma_for_each() presents one of such cases:

        unsigned int seen = 0;
        ...
        bpf_for_each(task_vma, vma, task, 0) {
                if (seen >= 1000)
                        break;
                ...
                seen++;
        }

Here clang generates the following code:

<LBB0_4>:
      24:       r8 = r6                          ; stash current value of
                ... body ...                       'seen'
      29:       r1 = r10
      30:       r1 += -0x8
      31:       call bpf_iter_task_vma_next
      32:       r6 += 0x1                        ; seen++;
      33:       if r0 == 0x0 goto +0x2 <LBB0_6>  ; exit on next() == NULL
      34:       r7 += 0x10
      35:       if r8 < 0x3e7 goto -0xc <LBB0_4> ; loop on seen < 1000

<LBB0_6>:
      ... exit ...

Note that counter in r6 is copied to r8 and then incremented,
conditional jump is done using r8. Because of this precision mark for
r6 lags one state behind of precision mark on r8 and widening logic
kicks in.

Adding barrier_var(seen) after conditional is sufficient to force
clang use the same register for both counting and conditional jump.

This issue was discussed in the thread [1] which was started by
Andrew Werner <awerner32@gmail.com> demonstrating a similar bug
in callback functions handling. The callbacks would be addressed
in a followup patch.

[1] https://lore.kernel.org/bpf/97a90da09404c65c8e810cf83c94ac703705dc0e.camel@gmail.com/

Co-developed-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Co-developed-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h                  |   1 +
 kernel/bpf/verifier.c                         | 212 +++++++++++++++---
 .../selftests/bpf/progs/iters_task_vma.c      |   1 +
 3 files changed, 184 insertions(+), 30 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e67cd45a85be..38b788228594 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -384,6 +384,7 @@ struct bpf_verifier_state {
 	 */
 	struct bpf_idx_pair *jmp_history;
 	u32 jmp_history_cnt;
+	u32 dfs_depth;
 };
 
 #define bpf_get_spilled_reg(slot, frame, mask)				\
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 366029e484a0..23e4eb0a5c23 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1802,6 +1802,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->parent = src->parent;
 	dst_state->first_insn_idx = src->first_insn_idx;
 	dst_state->last_insn_idx = src->last_insn_idx;
+	dst_state->dfs_depth = src->dfs_depth;
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
 		if (!dst) {
@@ -7723,6 +7724,80 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
 	return 0;
 }
 
+/* Look for a previous loop entry at insn_idx: nearest parent state
+ * stopped at insn_idx with callsites matching those in cur->frame.
+ */
+static struct bpf_verifier_state *find_prev_entry(struct bpf_verifier_env *env,
+						  struct bpf_verifier_state *cur,
+						  int insn_idx)
+{
+	struct bpf_verifier_state_list *sl;
+	struct bpf_verifier_state *st;
+
+	/* Explored states are pushed in stack order, most recent states come first */
+	sl = *explored_state(env, insn_idx);
+	for (; sl; sl = sl->next) {
+		/* If st->branches != 0 state is a part of current DFS verification path,
+		 * hence cur & st for a loop.
+		 */
+		st = &sl->state;
+		if (st->insn_idx == insn_idx && st->branches && same_callsites(st, cur) &&
+		    st->dfs_depth < cur->dfs_depth)
+			return st;
+	}
+
+	return NULL;
+}
+
+static void reset_idmap_scratch(struct bpf_verifier_env *env);
+static bool regs_exact(const struct bpf_reg_state *rold,
+		       const struct bpf_reg_state *rcur,
+		       struct bpf_idmap *idmap);
+
+static void maybe_widen_reg(struct bpf_verifier_env *env,
+			    struct bpf_reg_state *rold, struct bpf_reg_state *rcur,
+			    struct bpf_idmap *idmap)
+{
+	if (rold->type != SCALAR_VALUE)
+		return;
+	if (rold->type != rcur->type)
+		return;
+	if (rold->precise || rcur->precise || regs_exact(rold, rcur, idmap))
+		return;
+	__mark_reg_unknown(env, rcur);
+}
+
+static int widen_imprecise_scalars(struct bpf_verifier_env *env,
+				   struct bpf_verifier_state *old,
+				   struct bpf_verifier_state *cur)
+{
+	struct bpf_func_state *fold, *fcur;
+	int i, fr;
+
+	reset_idmap_scratch(env);
+	for (fr = old->curframe; fr >= 0; fr--) {
+		fold = old->frame[fr];
+		fcur = cur->frame[fr];
+
+		for (i = 0; i < MAX_BPF_REG; i++)
+			maybe_widen_reg(env,
+					&fold->regs[i],
+					&fcur->regs[i],
+					&env->idmap_scratch);
+
+		for (i = 0; i < fold->allocated_stack / BPF_REG_SIZE; i++) {
+			if (is_spilled_scalar_reg(&fold->stack[i]))
+				continue;
+
+			maybe_widen_reg(env,
+					&fold->stack[i].spilled_ptr,
+					&fcur->stack[i].spilled_ptr,
+					&env->idmap_scratch);
+		}
+	}
+	return 0;
+}
+
 /* process_iter_next_call() is called when verifier gets to iterator's next
  * "method" (e.g., bpf_iter_num_next() for numbers iterator) call. We'll refer
  * to it as just "iter_next()" in comments below.
@@ -7764,25 +7839,47 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
  * is some statically known limit on number of iterations (e.g., if there is
  * an explicit `if n > 100 then break;` statement somewhere in the loop).
  *
- * One very subtle but very important aspect is that we *always* simulate NULL
- * condition first (as the current state) before we simulate non-NULL case.
- * This has to do with intricacies of scalar precision tracking. By simulating
- * "exit condition" of iter_next() returning NULL first, we make sure all the
- * relevant precision marks *that will be set **after** we exit iterator loop*
- * are propagated backwards to common parent state of NULL and non-NULL
- * branches. Thanks to that, state equivalence checks done later in forked
- * state, when reaching iter_next() for ACTIVE iterator, can assume that
- * precision marks are finalized and won't change. Because simulating another
- * ACTIVE iterator iteration won't change them (because given same input
- * states we'll end up with exactly same output states which we are currently
- * comparing; and verification after the loop already propagated back what
- * needs to be **additionally** tracked as precise). It's subtle, grok
- * precision tracking for more intuitive understanding.
+ * Iteration convergence logic in is_state_visited() relies on exact
+ * states comparison, which ignores read and precision marks.
+ * This is necessary because read and precision marks are not finalized
+ * while in the loop. Exact comparison might preclude convergence for
+ * simple programs like below:
+ *
+ *     i = 0;
+ *     while(iter_next(&it))
+ *       i++;
+ *
+ * At each iteration step i++ would produce a new distinct state and
+ * eventually instruction processing limit would be reached.
+ *
+ * To avoid such behavior speculatively forget (widen) range for
+ * imprecise scalar registers, if those registers were not precise at the
+ * end of the previous iteration and do not match exactly.
+ *
+ * This is a conservative heuristic that allows to verify wide range of programs,
+ * however it precludes verification of programs that conjure an
+ * imprecise value on the first loop iteration and use it as precise on a second.
+ * For example, the following safe program would fail to verify:
+ *
+ *     struct bpf_num_iter it;
+ *     int arr[10];
+ *     int i = 0, a = 0;
+ *     bpf_iter_num_new(&it, 0, 10);
+ *     while (bpf_iter_num_next(&it)) {
+ *       if (a == 0) {
+ *         a = 1;
+ *         i = 7; // Because i changed verifier would forget
+ *                // it's range on second loop entry.
+ *       } else {
+ *         arr[i] = 42; // This would fail to verify.
+ *       }
+ *     }
+ *     bpf_iter_num_destroy(&it);
  */
 static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 				  struct bpf_kfunc_call_arg_meta *meta)
 {
-	struct bpf_verifier_state *cur_st = env->cur_state, *queued_st;
+	struct bpf_verifier_state *cur_st = env->cur_state, *queued_st, *prev_st;
 	struct bpf_func_state *cur_fr = cur_st->frame[cur_st->curframe], *queued_fr;
 	struct bpf_reg_state *cur_iter, *queued_iter;
 	int iter_frameno = meta->iter.frameno;
@@ -7800,6 +7897,19 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 	}
 
 	if (cur_iter->iter.state == BPF_ITER_STATE_ACTIVE) {
+		/* Because iter_next() call is a checkpoint is_state_visitied()
+		 * should guarantee parent state with same call sites and insn_idx.
+		 */
+		if (!cur_st->parent || cur_st->parent->insn_idx != insn_idx ||
+		    !same_callsites(cur_st->parent, cur_st)) {
+			verbose(env, "bug: bad parent state for iter next call");
+			return -EFAULT;
+		}
+		/* Note cur_st->parent in the call below, it is necessary to skip
+		 * checkpoint created for cur_st by is_state_visited()
+		 * right at this instruction.
+		 */
+		prev_st = find_prev_entry(env, cur_st->parent, insn_idx);
 		/* branch out active iter state */
 		queued_st = push_stack(env, insn_idx + 1, insn_idx, false);
 		if (!queued_st)
@@ -7808,6 +7918,8 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 		queued_iter = &queued_st->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
 		queued_iter->iter.state = BPF_ITER_STATE_ACTIVE;
 		queued_iter->iter.depth++;
+		if (prev_st)
+			widen_imprecise_scalars(env, prev_st, queued_st);
 
 		queued_fr = queued_st->frame[queued_st->curframe];
 		mark_ptr_not_null_reg(&queued_fr->regs[BPF_REG_0]);
@@ -15948,8 +16060,11 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 
 /* Returns true if (rold safe implies rcur safe) */
 static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
-		    struct bpf_reg_state *rcur, struct bpf_idmap *idmap)
+		    struct bpf_reg_state *rcur, struct bpf_idmap *idmap, bool exact)
 {
+	if (exact)
+		return regs_exact(rold, rcur, idmap);
+
 	if (!(rold->live & REG_LIVE_READ))
 		/* explored state didn't use this */
 		return true;
@@ -16066,7 +16181,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 }
 
 static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
-		      struct bpf_func_state *cur, struct bpf_idmap *idmap)
+		      struct bpf_func_state *cur, struct bpf_idmap *idmap, bool exact)
 {
 	int i, spi;
 
@@ -16079,7 +16194,12 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 
 		spi = i / BPF_REG_SIZE;
 
-		if (!(old->stack[spi].spilled_ptr.live & REG_LIVE_READ)) {
+		if (exact &&
+		    old->stack[spi].slot_type[i % BPF_REG_SIZE] !=
+		    cur->stack[spi].slot_type[i % BPF_REG_SIZE])
+			return false;
+
+		if (!(old->stack[spi].spilled_ptr.live & REG_LIVE_READ) && !exact) {
 			i += BPF_REG_SIZE - 1;
 			/* explored state didn't use this */
 			continue;
@@ -16129,7 +16249,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			 * return false to continue verification of this path
 			 */
 			if (!regsafe(env, &old->stack[spi].spilled_ptr,
-				     &cur->stack[spi].spilled_ptr, idmap))
+				     &cur->stack[spi].spilled_ptr, idmap, exact))
 				return false;
 			break;
 		case STACK_DYNPTR:
@@ -16211,16 +16331,16 @@ static bool refsafe(struct bpf_func_state *old, struct bpf_func_state *cur,
  * the current state will reach 'bpf_exit' instruction safely
  */
 static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_state *old,
-			      struct bpf_func_state *cur)
+			      struct bpf_func_state *cur, bool exact)
 {
 	int i;
 
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (!regsafe(env, &old->regs[i], &cur->regs[i],
-			     &env->idmap_scratch))
+			     &env->idmap_scratch, exact))
 			return false;
 
-	if (!stacksafe(env, old, cur, &env->idmap_scratch))
+	if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
 		return false;
 
 	if (!refsafe(old, cur, &env->idmap_scratch))
@@ -16229,17 +16349,23 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	return true;
 }
 
+static void reset_idmap_scratch(struct bpf_verifier_env *env)
+{
+	env->idmap_scratch.tmp_id_gen = env->id_gen;
+	memset(&env->idmap_scratch.map, 0, sizeof(env->idmap_scratch.map));
+}
+
 static bool states_equal(struct bpf_verifier_env *env,
 			 struct bpf_verifier_state *old,
-			 struct bpf_verifier_state *cur)
+			 struct bpf_verifier_state *cur,
+			 bool exact)
 {
 	int i;
 
 	if (old->curframe != cur->curframe)
 		return false;
 
-	env->idmap_scratch.tmp_id_gen = env->id_gen;
-	memset(&env->idmap_scratch.map, 0, sizeof(env->idmap_scratch.map));
+	reset_idmap_scratch(env);
 
 	/* Verification state from speculative execution simulation
 	 * must never prune a non-speculative execution one.
@@ -16269,7 +16395,7 @@ static bool states_equal(struct bpf_verifier_env *env,
 	for (i = 0; i <= old->curframe; i++) {
 		if (old->frame[i]->callsite != cur->frame[i]->callsite)
 			return false;
-		if (!func_states_equal(env, old->frame[i], cur->frame[i]))
+		if (!func_states_equal(env, old->frame[i], cur->frame[i], exact))
 			return false;
 	}
 	return true;
@@ -16579,9 +16705,33 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * It's safe to assume that iterator loop will finish, taking into
 			 * account iter_next() contract of eventually returning
 			 * sticky NULL result.
+			 *
+			 * Note, that states have to be compared exactly in this case because
+			 * read and precision marks might not be finalized inside the loop.
+			 * E.g. as in the program below:
+			 *
+			 *     1. r7 = -16
+			 *     2. r6 = bpf_get_prandom_u32()
+			 *     3. while (bpf_iter_num_next(&fp[-8])) {
+			 *     4.   if (r6 != 42) {
+			 *     5.     r7 = -32
+			 *     6.     r6 = bpf_get_prandom_u32()
+			 *     7.     continue
+			 *     8.   }
+			 *     9.   r0 = r10
+			 *    10.   r0 += r7
+			 *    11.   r8 = *(u64 *)(r0 + 0)
+			 *    12.   r6 = bpf_get_prandom_u32()
+			 *    13. }
+			 *
+			 * Here verifier would first visit path 1-3, create a checkpoint at 3
+			 * with r7=-16, continue to 4-7,3. Existing checkpoint at 3 does
+			 * not have read or precision mark for r7 yet, thus inexact states
+			 * comparison would discard current state with r7=-32
+			 * => unsafe memory access at 11 would not be caught.
 			 */
 			if (is_iter_next_insn(env, insn_idx)) {
-				if (states_equal(env, &sl->state, cur)) {
+				if (states_equal(env, &sl->state, cur, true)) {
 					struct bpf_func_state *cur_frame;
 					struct bpf_reg_state *iter_state, *iter_reg;
 					int spi;
@@ -16604,7 +16754,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			}
 			/* attempt to detect infinite loop to avoid unnecessary doomed work */
 			if (states_maybe_looping(&sl->state, cur) &&
-			    states_equal(env, &sl->state, cur) &&
+			    states_equal(env, &sl->state, cur, false) &&
 			    !iter_active_depths_differ(&sl->state, cur)) {
 				verbose_linfo(env, insn_idx, "; ");
 				verbose(env, "infinite loop detected at insn %d\n", insn_idx);
@@ -16629,7 +16779,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				add_new_state = false;
 			goto miss;
 		}
-		if (states_equal(env, &sl->state, cur)) {
+		if (states_equal(env, &sl->state, cur, false)) {
 hit:
 			sl->hit_cnt++;
 			/* reached equivalent register/stack state,
@@ -16669,7 +16819,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		 * Higher numbers increase max_states_per_insn and verification time,
 		 * but do not meaningfully decrease insn_processed.
 		 */
-		if (sl->miss_cnt > sl->hit_cnt * 3 + 3) {
+		if (sl->miss_cnt > sl->hit_cnt * 3 + 3 &&
+		    !(is_force_checkpoint(env, insn_idx) && sl->state.branches > 0)) {
 			/* the state is unlikely to be useful. Remove it to
 			 * speed up verification
 			 */
@@ -16743,6 +16894,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 
 	cur->parent = new;
 	cur->first_insn_idx = insn_idx;
+	cur->dfs_depth = new->dfs_depth + 1;
 	clear_jmp_history(cur);
 	new_sl->next = *explored_state(env, insn_idx);
 	*explored_state(env, insn_idx) = new_sl;
diff --git a/tools/testing/selftests/bpf/progs/iters_task_vma.c b/tools/testing/selftests/bpf/progs/iters_task_vma.c
index 44edecfdfaee..e085a51d153e 100644
--- a/tools/testing/selftests/bpf/progs/iters_task_vma.c
+++ b/tools/testing/selftests/bpf/progs/iters_task_vma.c
@@ -30,6 +30,7 @@ int iter_task_vma_for_each(const void *ctx)
 	bpf_for_each(task_vma, vma, task, 0) {
 		if (seen >= 1000)
 			break;
+		barrier_var(seen);
 
 		vm_ranges[seen].vm_start = vma->vm_start;
 		vm_ranges[seen].vm_end = vma->vm_end;
-- 
2.42.0


