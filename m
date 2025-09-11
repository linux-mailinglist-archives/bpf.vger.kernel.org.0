Return-Path: <bpf+bounces-68070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F061AB52578
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 03:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC5F1C2448D
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 01:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025F3154423;
	Thu, 11 Sep 2025 01:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6wcONK/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98701F4C96
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757552700; cv=none; b=BEfIE31xGBuNfz/JdkX464sPyqIUI5A20izuQw53WYlOglczP60czKyJa9ylPviA4OAZ5ulm8OiQivYWRiORRmNb2FkbWFh4+aWDuoh0HZfcRRJOlnbKFUpR2ppSUylr4W7nR41wFVqObo05p6NWPoH6YOFi6lEHsu9MNFZ4CxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757552700; c=relaxed/simple;
	bh=86HE7oXjrBOO0+QnFfkFQiruVly0cIIkpwYVtNkCAQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAhO9n0oWN6mmGyfzAJB+CTuaKf4Pc6ZCv7GcBOpvDTnVH73jfRU922sMZMU2fVi8tdaeHLp56WCSauHgpqvNy4zcz+oFbPu3t+L1rnj3aXTL+sqQMf+XLQNoWkrB0JVstOlYczbfgMphlO6PGRe6xRdHEMSk4znmZjaafUElrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6wcONK/; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so157156a12.0
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 18:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757552698; x=1758157498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29eK+nJyGFK/9IPD4JHEoxJM7+tpML2NCLq1EoW/SxQ=;
        b=C6wcONK/0lKpmPOeeVxGn1QzOkSg/l0EY37SngQQVogYjhyHzhd1jPEkI/gvuf/mz9
         um9vS7hDUOp/FT5k7mGZlRXHBH2r2iSr1sG7YCuQO0lRpbemPaoeU/4VtW8QeyA2F2LS
         v64BKKhF2BgXBL9dgGO+vC7ngQti+BlqoCFeMZmjYigQpLkbAPAu85Gp0jw1E6oiRU0y
         qkgzjXCZ59vyU0vO338PZYhi55uwm0JWEoM9idgRyRzYvI97JK/sC+/D/fT9K+unToG5
         Bk0TQ5N2HEwANPU7syfh2qUlMLLWKFgaTJsKP19Fyi1Zdf3tzusU6d7dfLNUGG40FPrQ
         lhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757552698; x=1758157498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29eK+nJyGFK/9IPD4JHEoxJM7+tpML2NCLq1EoW/SxQ=;
        b=BaH+pLMFtuFGDcHb/iA5Aim+k5Hbb2Kwo8b42EYqFWiVzp0vLP6tEDs/yvtLWHMDDy
         8jolh4F25QmHKzzJSk5TTVOHx34P03T7j6QtljPz9419hwHkV36zARNm3WDVHcBVL7dV
         8s7CyaLPk+PCcS7/k1U9CAYVjm6jNfIWxDN9pzng8rOAS9HffAeGX5zuKihp2Lktm4OP
         GtAfxoLtuyFCoxm1TKwkeu5G9vqwPCAccpYjWYatAAZL2Dl4Ci1LeGEnjFMg8fVq9I0c
         ierNYPGdPyH2dpri7RZdmFRi2SmTUmxnZciGUt7hnZCXkJVsb9EgW3fLptLutQNHLg8I
         AkPA==
X-Gm-Message-State: AOJu0Yzto5dDu+AiwtA3v5AsjFFACTqvQg91W/ItL3RFtMQq7A+p7iv5
	4SydXce+gLT3nUr+mlGn8RUhNcfMQeKpCv0iLu+WgjRQwrEJ8EScYSdiXMlfpg==
X-Gm-Gg: ASbGncsGKLH/Eelv76SCa30RqkNb+IkENFx071C+77+MpvowfW2fVmcVFECvRw0NMYi
	Oa7+1Ow9vHkkRozpa+8zk+R0i9QDEwFpOyITrajp9NToon+UN782ebERSg4iW6//cqC1Mr0E8pE
	q8YEJjbTimMz6uYXqLL9kYemq2vtK26bVJNG8ILnoA3HN9iEeXuA6OubGTy/xE9nJp64GcRDTyh
	sxTVtKgRYOapr31jtG10s2It9SVk2MTOYfbeabyyIsN+71Ijok/b2fVREa0kzkX4uICLCvVioDY
	calygGhWo5zefeDBZK/w2AbmUUL3hHWVoub0rDfHYs2gs92lsafpCrJBz2LQzoex3gRKIgDVp3i
	cb9gGOrbD5tMVjR7przhelUMkK4tq63SN+A==
X-Google-Smtp-Source: AGHT+IHdoUinI6XYVU8rEvNvTuBrkkrjn64NI/34lWrfqKdCK1rYiy+fgm15I00wke2lu+I3YWFqxQ==
X-Received: by 2002:a17:90b:2688:b0:30a:4874:5397 with SMTP id 98e67ed59e1d1-32d43eff94fmr21022730a91.9.1757552697797;
        Wed, 10 Sep 2025 18:04:57 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd61eaa27sm545511a91.1.2025.09.10.18.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:04:57 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 07/10] bpf: enable callchain sensitive stack liveness tracking
Date: Wed, 10 Sep 2025 18:04:32 -0700
Message-ID: <20250911010437.2779173-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911010437.2779173-1-eddyz87@gmail.com>
References: <20250911010437.2779173-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocate analysis instance:
- Add bpf_stack_liveness_{init,free}() calls to bpf_check().

Notify the instance about any stack reads and writes:
- Add bpf_mark_stack_write() call at every location where
  REG_LIVE_WRITTEN is recorded for a stack slot.
- Add bpf_mark_stack_read() call at every location mark_reg_read() is
  called.
- Both bpf_mark_stack_{read,write}() rely on
  env->liveness->cur_instance callchain being in sync with
  env->cur_state. It is possible to update env->liveness->cur_instance
  every time a mark read/write is called, but that costs a hash table
  lookup and is noticeable in the performance profile. Hence, manually
  reset env->liveness->cur_instance whenever the verifier changes
  env->cur_state call stack:
  - call bpf_reset_live_stack_callchain() when the verifier enters a
    subprogram;
  - call bpf_update_live_stack() when the verifier exits a subprogram
    (it implies the reset).

Make sure bpf_update_live_stack() is called for a callchain before
issuing liveness queries. And make sure that bpf_update_live_stack()
is called for any callee callchain first:
- Add bpf_update_live_stack() call at every location that processes
  BPF_EXIT:
  - exit from a subprogram;
  - before pop_stack() call.
  This makes sure that bpf_update_live_stack() is called for callee
  callchains before caller callchains.

Make sure must_write marks are set to zero for instructions that
do not always access the stack:
- Wrap do_check_insn() with bpf_reset_stack_write_marks() /
  bpf_commit_stack_write_marks() calls.
  Any calls to bpf_mark_stack_write() are accumulated between this
  pair of calls. If no bpf_mark_stack_write() calls were made
  it means that the instruction does not access stack (at-least
  on the current verification path) and it is important to record
  this fact.

Finally, use bpf_live_stack_query_init() / bpf_stack_slot_alive()
to query stack liveness info.

The manual tracking of the correct order for callee/caller
bpf_update_live_stack() calls is a bit convoluted and may warrant some
automation in future revisions.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 61 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bdcc20d2fab6..33cb8beb8706 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -789,6 +789,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 
 	state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
 	state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
+	bpf_mark_stack_write(env, state->frameno, BIT(spi - 1) | BIT(spi));
 
 	return 0;
 }
@@ -828,6 +829,7 @@ static void invalidate_dynptr(struct bpf_verifier_env *env, struct bpf_func_stat
 	 */
 	state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
 	state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
+	bpf_mark_stack_write(env, state->frameno, BIT(spi - 1) | BIT(spi));
 }
 
 static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
@@ -939,6 +941,7 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 	/* Same reason as unmark_stack_slots_dynptr above */
 	state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
 	state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
+	bpf_mark_stack_write(env, state->frameno, BIT(spi - 1) | BIT(spi));
 
 	return 0;
 }
@@ -1066,6 +1069,7 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 		for (j = 0; j < BPF_REG_SIZE; j++)
 			slot->slot_type[j] = STACK_ITER;
 
+		bpf_mark_stack_write(env, state->frameno, BIT(spi - i));
 		mark_stack_slot_scratched(env, spi - i);
 	}
 
@@ -1097,6 +1101,7 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 		for (j = 0; j < BPF_REG_SIZE; j++)
 			slot->slot_type[j] = STACK_INVALID;
 
+		bpf_mark_stack_write(env, state->frameno, BIT(spi - i));
 		mark_stack_slot_scratched(env, spi - i);
 	}
 
@@ -1186,6 +1191,7 @@ static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
 	slot = &state->stack[spi];
 	st = &slot->spilled_ptr;
 
+	bpf_mark_stack_write(env, reg->frameno, BIT(spi));
 	__mark_reg_known_zero(st);
 	st->type = PTR_TO_STACK; /* we don't have dedicated reg type */
 	st->live |= REG_LIVE_WRITTEN;
@@ -1244,6 +1250,7 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 
 	/* see unmark_stack_slots_dynptr() for why we need to set REG_LIVE_WRITTEN */
 	st->live |= REG_LIVE_WRITTEN;
+	bpf_mark_stack_write(env, reg->frameno, BIT(spi));
 
 	for (i = 0; i < BPF_REG_SIZE; i++)
 		slot->slot_type[i] = STACK_INVALID;
@@ -3619,6 +3626,9 @@ static int mark_stack_slot_obj_read(struct bpf_verifier_env *env, struct bpf_reg
 		if (err)
 			return err;
 
+		err = bpf_mark_stack_read(env, reg->frameno, env->insn_idx, BIT(spi - i));
+		if (err)
+			return err;
 		mark_stack_slot_scratched(env, spi - i);
 	}
 	return 0;
@@ -5151,6 +5161,18 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	if (err)
 		return err;
 
+	if (!(off % BPF_REG_SIZE) && size == BPF_REG_SIZE) {
+		/* only mark the slot as written if all 8 bytes were written
+		 * otherwise read propagation may incorrectly stop too soon
+		 * when stack slots are partially written.
+		 * This heuristic means that read propagation will be
+		 * conservative, since it will add reg_live_read marks
+		 * to stack slots all the way to first state when programs
+		 * writes+reads less than 8 bytes
+		 */
+		bpf_mark_stack_write(env, state->frameno, BIT(spi));
+	}
+
 	check_fastcall_stack_contract(env, state, insn_idx, off);
 	mark_stack_slot_scratched(env, spi);
 	if (reg && !(off % BPF_REG_SIZE) && reg->type == SCALAR_VALUE && env->bpf_capable) {
@@ -5420,12 +5442,16 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg;
 	u8 *stype, type;
 	int insn_flags = insn_stack_access_flags(reg_state->frameno, spi);
+	int err;
 
 	stype = reg_state->stack[spi].slot_type;
 	reg = &reg_state->stack[spi].spilled_ptr;
 
 	mark_stack_slot_scratched(env, spi);
 	check_fastcall_stack_contract(env, state, env->insn_idx, off);
+	err = bpf_mark_stack_read(env, reg_state->frameno, env->insn_idx, BIT(spi));
+	if (err)
+		return err;
 
 	if (is_spilled_reg(&reg_state->stack[spi])) {
 		u8 spill_size = 1;
@@ -8159,6 +8185,9 @@ static int check_stack_range_initialized(
 		mark_reg_read(env, &state->stack[spi].spilled_ptr,
 			      state->stack[spi].spilled_ptr.parent,
 			      REG_LIVE_READ64);
+		err = bpf_mark_stack_read(env, reg->frameno, env->insn_idx, BIT(spi));
+		if (err)
+			return err;
 		/* We do not set REG_LIVE_WRITTEN for stack slot, as we can not
 		 * be sure that whether stack slot is written to or not. Hence,
 		 * we must still conservatively propagate reads upwards even if
@@ -10716,6 +10745,8 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	/* and go analyze first insn of the callee */
 	*insn_idx = env->subprog_info[subprog].start - 1;
 
+	bpf_reset_live_stack_callchain(env);
+
 	if (env->log.level & BPF_LOG_LEVEL) {
 		verbose(env, "caller:\n");
 		print_verifier_state(env, state, caller->frameno, true);
@@ -18502,7 +18533,6 @@ static void clean_func_state(struct bpf_verifier_env *env,
 			     u32 ip)
 {
 	u16 live_regs = env->insn_aux_data[ip].live_regs_before;
-	enum bpf_reg_liveness live;
 	int i, j;
 
 	for (i = 0; i < BPF_REG_FP; i++) {
@@ -18515,9 +18545,7 @@ static void clean_func_state(struct bpf_verifier_env *env,
 	}
 
 	for (i = 0; i < st->allocated_stack / BPF_REG_SIZE; i++) {
-		live = st->stack[i].spilled_ptr.live;
-		/* liveness must not touch this stack slot anymore */
-		if (!(live & REG_LIVE_READ)) {
+		if (!bpf_stack_slot_alive(env, st->frameno, i)) {
 			__mark_reg_not_init(env, &st->stack[i].spilled_ptr);
 			for (j = 0; j < BPF_REG_SIZE; j++)
 				st->stack[i].slot_type[j] = STACK_INVALID;
@@ -18530,6 +18558,7 @@ static void clean_verifier_state(struct bpf_verifier_env *env,
 {
 	int i, ip;
 
+	bpf_live_stack_query_init(env, st);
 	st->cleaned = true;
 	for (i = 0; i <= st->curframe; i++) {
 		ip = frame_insn_idx(st, i);
@@ -18615,9 +18644,6 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 	if (exact == EXACT)
 		return regs_exact(rold, rcur, idmap);
 
-	if (!(rold->live & REG_LIVE_READ) && exact == NOT_EXACT)
-		/* explored state didn't use this */
-		return true;
 	if (rold->type == NOT_INIT) {
 		if (exact == NOT_EXACT || rcur->type == NOT_INIT)
 			/* explored state can't have used this */
@@ -19856,6 +19882,9 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 		return PROCESS_BPF_EXIT;
 
 	if (env->cur_state->curframe) {
+		err = bpf_update_live_stack(env);
+		if (err)
+			return err;
 		/* exit from nested function */
 		err = prepare_func_exit(env, &env->insn_idx);
 		if (err)
@@ -20041,7 +20070,7 @@ static int do_check(struct bpf_verifier_env *env)
 	for (;;) {
 		struct bpf_insn *insn;
 		struct bpf_insn_aux_data *insn_aux;
-		int err;
+		int err, marks_err;
 
 		/* reset current history entry on each new instruction */
 		env->cur_hist_ent = NULL;
@@ -20134,7 +20163,15 @@ static int do_check(struct bpf_verifier_env *env)
 		if (state->speculative && insn_aux->nospec)
 			goto process_bpf_exit;
 
+		err = bpf_reset_stack_write_marks(env, env->insn_idx);
+		if (err)
+			return err;
 		err = do_check_insn(env, &do_print_state);
+		if (err >= 0 || error_recoverable_with_nospec(err)) {
+			marks_err = bpf_commit_stack_write_marks(env);
+			if (marks_err)
+				return marks_err;
+		}
 		if (error_recoverable_with_nospec(err) && state->speculative) {
 			/* Prevent this speculative path from ever reaching the
 			 * insn that would have been unsafe to execute.
@@ -20173,6 +20210,9 @@ static int do_check(struct bpf_verifier_env *env)
 process_bpf_exit:
 			mark_verifier_state_scratched(env);
 			err = update_branch_counts(env, env->cur_state);
+			if (err)
+				return err;
+			err = bpf_update_live_stack(env);
 			if (err)
 				return err;
 			err = pop_stack(env, &prev_insn_idx, &env->insn_idx,
@@ -24733,6 +24773,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = bpf_stack_liveness_init(env);
+	if (ret)
+		goto skip_full_check;
+
 	ret = check_attach_btf_id(env);
 	if (ret)
 		goto skip_full_check;
@@ -24882,6 +24926,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		mutex_unlock(&bpf_verifier_lock);
 	vfree(env->insn_aux_data);
 err_free_env:
+	bpf_stack_liveness_free(env);
 	kvfree(env->cfg.insn_postorder);
 	kvfree(env->scc_info);
 	kvfree(env);
-- 
2.47.3


