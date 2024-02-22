Return-Path: <bpf+bounces-22484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD0F85F184
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 07:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08FF283B9D
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 06:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57ECDC8E2;
	Thu, 22 Feb 2024 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gehUlPJW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A9AA3F
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 06:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708583611; cv=none; b=b7shx9YxG1O4Ny1POxcu/M6cg+NpYsdxUdcaPCqzb/dOhlf5pSOuXDNNXgQWAhCcRrBvcH62s2zHuW4mNkNlqfbn8aW75NEt4NvCY6eVVAKwHLKuOGRCbI3NUzsBySvM7OKN0ItZnjOQW1wWREURF6Qdq96OyHMkt0wGpgkzBd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708583611; c=relaxed/simple;
	bh=GK1Qevp9bAQ1QfDDHDKhImK9I//g4re9QBNblWOBlNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UakJ53wJe8sHk5qweKttPe8Ghqo8FsuqwNO7C+vsuuUqz+7+NbdVMlmA/B0/vvh+YGAMNuzrlaaxtZiSotEhX2BV1LRRX4uVIOxQ+8f6CPIRQ6t1AkcZBn5QKmuhLAklA4mRFyuj0cBOihPLVVV7UVIFKu69yxABYR+ZmHOdrq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gehUlPJW; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so5154808b6e.3
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 22:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708583608; x=1709188408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a2gZuYRtiTotepc7PFTXdr1qOCfIMT5KjPGc40lYHjA=;
        b=gehUlPJWzNsbfL8TlZviM7zEblkMPqtCk6FG6IsUaKDlCNheY6DRqHhUmDbmE0YsOc
         5UtaJT6N/3IaqiX2BRrnfhYlgW/x+0BeK9/dXpR069FPHnKKqr+Wifx/XexGYFJft/Je
         +Znq6oTOLbNz0uYgKivkvp9GxeP/Q8V2/5zjc9bvjul3FtH6uQvVWbs9z9u25vT9/qGF
         jLZS4Khp8GG0iTcybF/J2Rgk+VJFGRebzX2XCcIWX2KoN691bs67w0wnDKUpbxn1AakT
         qiDxNqRgSxxWZvpSq3qWN+Couw7s9FR4EicDWr7JRdJH/KZJqs81rt5TjEZVhc/0pbHe
         VPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708583608; x=1709188408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2gZuYRtiTotepc7PFTXdr1qOCfIMT5KjPGc40lYHjA=;
        b=WbuJqGQb0HVuF5TYa8I/fYYIG7JWy8ksA0u7tQUUYuDlPwH5MRJ5dA2rV+3qkgmnOm
         /3cTtYOo7ZeT9zvbU8ythlAEDzNPWU1yktrHnPPhyTTaRrw32Aw8//4wPZEHjfXGipSY
         eqK8EmBPcRqt1Fpx+0iJosP1FDQY6xVE9RJXEnFsUVN93ckPa0H4lL8tYHjte0HIJflm
         Zf+aRJg+JNHuws3Yl9wv0eDsyw2Za9ZBBzzjMI7jOkALhOQ5JOlhAmfIDQuG1VQhDv8G
         ZKaqIlw0ZgdCBUpoHCHuYei/JSJuWZlqnK87aH9C4dQeV3F0qLEHP/PVmdNXxdM/J+Oe
         1BjQ==
X-Gm-Message-State: AOJu0YzEV07dJkKHerfQYz0YgqcBekblUojRMfJaJsD7zyEeMlDScLMF
	zKMuLigpCJkHe8aFtg2NX8F5ZZGZpHjueyX/COuLjjtk6XB7jSvfQT98TTjb
X-Google-Smtp-Source: AGHT+IH9cdODG3M6M+PesJnNFmZHMLLqJL6idKsujP6FhqfP2sa6+0qK/oXxzKfzbt2EcVEAmmakrw==
X-Received: by 2002:a05:6808:1995:b0:3c1:7bc1:5b4d with SMTP id bj21-20020a056808199500b003c17bc15b4dmr648247oib.26.1708583608240;
        Wed, 21 Feb 2024 22:33:28 -0800 (PST)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:b11c])
        by smtp.gmail.com with ESMTPSA id a6-20020aa780c6000000b006e134c4d6b0sm10066160pfn.217.2024.02.21.22.33.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Feb 2024 22:33:27 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf-next 1/2] bpf: Introduce bpf_can_loop() kfunc
Date: Wed, 21 Feb 2024 22:33:23 -0800
Message-Id: <20240222063324.46468-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
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
        for (struct bpf_iter_num ___it __attribute__((aligned(8),                       \
                                                      cleanup(bpf_iter_num_destroy))),  \
                        * ___tmp = (                                                    \
                                bpf_iter_num_new(&___it, 0, (1000000)),                 \
                                pos = list_entry_safe((head)->first,                    \
                                                      typeof(*(pos)), member),          \
                                (void)bpf_iter_num_destroy, (void *)0);                 \
             bpf_iter_num_next(&___it) && pos &&                                        \
                ({ ___tmp = (void *)pos->member.next; 1; });                            \
             pos = list_entry_safe((void __arena *)___tmp, typeof(*(pos)), member))

It's similar to bpf_for(), bpf_repeat() macros.
Unfortunately every "for" in normal C code needs an equivalent monster macro.

Instead, let's introduce bpf_can_loop() kfunc that acts on a hidden bpf_iter_num,
so that bpf_iter_num_new(), bpf_iter_num_destroy() don't need to be called explicitly.
It simplifies the macro to:
        for (void * ___tmp = (pos = list_entry_safe((head)->first,                    \
                                                    typeof(*(pos)), member),          \
                                (void *)0);                                           \
             bpf_can_loop(0) && pos &&                                                \
                ({ ___tmp = (void *)pos->member.next; 1; });                          \
             pos = list_entry_safe((void __arena *)___tmp, typeof(*(pos)), member))

and can be used in any normal "for" or "while" loop, like

  for (i = 0; i < cnt && bpf_can_loop(0); i++) {

The verifier recognizes that bpf_can_loop() is used in the program,
reserves additional 8 bytes of stack, zero initializes them in subprog prologue,
and passes that address to bpf_can_loop() kfunc that simply increments
the counter until it reaches BPF_MAX_LOOPS.

In the future bpf_can_loop() can be inlined to improve performance.
New instruction with the same semantics can be added, so that LLVM can generate it.

WARNING:
bpf_can_loop() is not a substitute for bpf_for() when it's used to
iterate normal arrays or map_values.
bpf_can_loop() works well only with arena pointers that don't need
to be bounds-checked on every iteration.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   3 +
 kernel/bpf/helpers.c         |  12 +++
 kernel/bpf/verifier.c        | 141 ++++++++++++++++++++++++++++++-----
 3 files changed, 136 insertions(+), 20 deletions(-)

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
index 011d54a1dc53..89667734abf5 100644
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
 
@@ -7954,10 +7956,14 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 	struct bpf_reg_state *cur_iter, *queued_iter;
 	int iter_frameno = meta->iter.frameno;
 	int iter_spi = meta->iter.spi;
+	bool is_can_loop = is_can_loop_kfunc(meta);
 
 	BTF_TYPE_EMIT(struct bpf_iter);
 
-	cur_iter = &env->cur_state->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
+	if (is_can_loop)
+		cur_iter = &cur_st->can_loop_reg;
+	else
+		cur_iter = &cur_st->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
 
 	if (cur_iter->iter.state != BPF_ITER_STATE_ACTIVE &&
 	    cur_iter->iter.state != BPF_ITER_STATE_DRAINED) {
@@ -7985,7 +7991,10 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 		if (!queued_st)
 			return -ENOMEM;
 
-		queued_iter = &queued_st->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
+		if (is_can_loop)
+			queued_iter = &queued_st->can_loop_reg;
+		else
+			queued_iter = &queued_st->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
 		queued_iter->iter.state = BPF_ITER_STATE_ACTIVE;
 		queued_iter->iter.depth++;
 		if (prev_st)
@@ -10925,6 +10934,7 @@ enum special_kfunc_type {
 	KF_bpf_percpu_obj_new_impl,
 	KF_bpf_percpu_obj_drop_impl,
 	KF_bpf_throw,
+	KF_bpf_can_loop,
 	KF_bpf_iter_css_task_new,
 };
 
@@ -10949,6 +10959,7 @@ BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
 BTF_ID(func, bpf_throw)
+BTF_ID(func, bpf_can_loop)
 #ifdef CONFIG_CGROUPS
 BTF_ID(func, bpf_iter_css_task_new)
 #endif
@@ -10977,6 +10988,7 @@ BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
 BTF_ID(func, bpf_throw)
+BTF_ID(func, bpf_can_loop)
 #ifdef CONFIG_CGROUPS
 BTF_ID(func, bpf_iter_css_task_new)
 #else
@@ -11003,6 +11015,11 @@ static bool is_kfunc_bpf_rcu_read_unlock(struct bpf_kfunc_call_arg_meta *meta)
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
@@ -12049,6 +12066,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	insn_aux = &env->insn_aux_data[insn_idx];
 
 	insn_aux->is_iter_next = is_iter_next_kfunc(&meta);
+	insn_aux->is_can_loop = is_can_loop_kfunc(&meta);
 
 	if (is_kfunc_destructive(&meta) && !capable(CAP_SYS_BOOT)) {
 		verbose(env, "destructive kfunc calls require CAP_SYS_BOOT capability\n");
@@ -12424,7 +12442,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			mark_btf_func_reg_size(env, regno, t->size);
 	}
 
-	if (is_iter_next_kfunc(&meta)) {
+	if (is_iter_next_kfunc(&meta) || is_can_loop_kfunc(&meta)) {
 		err = process_iter_next_call(env, insn_idx, &meta);
 		if (err)
 			return err;
@@ -15609,7 +15627,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			struct bpf_kfunc_call_arg_meta meta;
 
 			ret = fetch_kfunc_meta(env, insn, &meta, NULL);
-			if (ret == 0 && is_iter_next_kfunc(&meta)) {
+			if (ret == 0 && (is_iter_next_kfunc(&meta) || is_can_loop_kfunc(&meta))) {
 				mark_prune_point(env, t);
 				/* Checking and saving state checkpoints at iter_next() call
 				 * is crucial for fast convergence of open-coded iterator loop
@@ -16759,6 +16777,9 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->active_rcu_lock != cur->active_rcu_lock)
 		return false;
 
+	if (old->can_loop_reg.iter.state != cur->can_loop_reg.iter.state)
+		return false;
+
 	/* for states to be equal callsites have to be the same
 	 * and all frame states need to be equivalent
 	 */
@@ -16933,6 +16954,11 @@ static bool is_iter_next_insn(struct bpf_verifier_env *env, int insn_idx)
 	return env->insn_aux_data[insn_idx].is_iter_next;
 }
 
+static bool is_can_loop_insn(struct bpf_verifier_env *env, int insn_idx)
+{
+	return env->insn_aux_data[insn_idx].is_can_loop;
+}
+
 /* is_state_visited() handles iter_next() (see process_iter_next_call() for
  * terminology) calls specially: as opposed to bounded BPF loops, it *expects*
  * states to match, which otherwise would look like an infinite loop. So while
@@ -16997,6 +17023,9 @@ static bool iter_active_depths_differ(struct bpf_verifier_state *old, struct bpf
 	struct bpf_func_state *state;
 	int i, fr;
 
+	if (old->can_loop_reg.iter.depth != cur->can_loop_reg.iter.depth)
+		return true;
+
 	for (fr = old->curframe; fr >= 0; fr--) {
 		state = old->frame[fr];
 		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
@@ -17101,23 +17130,27 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * comparison would discard current state with r7=-32
 			 * => unsafe memory access at 11 would not be caught.
 			 */
-			if (is_iter_next_insn(env, insn_idx)) {
+			if (is_iter_next_insn(env, insn_idx) || is_can_loop_insn(env, insn_idx)) {
 				if (states_equal(env, &sl->state, cur, true)) {
 					struct bpf_func_state *cur_frame;
 					struct bpf_reg_state *iter_state, *iter_reg;
 					int spi;
 
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
+					if (is_can_loop_insn(env, insn_idx)) {
+						iter_state = &cur->can_loop_reg;
+					} else {
+						cur_frame = cur->frame[cur->curframe];
+						/* btf_check_iter_kfuncs() enforces that
+						 * iter state pointer is always the first arg
+						 */
+						iter_reg = &cur_frame->regs[BPF_REG_1];
+						/* current state is valid due to states_equal(),
+						 * so we can assume valid iter and reg state,
+						 * no need for extra (re-)validations
+						 */
+						spi = __get_spi(iter_reg->off + iter_reg->var_off.value);
+						iter_state = &func(env, iter_reg)->stack[spi].spilled_ptr;
+					}
 					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE) {
 						update_loop_entry(cur, &sl->state);
 						goto hit;
@@ -19258,7 +19291,8 @@ static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
 }
 
 static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
-			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
+			    struct bpf_insn *insn_buf, int insn_idx, int stack_base,
+			    int *cnt, int *stack_extra)
 {
 	const struct bpf_kfunc_desc *desc;
 
@@ -19349,6 +19383,12 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -19396,7 +19436,10 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
@@ -19416,7 +19459,16 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		mark_subprog_exc_cb(env, env->exception_callback_subprog);
 	}
 
-	for (i = 0; i < insn_cnt; i++, insn++) {
+	for (i = 0; i < insn_cnt;
+	     ({
+		if (stack_depth_extra && subprogs[cur_subprog + 1].start == i + delta + 1) {
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
@@ -19536,11 +19588,18 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
@@ -19549,6 +19608,8 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta	 += cnt - 1;
 			env->prog = prog = new_prog;
 			insn	  = new_prog->insnsi + i + delta;
+			if (stack_extra)
+				stack_depth_extra = max(stack_depth_extra, stack_extra);
 			continue;
 		}
 
@@ -19942,6 +20003,30 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
@@ -20130,6 +20215,21 @@ static void free_states(struct bpf_verifier_env *env)
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
@@ -20147,6 +20247,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	state->curframe = 0;
 	state->speculative = false;
 	state->branches = 1;
+	init_can_loop_reg(&state->can_loop_reg);
 	state->frame[0] = kzalloc(sizeof(struct bpf_func_state), GFP_KERNEL);
 	if (!state->frame[0]) {
 		kfree(state);
-- 
2.34.1


