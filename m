Return-Path: <bpf+bounces-30368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 797458CCC64
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 08:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6711F217BE
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 06:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6220C13C679;
	Thu, 23 May 2024 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDPeYl05"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2877D13C677
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 06:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716446545; cv=none; b=IuabEqJIcOTtWO1rQbWmpM0G/ZkmggguIs6aW6wr2A/TCMBfolvg8cljua1iKd7aVq9tx0CSciWUy3qxKkJzP6qOHTYSQgMHkGwe5/GLsUe1ICHJ0wiRs71C+Bqk/LhE3o7TEyD2QpSVu63R/DrrmdCUuBvJZmfTL59DsulN+9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716446545; c=relaxed/simple;
	bh=0mK4xBe1tGtC+K+AKp3Rco1tbt333Y1OlenwWVDTrsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ACvQAkxyB//3U2V3h5+iXOZGiNhcL8Cy0gamS1RzaMqsfRJeOvfLzApBuLoA04DHfOu4HRCrY7/lVwFpgmqZppHrqOnypprdiE5c/tMaZn3FPP/HnJGdmtSwyl7yGsmM+RD3lCrFU99rqNdauqF2cxrf+UAyUfDuGvIDeeKg728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDPeYl05; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f32448e8fbso11007135ad.1
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 23:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716446543; x=1717051343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v5p3ZEF2d4SCHisWfQuv4Q8T1NQIp6pmQK/IANUXNNI=;
        b=VDPeYl05sioW4AHeSdZMqLRmQvZsPf8BA0s4dRpxHxMhJeh0I4NIzy386yTc6gvhRP
         NLWLAGQ0iyeAAuMUkPX1rzW4RXmkKp59RtppZLJuPbLjmQcbzfhJ61YjeW9zxQVh9w3P
         fGa9hOlB3/kmDS+v5+NpNMjdgta5wV4mxlIHXXqxyNWIlxnvBrMlWT1SNFLuXhVpgBbS
         YRYb50wnvFud3qnNr7xocFNMt3sBirms4K98ymegDSwGtLxz1yJ7LpxUfvbYfMLJ8R+c
         h/zCQDHGNl/5JiGSTVW7T0YCow/2ShTblif5PUAQ0or0gvPnfdhGVKGu/Y24ae3LnjNw
         V5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716446543; x=1717051343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5p3ZEF2d4SCHisWfQuv4Q8T1NQIp6pmQK/IANUXNNI=;
        b=YK4vFZzTiQ4jNKjollXQhFl0VInAjG+uc4RtDrLYErlUXRwM49RLTiRyO4s2wwS/8Q
         zq5+MA5yNigmO/0/HOCNDGMIl7m4ZybV+5kiD1dx010q3/1f6fO+K0RqcojTFcKPpplR
         H2mnSIs/JPrJhnwJYMJrdEr5+uAw/Gs/bhYGmmtrGSwBAtSUOcmE+gM7NB6yFPKfMA/l
         CxAaVap4BbE5+7R8SkblasnANfy5Vnxo70NXYvq0kGCuww2nBwwdZT65yre+aLUp8UQR
         gC7Wpophib1rsYiOj72DC48VS5/mCElSA0foGsxdE4Fiah7+GcHz1LWcAI7HgqB5QbD3
         ML7g==
X-Gm-Message-State: AOJu0Yx3JgK7RD8YW/mN85nAy/6vVTZaGzpGAbwiBasBL3jhTFZ56h5P
	1wGRUypCxaEyIw+G0VkyVeDYLYkbPyrOjSugxztTr45zngiroW60d/sbRQ==
X-Google-Smtp-Source: AGHT+IFn9Q7/9ZwZUfMu6gP9/AOs1sPSQ2T2HDKhi9gPgCTcM9hYWqmkI+9HN6HhRPJUwVjh/3JUUw==
X-Received: by 2002:a17:902:c794:b0:1f3:33ca:eecf with SMTP id d9443c01a7336-1f333caf12amr20661135ad.48.1716446542962;
        Wed, 22 May 2024 23:42:22 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:191d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad7dc1sm249606585ad.89.2024.05.22.23.42.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 May 2024 23:42:22 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next] bpf: Relax precision marking in open coded iters and may_goto loop.
Date: Wed, 22 May 2024 23:42:19 -0700
Message-Id: <20240523064219.42465-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v1->v2:
- Replaced copy precision logic with faster and more accurate alternative.
  See find_precision().
- Removed ignore_bad_range. Now is_branch_taken() logic is used
  to mark either false or true register as unknown.
  That keeps reg_bounds_sanity_check() functioning at jmp insn and later.
- Added a test similar to iter_task_vma_for_each, but more complext with
  a mix of arena and normal pointers.

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

It changes the definition of the verifier states loop.
Previously, we considered a state loop to be such a sequence of states
Si -> ... -> Sj -> ... -> Sk that states_equal(Si, Sk, RANGE_WITHIN)
is true.

With this change Si -> ... -> Sj -> ... Sk is a loop if call sites and
instruction pointers for Si and Sk match.

Whether or not Si and Sk are in the loop influences two things:
(a) if exact comparison is needed for states cache;
(b) if widening transformation could be applied to some scalars.

All pairs (Si, Sk) marked as a loop using old definition would be
marked as such using new definition (in a addition to some new pairs).

Hence it is safe to apply (a) and (b) in strictly more cases.

Note that update_loop_entry() relies on the following properties:
- every state in the current DFS path (except current)
  has branches > 0;
- states not in the DFS path are either:
  - in explored_states, are fully explored and have branches == 0;
  - in env->stack, are not yet explored and have branches == 0
    (and also not reachable from is_state_visited()).

With that the get_loop_entry() can be used to gate is_branch_taken() logic.
When 'if (i < 1000)' is done within open coded iterator or in a loop with
may_goto invokes is_branch_taken() logic, but still follows both branches. It
uses is_branch_taken()'s prediction to mark false or true register as unknown.

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
ignore_pred = !(!get_loop_entry(this_branch) || src_reg->precise ||
                dst_reg->precise ||
                (BPF_SRC(insn->code) == BPF_K && insn->imm == 0));

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
+               arr[i] = i; // when arr is arena
+       }
+char __arena arr1[100000]; /* works */
+char arr2[1000]; /* ok for small sizes */

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

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c                         | 76 +++++++++++++++----
 .../testing/selftests/bpf/progs/arena_htab.c  | 16 +++-
 tools/testing/selftests/bpf/progs/iters.c     | 18 ++---
 .../bpf/progs/verifier_iterating_callbacks.c  | 15 ++--
 4 files changed, 90 insertions(+), 35 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 77da1f438bec..8139bfb2425f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15107,7 +15107,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	struct bpf_reg_state *eq_branch_regs;
 	struct bpf_reg_state fake_reg = {};
 	u8 opcode = BPF_OP(insn->code);
-	bool is_jmp32;
+	bool is_jmp32, ignore_pred;
 	int pred = -1;
 	int err;
 
@@ -15177,8 +15177,12 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	}
 
 	is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
+	ignore_pred = !(!get_loop_entry(this_branch) || src_reg->precise ||
+			dst_reg->precise ||
+			(BPF_SRC(insn->code) == BPF_K && insn->imm == 0));
+
 	pred = is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
-	if (pred >= 0) {
+	if (pred >= 0 && !ignore_pred) {
 		/* If we get here with a dst_reg pointer type it is because
 		 * above is_branch_taken() special cased the 0 comparison.
 		 */
@@ -15191,6 +15195,14 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			return err;
 	}
 
+	if (pred < 0 || ignore_pred) {
+		other_branch = push_stack(env, *insn_idx + insn->off + 1, *insn_idx,
+					  false);
+		if (!other_branch)
+			return -EFAULT;
+		other_branch_regs = other_branch->frame[other_branch->curframe]->regs;
+	}
+
 	if (pred == 1) {
 		/* Only follow the goto, ignore fall-through. If needed, push
 		 * the fall-through branch for simulation under speculative
@@ -15202,8 +15214,13 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			return -EFAULT;
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch->frame[this_branch->curframe]);
-		*insn_idx += insn->off;
-		return 0;
+		if (ignore_pred) {
+			__mark_reg_unknown(env, dst_reg);
+			__mark_reg_unknown(env, src_reg);
+		} else {
+			*insn_idx += insn->off;
+			return 0;
+		}
 	} else if (pred == 0) {
 		/* Only follow the fall-through branch, since that's where the
 		 * program will go. If needed, push the goto branch for
@@ -15216,15 +15233,15 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			return -EFAULT;
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch->frame[this_branch->curframe]);
-		return 0;
+		if (ignore_pred) {
+			__mark_reg_unknown(env, &other_branch_regs[insn->dst_reg]);
+			if (BPF_SRC(insn->code) == BPF_X)
+				__mark_reg_unknown(env, &other_branch_regs[insn->src_reg]);
+		} else {
+			return 0;
+		}
 	}
 
-	other_branch = push_stack(env, *insn_idx + insn->off + 1, *insn_idx,
-				  false);
-	if (!other_branch)
-		return -EFAULT;
-	other_branch_regs = other_branch->frame[other_branch->curframe]->regs;
-
 	if (BPF_SRC(insn->code) == BPF_X) {
 		err = reg_set_min_max(env,
 				      &other_branch_regs[insn->dst_reg],
@@ -17217,6 +17234,38 @@ static int propagate_precision(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static void find_precise_reg(struct bpf_reg_state *cur_reg)
+{
+	struct bpf_reg_state *reg;
+
+	reg = cur_reg->parent;
+	while (reg && reg->type == SCALAR_VALUE) {
+		/*
+		 * propagate_liveness() might not have happened for this states yet.
+		 * Intermediate reg missing LIVE_READ mark is not an issue.
+		 */
+		if (reg->precise && (reg->live & REG_LIVE_READ)) {
+			cur_reg->precise = true;
+			break;
+		}
+		reg = reg->parent;
+	}
+}
+
+static void find_precision(struct bpf_verifier_state *cur_state)
+{
+	struct bpf_func_state *state;
+	struct bpf_reg_state *reg;
+
+	if (!get_loop_entry(cur_state))
+		return;
+	bpf_for_each_reg_in_vstate(cur_state, state, reg, ({
+		if (reg->type != SCALAR_VALUE || reg->precise)
+			continue;
+		find_precise_reg(reg);
+	}));
+}
+
 static bool states_maybe_looping(struct bpf_verifier_state *old,
 				 struct bpf_verifier_state *cur)
 {
@@ -17409,6 +17458,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * => unsafe memory access at 11 would not be caught.
 			 */
 			if (is_iter_next_insn(env, insn_idx)) {
+				update_loop_entry(cur, &sl->state);
 				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
 					struct bpf_func_state *cur_frame;
 					struct bpf_reg_state *iter_state, *iter_reg;
@@ -17426,15 +17476,14 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
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
@@ -18066,6 +18115,7 @@ static int do_check(struct bpf_verifier_env *env)
 						return err;
 					break;
 				} else {
+					find_precision(env->cur_state);
 					do_print_state = true;
 					continue;
 				}
diff --git a/tools/testing/selftests/bpf/progs/arena_htab.c b/tools/testing/selftests/bpf/progs/arena_htab.c
index 1e6ac187a6a0..e669db468c5a 100644
--- a/tools/testing/selftests/bpf/progs/arena_htab.c
+++ b/tools/testing/selftests/bpf/progs/arena_htab.c
@@ -18,25 +18,35 @@ void __arena *htab_for_user;
 bool skip = false;
 
 int zero = 0;
+char __arena arr1[100000]; /* works */
+char arr2[1000]; /* ok for small sizes */
 
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
 
-	/* should replace all elems with new ones */
-	for (i = zero; i < 1000; i++)
+	/* should replace some elems with new ones */
+	for (i = 0; i < 1000 && can_loop; i++) {
 		htab_update_elem(htab, i, i);
+		/* Access mem to make the verifier use bounded loop logic */
+		arr2[i] = i;
+	}
 	cast_user(htab);
 	htab_for_user = htab;
 #else
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
index bd676d7e615f..420fdb2c6845 100644
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


