Return-Path: <bpf+bounces-15145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CFD7ED939
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 03:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15BD81C208C5
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 02:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B578F40;
	Thu, 16 Nov 2023 02:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPIlQQ5o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C95BA3
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:39 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9c603e235d1so43921766b.3
        for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700101118; x=1700705918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSjGH8JwKI8XBJmFzzgvaKpB4GUvPpx3hrKO2o+qQ4Q=;
        b=OPIlQQ5o7DbxrZdPNy2+Q7Xpo7x1jv/Sj85Fuqx1x1dB0Hrwi+O5nJGrc/5EcUovAm
         sBeOca3nGmLoDWOUbW1S2lLK4B3hQj+y58UFX7aTcz73jI6sywRlrS5fGEyUDX5oUMyp
         XCbW6U2bpdkLUp9eOwDAwkiLg0rIG0G4gyzPPkd+mgNP8sF9Mguh7qapsYslRVc+0MOy
         YTp4I2TuYR8jOGXBF/VEMNIxPmS7GDcYC3lN1kpuwz9T3BbvNMrcqwhklDC1kDXIqt/1
         DNleZ4PkhHGExQiUOR1fCaAxHbKlW0qRnSy/9r34HrtHjFxejfyCBAKazYkOonUyjbqK
         MXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700101118; x=1700705918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSjGH8JwKI8XBJmFzzgvaKpB4GUvPpx3hrKO2o+qQ4Q=;
        b=CHmVCs2yo/D6SRETOLD3Zt9ZjGkyR5nzxlk2Xgj6tFft633NgjICk1QaQYoZt37qb0
         dO5ytfJNQO7iKM+YHAhKD2rJ/qMiHkEvVLuTiwD3BObpEkJlzYJhPw2G92FCrpS+nFsM
         qdiXLNOMSE6R4/f2F0i55DPJpljLghltuFRug6NP+e52ltzPd7ay0lIHhoCUJK/CBD7j
         F6uxbEXltIgIi11D9vCJXnddYGUS6xNFk6GPHbmK1waYifS5HP4v4VfjXtec5P0SSZL8
         B9eu18t5ssldsa+V9xpM6uBBKDdbwT4PYP6p0JZQKKPEI4d0mdm8qFHD/YEgWDsQSZMu
         klew==
X-Gm-Message-State: AOJu0YznS9rmO8WpkNFar6P5h25FRkoUgZeLQNU+MsdYfmzNf9S5AUxZ
	CuqeQu7bjRQ0FAA6p3VUwKLsc2XOj9tYhA==
X-Google-Smtp-Source: AGHT+IFXB+DIZC+hgk+kFf9YJ+Ve+aE3G5JUAEPchT2YVMr+c/+Dm9pcDInx9zoQM8d+DzK6VOfEjw==
X-Received: by 2002:a17:906:5ad4:b0:9df:254d:3e45 with SMTP id x20-20020a1709065ad400b009df254d3e45mr9684630ejs.24.1700101117674;
        Wed, 15 Nov 2023 18:18:37 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ay1-20020a170906d28100b009dd606ce80fsm7774064ejb.31.2023.11.15.18.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 18:18:37 -0800 (PST)
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
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf 06/12] bpf: verify callbacks as if they are called unknown number of times
Date: Thu, 16 Nov 2023 04:17:57 +0200
Message-ID: <20231116021803.9982-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116021803.9982-1-eddyz87@gmail.com>
References: <20231116021803.9982-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prior to this patch callbacks were handled as regular function calls,
execution of callback body was modeled exactly once.
This patch updates callbacks handling logic as follows:
- introduces a function push_callback_call() that schedules callback
  body verification in env->head stack;
- updates prepare_func_exit() to reschedule callback body verification
  upon BPF_EXIT;
- as calls to bpf_*_iter_next(), calls to callback invoking functions
  are marked as checkpoints;
- is_state_visited() is updated to stop callback based iteration when
  some identical parent state is found.

Paths with callback function invoked zero times are now verified first,
which leads to necessity to modify some selftests:
- the following negative tests required adding release/unlock/drop
  calls to avoid previously masked unrelated error reports:
  - cb_refs.c:underflow_prog
  - exceptions_fail.c:reject_rbtree_add_throw
  - exceptions_fail.c:reject_with_cp_reference
- the following precision tracking selftests needed change in expected
  log trace:
  - verifier_subprog_precision.c:callback_result_precise
    (note: r0 precision is no longer propagated inside callback and
           I think this is a correct behavior)
  - verifier_subprog_precision.c:parent_callee_saved_reg_precise_with_callback
  - verifier_subprog_precision.c:parent_stack_slot_precise_with_callback

Reported-by: Andrew Werner <awerner32@gmail.com>
Closes: https://lore.kernel.org/bpf/CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com/
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h                  |   5 +
 kernel/bpf/verifier.c                         | 257 +++++++++++-------
 .../selftests/bpf/prog_tests/cb_refs.c        |   4 +-
 tools/testing/selftests/bpf/progs/cb_refs.c   |   1 +
 .../selftests/bpf/progs/exceptions_fail.c     |   2 +
 .../bpf/progs/verifier_subprog_precision.c    |  22 +-
 6 files changed, 183 insertions(+), 108 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 24213a99cc79..0ffb479c72d8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -400,6 +400,7 @@ struct bpf_verifier_state {
 	struct bpf_idx_pair *jmp_history;
 	u32 jmp_history_cnt;
 	u32 dfs_depth;
+	u32 callback_iter_depth;
 };
 
 #define bpf_get_spilled_reg(slot, frame, mask)				\
@@ -511,6 +512,10 @@ struct bpf_insn_aux_data {
 	 * this instruction, regardless of any heuristics
 	 */
 	bool force_checkpoint;
+	/* true if instruction is a call to a helper function that
+	 * accepts callback function as a parameter.
+	 */
+	bool callback_iter;
 };
 
 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d9513fd58c7c..270f7ca3c44d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -542,13 +542,12 @@ static bool is_dynptr_ref_function(enum bpf_func_id func_id)
 	return func_id == BPF_FUNC_dynptr_data;
 }
 
-static bool is_callback_calling_kfunc(u32 btf_id);
+static bool is_sync_callback_calling_kfunc(u32 btf_id);
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn);
 
-static bool is_callback_calling_function(enum bpf_func_id func_id)
+static bool is_sync_callback_calling_function(enum bpf_func_id func_id)
 {
 	return func_id == BPF_FUNC_for_each_map_elem ||
-	       func_id == BPF_FUNC_timer_set_callback ||
 	       func_id == BPF_FUNC_find_vma ||
 	       func_id == BPF_FUNC_loop ||
 	       func_id == BPF_FUNC_user_ringbuf_drain;
@@ -559,6 +558,18 @@ static bool is_async_callback_calling_function(enum bpf_func_id func_id)
 	return func_id == BPF_FUNC_timer_set_callback;
 }
 
+static bool is_callback_calling_function(enum bpf_func_id func_id)
+{
+	return is_sync_callback_calling_function(func_id) ||
+	       is_async_callback_calling_function(func_id);
+}
+
+static bool is_sync_callback_calling_insn(struct bpf_insn *insn)
+{
+	return (bpf_helper_call(insn) && is_sync_callback_calling_function(insn->imm)) ||
+	       (bpf_pseudo_kfunc_call(insn) && is_sync_callback_calling_kfunc(insn->imm));
+}
+
 static bool is_storage_get_function(enum bpf_func_id func_id)
 {
 	return func_id == BPF_FUNC_sk_storage_get ||
@@ -1803,6 +1814,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->first_insn_idx = src->first_insn_idx;
 	dst_state->last_insn_idx = src->last_insn_idx;
 	dst_state->dfs_depth = src->dfs_depth;
+	dst_state->callback_iter_depth = src->callback_iter_depth;
 	dst_state->used_as_loop_entry = src->used_as_loop_entry;
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
@@ -3855,6 +3867,8 @@ static void fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask)
 	}
 }
 
+static bool is_callback_iter_next(struct bpf_verifier_env *env, int insn_idx);
+
 /* For given verifier state backtrack_insn() is called from the last insn to
  * the first insn. Its purpose is to compute a bitmask of registers and
  * stack slots that needs precision in the parent verifier state.
@@ -4030,10 +4044,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 					return -EFAULT;
 				return 0;
 			}
-		} else if ((bpf_helper_call(insn) &&
-			    is_callback_calling_function(insn->imm) &&
-			    !is_async_callback_calling_function(insn->imm)) ||
-			   (bpf_pseudo_kfunc_call(insn) && is_callback_calling_kfunc(insn->imm))) {
+		} else if (is_sync_callback_calling_insn(insn) && idx != subseq_idx - 1) {
 			/* callback-calling helper or kfunc call, which means
 			 * we are exiting from subprog, but unlike the subprog
 			 * call handling above, we shouldn't propagate
@@ -4074,10 +4085,18 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 		} else if (opcode == BPF_EXIT) {
 			bool r0_precise;
 
+			/* Backtracking to a nested function call, 'idx' is a part of
+			 * the inner frame 'subseq_idx' is a part of the outer frame.
+			 * In case of a regular function call, instructions giving
+			 * precision to registers R1-R5 should have been found already.
+			 * In case of a callback, it is ok to have R1-R5 marked for
+			 * backtracking, as these registers are set by the function
+			 * invoking callback.
+			 */
+			if (subseq_idx >= 0 && is_callback_iter_next(env, subseq_idx))
+				for (i = BPF_REG_1; i <= BPF_REG_5; i++)
+					bt_clear_reg(bt, i);
 			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
-				/* if backtracing was looking for registers R1-R5
-				 * they should have been found already.
-				 */
 				verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
 				WARN_ONCE(1, "verifier backtracking bug");
 				return -EFAULT;
@@ -9596,11 +9615,11 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 	return err;
 }
 
-static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
-			     int *insn_idx, int subprog,
-			     set_callee_state_fn set_callee_state_cb)
+static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			      int insn_idx, int subprog,
+			      set_callee_state_fn set_callee_state_cb)
 {
-	struct bpf_verifier_state *state = env->cur_state;
+	struct bpf_verifier_state *state = env->cur_state, *callback_state;
 	struct bpf_func_state *caller, *callee;
 	int err;
 
@@ -9608,44 +9627,22 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	err = btf_check_subprog_call(env, subprog, caller->regs);
 	if (err == -EFAULT)
 		return err;
-	if (subprog_is_global(env, subprog)) {
-		if (err) {
-			verbose(env, "Caller passes invalid args into func#%d\n",
-				subprog);
-			return err;
-		} else {
-			if (env->log.level & BPF_LOG_LEVEL)
-				verbose(env,
-					"Func#%d is global and valid. Skipping.\n",
-					subprog);
-			clear_caller_saved_regs(env, caller->regs);
-
-			/* All global functions return a 64-bit SCALAR_VALUE */
-			mark_reg_unknown(env, caller->regs, BPF_REG_0);
-			caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
-
-			/* continue with next insn after call */
-			return 0;
-		}
-	}
 
 	/* set_callee_state is used for direct subprog calls, but we are
 	 * interested in validating only BPF helpers that can call subprogs as
 	 * callbacks
 	 */
-	if (set_callee_state_cb != set_callee_state) {
-		env->subprog_info[subprog].is_cb = true;
-		if (bpf_pseudo_kfunc_call(insn) &&
-		    !is_callback_calling_kfunc(insn->imm)) {
-			verbose(env, "verifier bug: kfunc %s#%d not marked as callback-calling\n",
-				func_id_name(insn->imm), insn->imm);
-			return -EFAULT;
-		} else if (!bpf_pseudo_kfunc_call(insn) &&
-			   !is_callback_calling_function(insn->imm)) { /* helper */
-			verbose(env, "verifier bug: helper %s#%d not marked as callback-calling\n",
-				func_id_name(insn->imm), insn->imm);
-			return -EFAULT;
-		}
+	env->subprog_info[subprog].is_cb = true;
+	if (bpf_pseudo_kfunc_call(insn) &&
+	    !is_sync_callback_calling_kfunc(insn->imm)) {
+		verbose(env, "verifier bug: kfunc %s#%d not marked as callback-calling\n",
+			func_id_name(insn->imm), insn->imm);
+		return -EFAULT;
+	} else if (!bpf_pseudo_kfunc_call(insn) &&
+		   !is_callback_calling_function(insn->imm)) { /* helper */
+		verbose(env, "verifier bug: helper %s#%d not marked as callback-calling\n",
+			func_id_name(insn->imm), insn->imm);
+		return -EFAULT;
 	}
 
 	if (insn->code == (BPF_JMP | BPF_CALL) &&
@@ -9656,25 +9653,76 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		/* there is no real recursion here. timer callbacks are async */
 		env->subprog_info[subprog].is_async_cb = true;
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
-					 *insn_idx, subprog);
+					 insn_idx, subprog);
 		if (!async_cb)
 			return -EFAULT;
 		callee = async_cb->frame[0];
 		callee->async_entry_cnt = caller->async_entry_cnt + 1;
 
 		/* Convert bpf_timer_set_callback() args into timer callback args */
-		err = set_callee_state_cb(env, caller, callee, *insn_idx);
+		err = set_callee_state_cb(env, caller, callee, insn_idx);
 		if (err)
 			return err;
 
+		return 0;
+	}
+
+	/* for callback functions enqueue entry to callback and
+	 * proceed with next instruction within current frame.
+	 */
+	callback_state = push_stack(env, env->subprog_info[subprog].start, insn_idx, false);
+	if (!callback_state)
+		return -ENOMEM;
+
+	err = setup_func_entry(env, subprog, insn_idx, set_callee_state_cb,
+			       callback_state);
+	if (err)
+		return err;
+
+	callback_state->callback_iter_depth++;
+	return 0;
+}
+
+static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			   int *insn_idx)
+{
+	struct bpf_verifier_state *state = env->cur_state;
+	struct bpf_func_state *caller;
+	int err, subprog, target_insn;
+
+	target_insn = *insn_idx + insn->imm + 1;
+	subprog = find_subprog(env, target_insn);
+	if (subprog < 0) {
+		verbose(env, "verifier bug. No program starts at insn %d\n", target_insn);
+		return -EFAULT;
+	}
+
+	caller = state->frame[state->curframe];
+	err = btf_check_subprog_call(env, subprog, caller->regs);
+	if (err == -EFAULT)
+		return err;
+	if (subprog_is_global(env, subprog)) {
+		if (err) {
+			verbose(env, "Caller passes invalid args into func#%d\n", subprog);
+			return err;
+		}
+
+		if (env->log.level & BPF_LOG_LEVEL)
+			verbose(env, "Func#%d is global and valid. Skipping.\n", subprog);
 		clear_caller_saved_regs(env, caller->regs);
+
+		/* All global functions return a 64-bit SCALAR_VALUE */
 		mark_reg_unknown(env, caller->regs, BPF_REG_0);
 		caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
+
 		/* continue with next insn after call */
 		return 0;
 	}
 
-	err = setup_func_entry(env, subprog, *insn_idx, set_callee_state_cb, state);
+	/* for regular function entry setup new frame and continue
+	 * from that frame.
+	 */
+	err = setup_func_entry(env, subprog, *insn_idx, set_callee_state, state);
 	if (err)
 		return err;
 
@@ -9734,22 +9782,6 @@ static int set_callee_state(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
-			   int *insn_idx)
-{
-	int subprog, target_insn;
-
-	target_insn = *insn_idx + insn->imm + 1;
-	subprog = find_subprog(env, target_insn);
-	if (subprog < 0) {
-		verbose(env, "verifier bug. No program starts at insn %d\n",
-			target_insn);
-		return -EFAULT;
-	}
-
-	return __check_func_call(env, insn, insn_idx, subprog, set_callee_state);
-}
-
 static int set_map_elem_callback_state(struct bpf_verifier_env *env,
 				       struct bpf_func_state *caller,
 				       struct bpf_func_state *callee,
@@ -9990,7 +10022,15 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 			return err;
 	}
 
-	*insn_idx = callee->callsite + 1;
+	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to callsite,
+	 * there function call logic would reschedule callback visit. If iteration
+	 * converges is_state_visited() would prune that visit eventually.
+	 */
+	if (callee->in_callback_fn && is_callback_iter_next(env, callee->callsite))
+		*insn_idx = callee->callsite;
+	else
+		*insn_idx = callee->callsite + 1;
+
 	if (env->log.level & BPF_LOG_LEVEL) {
 		verbose(env, "returning from callee:\n");
 		print_verifier_state(env, callee, true);
@@ -10403,24 +10443,24 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		}
 		break;
 	case BPF_FUNC_for_each_map_elem:
-		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
-					set_map_elem_callback_state);
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+					 set_map_elem_callback_state);
 		break;
 	case BPF_FUNC_timer_set_callback:
-		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
-					set_timer_callback_state);
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+					 set_timer_callback_state);
 		break;
 	case BPF_FUNC_find_vma:
-		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
-					set_find_vma_callback_state);
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+					 set_find_vma_callback_state);
 		break;
 	case BPF_FUNC_snprintf:
 		err = check_bpf_snprintf_call(env, regs);
 		break;
 	case BPF_FUNC_loop:
 		update_loop_inline_state(env, meta.subprogno);
-		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
-					set_loop_callback_state);
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+					 set_loop_callback_state);
 		break;
 	case BPF_FUNC_dynptr_from_mem:
 		if (regs[BPF_REG_1].type != PTR_TO_MAP_VALUE) {
@@ -10516,8 +10556,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		break;
 	}
 	case BPF_FUNC_user_ringbuf_drain:
-		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
-					set_user_ringbuf_callback_state);
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+					 set_user_ringbuf_callback_state);
 		break;
 	}
 
@@ -11414,7 +11454,7 @@ static bool is_bpf_graph_api_kfunc(u32 btf_id)
 	       btf_id == special_kfunc_list[KF_bpf_refcount_acquire_impl];
 }
 
-static bool is_callback_calling_kfunc(u32 btf_id)
+static bool is_sync_callback_calling_kfunc(u32 btf_id)
 {
 	return btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl];
 }
@@ -12176,6 +12216,21 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EACCES;
 	}
 
+	/* Check the arguments */
+	err = check_kfunc_args(env, &meta, insn_idx);
+	if (err < 0)
+		return err;
+
+	if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+					 set_rbtree_add_callback_state);
+		if (err) {
+			verbose(env, "kfunc %s#%d failed callback verification\n",
+				func_name, meta.func_id);
+			return err;
+		}
+	}
+
 	rcu_lock = is_kfunc_bpf_rcu_read_lock(&meta);
 	rcu_unlock = is_kfunc_bpf_rcu_read_unlock(&meta);
 
@@ -12211,10 +12266,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EINVAL;
 	}
 
-	/* Check the arguments */
-	err = check_kfunc_args(env, &meta, insn_idx);
-	if (err < 0)
-		return err;
 	/* In case of release function, we get register number of refcounted
 	 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
 	 */
@@ -12248,16 +12299,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
-	if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
-		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
-					set_rbtree_add_callback_state);
-		if (err) {
-			verbose(env, "kfunc %s#%d failed callback verification\n",
-				func_name, meta.func_id);
-			return err;
-		}
-	}
-
 	if (meta.func_id == special_kfunc_list[KF_bpf_throw]) {
 		if (!bpf_jit_supports_exceptions()) {
 			verbose(env, "JIT does not support calling kfunc %s#%d\n",
@@ -15504,6 +15545,15 @@ static bool is_force_checkpoint(struct bpf_verifier_env *env, int insn_idx)
 	return env->insn_aux_data[insn_idx].force_checkpoint;
 }
 
+static void mark_callback_iter_next(struct bpf_verifier_env *env, int idx)
+{
+	env->insn_aux_data[idx].callback_iter = true;
+}
+
+static bool is_callback_iter_next(struct bpf_verifier_env *env, int insn_idx)
+{
+	return env->insn_aux_data[insn_idx].callback_iter;
+}
 
 enum {
 	DONE_EXPLORING = 0,
@@ -15620,6 +15670,21 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 * async state will be pushed for further exploration.
 			 */
 			mark_prune_point(env, t);
+		/* For functions that invoke callbacks it is not known how many times
+		 * callback would be called. Verifier models callback calling functions
+		 * by repeatedly visiting callback bodies and returning to origin call
+		 * instruction.
+		 * In order to stop such iteration verifier needs to identify when a
+		 * state identical some state from a previous iteration is reached.
+		 * Check below forces creation of checkpoint before callback calling
+		 * instruction to allow search for such identical states.
+		 */
+		if (is_sync_callback_calling_insn(insn)) {
+			mark_callback_iter_next(env, t);
+			mark_force_checkpoint(env, t);
+			mark_prune_point(env, t);
+			mark_jmp_point(env, t);
+		}
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			struct bpf_kfunc_call_arg_meta meta;
 
@@ -17080,10 +17145,16 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				}
 				goto skip_inf_loop_check;
 			}
+			if (is_callback_iter_next(env, insn_idx)) {
+				if (states_equal(env, &sl->state, cur, true))
+					goto hit;
+				goto skip_inf_loop_check;
+			}
 			/* attempt to detect infinite loop to avoid unnecessary doomed work */
 			if (states_maybe_looping(&sl->state, cur) &&
 			    states_equal(env, &sl->state, cur, false) &&
-			    !iter_active_depths_differ(&sl->state, cur)) {
+			    !iter_active_depths_differ(&sl->state, cur) &&
+			    sl->state.callback_iter_depth == cur->callback_iter_depth) {
 				verbose_linfo(env, insn_idx, "; ");
 				verbose(env, "infinite loop detected at insn %d\n", insn_idx);
 				verbose(env, "cur state:");
diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
index 3bff680de16c..b5aa168889c1 100644
--- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
+++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
@@ -21,12 +21,14 @@ void test_cb_refs(void)
 {
 	LIBBPF_OPTS(bpf_object_open_opts, opts, .kernel_log_buf = log_buf,
 						.kernel_log_size = sizeof(log_buf),
-						.kernel_log_level = 1);
+						.kernel_log_level = 1 | 2 | 4);
 	struct bpf_program *prog;
 	struct cb_refs *skel;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(cb_refs_tests); i++) {
+		if (!test__start_subtest(cb_refs_tests[i].prog_name))
+			continue;
 		LIBBPF_OPTS(bpf_test_run_opts, run_opts,
 			.data_in = &pkt_v4,
 			.data_size_in = sizeof(pkt_v4),
diff --git a/tools/testing/selftests/bpf/progs/cb_refs.c b/tools/testing/selftests/bpf/progs/cb_refs.c
index 76d661b20e87..56c764df8196 100644
--- a/tools/testing/selftests/bpf/progs/cb_refs.c
+++ b/tools/testing/selftests/bpf/progs/cb_refs.c
@@ -33,6 +33,7 @@ int underflow_prog(void *ctx)
 	if (!p)
 		return 0;
 	bpf_for_each_map_elem(&array_map, cb1, &p, 0);
+	bpf_kfunc_call_test_release(p);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index 4c39e920dac2..8c0ef2742208 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -171,6 +171,7 @@ int reject_with_rbtree_add_throw(void *ctx)
 		return 0;
 	bpf_spin_lock(&lock);
 	bpf_rbtree_add(&rbtree, &f->node, rbless);
+	bpf_spin_unlock(&lock);
 	return 0;
 }
 
@@ -214,6 +215,7 @@ int reject_with_cb_reference(void *ctx)
 	if (!f)
 		return 0;
 	bpf_loop(5, subprog_cb_ref, NULL, 0);
+	bpf_obj_drop(f);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index db6b3143338b..ead358679fe2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -120,14 +120,12 @@ __naked int global_subprog_result_precise(void)
 SEC("?raw_tp")
 __success __log_level(2)
 __msg("14: (0f) r1 += r6")
-__msg("mark_precise: frame0: last_idx 14 first_idx 10")
+__msg("mark_precise: frame0: last_idx 14 first_idx 9")
 __msg("mark_precise: frame0: regs=r6 stack= before 13: (bf) r1 = r7")
 __msg("mark_precise: frame0: regs=r6 stack= before 12: (27) r6 *= 4")
 __msg("mark_precise: frame0: regs=r6 stack= before 11: (25) if r6 > 0x3 goto pc+4")
 __msg("mark_precise: frame0: regs=r6 stack= before 10: (bf) r6 = r0")
-__msg("mark_precise: frame0: parent state regs=r0 stack=:")
-__msg("mark_precise: frame0: last_idx 18 first_idx 0")
-__msg("mark_precise: frame0: regs=r0 stack= before 18: (95) exit")
+__msg("mark_precise: frame0: regs=r0 stack= before 9: (85) call bpf_loop")
 __naked int callback_result_precise(void)
 {
 	asm volatile (
@@ -234,14 +232,12 @@ __naked int parent_callee_saved_reg_precise_global(void)
 SEC("?raw_tp")
 __success __log_level(2)
 __msg("12: (0f) r1 += r6")
-__msg("mark_precise: frame0: last_idx 12 first_idx 10")
+__msg("mark_precise: frame0: last_idx 12 first_idx 9")
 __msg("mark_precise: frame0: regs=r6 stack= before 11: (bf) r1 = r7")
 __msg("mark_precise: frame0: regs=r6 stack= before 10: (27) r6 *= 4")
+__msg("mark_precise: frame0: regs=r6 stack= before 9: (85) call bpf_loop")
 __msg("mark_precise: frame0: parent state regs=r6 stack=:")
-__msg("mark_precise: frame0: last_idx 16 first_idx 0")
-__msg("mark_precise: frame0: regs=r6 stack= before 16: (95) exit")
-__msg("mark_precise: frame1: regs= stack= before 15: (b7) r0 = 0")
-__msg("mark_precise: frame1: regs= stack= before 9: (85) call bpf_loop#181")
+__msg("mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx 9")
 __msg("mark_precise: frame0: regs=r6 stack= before 8: (b7) r4 = 0")
 __msg("mark_precise: frame0: regs=r6 stack= before 7: (b7) r3 = 0")
 __msg("mark_precise: frame0: regs=r6 stack= before 6: (bf) r2 = r8")
@@ -374,15 +370,13 @@ __naked int parent_stack_slot_precise_global(void)
 SEC("?raw_tp")
 __success __log_level(2)
 __msg("14: (0f) r1 += r6")
-__msg("mark_precise: frame0: last_idx 14 first_idx 11")
+__msg("mark_precise: frame0: last_idx 14 first_idx 10")
 __msg("mark_precise: frame0: regs=r6 stack= before 13: (bf) r1 = r7")
 __msg("mark_precise: frame0: regs=r6 stack= before 12: (27) r6 *= 4")
 __msg("mark_precise: frame0: regs=r6 stack= before 11: (79) r6 = *(u64 *)(r10 -8)")
+__msg("mark_precise: frame0: regs= stack=-8 before 10: (85) call bpf_loop")
 __msg("mark_precise: frame0: parent state regs= stack=-8:")
-__msg("mark_precise: frame0: last_idx 18 first_idx 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 18: (95) exit")
-__msg("mark_precise: frame1: regs= stack= before 17: (b7) r0 = 0")
-__msg("mark_precise: frame1: regs= stack= before 10: (85) call bpf_loop#181")
+__msg("mark_precise: frame0: last_idx 9 first_idx 0 subseq_idx 10")
 __msg("mark_precise: frame0: regs= stack=-8 before 9: (b7) r4 = 0")
 __msg("mark_precise: frame0: regs= stack=-8 before 8: (b7) r3 = 0")
 __msg("mark_precise: frame0: regs= stack=-8 before 7: (bf) r2 = r8")
-- 
2.42.0


