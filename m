Return-Path: <bpf+bounces-30259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1DD8CB911
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 04:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7131C2034A
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 02:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898C11E4A2;
	Wed, 22 May 2024 02:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9ga+xF/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6BC26293
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 02:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716346041; cv=none; b=khg7QEKeAvv8ylGQrKIEfeCHlNxdv/6pky6rpI0U4YBk9pO6sePaxmnPTUYEm0q2MyfPyhoHo2vJrpCMlYZmbszpB2phhXunyW8YvTAxpzgHw+pSX+JOkotnz1kgLWTUXUt+Fn486RBS3WaT+uL1uJ732xfU9YSNVBISyFPyVFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716346041; c=relaxed/simple;
	bh=JMSK5Kgp2ibp/jL8V6puEswzVK2vqH755gBAWXwSn1c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=usMomy5kfdYBX5v4XhyzvlF0oGSK11pIW94eTMl9a87KDJ6GRIXnkqXz8bDqXVAlF0iGcrj/fAp9sNMEXbTzryCIAuuqfILqi5czN9SiVhnvvIGUcIN/tgXuMncd0wYOvOZFM3TOgFl/MaGhi2F3rAwSz7P5PDRGyKoufmeaRXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9ga+xF/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ecc23e6c9dso109216085ad.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 19:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716346038; x=1716950838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ip97ZryjgvDw0E3emd452VFF721rwhMu9VSqnkvJOKA=;
        b=E9ga+xF/jq2ef3X7uPTwaU9RxJDEy1/0E9PdWMC59PnsOVWgrJExn7dDgkiOcK3Ca6
         t1t9tW7JmZhNKDRfu3BnB1+e+ri1FR0FJsoX0Xj5VR7jpzzNN6+dWwoRdDzpfB0Rc5Qe
         Ab3t+BbfeUcUMCKcPRJ8GyrdChLUMDbVog6eF1Vu9AnbMVJT6lC3s7/Ag9y0pQhtMS32
         X6rDOxrwujQdx9rJT1CQhuJzRhKWAiShQRzyZ2pAKDOw7XDbM8TxT2Qnsa2UjbJ1Jvyo
         ns2wz8D1vxYNt6EPVK/grbb132OL6f2FtrAGlr406cXXo0nwDBm4QLn9Wbjpj9DuUWGs
         8ZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716346038; x=1716950838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ip97ZryjgvDw0E3emd452VFF721rwhMu9VSqnkvJOKA=;
        b=aGUA3X9w59G+iV1J3I3AU6Zku3Zsf6H1Y0ldeVVvlUnF1pFTF7NGZT4arAWSdfu6Y/
         S0xA3/rs3XndJ6yYELMPWeky5yWKMdx1RydMZYd6tP1L4iRIo4yUtu0HAPnbbtXF7Nlq
         N9vwwskcUnSnnrXZDXHnR6XcSkrCKOjKs2kI+kdPL1X+8kArg2WXfEylnR6mpvB02Ana
         9WSlt5Nv9RZnJ7pvVXeOvubJ8AlYWKvdDlz2rKNtPBicjJaZuJNoHGXFyF4GPbuiLxBu
         zzNd0UUACUc/Ii5Sr5ItMX4YVXBJ+zByAQQnFAjZfrojfpd/UM2CXE5GR0l9k/7/A9AN
         +R/w==
X-Gm-Message-State: AOJu0YxWcTi4Lu1wqfKXIyKXmwUGHxdaT9o9u3fEgmGKMu3iTvCSMSiW
	+MoVz3myHVll5HCbg+tZS1Ol8/a17So7Ei/gR5zx8zJohitBPHD4Ll7G6g==
X-Google-Smtp-Source: AGHT+IENtx68chO53RMB//cq/A6ZQvMBOOAescZvUjFvatvsZRItG99ptnWncwrNBRYnEnLvxCejfg==
X-Received: by 2002:a17:902:da8d:b0:1f2:f7ff:96af with SMTP id d9443c01a7336-1f31c9f4ef0mr7999245ad.69.1716346037663;
        Tue, 21 May 2024 19:47:17 -0700 (PDT)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::5:acf5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c035c42sm227846255ad.187.2024.05.21.19.47.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 May 2024 19:47:17 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf-next] bpf: Relax precision marking in open coded iters and may_goto loop.
Date: Tue, 21 May 2024 19:47:13 -0700
Message-Id: <20240522024713.59136-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Motivation for the patch
------------------------
Open coded iterators and may_goto is a great mechanism to implement loops,
but counted loops are problematic. For example:
  for (i = 0; i < 100 && can_loop; i++)
is verified as a bounded loop, since i < 100 condition forces the verifier
to mark 'i' as precise and loop states at different iterations are not equivalent.
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

This should be correct, since reaching the same insn should
satisfy "if h1 in path" requirement of update_loop_entry() algorithm.
It's too conservative to update loop_entry only on a state match.

With that the get_loop_entry() can be used to gate is_branch_taken() logic.
When 'if (i < 1000)' is done within open coded iterator or in a loop with may_goto
don't invoke is_branch_taken() logic.
When it's skipped don't do reg_bounds_sanity_check(), since it will surely
see range violations.

Now, consider progs/iters_task_vma.c that has the following logic:
    bpf_for_each(...) {
       if (i > 1000)
          break;

       arr[i] = ..;
    }

Skipping precision mark at if (i > 1000) keeps 'i' imprecise,
but arr[i] will mark 'i' as precise anyway, because 'arr' is a map.
On the next iteration of the loop the patch does copy_precision()
that copies precision markings for top of the loop into next state
of the loop. So on the next iteration 'i' will be seen as precise.

Hence the key part of the patch:
-       pred = is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
+       if (!get_loop_entry(this_branch) || src_reg->precise || dst_reg->precise ||
+           (BPF_SRC(insn->code) == BPF_K && insn->imm == 0))
+               pred = is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);

!get_loop_entry(this_branch) -> if not inside open coded iter keep
  existing is_branch_taken() logic, since bounded loop relies on it.

src_reg->precise || dst_reg->precise -> if later inside the loop the 'i' was
  actually marked as precise then we have to do is_branch_taken() and above
  bpf_for_each() will be verified as a bounded loop checking all 1000
  iterations. Otherwise we will keep incrementing 'i' and it will eventually
  get out of bounds in arr[i] and the verifier will reject such memory access.

BPF_SRC(insn->code) == BPF_K && insn->imm == 0 -> if it's a check for
  an exit condition from open coded iterator then do is_branch_taken() as well.
  Otherwise all open coded iterators won't work.

Now consider the same example:
    bpf_for_each(...) {
       if (i > 1000)
          break;

       arr[i] = ..;
    }
but 'arr' is an arena pointer. In this case 'i > 1000' will keep 'i' as
imprecise and arr[i] will keep it as imprecise as well.
And the whole loop will be verified with open coded iterator logic.

Now the following works:
-       for (i = zero; i < 1000; i++)
+       for (i = 0; i < 100000 && can_loop; i++) {
                htab_update_elem(htab, i, i);
+               arr[i] = i; // either arr1 or arr2
+       }
+char __arena arr1[100000]; /* works */
+char arr2[100000]; /* runs into 1M limit */

So the users can now use 'for (i = 0;...' pattern everywhere and
the verifier will fall back to bounded loop logic and precise 'i'
when 'i' is used in map-style memory access.
For arena based algorithms 'i' will stay imprecise.

-       for (i = zero; i < ARR_SZ && can_loop; i++)
+       /* i = 0 is ok here, since i is not used in memory access */
+       for (i = 0; i < ARR_SZ && can_loop; i++)
                sum += i;
+
+       /* have to use i = zero due to arr[i] where arr is not an arena */
        for (i = zero; i < ARR_SZ; i++) {
                barrier_var(i);
                sum += i + arr[i];

and i = zero workaround in iter_obfuscate_counter() can be removed.

copy_precision() is a hack, of course, to demonstrate an idea.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c                         | 94 +++++++++++++++++--
 .../testing/selftests/bpf/progs/arena_htab.c  | 11 ++-
 tools/testing/selftests/bpf/progs/iters.c     | 18 +---
 .../bpf/progs/verifier_iterating_callbacks.c  | 17 ++--
 4 files changed, 112 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 77da1f438bec..7a1606ccf692 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14882,7 +14882,7 @@ static int reg_set_min_max(struct bpf_verifier_env *env,
 			   struct bpf_reg_state *true_reg2,
 			   struct bpf_reg_state *false_reg1,
 			   struct bpf_reg_state *false_reg2,
-			   u8 opcode, bool is_jmp32)
+			   u8 opcode, bool is_jmp32, bool ignore_bad_range)
 {
 	int err;
 
@@ -14903,6 +14903,8 @@ static int reg_set_min_max(struct bpf_verifier_env *env,
 	reg_bounds_sync(true_reg1);
 	reg_bounds_sync(true_reg2);
 
+	if (ignore_bad_range)
+		return 0;
 	err = reg_bounds_sanity_check(env, true_reg1, "true_reg1");
 	err = err ?: reg_bounds_sanity_check(env, true_reg2, "true_reg2");
 	err = err ?: reg_bounds_sanity_check(env, false_reg1, "false_reg1");
@@ -15177,7 +15179,11 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	}
 
 	is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
-	pred = is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
+	if (!get_loop_entry(this_branch) || src_reg->precise || dst_reg->precise ||
+	    (BPF_SRC(insn->code) == BPF_K && insn->imm == 0))
+		pred = is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
+	else
+		pred = -2;
 	if (pred >= 0) {
 		/* If we get here with a dst_reg pointer type it is because
 		 * above is_branch_taken() special cased the 0 comparison.
@@ -15229,13 +15235,13 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		err = reg_set_min_max(env,
 				      &other_branch_regs[insn->dst_reg],
 				      &other_branch_regs[insn->src_reg],
-				      dst_reg, src_reg, opcode, is_jmp32);
+				      dst_reg, src_reg, opcode, is_jmp32, pred == -2);
 	} else /* BPF_SRC(insn->code) == BPF_K */ {
 		err = reg_set_min_max(env,
 				      &other_branch_regs[insn->dst_reg],
 				      src_reg /* fake one */,
 				      dst_reg, src_reg /* same fake one */,
-				      opcode, is_jmp32);
+				      opcode, is_jmp32, pred == -2);
 	}
 	if (err)
 		return err;
@@ -17217,6 +17223,81 @@ static int propagate_precision(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static void __copy_precision(struct bpf_verifier_env *env,
+			     struct bpf_verifier_state *cur,
+			     const struct bpf_verifier_state *old)
+{
+	struct bpf_reg_state *state_reg;
+	struct bpf_func_state *state, *cur_fr;
+	int i, fr;
+	bool first;
+
+	for (fr = min(cur->curframe, old->curframe); fr >= 0; fr--) {
+		state = old->frame[fr];
+		cur_fr = cur->frame[fr];
+		state_reg = state->regs;
+		first = true;
+		verbose(env, "XX old state:");
+		print_verifier_state(env, state, true);
+		for (i = 0; i < BPF_REG_FP; i++, state_reg++) {
+			if (state_reg->type != SCALAR_VALUE ||
+			    !state_reg->precise ||
+			    !(state_reg->live & REG_LIVE_READ))
+				continue;
+			if (env->log.level & BPF_LOG_LEVEL2) {
+				if (first)
+					verbose(env, "XX frame %d: propagating r%d", fr, i);
+				else
+					verbose(env, ",r%d", i);
+			}
+			cur_fr->regs[i].precise = true;
+			first = false;
+		}
+
+		for (i = 0; i < min(cur_fr->allocated_stack, state->allocated_stack) / BPF_REG_SIZE; i++) {
+			if (!is_spilled_reg(&state->stack[i]))
+				continue;
+			state_reg = &state->stack[i].spilled_ptr;
+			if (state_reg->type != SCALAR_VALUE ||
+			    !state_reg->precise ||
+			    !(state_reg->live & REG_LIVE_READ))
+				continue;
+			if (env->log.level & BPF_LOG_LEVEL2) {
+				if (first)
+					verbose(env, "XX frame %d: propagating fp%d",
+						fr, (-i - 1) * BPF_REG_SIZE);
+				else
+					verbose(env, ",fp%d", (-i - 1) * BPF_REG_SIZE);
+			}
+			cur_fr->stack[i].spilled_ptr.precise = true;
+			first = false;
+		}
+		if (!first)
+			verbose(env, "\n");
+	}
+}
+
+static void copy_precision(struct bpf_verifier_env *env,
+			   struct bpf_verifier_state *cur,
+			   const struct bpf_verifier_state *old)
+{
+	if (!old)
+		return;
+	/*
+	 * parent state unlikely to have precise registers
+	 * due to mark_all_scalars_imprecise(), but let's try anyway.
+	 */
+	__copy_precision(env, cur, old);
+	old = old->parent;
+	if (!old)
+		return;
+	/*
+	 * This one might have precise scalars, since precision propagation
+	 * from array access will mark them in the parent.
+	 */
+	__copy_precision(env, cur, old);
+}
+
 static bool states_maybe_looping(struct bpf_verifier_state *old,
 				 struct bpf_verifier_state *cur)
 {
@@ -17409,6 +17490,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * => unsafe memory access at 11 would not be caught.
 			 */
 			if (is_iter_next_insn(env, insn_idx)) {
+				update_loop_entry(cur, &sl->state);
 				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
 					struct bpf_func_state *cur_frame;
 					struct bpf_reg_state *iter_state, *iter_reg;
@@ -17426,15 +17508,14 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 					spi = __get_spi(iter_reg->off + iter_reg->var_off.value);
 					iter_state = &func(env, iter_reg)->stack[spi].spilled_ptr;
 					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE) {
-						update_loop_entry(cur, &sl->state);
 						goto hit;
 					}
 				}
 				goto skip_inf_loop_check;
 			}
 			if (is_may_goto_insn_at(env, insn_idx)) {
+				update_loop_entry(cur, &sl->state);
 				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
-					update_loop_entry(cur, &sl->state);
 					goto hit;
 				}
 				goto skip_inf_loop_check;
@@ -18066,6 +18147,7 @@ static int do_check(struct bpf_verifier_env *env)
 						return err;
 					break;
 				} else {
+					copy_precision(env, env->cur_state, env->cur_state->parent);
 					do_print_state = true;
 					continue;
 				}
diff --git a/tools/testing/selftests/bpf/progs/arena_htab.c b/tools/testing/selftests/bpf/progs/arena_htab.c
index 1e6ac187a6a0..ac45700ca5ad 100644
--- a/tools/testing/selftests/bpf/progs/arena_htab.c
+++ b/tools/testing/selftests/bpf/progs/arena_htab.c
@@ -18,24 +18,31 @@ void __arena *htab_for_user;
 bool skip = false;
 
 int zero = 0;
+char __arena arr1[100000]; /* works */
+char arr2[100000]; /* runs into 1M limit */
 
 SEC("syscall")
 int arena_htab_llvm(void *ctx)
 {
 #if defined(__BPF_FEATURE_ADDR_SPACE_CAST) || defined(BPF_ARENA_FORCE_ASM)
 	struct htab __arena *htab;
+	char __arena *arr = arr1;
 	__u64 i;
 
 	htab = bpf_alloc(sizeof(*htab));
 	cast_kern(htab);
 	htab_init(htab);
 
+	cast_kern(arr);
+
 	/* first run. No old elems in the table */
-	for (i = zero; i < 1000; i++)
+	for (i = 0; i < 100000 && can_loop; i++) {
 		htab_update_elem(htab, i, i);
+		arr[i] = i;
+	}
 
 	/* should replace all elems with new ones */
-	for (i = zero; i < 1000; i++)
+	for (i = 0; i < 100000 && can_loop; i++)
 		htab_update_elem(htab, i, i);
 	cast_user(htab);
 	htab_for_user = htab;
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index fe65e0952a1e..dfc2c9cc0529 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -188,6 +188,8 @@ int iter_pragma_unroll_loop(const void *ctx)
 	for (i = 0; i < 3; i++) {
 		v = bpf_iter_num_next(&it);
 		bpf_printk("ITER_BASIC: E3 VAL: i=%d v=%d", i, v ? *v : -1);
+		if (!v)
+			break;
 	}
 	bpf_iter_num_destroy(&it);
 
@@ -243,6 +245,8 @@ int iter_multiple_sequential_loops(const void *ctx)
 	for (i = 0; i < 3; i++) {
 		v = bpf_iter_num_next(&it);
 		bpf_printk("ITER_BASIC: E3 VAL: i=%d v=%d", i, v ? *v : -1);
+		if (!v)
+			break;
 	}
 	bpf_iter_num_destroy(&it);
 
@@ -291,10 +295,7 @@ int iter_obfuscate_counter(const void *ctx)
 {
 	struct bpf_iter_num it;
 	int *v, sum = 0;
-	/* Make i's initial value unknowable for verifier to prevent it from
-	 * pruning if/else branch inside the loop body and marking i as precise.
-	 */
-	int i = zero;
+	int i = 0;
 
 	MY_PID_GUARD();
 
@@ -304,15 +305,6 @@ int iter_obfuscate_counter(const void *ctx)
 
 		i += 1;
 
-		/* If we initialized i as `int i = 0;` above, verifier would
-		 * track that i becomes 1 on first iteration after increment
-		 * above, and here verifier would eagerly prune else branch
-		 * and mark i as precise, ruining open-coded iterator logic
-		 * completely, as each next iteration would have a different
-		 * *precise* value of i, and thus there would be no
-		 * convergence of state. This would result in reaching maximum
-		 * instruction limit, no matter what the limit is.
-		 */
 		if (i == 1)
 			x = 123;
 		else
diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index bd676d7e615f..bd45a328fa85 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -318,8 +318,11 @@ int cond_break1(const void *ctx)
 	unsigned long i;
 	unsigned int sum = 0;
 
-	for (i = zero; i < ARR_SZ && can_loop; i++)
+	/* i = 0 is ok here, since i is not used in memory access */
+	for (i = 0; i < ARR_SZ && can_loop; i++)
 		sum += i;
+
+	/* have to use i = zero due to arr[i] where arr is not an arena */
 	for (i = zero; i < ARR_SZ; i++) {
 		barrier_var(i);
 		sum += i + arr[i];
@@ -336,8 +339,8 @@ int cond_break2(const void *ctx)
 	int i, j;
 	int sum = 0;
 
-	for (i = zero; i < 1000 && can_loop; i++)
-		for (j = zero; j < 1000; j++) {
+	for (i = 0; i < 1000 && can_loop; i++)
+		for (j = 0; j < 1000; j++) {
 			sum += i + j;
 			cond_break;
 	}
@@ -348,7 +351,7 @@ static __noinline int loop(void)
 {
 	int i, sum = 0;
 
-	for (i = zero; i <= 1000000 && can_loop; i++)
+	for (i = 0; i <= 1000000 && can_loop; i++)
 		sum += i;
 
 	return sum;
@@ -365,7 +368,7 @@ SEC("socket")
 __success __retval(1)
 int cond_break4(const void *ctx)
 {
-	int cnt = zero;
+	int cnt = 0;
 
 	for (;;) {
 		/* should eventually break out of the loop */
@@ -378,7 +381,7 @@ int cond_break4(const void *ctx)
 
 static __noinline int static_subprog(void)
 {
-	int cnt = zero;
+	int cnt = 0;
 
 	for (;;) {
 		cond_break;
@@ -392,7 +395,7 @@ SEC("socket")
 __success __retval(1)
 int cond_break5(const void *ctx)
 {
-	int cnt1 = zero, cnt2;
+	int cnt1 = 0, cnt2;
 
 	for (;;) {
 		cond_break;
-- 
2.43.0


