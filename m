Return-Path: <bpf+bounces-73840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AB3C3B0DB
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 14:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 268504FE4DE
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFC3337BA7;
	Thu,  6 Nov 2025 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1Z0gvPY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED243358C4
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433623; cv=none; b=fVCB6M1Eo6jyZJF2dGjf3+oiaPqy2XpovyLAUwfCfH3E4RGrI8Odc0LMYrWmwHbafLCQGASOBZ7+OhCCtvwd0+zXmZaiSwv6t77H6M34zezOlsaAqLr0rA88lsWvZ3WZYnMzTE5fQuMTo4k4KtGdgj2oyMDx8LrD6fcEpqh/VTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433623; c=relaxed/simple;
	bh=Md++fu49nP/8mT6hALlYH/LhcbC4sBZZpRrZuND42z0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hdvms3iMzOWpyby27ALx5ujodeVURozVNxHu8tMwgJbH5PP61DQavq2vb1v/DznJdzAh7PLA7ohcxeGtyDxf+DSH+p8ChP99SUZ63CidlJ0UK1vVCCrIPTbfvv2HTA1QIu0K65sQb2NIPOlr1BQ7RAp8Uhu6KZWETuyM5xDUoVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1Z0gvPY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42557c5cedcso528478f8f.0
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 04:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762433619; x=1763038419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nHltJPQHHc4nhzlx7aFR/dmXb3N8HOdaeVX4vRP+Gs=;
        b=E1Z0gvPYUQge1V0DE7GFevt2ny3kcaS4Ti308ebuqTi+G9Or9qzfwOG+BBMCGOP3F8
         cZ9IoXpgoj6SEER8Bu5y3hJoezuxFH3xk5jgL7dy82E/eEdQ2yCT3vfPZAjJ2ytsl10q
         pzTnahbpcYMtkmk8rioE7JX/yElZg9XFIkWmGV2ewJDfio/Zmc0ahvAGFSmgXAEneDoj
         5IIAllv+Vj/Rl/ZbKVV2mYZGgpJHzDeKmwnVwFT5zFZC6lXzekJur7xbVSWE9CIHG9U+
         Ur7bXRyDkHzl8dhJ2YZR0YGmTNQjx11J4y+75y/3raLJKTk6f4mD7mFj8xwGUir7NUS+
         bB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433619; x=1763038419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nHltJPQHHc4nhzlx7aFR/dmXb3N8HOdaeVX4vRP+Gs=;
        b=dFknjDCsWWxRNMk9KuCYEk4b2Qv7JRRmzu3xNW6dQVkiqEJ7d/DqFACKpA4wrvDntX
         SpksvPVlq4benTOkrjbt5BwmNe76YdjpFAsVBgZNvUS5Kaar8pZ78CATTU7IfO5A0Utp
         FHxaffmS56GIM87CVRll+cxAg0depm5O24D7TcycFaFkwU26VI1jKq2u50eU6bX8unb2
         4HvLQsvMywr88HYLOJFzH4gqSxBh/FsRAukiu4UsUl4bou+eoPXpskMZfzLvdS6p5nCi
         ZB+wfUrDON2+Affd3mYBpxakDQ7wBF0FEkhfVRui6Xh8cY4CpiehPHN1Nf+q2RgNZzsP
         Ow9A==
X-Gm-Message-State: AOJu0YyN9uT/kPviXtSvCXq56uDHq/qWJ80tcVj8NWZ36FDLWOuPCWpt
	1sKuS+KEjpXRhLY1ZDvvpvcM73KoHFNTKiGpkLl1xQm18mtITQTygDJl0aGN
X-Gm-Gg: ASbGncs4n0dxrgQCF8kPybuIG2SQrCp9D1Xc5+UJEwN8qILR4o+yhC1rMRagc4NE2bS
	g+0qotE3oIfSWszYV3EDnWeFwtQOW22k5RBFf95TLuvTYUzlbkw9QsGxntZvFDQkvNe7hqySIm2
	XsMQSAHPmq9/AyYB8udmxui93VmN/6yExeGmTBVrZV+9Iz0FE0WZ2qqbLyx/RSYMvxdYLUe643d
	YujJjry1EqLhr5avP1GQNIl48LByyTViLRnQPN1CR9J6HLe75YSg4CtO8szomaQ4wVUBKbMdxLY
	WLMgpeWuriEKjoFNjoGiXCKcAqBlszZnRguky/HAmNYWVFJduRPBekzOR72p5g5gRaV7+78T/S3
	viFHVC3ZocMlQ0j/yaOIIJrAEhjKvbOS+pHfB21puZLDFpRwuGCdP5dZ116qjbbOr6ItSYJDyre
	PGASIxYQe0paUilcVIecSBR4XctwWpCfVXkXh7+cyJSA4vYM3NCZlvxoo=
X-Google-Smtp-Source: AGHT+IFeg37HwbkpqMpKiz0OXhY232Pqm49gtMvdmTd/OAarHIH1KXPvOm+PnlvXfXxurhk4CsA8fA==
X-Received: by 2002:a05:6000:3111:b0:429:c450:8fad with SMTP id ffacd0b85a97d-429e3311ab5mr6260946f8f.53.1762433618708;
        Thu, 06 Nov 2025 04:53:38 -0800 (PST)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4788856f8f.9.2025.11.06.04.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:53:38 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
X-Google-Original-From: Hao Sun <hao.sun@inf.ethz.ch>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	linux-kernel@vger.kernel.org,
	sunhao.th@gmail.com,
	Hao Sun <hao.sun@inf.ethz.ch>
Subject: [PATCH RFC 05/17] bpf: Add top-level workflow of bcf_track()
Date: Thu,  6 Nov 2025 13:52:43 +0100
Message-Id: <20251106125255.1969938-6-hao.sun@inf.ethz.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
References: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the top-level `bcf_track()` that symbolically tracks the path suffix
identified by `backtrack_states()` and records per-register expressions and
path conditions.

- Extend `struct bpf_reg_state` with `bcf_expr` index. Extend
  `env->bcf` with tracking state: expression arena (exprs/expr_cnt/expr_size),
  branch condition list (br_conds/br_cond_cnt), and final `path_cond` and
  `refine_cond` index.

- Disable liveness/precision/pruning side effects during tracking to ensure
  single-state, suffix-only analysis (short-circuit early in liveness helpers,
  jump history/push, speculative sanitization, visited-state pruning).

- Implement an env save/restore (`env_backup` + `swap_env_states`) so the
  tracker can reuse verifier execution without polluting global state. 

- After tracking, copy collected `bcf_expr` bindings from the tracked state
  into the original state’s regs. The path condition is built later,

Follow-ups add instruction-specific tracking, path matching and condition
construction into this framework.

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
---
 include/linux/bpf_verifier.h |   9 +++
 kernel/bpf/liveness.c        |  15 ++++
 kernel/bpf/verifier.c        | 135 +++++++++++++++++++++++++++++++++--
 3 files changed, 154 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 090430168523..b430702784e2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -204,6 +204,7 @@ struct bpf_reg_state {
 	s32 subreg_def;
 	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
 	bool precise;
+	int bcf_expr;
 };
 
 enum bpf_stack_slot_type {
@@ -742,6 +743,14 @@ struct bcf_refine_state {
 	u32 cur_jmp_entry;
 
 	bool available; /* if bcf_buf is provided. */
+	bool tracking; /* In bcf_track(). */
+	struct bcf_expr *exprs;
+	u32 expr_size;
+	u32 expr_cnt;
+	u32 *br_conds; /* each branch condition */
+	u32 br_cond_cnt;
+	int path_cond; /* conjunction of br_conds */
+	int refine_cond; /* refinement condition */
 };
 
 /* single container for all structs
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index bffb495bc933..4e44c3f0404c 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -276,6 +276,8 @@ static struct per_frame_masks *alloc_frame_masks(struct bpf_verifier_env *env,
 
 void bpf_reset_live_stack_callchain(struct bpf_verifier_env *env)
 {
+	if (env->bcf.tracking)
+		return;
 	env->liveness->cur_instance = NULL;
 }
 
@@ -318,6 +320,9 @@ int bpf_mark_stack_read(struct bpf_verifier_env *env, u32 frame, u32 insn_idx, u
 {
 	int err;
 
+	if (env->bcf.tracking)
+		return 0;
+
 	err = ensure_cur_instance(env);
 	err = err ?: mark_stack_read(env, env->liveness->cur_instance, frame, insn_idx, mask);
 	return err;
@@ -339,6 +344,9 @@ int bpf_reset_stack_write_marks(struct bpf_verifier_env *env, u32 insn_idx)
 	struct bpf_liveness *liveness = env->liveness;
 	int err;
 
+	if (env->bcf.tracking)
+		return 0;
+
 	err = ensure_cur_instance(env);
 	if (err)
 		return err;
@@ -349,6 +357,8 @@ int bpf_reset_stack_write_marks(struct bpf_verifier_env *env, u32 insn_idx)
 
 void bpf_mark_stack_write(struct bpf_verifier_env *env, u32 frame, u64 mask)
 {
+	if (env->bcf.tracking)
+		return;
 	env->liveness->write_masks_acc[frame] |= mask;
 }
 
@@ -398,6 +408,8 @@ static int commit_stack_write_marks(struct bpf_verifier_env *env,
  */
 int bpf_commit_stack_write_marks(struct bpf_verifier_env *env)
 {
+	if (env->bcf.tracking)
+		return 0;
 	return commit_stack_write_marks(env, env->liveness->cur_instance);
 }
 
@@ -675,6 +687,9 @@ int bpf_update_live_stack(struct bpf_verifier_env *env)
 	struct func_instance *instance;
 	int err, frame;
 
+	if (env->bcf.tracking)
+		return 0;
+
 	bpf_reset_live_stack_callchain(env);
 	for (frame = env->cur_state->curframe; frame >= 0; --frame) {
 		instance = lookup_instance(env, env->cur_state, frame);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7125f7434e6f..725ea503c1c7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3924,6 +3924,9 @@ static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_st
 	struct bpf_jmp_history_entry *p;
 	size_t alloc_size;
 
+	if (env->bcf.tracking)
+		return 0;
+
 	/* combine instruction flags if we already recorded this instruction */
 	if (env->cur_hist_ent) {
 		/* atomic instructions push insn_flags twice, for READ and
@@ -4735,7 +4738,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg;
 	int i, fr, err;
 
-	if (!env->bpf_capable)
+	if (!env->bpf_capable || env->bcf.tracking)
 		return 0;
 
 	changed = changed ?: &tmp;
@@ -8878,6 +8881,9 @@ static struct bpf_verifier_state *find_prev_entry(struct bpf_verifier_env *env,
 	struct bpf_verifier_state *st;
 	struct list_head *pos, *head;
 
+	if (env->bcf.tracking)
+		return NULL;
+
 	/* Explored states are pushed in stack order, most recent states come first */
 	head = explored_state(env, insn_idx);
 	list_for_each(pos, head) {
@@ -14302,7 +14308,8 @@ static bool can_skip_alu_sanitation(const struct bpf_verifier_env *env,
 {
 	return env->bypass_spec_v1 ||
 		BPF_SRC(insn->code) == BPF_K ||
-		cur_aux(env)->nospec;
+		cur_aux(env)->nospec ||
+		env->bcf.tracking;
 }
 
 static int update_alu_sanitation_state(struct bpf_insn_aux_data *aux,
@@ -14350,6 +14357,9 @@ static int sanitize_speculative_path(struct bpf_verifier_env *env,
 	struct bpf_verifier_state *branch;
 	struct bpf_reg_state *regs;
 
+	if (env->bcf.tracking)
+		return 0;
+
 	branch = push_stack(env, next_idx, curr_idx, true);
 	if (!IS_ERR(branch) && insn) {
 		regs = branch->frame[branch->curframe]->regs;
@@ -19415,6 +19425,9 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	int n, err, states_cnt = 0;
 	struct list_head *pos, *tmp, *head;
 
+	if (env->bcf.tracking)
+		return 0;
+
 	force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx) ||
 			  /* Avoid accumulating infinitely long jmp history */
 			  cur->jmp_history_cnt > 40;
@@ -20076,7 +20089,7 @@ static int do_check(struct bpf_verifier_env *env)
 	struct bpf_insn *insns = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
 	bool do_print_state = false;
-	int prev_insn_idx = -1;
+	int prev_insn_idx = env->prev_insn_idx;
 
 	for (;;) {
 		struct bpf_insn *insn;
@@ -20178,6 +20191,14 @@ static int do_check(struct bpf_verifier_env *env)
 		if (err)
 			return err;
 		err = do_check_insn(env, &do_print_state);
+		/*
+		 * bcf_track() only follows checked insns, errors during it
+		 * indicate a previously refined location; The refinement
+		 * is applied directly (see bcf_refine()), so analyzes the
+		 * insn again with the refined state.
+		 */
+		if (err && env->bcf.tracking)
+			err = do_check_insn(env, &do_print_state);
 		if (err >= 0 || error_recoverable_with_nospec(err)) {
 			marks_err = bpf_commit_stack_write_marks(env);
 			if (marks_err)
@@ -23275,6 +23296,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	struct bpf_reg_state *regs;
 	int ret, i;
 
+	env->prev_insn_idx = -1;
 	env->prev_linfo = NULL;
 	env->pass_cnt++;
 
@@ -23388,6 +23410,10 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	}
 
 	ret = do_check(env);
+
+	/* Invoked by bcf_track(), just return. */
+	if (env->bcf.tracking)
+		return ret;
 out:
 	if (!ret && pop_log)
 		bpf_vlog_reset(&env->log, 0);
@@ -23395,11 +23421,104 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	return ret;
 }
 
+struct env_backup {
+	u32 insn_idx;
+	u32 prev_insn_idx;
+	struct bpf_verifier_stack_elem *head;
+	int stack_size;
+	u32 id_gen;
+	struct bpf_verifier_state *cur_state;
+	const struct bpf_line_info *prev_linfo;
+	struct list_head *explored_states;
+	struct list_head free_list;
+	u32 log_level;
+	u32 prev_insn_processed, insn_processed;
+	u32 prev_jmps_processed, jmps_processed;
+};
+
+static void swap_env_states(struct env_backup *env_old,
+			    struct bpf_verifier_env *env)
+{
+	swap(env_old->insn_idx, env->insn_idx);
+	swap(env_old->prev_insn_idx, env->prev_insn_idx);
+	swap(env_old->head, env->head);
+	swap(env_old->stack_size, env->stack_size);
+	swap(env_old->id_gen, env->id_gen);
+	swap(env_old->cur_state, env->cur_state);
+	swap(env_old->prev_linfo, env->prev_linfo);
+	swap(env_old->explored_states, env->explored_states);
+	swap(env_old->free_list, env->free_list);
+	/* Disable log during bcf tracking */
+	swap(env_old->log_level, env->log.level);
+	swap(env_old->prev_insn_processed, env->prev_insn_processed);
+	swap(env_old->insn_processed, env->insn_processed);
+	swap(env_old->prev_jmps_processed, env->prev_jmps_processed);
+	swap(env_old->jmps_processed, env->jmps_processed);
+}
+
 static int bcf_track(struct bpf_verifier_env *env,
 		     struct bpf_verifier_state *st,
 		     struct bpf_verifier_state *base)
 {
-	return -EOPNOTSUPP;
+	struct bpf_reg_state *regs = st->frame[st->curframe]->regs;
+	struct bpf_reg_state *tracked_regs;
+	struct bpf_verifier_state *vstate = NULL;
+	struct env_backup env_old = { 0 };
+	struct bcf_refine_state *bcf = &env->bcf;
+	int err, i;
+
+	bcf->expr_cnt = 0;
+	bcf->path_cond = -1;
+	bcf->refine_cond = -1;
+
+	if (base) {
+		vstate = kzalloc(sizeof(struct bpf_verifier_state),
+				 GFP_KERNEL_ACCOUNT);
+		if (!vstate)
+			return -ENOMEM;
+		err = copy_verifier_state(vstate, base);
+		if (err) {
+			free_verifier_state(vstate, true);
+			return err;
+		}
+		vstate->parent = vstate->equal_state = NULL;
+		vstate->first_insn_idx = base->insn_idx;
+		clear_jmp_history(vstate);
+	}
+
+	/* Continue with the current id. */
+	env_old.id_gen = env->id_gen;
+	swap_env_states(&env_old, env);
+
+	env->bcf.tracking = true;
+	if (vstate) {
+		env->insn_idx = vstate->first_insn_idx;
+		env->prev_insn_idx = vstate->last_insn_idx;
+		env->cur_state = vstate;
+		err = do_check(env);
+	} else {
+		u32 subprog = st->frame[0]->subprogno;
+
+		env->insn_idx = env->subprog_info[subprog].start;
+		err = do_check_common(env, subprog);
+	}
+	env->bcf.tracking = false;
+
+	if (!err && !same_callsites(env->cur_state, st))
+		err = -EFAULT;
+
+	if (!err) {
+		tracked_regs = cur_regs(env);
+		for (i = 0; i < BPF_REG_FP; i++)
+			regs[i].bcf_expr = tracked_regs[i].bcf_expr;
+	}
+
+	free_verifier_state(env->cur_state, true);
+	env->cur_state = NULL;
+	while (!pop_stack(env, NULL, NULL, false))
+		;
+	swap_env_states(&env_old, env);
+	return err;
 }
 
 /*
@@ -23507,6 +23626,12 @@ static int __used bcf_refine(struct bpf_verifier_env *env,
 	/* BCF requested multiple times in an error path. */
 	if (bcf_requested(env))
 		return -EFAULT;
+	/* BCF requested during bcf_track(), known safe just refine. */
+	if (env->bcf.tracking) {
+		if (refine_cb)
+			return refine_cb(env, st, ctx);
+		return 0;
+	}
 
 	if (!reg_masks) {
 		for (i = 0; i < BPF_REG_FP; i++) {
@@ -23527,7 +23652,7 @@ static int __used bcf_refine(struct bpf_verifier_env *env,
 	if (!err && refine_cb)
 		err = refine_cb(env, st, ctx);
 
-	if (!err)
+	if (!err && (env->bcf.refine_cond >= 0 || env->bcf.path_cond >= 0))
 		mark_bcf_requested(env);
 
 	kfree(env->bcf.parents);
-- 
2.34.1


