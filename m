Return-Path: <bpf+bounces-44585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1D19C4D82
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 04:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4BB288445
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 03:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185BC205E04;
	Tue, 12 Nov 2024 03:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xq8qf82J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93709166F14
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 03:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731383739; cv=none; b=DIn4cOhqVqqY9ZCtYt/H3wtXLz8eZdOrFIbFLfnT35ktaRSi1sJAq+1anq1sCQJknH5ULvhz+13PAU73cz7gRWYlt7YA5OFVcxyEV33AM81nvOLqu4/AyjbzUnks2DMUJJFyest1/aZtiuhgLTpu908CIa0AnqiFQ/F6ffa/PS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731383739; c=relaxed/simple;
	bh=OGpGr0x+ueWoB6xurXNnCjqtncV50GzIHLCN9yPCVp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SLdmFWb3BJx4kWIRsrbRBZ28gxMK8wr2TqTByjAGjad7xusMjy4sWuKFZtEop5K7FzNmM7DO5hTu0sCyVvlGYQ93Eq97kSfeoHEp5XS5tpuH47JNWxdlSPjT3kv9btMw3cfzLJgN1jneelHQirZsZeq4YBraOmCjm0XOnChyRPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xq8qf82J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42B7C4CECD;
	Tue, 12 Nov 2024 03:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731383739;
	bh=OGpGr0x+ueWoB6xurXNnCjqtncV50GzIHLCN9yPCVp8=;
	h=From:To:Cc:Subject:Date:From;
	b=Xq8qf82JpUWyapWxYQai6JBa68TMrptHtjYST4Zme6EvY5wvTMMyjom5+hQQ+Dw+g
	 6+C/s9h4LhVRRPEANhKfVIfK8d1A86bEIAbXZBB3HaJuxiDDdVy1sAsKKBE2MnNfNn
	 U3MVP8yVdcqr0hSOr3YCw6iFjaTKgvYgJDODFLLSNYJ4g0I0hAi6986dXb3qZ3oClk
	 Nz0+m0+BBLdmPSFGQ6oXRKEh0xA4NpbLT6YWdnlOwIDhkXOX1KTZZ1ZuIJJpdTBH4q
	 nUPh0yVi18TfEaqKrKpoF22/qveJzs3dM75PZssxYEI4ufagjCGGJhVErdugUeIM2W
	 OJoxW+J9NC3hQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v2 bpf-next] bpf: use common instruction history across all states
Date: Mon, 11 Nov 2024 19:55:29 -0800
Message-ID: <20241112035530.1219098-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of allocating and copying instruction history each time we
enqueue child verifier state, switch to a model where we use one common
dynamically sized array of instruction history entries across all states.

The key observation for proving this is correct is that instruction
history is only relevant while state is active, which means it either is
a current state (and thus we are actively modifying instruction history
and no other state can interfere with us) or we are checkpointed state
with some children still active (either enqueued or being current).

In the latter case our portion of instruction history is finalized and
won't change or grow, so as long as we keep it immutable until the state
is finalized, we are good.

Now, when state is finalized and is put into state hash for potentially
future pruning lookups, instruction history is not used anymore. This is
because instruction history is only used by precision marking logic, and
we never modify precision markings for finalized states.

So, instead of each state having its own small instruction history, we
keep a global dynamically-sized instruction history, where each state in
current DFS path from root to active state remembers its portion of
instruction history. Current state can append to this history, but
cannot modify any of its parent histories.

Async callback state enqueueing, while logically detached from parent
state, still is part of verification backtracking tree, so has to follow
the same schema as normal state checkpoints.

Because the insn_hist array can be grown through realloc, states don't
keep pointers, they instead maintain two indices, [start, end), into
global instruction history array. End is exclusive index, so
`start == end` means there is no relevant instruction history.

This eliminates a lot of allocations and minimizes overall memory usage.

For instance, running a worst-case test from [0] (but without the
heuristics-based fix [1]), it took 12.5 minutes until we get -ENOMEM.
With the changes in this patch the whole test succeeds in 10 minutes
(very slow, so heuristics from [1] is important, of course).

To further validate correctness, veristat-based comparison was performed for
Meta production BPF objects and BPF selftests objects. In both cases there
were no differences *at all* in terms of verdict or instruction and state
counts, providing a good confidence in the change.

Having this low-memory-overhead solution of keeping dynamic
per-instruction history cheaply opens up some new possibilities, like
keeping extra information for literally every single validated
instruction. This will be used for simplifying precision backpropagation
logic in follow up patches.

  [0] https://lore.kernel.org/bpf/20241029172641.1042523-2-eddyz87@gmail.com/
  [1] https://lore.kernel.org/bpf/20241029172641.1042523-1-eddyz87@gmail.com/

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
v1->v2:
  - typo fix, and use hist_start in get_prev_insn_idx (Alexei).
---
 include/linux/bpf_verifier.h |  19 ++++---
 kernel/bpf/verifier.c        | 105 +++++++++++++++++------------------
 2 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3a74033d49c4..05031ff77b1d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -334,7 +334,7 @@ struct bpf_func_state {
 
 #define MAX_CALL_FRAMES 8
 
-/* instruction history flags, used in bpf_jmp_history_entry.flags field */
+/* instruction history flags, used in bpf_insn_hist_entry.flags field */
 enum {
 	/* instruction references stack slot through PTR_TO_STACK register;
 	 * we also store stack's frame number in lower 3 bits (MAX_CALL_FRAMES is 8)
@@ -352,7 +352,7 @@ enum {
 static_assert(INSN_F_FRAMENO_MASK + 1 >= MAX_CALL_FRAMES);
 static_assert(INSN_F_SPI_MASK + 1 >= MAX_BPF_STACK / 8);
 
-struct bpf_jmp_history_entry {
+struct bpf_insn_hist_entry {
 	u32 idx;
 	/* insn idx can't be bigger than 1 million */
 	u32 prev_idx : 22;
@@ -442,13 +442,14 @@ struct bpf_verifier_state {
 	 * See get_loop_entry() for more information.
 	 */
 	struct bpf_verifier_state *loop_entry;
-	/* jmp history recorded from first to last.
-	 * backtracking is using it to go from last to first.
-	 * For most states jmp_history_cnt is [0-3].
+	/* Sub-range of env->insn_hist[] corresponding to this state's
+	 * instruction history.
+	 * Backtracking is using it to go from last to first.
+	 * For most states instruction history is short, 0-3 instructions.
 	 * For loops can go up to ~40.
 	 */
-	struct bpf_jmp_history_entry *jmp_history;
-	u32 jmp_history_cnt;
+	u32 insn_hist_start;
+	u32 insn_hist_end;
 	u32 dfs_depth;
 	u32 callback_unroll_depth;
 	u32 may_goto_depth;
@@ -731,7 +732,9 @@ struct bpf_verifier_env {
 		int cur_stack;
 	} cfg;
 	struct backtrack_state bt;
-	struct bpf_jmp_history_entry *cur_hist_ent;
+	struct bpf_insn_hist_entry *insn_hist;
+	struct bpf_insn_hist_entry *cur_hist_ent;
+	u32 insn_hist_cap;
 	u32 pass_cnt; /* number of times do_check() was called */
 	u32 subprog_cnt;
 	/* number of instructions analyzed by the verifier */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9f5de8d4fbd0..f76dc27e3d86 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1450,13 +1450,6 @@ static void free_func_state(struct bpf_func_state *state)
 	kfree(state);
 }
 
-static void clear_jmp_history(struct bpf_verifier_state *state)
-{
-	kfree(state->jmp_history);
-	state->jmp_history = NULL;
-	state->jmp_history_cnt = 0;
-}
-
 static void free_verifier_state(struct bpf_verifier_state *state,
 				bool free_self)
 {
@@ -1466,7 +1459,6 @@ static void free_verifier_state(struct bpf_verifier_state *state,
 		free_func_state(state->frame[i]);
 		state->frame[i] = NULL;
 	}
-	clear_jmp_history(state);
 	if (free_self)
 		kfree(state);
 }
@@ -1492,13 +1484,6 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	struct bpf_func_state *dst;
 	int i, err;
 
-	dst_state->jmp_history = copy_array(dst_state->jmp_history, src->jmp_history,
-					  src->jmp_history_cnt, sizeof(*dst_state->jmp_history),
-					  GFP_USER);
-	if (!dst_state->jmp_history)
-		return -ENOMEM;
-	dst_state->jmp_history_cnt = src->jmp_history_cnt;
-
 	/* if dst has more stack frames then src frame, free them, this is also
 	 * necessary in case of exceptional exits using bpf_throw.
 	 */
@@ -1515,6 +1500,8 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->parent = src->parent;
 	dst_state->first_insn_idx = src->first_insn_idx;
 	dst_state->last_insn_idx = src->last_insn_idx;
+	dst_state->insn_hist_start = src->insn_hist_start;
+	dst_state->insn_hist_end = src->insn_hist_end;
 	dst_state->dfs_depth = src->dfs_depth;
 	dst_state->callback_unroll_depth = src->callback_unroll_depth;
 	dst_state->used_as_loop_entry = src->used_as_loop_entry;
@@ -2567,9 +2554,14 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	 * The caller state doesn't matter.
 	 * This is async callback. It starts in a fresh stack.
 	 * Initialize it similar to do_check_common().
+	 * But we do need to make sure to not clobber insn_hist, so we keep
+	 * chaining insn_hist_start/insn_hist_end indices as for a normal
+	 * child state.
 	 */
 	elem->st.branches = 1;
 	elem->st.in_sleepable = is_sleepable;
+	elem->st.insn_hist_start = env->cur_state->insn_hist_end;
+	elem->st.insn_hist_end = elem->st.insn_hist_start;
 	frame = kzalloc(sizeof(*frame), GFP_KERNEL);
 	if (!frame)
 		goto err;
@@ -3549,11 +3541,10 @@ static void linked_regs_unpack(u64 val, struct linked_regs *s)
 }
 
 /* for any branch, call, exit record the history of jmps in the given state */
-static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
-			    int insn_flags, u64 linked_regs)
+static int push_insn_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
+			     int insn_flags, u64 linked_regs)
 {
-	u32 cnt = cur->jmp_history_cnt;
-	struct bpf_jmp_history_entry *p;
+	struct bpf_insn_hist_entry *p;
 	size_t alloc_size;
 
 	/* combine instruction flags if we already recorded this instruction */
@@ -3573,29 +3564,32 @@ static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_st
 		return 0;
 	}
 
-	cnt++;
-	alloc_size = kmalloc_size_roundup(size_mul(cnt, sizeof(*p)));
-	p = krealloc(cur->jmp_history, alloc_size, GFP_USER);
-	if (!p)
-		return -ENOMEM;
-	cur->jmp_history = p;
+	if (cur->insn_hist_end + 1 > env->insn_hist_cap) {
+		alloc_size = size_mul(cur->insn_hist_end + 1, sizeof(*p));
+		p = kvrealloc(env->insn_hist, alloc_size, GFP_USER);
+		if (!p)
+			return -ENOMEM;
+		env->insn_hist = p;
+		env->insn_hist_cap = alloc_size / sizeof(*p);
+	}
 
-	p = &cur->jmp_history[cnt - 1];
+	p = &env->insn_hist[cur->insn_hist_end];
 	p->idx = env->insn_idx;
 	p->prev_idx = env->prev_insn_idx;
 	p->flags = insn_flags;
 	p->linked_regs = linked_regs;
-	cur->jmp_history_cnt = cnt;
+
+	cur->insn_hist_end++;
 	env->cur_hist_ent = p;
 
 	return 0;
 }
 
-static struct bpf_jmp_history_entry *get_jmp_hist_entry(struct bpf_verifier_state *st,
-						        u32 hist_end, int insn_idx)
+static struct bpf_insn_hist_entry *get_insn_hist_entry(struct bpf_verifier_env *env,
+						       u32 hist_start, u32 hist_end, int insn_idx)
 {
-	if (hist_end > 0 && st->jmp_history[hist_end - 1].idx == insn_idx)
-		return &st->jmp_history[hist_end - 1];
+	if (hist_end > hist_start && env->insn_hist[hist_end - 1].idx == insn_idx)
+		return &env->insn_hist[hist_end - 1];
 	return NULL;
 }
 
@@ -3612,25 +3606,26 @@ static struct bpf_jmp_history_entry *get_jmp_hist_entry(struct bpf_verifier_stat
  * history entry recording a jump from last instruction of parent state and
  * first instruction of given state.
  */
-static int get_prev_insn_idx(struct bpf_verifier_state *st, int i,
-			     u32 *history)
+static int get_prev_insn_idx(const struct bpf_verifier_env *env,
+			     struct bpf_verifier_state *st,
+			     int insn_idx, u32 hist_start, u32 *hist_endp)
 {
-	u32 cnt = *history;
+	u32 hist_end = *hist_endp;
+	u32 cnt = hist_end - hist_start;
 
-	if (i == st->first_insn_idx) {
+	if (insn_idx == st->first_insn_idx) {
 		if (cnt == 0)
 			return -ENOENT;
-		if (cnt == 1 && st->jmp_history[0].idx == i)
+		if (cnt == 1 && env->insn_hist[hist_start].idx == insn_idx)
 			return -ENOENT;
 	}
 
-	if (cnt && st->jmp_history[cnt - 1].idx == i) {
-		i = st->jmp_history[cnt - 1].prev_idx;
-		(*history)--;
+	if (cnt && env->insn_hist[hist_end - 1].idx == insn_idx) {
+		(*hist_endp)--;
+		return env->insn_hist[hist_end - 1].prev_idx;
 	} else {
-		i--;
+		return insn_idx - 1;
 	}
-	return i;
 }
 
 static const char *disasm_kfunc_name(void *data, const struct bpf_insn *insn)
@@ -3802,7 +3797,7 @@ static void fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask)
 /* If any register R in hist->linked_regs is marked as precise in bt,
  * do bt_set_frame_{reg,slot}(bt, R) for all registers in hist->linked_regs.
  */
-static void bt_sync_linked_regs(struct backtrack_state *bt, struct bpf_jmp_history_entry *hist)
+static void bt_sync_linked_regs(struct backtrack_state *bt, struct bpf_insn_hist_entry *hist)
 {
 	struct linked_regs linked_regs;
 	bool some_precise = false;
@@ -3847,7 +3842,7 @@ static bool calls_callback(struct bpf_verifier_env *env, int insn_idx);
  *   - *was* processed previously during backtracking.
  */
 static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
-			  struct bpf_jmp_history_entry *hist, struct backtrack_state *bt)
+			  struct bpf_insn_hist_entry *hist, struct backtrack_state *bt)
 {
 	const struct bpf_insn_cbs cbs = {
 		.cb_call	= disasm_kfunc_name,
@@ -4266,7 +4261,7 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
  * SCALARS, as well as any other registers and slots that contribute to
  * a tracked state of given registers/stack slots, depending on specific BPF
  * assembly instructions (see backtrack_insns() for exact instruction handling
- * logic). This backtracking relies on recorded jmp_history and is able to
+ * logic). This backtracking relies on recorded insn_hist and is able to
  * traverse entire chain of parent states. This process ends only when all the
  * necessary registers/slots and their transitive dependencies are marked as
  * precise.
@@ -4383,8 +4378,9 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 
 	for (;;) {
 		DECLARE_BITMAP(mask, 64);
-		u32 history = st->jmp_history_cnt;
-		struct bpf_jmp_history_entry *hist;
+		u32 hist_start = st->insn_hist_start;
+		u32 hist_end = st->insn_hist_end;
+		struct bpf_insn_hist_entry *hist;
 
 		if (env->log.level & BPF_LOG_LEVEL2) {
 			verbose(env, "mark_precise: frame%d: last_idx %d first_idx %d subseq_idx %d \n",
@@ -4423,7 +4419,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				err = 0;
 				skip_first = false;
 			} else {
-				hist = get_jmp_hist_entry(st, history, i);
+				hist = get_insn_hist_entry(env, hist_start, hist_end, i);
 				err = backtrack_insn(env, i, subseq_idx, hist, bt);
 			}
 			if (err == -ENOTSUPP) {
@@ -4440,7 +4436,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				 */
 				return 0;
 			subseq_idx = i;
-			i = get_prev_insn_idx(st, i, &history);
+			i = get_prev_insn_idx(env, st, i, hist_start, &hist_end);
 			if (i == -ENOENT)
 				break;
 			if (i >= env->prog->len) {
@@ -4806,7 +4802,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	}
 
 	if (insn_flags)
-		return push_jmp_history(env, env->cur_state, insn_flags, 0);
+		return push_insn_history(env, env->cur_state, insn_flags, 0);
 	return 0;
 }
 
@@ -5113,7 +5109,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 		insn_flags = 0; /* we are not restoring spilled register */
 	}
 	if (insn_flags)
-		return push_jmp_history(env, env->cur_state, insn_flags, 0);
+		return push_insn_history(env, env->cur_state, insn_flags, 0);
 	return 0;
 }
 
@@ -15666,7 +15662,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	if (dst_reg->type == SCALAR_VALUE && dst_reg->id)
 		collect_linked_regs(this_branch, dst_reg->id, &linked_regs);
 	if (linked_regs.cnt > 1) {
-		err = push_jmp_history(env, this_branch, 0, linked_regs_pack(&linked_regs));
+		err = push_insn_history(env, this_branch, 0, linked_regs_pack(&linked_regs));
 		if (err)
 			return err;
 	}
@@ -18250,7 +18246,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * the current state.
 			 */
 			if (is_jmp_point(env, env->insn_idx))
-				err = err ? : push_jmp_history(env, cur, 0, 0);
+				err = err ? : push_insn_history(env, cur, 0, 0);
 			err = err ? : propagate_precision(env, &sl->state);
 			if (err)
 				return err;
@@ -18349,8 +18345,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 
 	cur->parent = new;
 	cur->first_insn_idx = insn_idx;
+	cur->insn_hist_start = cur->insn_hist_end;
 	cur->dfs_depth = new->dfs_depth + 1;
-	clear_jmp_history(cur);
 	new_sl->next = *explored_state(env, insn_idx);
 	*explored_state(env, insn_idx) = new_sl;
 	/* connect new state to parentage chain. Current frame needs all
@@ -18518,7 +18514,7 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 
 		if (is_jmp_point(env, env->insn_idx)) {
-			err = push_jmp_history(env, state, 0, 0);
+			err = push_insn_history(env, state, 0, 0);
 			if (err)
 				return err;
 		}
@@ -22704,6 +22700,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
 	vfree(env->insn_aux_data);
+	kvfree(env->insn_hist);
 err_free_env:
 	kvfree(env);
 	return ret;
-- 
2.43.5


