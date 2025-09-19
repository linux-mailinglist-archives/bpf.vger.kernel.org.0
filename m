Return-Path: <bpf+bounces-68893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D77CB87B65
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 04:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6460D2A8815
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 02:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E72273D67;
	Fri, 19 Sep 2025 02:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ah719z//"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3475425C802
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 02:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248349; cv=none; b=NqoWIXBhCfKF+cYAl/2P4yJqVvMQOVcXrz6JLL/c1dizmu9TBG6VwKMYFyeZDtAQweIs2ddPodmsRJj4EysSZmW2NL/itV6r5DC03F3Bn4rMOacDwhm/xxWedLWLTLeRVimPMjEJFLL5pC4/0oWrtYzR154rZIXhgws/h4fvwWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248349; c=relaxed/simple;
	bh=DCo7p2fq+2OFpsl3mhOzghttrXdoCyjUFPMWkBAEE1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M5qJNHQ+FDxMbEnLbqLYSjwDfEW9tPxzD2Q5RAlvV/QgPnaxN+K7kLD7Ybum4a1UaigcpC13jkNn+RCHmzhZh5i/4/x6MahWpDG+8f0piWswAvcljRcnlxC739vcs3uQRgXlVDh9bWAT/mZkDyy9OJyaJiRuPsBn2yYp4Orjr50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ah719z//; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b5515eaefceso589702a12.2
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 19:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758248347; x=1758853147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3ySgHoumlNGl7PWREAbuqaIpcj32uoTh4IJe6avSCc=;
        b=Ah719z//JKi0wT3r6ZciWDMLI7kwJJbUjKAks/IpZjygPGnTT9UPdJCFRhWaVyDKa1
         XJnkTCNEWd0GzHgtITsyqAArKY1B0KSgLtVEuWHzfvDoq+wAR94uI5pjV6GjgMmeDZXV
         eUgxezIT9KnzDevBSVfFsXU2FEHmM45BSfwsFkU2GT1/BFB6bn+X84Jh4yXdwhkYb47T
         Ca0W78cNIDpjqUUkLt7G4w38iYpLPT0st8urj6PSxvwjQzbEM3sddBvxdxKMFZIl+53m
         Xo9LSJm4q8e6Akfcod2XrJNU9bwNe1v4PSfc+zPO+lnEDt4nI/PxdFCPSWACRZqBJMhI
         pZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758248347; x=1758853147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3ySgHoumlNGl7PWREAbuqaIpcj32uoTh4IJe6avSCc=;
        b=Qb97Yok0OvmqDHyDTHsrDs6AIP9Y7MOiyCFyMTQWCSFVdXZFy3QQvGBf1fjYKhmQBn
         qkvy8Gk96V9hPtGSe0r9ANPUYi9AxnZMVlsSxyl5AbH7KRWCXWELyLK7WhK2GU05/5Up
         M6c/Ks1fl1QcOzIPdkqf6LG+hIEJmOcwNnOSVSMuXf7YD2uZMyGixXdv9vtNnOSZyWgJ
         Qw2CpP5i4rflOYVOK7eFKt51uIMTTnOMIsYBUqX1ypHgQFmdg5VkD4eFze0R6G6uQdH7
         EXsEnhXyTiZv9fc0VeQzpZtLJszIjMIw4lTXYt/bcDmHcrSnKqFvpLviDv8uPqJEwD5F
         YelQ==
X-Gm-Message-State: AOJu0YxMKeQQlGIfgELYje/zYJ/OQ23rGx46WsEgG+xZ/E++VPWK/OJd
	jznZyphy9nallEmB/FVWrkblj5R+QNOf6WeJgiSdCNJH9aO0T/PBasaAQIPjcA==
X-Gm-Gg: ASbGncuWDFmMri8UR2iSPGk+6pX1WqZd67IpRiUCxeuD/NRQnh7tLGeTxeSZEifOH0u
	CfkNciPNgpRbnSUHdjke5o5C+fhOZgnLhSQOKlFrItwf0Li2whSAcsS+lCjNXrGrgsp/ixq0Ej5
	qQHgqV0RTtmB69KO/U0yHx1GJYBwic8L1PoHaYHPVXCZnS18e3NFeCqR65KKWo8/xfIuOgrgac9
	OXkzxPIUSoqk21aUzXVGmUxoqg9VeKkhgOdyiZKBCUawuc24CMaoBtji3PMIn05BeL2rcN/7FkQ
	ud6aPm7K23/Mpo3SDmADJ2H37CSkmvAuCbIwg47pA7MbAHKwShpsEloFcdeuVFECexP9DXYblsO
	C60Q6t8jV9hJYCRlR
X-Google-Smtp-Source: AGHT+IGJnNR5JBfn4Q/gD+bmFk+pU4uZBY0cL8vxVeMnO8ZnVvIJ7SQ8i5ff8Uv5MExq+3dFx/9e7w==
X-Received: by 2002:a17:903:32cb:b0:248:9e56:e806 with SMTP id d9443c01a7336-269ba402999mr27133395ad.12.1758248347009;
        Thu, 18 Sep 2025 19:19:07 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033a3e5sm39186235ad.126.2025.09.18.19.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 19:19:06 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 07/12] bpf: enable callchain sensitive stack liveness tracking
Date: Thu, 18 Sep 2025 19:18:40 -0700
Message-ID: <20250918-callchain-sensitive-liveness-v3-7-c3cd27bacc60@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
References: <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
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
index 59d0dc4deb785dac45fbca3c9a750ea9b54f9818..991b5593a27708a49933a3cf3ef3aabe76862db2 100644
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
@@ -3634,6 +3641,9 @@ static int mark_stack_slot_obj_read(struct bpf_verifier_env *env, struct bpf_reg
 		if (err)
 			return err;
 
+		err = bpf_mark_stack_read(env, reg->frameno, env->insn_idx, BIT(spi - i));
+		if (err)
+			return err;
 		mark_stack_slot_scratched(env, spi - i);
 	}
 	return 0;
@@ -5166,6 +5176,18 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
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
@@ -5435,12 +5457,16 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
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
@@ -8174,6 +8200,9 @@ static int check_stack_range_initialized(
 		mark_reg_read(env, &state->stack[spi].spilled_ptr,
 			      state->stack[spi].spilled_ptr.parent,
 			      REG_LIVE_READ64);
+		err = bpf_mark_stack_read(env, reg->frameno, env->insn_idx, BIT(spi));
+		if (err)
+			return err;
 		/* We do not set REG_LIVE_WRITTEN for stack slot, as we can not
 		 * be sure that whether stack slot is written to or not. Hence,
 		 * we must still conservatively propagate reads upwards even if
@@ -10735,6 +10764,8 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	/* and go analyze first insn of the callee */
 	*insn_idx = env->subprog_info[subprog].start - 1;
 
+	bpf_reset_live_stack_callchain(env);
+
 	if (env->log.level & BPF_LOG_LEVEL) {
 		verbose(env, "caller:\n");
 		print_verifier_state(env, state, caller->frameno, true);
@@ -18532,7 +18563,6 @@ static void clean_func_state(struct bpf_verifier_env *env,
 			     u32 ip)
 {
 	u16 live_regs = env->insn_aux_data[ip].live_regs_before;
-	enum bpf_reg_liveness live;
 	int i, j;
 
 	for (i = 0; i < BPF_REG_FP; i++) {
@@ -18545,9 +18575,7 @@ static void clean_func_state(struct bpf_verifier_env *env,
 	}
 
 	for (i = 0; i < st->allocated_stack / BPF_REG_SIZE; i++) {
-		live = st->stack[i].spilled_ptr.live;
-		/* liveness must not touch this stack slot anymore */
-		if (!(live & REG_LIVE_READ)) {
+		if (!bpf_stack_slot_alive(env, st->frameno, i)) {
 			__mark_reg_not_init(env, &st->stack[i].spilled_ptr);
 			for (j = 0; j < BPF_REG_SIZE; j++)
 				st->stack[i].slot_type[j] = STACK_INVALID;
@@ -18560,6 +18588,7 @@ static void clean_verifier_state(struct bpf_verifier_env *env,
 {
 	int i, ip;
 
+	bpf_live_stack_query_init(env, st);
 	st->cleaned = true;
 	for (i = 0; i <= st->curframe; i++) {
 		ip = frame_insn_idx(st, i);
@@ -18645,9 +18674,6 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 	if (exact == EXACT)
 		return regs_exact(rold, rcur, idmap);
 
-	if (!(rold->live & REG_LIVE_READ) && exact == NOT_EXACT)
-		/* explored state didn't use this */
-		return true;
 	if (rold->type == NOT_INIT) {
 		if (exact == NOT_EXACT || rcur->type == NOT_INIT)
 			/* explored state can't have used this */
@@ -19886,6 +19912,9 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 		return PROCESS_BPF_EXIT;
 
 	if (env->cur_state->curframe) {
+		err = bpf_update_live_stack(env);
+		if (err)
+			return err;
 		/* exit from nested function */
 		err = prepare_func_exit(env, &env->insn_idx);
 		if (err)
@@ -20071,7 +20100,7 @@ static int do_check(struct bpf_verifier_env *env)
 	for (;;) {
 		struct bpf_insn *insn;
 		struct bpf_insn_aux_data *insn_aux;
-		int err;
+		int err, marks_err;
 
 		/* reset current history entry on each new instruction */
 		env->cur_hist_ent = NULL;
@@ -20164,7 +20193,15 @@ static int do_check(struct bpf_verifier_env *env)
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
@@ -20203,6 +20240,9 @@ static int do_check(struct bpf_verifier_env *env)
 process_bpf_exit:
 			mark_verifier_state_scratched(env);
 			err = update_branch_counts(env, env->cur_state);
+			if (err)
+				return err;
+			err = bpf_update_live_stack(env);
 			if (err)
 				return err;
 			err = pop_stack(env, &prev_insn_idx, &env->insn_idx,
@@ -24763,6 +24803,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = bpf_stack_liveness_init(env);
+	if (ret)
+		goto skip_full_check;
+
 	ret = check_attach_btf_id(env);
 	if (ret)
 		goto skip_full_check;
@@ -24912,6 +24956,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		mutex_unlock(&bpf_verifier_lock);
 	vfree(env->insn_aux_data);
 err_free_env:
+	bpf_stack_liveness_free(env);
 	kvfree(env->cfg.insn_postorder);
 	kvfree(env->scc_info);
 	kvfree(env);

-- 
2.51.0

