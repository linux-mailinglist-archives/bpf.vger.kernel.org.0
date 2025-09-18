Return-Path: <bpf+bounces-68845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9F8B8682D
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 20:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F81F7B9109
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E958248B;
	Thu, 18 Sep 2025 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emYm4qLS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8872D6604
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221294; cv=none; b=DZwK7Qk8X5f63kU+cNZDAkdQasXrTMwnr7Z1kVlU6HPhftBtj0luIbpNGNaT2o8XfhA9MFVOWLpEsGpmx1HjB2YJiOgmHynXMc/Mn0ONNW36U0j/t1c5rP4H19CFy0zZHU3Btw2rroNyDlkGeo1MEFyv/bQQfE8pKeQ9KcPVu3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221294; c=relaxed/simple;
	bh=SC0n59s95WxBf06p73s+Usf09LtXfukmseFbjLWm+cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1eir9tWKp3hbYfLIt8C8dQI3takeARsgZmhGImeB3SxOHIbYVpVMX2d5Vv/KBVqpkHgw3KNrf6RqyMaYkfGd/zh4T+ioj5/Dsuyi9ttGXidRqiLZ9pkJOVb/XOJutM0YpJ00usW23kbZiCMzi6212wKMMG0LI23ZZnj59JDtVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emYm4qLS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-267facf9b58so9814385ad.2
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758221291; x=1758826091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdEfTB/RaPi9giXvIvpe42wVaaM3ANHV+dKTOM1d5Zg=;
        b=emYm4qLSF9PaBviAfjVv9u6eEKXam5jVvRua167fN7YXoTrFJE3si9ATkM6uV6h4/j
         VpJg7I7Jo1Hf5qcbPTwba61DLQ/XZyLdq2H4wUUcgCRbTlS3zyWwhyNGvfIViL57nFhp
         YaLr9XthBXGkbMNm9zo1eWb/iLTOpTzJTEVTyKlxhAgOY4EG3O6LeoSXyaWTphgLLPc7
         I4RDdIr/qy3UQJoGpDtAbpvdmqfnM9xpjYr0HQZcUx6DWtbsCUZzL3HyBaVvyTpEWqUF
         1h6tC+iG/JWjBLpLsvym6AT2QjxAugbmFjOJFH0YYOaHn1HEv7ZZzt8hCNKudj1BwSp7
         eHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758221291; x=1758826091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdEfTB/RaPi9giXvIvpe42wVaaM3ANHV+dKTOM1d5Zg=;
        b=XW4pzrBRpLRxrks6Ne/El/HAoaRCSRghBoFLcmH3iusiEC39pyMnTGMAX1CxJLK0Qs
         ynLT3ZL0fI480hLySRqQfnTq+vOy4jGLQ5TY6sS6tWp7EBIFbnGCPk2fInORtitVam4u
         VjAf2DstLYwrFs9GX6RDNShBjp7kb2p0RxGwZaUZdq7Ph8AaFWwX6ahNapIoVJTQ2VnE
         MQ92HFWzs9kh0w5StBpHsWXuW6fxelg3agrn7pzXsX3k03z7eRbjPI+AbPqLStrbUNEa
         502h/sYoMz4FDcgELRR56ZcEec0xX4fOqUXYsUQxUECSBd8yGz9uXhsTkN3tDfsBlg3E
         KGRQ==
X-Gm-Message-State: AOJu0YzOWhxJFTFv90zc38B0jsAtf/07FI3wgoL4X0r/i5+ezrgVHyA2
	Ki91KRKLgKDHSz5cUMgwcnHPKwmLqheUZ/0b6lSgmQJoBhHtWpxV99lp5wTdGixx
X-Gm-Gg: ASbGnctKZdYwuB1gFairCFMW7ZbMKLJqgvrWm5/bVJwjz6uNd4Ki7wO0d+hpfGRV3qh
	puZSLH8HxlbGtjV4PBL252lLCFpeURKb0xLO6zASPdsU9pWHnrdToMSZ/Mc/C8VUZwW3huWYdAB
	XLuh9SjPJP1cvgYKLuNy8VXQkrsSA1wjHb0vryLibjL6beGnwBXkma/2SP+VjfDURdaNX/ne+6p
	uePmqjMOyIwk+k2GQGH6PVpjLM0jBHaV/gpAjZdn9UKPsOkBgPl7cBtYk/2evaCYBgJBZdCqYSz
	qTW3E10UrfnMdjktTXx5JrtqMT8NoaYBqKihgiPkc3em4gJNijWNfrMz5iKMYfZs1BsuPA+FMlx
	dqdnZTWowZbVhkbrif0OcdhZml2YSeODtULL2LWB11E3NlQ==
X-Google-Smtp-Source: AGHT+IGU8dhU06SOwJVNiQzWZPI09mzpAhLZJZbucEml/W3XPoVqdVnevS7wRQjJ/OwFYupAt8TJmQ==
X-Received: by 2002:a17:902:ccca:b0:269:9ee8:c266 with SMTP id d9443c01a7336-269ba42f618mr6830885ad.15.1758221290563;
        Thu, 18 Sep 2025 11:48:10 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm32361505ad.90.2025.09.18.11.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 11:48:10 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 07/12] bpf: enable callchain sensitive stack liveness tracking
Date: Thu, 18 Sep 2025 11:47:36 -0700
Message-ID: <20250918-callchain-sensitive-liveness-v2-7-214ed2653eee@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918-callchain-sensitive-liveness-v2-0-214ed2653eee@gmail.com>
References: <20250918-callchain-sensitive-liveness-v2-0-214ed2653eee@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
 kernel/bpf/verifier.c | 61 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 12ba281472dc0e014a700659ec802db20f7d71a6..af08cc94c3b053e417d59c83aec108ef2ef828ef 100644
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
@@ -10720,6 +10749,8 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	/* and go analyze first insn of the callee */
 	*insn_idx = env->subprog_info[subprog].start - 1;
 
+	bpf_reset_live_stack_callchain(env);
+
 	if (env->log.level & BPF_LOG_LEVEL) {
 		verbose(env, "caller:\n");
 		print_verifier_state(env, state, caller->frameno, true);
@@ -18507,7 +18538,6 @@ static void clean_func_state(struct bpf_verifier_env *env,
 			     u32 ip)
 {
 	u16 live_regs = env->insn_aux_data[ip].live_regs_before;
-	enum bpf_reg_liveness live;
 	int i, j;
 
 	for (i = 0; i < BPF_REG_FP; i++) {
@@ -18520,9 +18550,7 @@ static void clean_func_state(struct bpf_verifier_env *env,
 	}
 
 	for (i = 0; i < st->allocated_stack / BPF_REG_SIZE; i++) {
-		live = st->stack[i].spilled_ptr.live;
-		/* liveness must not touch this stack slot anymore */
-		if (!(live & REG_LIVE_READ)) {
+		if (!bpf_stack_slot_alive(env, st->frameno, i)) {
 			__mark_reg_not_init(env, &st->stack[i].spilled_ptr);
 			for (j = 0; j < BPF_REG_SIZE; j++)
 				st->stack[i].slot_type[j] = STACK_INVALID;
@@ -18535,6 +18563,7 @@ static void clean_verifier_state(struct bpf_verifier_env *env,
 {
 	int i, ip;
 
+	bpf_live_stack_query_init(env, st);
 	st->cleaned = true;
 	for (i = 0; i <= st->curframe; i++) {
 		ip = frame_insn_idx(st, i);
@@ -18620,9 +18649,6 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 	if (exact == EXACT)
 		return regs_exact(rold, rcur, idmap);
 
-	if (!(rold->live & REG_LIVE_READ) && exact == NOT_EXACT)
-		/* explored state didn't use this */
-		return true;
 	if (rold->type == NOT_INIT) {
 		if (exact == NOT_EXACT || rcur->type == NOT_INIT)
 			/* explored state can't have used this */
@@ -19861,6 +19887,9 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 		return PROCESS_BPF_EXIT;
 
 	if (env->cur_state->curframe) {
+		err = bpf_update_live_stack(env);
+		if (err)
+			return err;
 		/* exit from nested function */
 		err = prepare_func_exit(env, &env->insn_idx);
 		if (err)
@@ -20046,7 +20075,7 @@ static int do_check(struct bpf_verifier_env *env)
 	for (;;) {
 		struct bpf_insn *insn;
 		struct bpf_insn_aux_data *insn_aux;
-		int err;
+		int err, marks_err;
 
 		/* reset current history entry on each new instruction */
 		env->cur_hist_ent = NULL;
@@ -20139,7 +20168,15 @@ static int do_check(struct bpf_verifier_env *env)
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
@@ -20178,6 +20215,9 @@ static int do_check(struct bpf_verifier_env *env)
 process_bpf_exit:
 			mark_verifier_state_scratched(env);
 			err = update_branch_counts(env, env->cur_state);
+			if (err)
+				return err;
+			err = bpf_update_live_stack(env);
 			if (err)
 				return err;
 			err = pop_stack(env, &prev_insn_idx, &env->insn_idx,
@@ -24738,6 +24778,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = bpf_stack_liveness_init(env);
+	if (ret)
+		goto skip_full_check;
+
 	ret = check_attach_btf_id(env);
 	if (ret)
 		goto skip_full_check;
@@ -24887,6 +24931,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		mutex_unlock(&bpf_verifier_lock);
 	vfree(env->insn_aux_data);
 err_free_env:
+	bpf_stack_liveness_free(env);
 	kvfree(env->cfg.insn_postorder);
 	kvfree(env->scc_info);
 	kvfree(env);

-- 
2.51.0

