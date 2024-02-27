Return-Path: <bpf+bounces-22758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204EA8688CB
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 06:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B1DFB24D4E
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 05:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B31153373;
	Tue, 27 Feb 2024 05:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2nn62+o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB89652F87
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 05:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709013165; cv=none; b=NBrjl6WtOV1XysXu3Y2xG1K5A0WUA7JzyT3btCyFxS8sOFHLrTyg5DIlGx98r9E7O9oyYRzPAytPLNnY1MbmCj42evUUsPJzzTwO4AkZJweSKBci4rZ8mGcJ6skDzlW52zuolvjpWS3bi+BUf0SgB3YcGorov4Nb54ys47rIm8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709013165; c=relaxed/simple;
	bh=nOw5gwdU4O8p1DE2ltNCvLaT6fFCe0pKM9F9hFq3Xsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G0lDE8Z3PHcl9AMl0OJrs9VsZAXn7RahB35+FBxye9JxcUsPJEtPvuxokMIHXjOMEYvkHbO2ApyqKw+tzStxPmwVN+E1VcgSSFHie98KxnCtgdxckoezC7hx3FzyhBuhMsGNGZ7zGHav2XuI9RB8fVXKchr8MAOc8d2kvqp2or0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2nn62+o; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e332bc65b3so2052924b3a.3
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 21:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709013163; x=1709617963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDvHeE8XazdQKL8cUyGEb4eKopCmBzucehVZUxFbkMM=;
        b=P2nn62+o5nKWsIJ0kS4OMM2eqEicPpXq/OiQCdwJ7eLgK024OOQ3GvByhwc2x34nTN
         PT7PxF9HpCQ99mfSxItJLC1qhfV1KvEhfcW06TMyLen7v2yLpynzlOyLs2lB7jQi1ecC
         wIK5zTeMWDies4FURP49Rt0qAY8XaoMFywAANQIrmvujiZOWtBhC5ZQq8+zGvSTqYvNP
         FP8X5ReQra/g/rDoXhDMkSIebmZgIexW3GbwZWF+afaJ5IdOFOW4Lrgx0TciQ+R4W4tx
         VyPDFghHWisbhc7GEEaP3smhh1MwG4jYCafg8nbZx1O45/IN9rxxud+kxk3U3e/XjyJS
         C0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709013163; x=1709617963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDvHeE8XazdQKL8cUyGEb4eKopCmBzucehVZUxFbkMM=;
        b=lmog4UT81+Cn8s8IE+E/sKv72dWVieqeKXl0IJ5Li1wQo6kjdN/rJBoRK5aPWR6Jnl
         lxed6kHfyfkpDGmWvFfKoKLSub7XKruqFasYR7YuCKy2I8tn+f5pezodZmU10A+rBcw5
         i8DfqFXJej07JojCdTe3u4wtKxO6GbFi3fO+l+jAqMupUAoOPGBOdwr2EJ/IY6s5/05v
         Z9XkKz1ixNr11QRD3nx/sRGuVIalBP7nmQm5u5KD3difUC3uETAGfN8gPWbhVoLq7csO
         oinn3PV2IsqmqkU/pc3vW0yrP13ZHWCFsbkwAzB0FJvfIXpUKmMAlI6D4rtO6jgtQhDA
         TqwA==
X-Gm-Message-State: AOJu0Yy3hCpPNdD9xeXqKQjHt/pko9ZSNFzEMZamcmNGBJOzjJtRpbxx
	qcXO4xplNuJ8fiB/mJL4vDZwVStGP79xVUhSFeKM56/W1yD/r+e/CyTi1/H4
X-Google-Smtp-Source: AGHT+IGk3Jc0Rzx0gthLO4Xql/KdMaaegIIDbYoeLNjCnds1HReZgzpjEihiq2KW/l+PVEXsguVw4A==
X-Received: by 2002:a05:6a00:72b:b0:6e4:d15c:88e2 with SMTP id 11-20020a056a00072b00b006e4d15c88e2mr7796913pfm.18.1709013162551;
        Mon, 26 Feb 2024 21:52:42 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::4:45de])
        by smtp.gmail.com with ESMTPSA id k25-20020a635619000000b005bdbe9a597fsm4882379pgb.57.2024.02.26.21.52.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Feb 2024 21:52:42 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 1/2] bpf: Introduce bpf_can_loop() kfunc
Date: Mon, 26 Feb 2024 21:52:34 -0800
Message-Id: <20240227055235.23463-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240227055235.23463-1-alexei.starovoitov@gmail.com>
References: <20240227055235.23463-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

While working on bpf_arena the following monster macro had to be
used to iterate a link list:

  for (struct bpf_iter_num ___it __attribute__((aligned(8),
                                                cleanup(bpf_iter_num_destroy))),
              * ___tmp = (bpf_iter_num_new(&___it, 0, (1000000)),
                          pos = list_entry_safe((head)->first,
                                                typeof(*(pos)), member),
                          (void)bpf_iter_num_destroy,
			  (void *)0);
       bpf_iter_num_next(&___it) && pos &&
          ({ ___tmp = (void *)pos->member.next; 1; });
       pos = list_entry_safe((void __arena *)___tmp, typeof(*(pos)), member))

It's similar to bpf_for(), bpf_repeat() macros.
Unfortunately every "for" in normal C code needs an equivalent monster macro.

Instead, let's introduce bpf_can_loop() kfunc that acts on a hidden
bpf_iter_num, so that bpf_iter_num_new(), bpf_iter_num_destroy()
don't need to be called explicitly. It simplifies the macro to:

  for (void * ___tmp = (pos = list_entry_safe((head)->first,
                                              typeof(*(pos)), member),
                        (void *)0);
       bpf_can_loop(0) && pos &&
          ({ ___tmp = (void *)pos->member.next; 1; });
       pos = list_entry_safe((void __arena *)___tmp, typeof(*(pos)), member))

and can be used in any normal "for" or "while" loop, like

  for (i = 0; i < cnt && bpf_can_loop(0); i++) {

The verifier recognizes that bpf_can_loop() is used in the program,
reserves additional 8 bytes of stack, zero initializes them in subprog
prologue, and passes that address to bpf_can_loop() kfunc that simply
increments the counter until it reaches BPF_MAX_LOOPS.

In the future bpf_can_loop() can be inlined to improve performance.
New instruction with the same semantics can be added,
and LLVM will finally be able to emit __builtin_memcpy, __builtin_strcmp.

bpf_can_loop() is not a substitute for bpf_for() when it's used to
iterate normal arrays or map_values.
bpf_can_loop() works well only with arena pointers that don't need
to be bounds-checked on every iteration.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   3 +
 kernel/bpf/helpers.c         |  12 +++
 kernel/bpf/verifier.c        | 163 +++++++++++++++++++++++++++++------
 3 files changed, 150 insertions(+), 28 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 84365e6dd85d..69bc7f2d20f1 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -449,6 +449,7 @@ struct bpf_verifier_state {
 	u32 jmp_history_cnt;
 	u32 dfs_depth;
 	u32 callback_unroll_depth;
+	struct bpf_reg_state can_loop_reg;
 };
 
 #define bpf_get_spilled_reg(slot, frame, mask)				\
@@ -549,6 +550,7 @@ struct bpf_insn_aux_data {
 	bool zext_dst; /* this insn zero extends dst reg */
 	bool storage_get_func_atomic; /* bpf_*_storage_get() with atomic memory alloc */
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
+	bool is_can_loop; /* bpf_can_loop() kfunc call */
 	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
 	u8 alu_state; /* used in combination with alu_limit */
 
@@ -619,6 +621,7 @@ struct bpf_subprog_info {
 	u32 start; /* insn idx of function entry point */
 	u32 linfo_idx; /* The idx to the main_prog->aux->linfo */
 	u16 stack_depth; /* max. stack depth used by this function */
+	u16 stack_extra;
 	bool has_tail_call: 1;
 	bool tail_call_reachable: 1;
 	bool has_ld_abs: 1;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 93edf730d288..d1d93ad8a010 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2542,6 +2542,17 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
 
+__bpf_kfunc long bpf_can_loop(void *ptr__ign)
+{
+	u64 *pcnt = ptr__ign, cnt = *pcnt;
+
+	if (cnt < BPF_MAX_LOOPS) {
+		*pcnt = cnt + 1;
+		return cnt + 1;
+	}
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -2618,6 +2629,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
+BTF_ID_FLAGS(func, bpf_can_loop)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 011d54a1dc53..a94ed21b7770 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -502,6 +502,7 @@ static bool is_dynptr_ref_function(enum bpf_func_id func_id)
 
 static bool is_sync_callback_calling_kfunc(u32 btf_id);
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn);
+static bool is_can_loop_kfunc(struct bpf_kfunc_call_arg_meta *meta);
 
 static bool is_sync_callback_calling_function(enum bpf_func_id func_id)
 {
@@ -1436,6 +1437,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 		if (err)
 			return err;
 	}
+	dst_state->can_loop_reg = src->can_loop_reg;
 	return 0;
 }
 
@@ -7868,6 +7870,34 @@ static int widen_imprecise_scalars(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static bool is_can_loop_insn(struct bpf_verifier_env *env, int insn_idx)
+{
+	return env->insn_aux_data[insn_idx].is_can_loop;
+}
+
+static struct bpf_reg_state *get_iter_reg(struct bpf_verifier_env *env,
+					  struct bpf_verifier_state *st, int insn_idx)
+{
+	struct bpf_func_state *cur_frame;
+	struct bpf_reg_state *iter_reg;
+	int spi;
+
+	if (is_can_loop_insn(env, insn_idx))
+		return &st->can_loop_reg;
+
+	cur_frame = st->frame[st->curframe];
+	/* btf_check_iter_kfuncs() enforces that
+	 * iter state pointer is always the first arg
+	 */
+	iter_reg = &cur_frame->regs[BPF_REG_1];
+	/* current state is valid due to states_equal(),
+	 * so we can assume valid iter and reg state,
+	 * no need for extra (re-)validations
+	 */
+	spi = __get_spi(iter_reg->off + iter_reg->var_off.value);
+	return &func(env, iter_reg)->stack[spi].spilled_ptr;
+}
+
 /* process_iter_next_call() is called when verifier gets to iterator's next
  * "method" (e.g., bpf_iter_num_next() for numbers iterator) call. We'll refer
  * to it as just "iter_next()" in comments below.
@@ -7946,18 +7976,15 @@ static int widen_imprecise_scalars(struct bpf_verifier_env *env,
  *     }
  *     bpf_iter_num_destroy(&it);
  */
-static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
-				  struct bpf_kfunc_call_arg_meta *meta)
+static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx)
 {
 	struct bpf_verifier_state *cur_st = env->cur_state, *queued_st, *prev_st;
 	struct bpf_func_state *cur_fr = cur_st->frame[cur_st->curframe], *queued_fr;
 	struct bpf_reg_state *cur_iter, *queued_iter;
-	int iter_frameno = meta->iter.frameno;
-	int iter_spi = meta->iter.spi;
 
 	BTF_TYPE_EMIT(struct bpf_iter);
 
-	cur_iter = &env->cur_state->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
+	cur_iter = get_iter_reg(env, cur_st, insn_idx);
 
 	if (cur_iter->iter.state != BPF_ITER_STATE_ACTIVE &&
 	    cur_iter->iter.state != BPF_ITER_STATE_DRAINED) {
@@ -7985,7 +8012,7 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 		if (!queued_st)
 			return -ENOMEM;
 
-		queued_iter = &queued_st->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
+		queued_iter = get_iter_reg(env, queued_st, insn_idx);
 		queued_iter->iter.state = BPF_ITER_STATE_ACTIVE;
 		queued_iter->iter.depth++;
 		if (prev_st)
@@ -10925,6 +10952,7 @@ enum special_kfunc_type {
 	KF_bpf_percpu_obj_new_impl,
 	KF_bpf_percpu_obj_drop_impl,
 	KF_bpf_throw,
+	KF_bpf_can_loop,
 	KF_bpf_iter_css_task_new,
 };
 
@@ -10949,6 +10977,7 @@ BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
 BTF_ID(func, bpf_throw)
+BTF_ID(func, bpf_can_loop)
 #ifdef CONFIG_CGROUPS
 BTF_ID(func, bpf_iter_css_task_new)
 #endif
@@ -10977,6 +11006,7 @@ BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
 BTF_ID(func, bpf_throw)
+BTF_ID(func, bpf_can_loop)
 #ifdef CONFIG_CGROUPS
 BTF_ID(func, bpf_iter_css_task_new)
 #else
@@ -11003,6 +11033,11 @@ static bool is_kfunc_bpf_rcu_read_unlock(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->func_id == special_kfunc_list[KF_bpf_rcu_read_unlock];
 }
 
+static bool is_can_loop_kfunc(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->func_id == special_kfunc_list[KF_bpf_can_loop];
+}
+
 static enum kfunc_ptr_arg_type
 get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 		       struct bpf_kfunc_call_arg_meta *meta,
@@ -12049,6 +12084,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	insn_aux = &env->insn_aux_data[insn_idx];
 
 	insn_aux->is_iter_next = is_iter_next_kfunc(&meta);
+	insn_aux->is_can_loop = is_can_loop_kfunc(&meta);
 
 	if (is_kfunc_destructive(&meta) && !capable(CAP_SYS_BOOT)) {
 		verbose(env, "destructive kfunc calls require CAP_SYS_BOOT capability\n");
@@ -12424,8 +12460,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			mark_btf_func_reg_size(env, regno, t->size);
 	}
 
-	if (is_iter_next_kfunc(&meta)) {
-		err = process_iter_next_call(env, insn_idx, &meta);
+	if (is_iter_next_kfunc(&meta) || is_can_loop_kfunc(&meta)) {
+		err = process_iter_next_call(env, insn_idx);
 		if (err)
 			return err;
 	}
@@ -15609,7 +15645,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			struct bpf_kfunc_call_arg_meta meta;
 
 			ret = fetch_kfunc_meta(env, insn, &meta, NULL);
-			if (ret == 0 && is_iter_next_kfunc(&meta)) {
+			if (ret == 0 && (is_iter_next_kfunc(&meta) || is_can_loop_kfunc(&meta))) {
 				mark_prune_point(env, t);
 				/* Checking and saving state checkpoints at iter_next() call
 				 * is crucial for fast convergence of open-coded iterator loop
@@ -16759,6 +16795,9 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->active_rcu_lock != cur->active_rcu_lock)
 		return false;
 
+	if (old->can_loop_reg.iter.state != cur->can_loop_reg.iter.state)
+		return false;
+
 	/* for states to be equal callsites have to be the same
 	 * and all frame states need to be equivalent
 	 */
@@ -16997,6 +17036,9 @@ static bool iter_active_depths_differ(struct bpf_verifier_state *old, struct bpf
 	struct bpf_func_state *state;
 	int i, fr;
 
+	if (old->can_loop_reg.iter.depth != cur->can_loop_reg.iter.depth)
+		return true;
+
 	for (fr = old->curframe; fr >= 0; fr--) {
 		state = old->frame[fr];
 		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
@@ -17101,23 +17143,11 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * comparison would discard current state with r7=-32
 			 * => unsafe memory access at 11 would not be caught.
 			 */
-			if (is_iter_next_insn(env, insn_idx)) {
+			if (is_iter_next_insn(env, insn_idx) || is_can_loop_insn(env, insn_idx)) {
 				if (states_equal(env, &sl->state, cur, true)) {
-					struct bpf_func_state *cur_frame;
-					struct bpf_reg_state *iter_state, *iter_reg;
-					int spi;
+					struct bpf_reg_state *iter_state;
 
-					cur_frame = cur->frame[cur->curframe];
-					/* btf_check_iter_kfuncs() enforces that
-					 * iter state pointer is always the first arg
-					 */
-					iter_reg = &cur_frame->regs[BPF_REG_1];
-					/* current state is valid due to states_equal(),
-					 * so we can assume valid iter and reg state,
-					 * no need for extra (re-)validations
-					 */
-					spi = __get_spi(iter_reg->off + iter_reg->var_off.value);
-					iter_state = &func(env, iter_reg)->stack[spi].spilled_ptr;
+					iter_state = get_iter_reg(env, cur, insn_idx);
 					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE) {
 						update_loop_entry(cur, &sl->state);
 						goto hit;
@@ -19258,7 +19288,8 @@ static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
 }
 
 static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
-			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
+			    struct bpf_insn *insn_buf, int insn_idx, int stack_base,
+			    int *cnt, int *stack_extra)
 {
 	const struct bpf_kfunc_desc *desc;
 
@@ -19349,6 +19380,12 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_can_loop]) {
+		insn_buf[0] = BPF_MOV64_REG(BPF_REG_1, BPF_REG_FP);
+		insn_buf[1] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, stack_base - 8);
+		insn_buf[2] = *insn;
+		*cnt = 3;
+		*stack_extra = 8;
 	}
 	return 0;
 }
@@ -19396,7 +19433,10 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 	struct bpf_insn insn_buf[16];
 	struct bpf_prog *new_prog;
 	struct bpf_map *map_ptr;
-	int i, ret, cnt, delta = 0;
+	int i, ret, cnt, delta = 0, cur_subprog = 0;
+	struct bpf_subprog_info *subprogs = env->subprog_info;
+	u16 stack_depth = subprogs[cur_subprog].stack_depth;
+	u16 stack_depth_extra = 0;
 
 	if (env->seen_exception && !env->exception_callback_subprog) {
 		struct bpf_insn patch[] = {
@@ -19416,7 +19456,16 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		mark_subprog_exc_cb(env, env->exception_callback_subprog);
 	}
 
-	for (i = 0; i < insn_cnt; i++, insn++) {
+	for (i = 0; i < insn_cnt;
+	     ({
+		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
+			subprogs[cur_subprog].stack_depth += stack_depth_extra;
+			subprogs[cur_subprog].stack_extra = stack_depth_extra;
+			cur_subprog++;
+			stack_depth = subprogs[cur_subprog].stack_depth;
+			stack_depth_extra = 0;
+		}
+	      }), i++, insn++) {
 		/* Make divide-by-zero exceptions impossible. */
 		if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
 		    insn->code == (BPF_ALU64 | BPF_DIV | BPF_X) ||
@@ -19536,11 +19585,18 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (insn->src_reg == BPF_PSEUDO_CALL)
 			continue;
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
-			ret = fixup_kfunc_call(env, insn, insn_buf, i + delta, &cnt);
+			int stack_extra = 0;
+
+			ret = fixup_kfunc_call(env, insn, insn_buf, i + delta,
+					       -stack_depth, &cnt, &stack_extra);
 			if (ret)
 				return ret;
 			if (cnt == 0)
 				continue;
+			if (stack_extra & (BPF_REG_SIZE - 1)) {
+				verbose(env, "verifier bug: kfunc stack extra must be power of 8\n");
+				return -EFAULT;
+			}
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
@@ -19549,6 +19605,17 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta	 += cnt - 1;
 			env->prog = prog = new_prog;
 			insn	  = new_prog->insnsi + i + delta;
+			if (stack_extra) {
+				/* multiple calls to bpf_can_loop() from one subprog
+				 * share the same stack slot.
+				 * Only bpf_can_loop kfunc can request extra stack for now.
+				 */
+				if (stack_depth_extra && stack_depth_extra != stack_extra) {
+					verbose(env, "verifier bug: stack_extra\n");
+					return -EFAULT;
+				}
+				stack_depth_extra = stack_extra;
+			}
 			continue;
 		}
 
@@ -19942,6 +20009,30 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		insn->imm = fn->func - __bpf_call_base;
 	}
 
+	env->prog->aux->stack_depth = subprogs[0].stack_depth;
+	for (i = 0; i < env->subprog_cnt; i++) {
+		int subprog_start = subprogs[i].start, j;
+		int stack_slots = subprogs[i].stack_extra / 8;
+
+		if (stack_slots >= ARRAY_SIZE(insn_buf)) {
+			verbose(env, "verifier bug: stack_extra is too large\n");
+			return -EFAULT;
+		}
+
+		/* Add insns to subprog prologue to zero init extra stack */
+		for (j = 0; j < stack_slots; j++)
+			insn_buf[j] = BPF_ST_MEM(BPF_DW, BPF_REG_FP,
+						 -subprogs[i].stack_depth + j * 8, 0);
+		if (j) {
+			insn_buf[j] = env->prog->insnsi[subprog_start];
+
+			new_prog = bpf_patch_insn_data(env, subprog_start, insn_buf, j + 1);
+			if (!new_prog)
+				return -ENOMEM;
+			env->prog = prog = new_prog;
+		}
+	}
+
 	/* Since poke tab is now finalized, publish aux to tracker. */
 	for (i = 0; i < prog->aux->size_poke_tab; i++) {
 		map_ptr = prog->aux->poke_tab[i].tail_call.map;
@@ -20130,6 +20221,21 @@ static void free_states(struct bpf_verifier_env *env)
 	}
 }
 
+static void init_can_loop_reg(struct bpf_reg_state *st)
+{
+	__mark_reg_known_zero(st);
+	st->type = PTR_TO_STACK;
+	st->live |= REG_LIVE_WRITTEN;
+	st->ref_obj_id = 0;
+	st->iter.btf = NULL;
+	st->iter.btf_id = 0;
+	/* Init register state to sane values.
+	 * Only iter.state and iter.depth are used during verification.
+	 */
+	st->iter.state = BPF_ITER_STATE_ACTIVE;
+	st->iter.depth = 0;
+}
+
 static int do_check_common(struct bpf_verifier_env *env, int subprog)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
@@ -20147,6 +20253,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	state->curframe = 0;
 	state->speculative = false;
 	state->branches = 1;
+	init_can_loop_reg(&state->can_loop_reg);
 	state->frame[0] = kzalloc(sizeof(struct bpf_func_state), GFP_KERNEL);
 	if (!state->frame[0]) {
 		kfree(state);
-- 
2.34.1


