Return-Path: <bpf+bounces-51656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB91DA36D95
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 12:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807191895887
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 11:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48AA1ACED7;
	Sat, 15 Feb 2025 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfGLH+MA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36C01A2385
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617481; cv=none; b=Ulq1TVYsQ2Ac7WNfkfl/R3GH3AdiRvMdeZGGP6xd6hBodSmNU0Ak2i3YLgZ46bneAHCBdF9EVRqgJIQoeY8NI5jAmWhWi37V1mqn82iwjP00939Pwh6xCunaTD68q1K0KYrJKiw69RsRJWZUwB6WjRdMMOcNjseNd3p6OZfFlsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617481; c=relaxed/simple;
	bh=+DfS+GyLbUJHdW/X64WkBKFCZRZg+hk/cJW8fdRccLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtVdawx+roqZmPT9DL5sC5Z6TsXtTI8uK3k3LVWGjCfORR7tvaz7Kn8FPPBSrCjm9fkm7CVC1nnMxfCFu4/bTSCwRbyAULEvnymFL8SR9rLTnE55p2uh/OeO8enWKK2/YSxWoS/6V1KxSzV8YRNSCxS/+GqyUeGazx42IDsPusA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfGLH+MA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220e83d65e5so39980485ad.1
        for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 03:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739617479; x=1740222279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gR0Ow73SgpQ9Ni07Z6IDcyMmHQIfl1OEhqIwDsg3G8=;
        b=nfGLH+MAdO+3qUsj3uPYtH0tOZnP+DiCMbkVZ8QA/pHNZ6dGAC+DQdSDgp+8kHbWS+
         7vgdmnaMSG9lIhhcYjzOhf41WEstU6dTB28Fz1boyGcewhVUTD5IeCJAOFjZgiP0sX3e
         23+1wqd501uIAG1MSi5twOpFRfnJvdhkPOOp3HkvXhttSPmC4Ctl+yVW6v46AS4WTbl5
         3h7uqx6fyYcah/M1t+8nQuwoTGWkbj0YYLYMFOUl+0tROaoAPKCHwJbwTogbZdj6pGdH
         GMrKEE37nTCe4aP1OAa2xCx2Tkl+b4L1G7+cVOxGMbCUPh0RD6XJ9gA553U/vyndhumz
         TVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739617479; x=1740222279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gR0Ow73SgpQ9Ni07Z6IDcyMmHQIfl1OEhqIwDsg3G8=;
        b=kmUWszndkjyX2QRRcrsalZRehRcJO0OwjqoC8hre4aPKYYKAn/9l1U3gUfzq1wBoZ4
         qUZMmJLYx88l5x4qPGVv/rjViM/UwROoy8vjacV4YBDO0U/ff7JavC9mUudjHseqyZNc
         /xbieOa8e0AtBKOljQe3p3ftXWKTVlWSoM0Cjhik7GJ/CRKqJiI7gJPCNLR/EIc44WHc
         ca7hARCKJQOyY09ILBXt2okPgaLfP7fQggIrbfYRhXpKv2qPjaASVTo8UkgJ29eyjMed
         v7I92WR734FTps+UBmgb/hi9UMK84038z/B3IXeujn3HI84Sztns+W6VyYojPDPSt8/B
         vdkA==
X-Gm-Message-State: AOJu0YxAno1dWN9rvPo9P/83Kap7dCxUh8n0klwIDpGwTwqmciWUEgXk
	3o/ZhWowg6xsvfAI4FQqSlN5UrYyxmhnIKPB1yqvcILV5KXZT9f23W89sA==
X-Gm-Gg: ASbGncsmBfEuhfXTeiWtnCIhcwzvT8z3adquoWlFly3THbpGk9UqsOPLEmgaT/bFak3
	tQmSAG9yXSpylpn6hPSOheaLpTfuGsNPmggxjGgLlZ6tyV4YZ5lCAO1LDfYfUWBYwp79RBJjuSd
	PFNHfW5UgH/5kdXqX3ui5tJt1fvH82jJG97/Wq7OA4eOLnBzMetn+rgeNd1KLfLlWeUZVCdGcA5
	57VXTwJbZFY9WKj3xiWAFedPV3ydGHSJ2opOGneqPxUGBwPskomJVihfeYyPwkMG3nhkzGYTsX5
	8IknNaZBrRI=
X-Google-Smtp-Source: AGHT+IFrjOBiaNW5fjL02+gyQaqCNKSpOeREIgajsD8+ZZvx+e7FUn8hZfPABlWN3rrSPCmIx4B+KA==
X-Received: by 2002:a05:6a20:9145:b0:1ee:6ec3:e824 with SMTP id adf61e73a8af0-1ee8cba0ff3mr5006380637.30.1739617478710;
        Sat, 15 Feb 2025 03:04:38 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326d58d4d0sm72435b3a.94.2025.02.15.03.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 03:04:38 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	patsomaru@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 09/10] bpf: free verifier states when they are no longer referenced
Date: Sat, 15 Feb 2025 03:04:00 -0800
Message-ID: <20250215110411.3236773-10-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215110411.3236773-1-eddyz87@gmail.com>
References: <20250215110411.3236773-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fixes from patches 1 and 3 are applied, Patrick Somaru reported
an increase in memory consumption for sched_ext iterator-based
programs hitting 1M instructions limit. For example, 2Gb VMs ran out
of memory while verifying a program. Similar behaviour could be
reproduced on current bpf-next master.

Here is an example of such program:

    /* verification completes if given 16G or RAM,
     * final env->free_list size is 369,960 entries.
     */
    SEC("raw_tp")
    __flag(BPF_F_TEST_STATE_FREQ)
    __success
    int free_list_bomb(const void *ctx)
    {
        volatile char buf[48] = {};
        unsigned i, j;

        j = 0;
        bpf_for(i, 0, 10) {
            /* this forks verifier state:
             * - verification of current path continues and
             *   creates a checkpoint after 'if';
             * - verification of forked path hits the
             *   checkpoint and marks it as loop_entry.
             */
            if (bpf_get_prandom_u32())
                asm volatile ("");
            /* this marks 'j' as precise, thus any checkpoint
             * created on current iteration would not be matched
             * on the next iteration.
             */
            buf[j++] = 42;
            j %= ARRAY_SIZE(buf);
        }
        asm volatile (""::"r"(buf));
        return 0;
    }

Memory consumption increased due to more states being marked as loop
entries and eventually added to env->free_list.

This commit introduces logic to free states from env->free_list during
verification. A state in env->free_list can be freed if:
- it has no child states;
- it is not used as a loop_entry.

This commit:
- updates bpf_verifier_state->used_as_loop_entry to be a counter
  that tracks how many states use this one as a loop entry;
- adds a function maybe_free_verifier_state(), which:
  - frees a state if its ->branches and ->used_as_loop_entry counters
    are both zero;
  - if the state is freed, state->loop_entry->used_as_loop_entry is
    decremented, and an attempt is made to free state->loop_entry.

In the example above, this approach reduces the maximum number of
states in the free list from 369,960 to 16,223.

However, this approach has its limitations. If the buf size in the
example above is modified to 64, state caching overflows: the state
for j=0 is evicted from the cache before it can be used to stop
traversal. As a result, states in the free list accumulate because
their branch counters do not reach zero.

The effect of this patch on the selftests looks as follows:

File                              Program                               Max free list (A)  Max free list (B)  Max free list (DIFF)
--------------------------------  ------------------------------------  -----------------  -----------------  --------------------
arena_list.bpf.o                  arena_list_add                                       17                  3         -14 (-82.35%)
bpf_iter_task_stack.bpf.o         dump_task_stack                                      39                  9         -30 (-76.92%)
iters.bpf.o                       checkpoint_states_deletion                          265                 89        -176 (-66.42%)
iters.bpf.o                       clean_live_states                                    19                  0        -19 (-100.00%)
profiler2.bpf.o                   tracepoint__syscalls__sys_enter_kill                102                  1        -101 (-99.02%)
profiler3.bpf.o                   tracepoint__syscalls__sys_enter_kill                144                  0       -144 (-100.00%)
pyperf600_iter.bpf.o              on_event                                             15                  0        -15 (-100.00%)
pyperf600_nounroll.bpf.o          on_event                                           1170               1158          -12 (-1.03%)
setget_sockopt.bpf.o              skops_sockopt                                        18                  0        -18 (-100.00%)
strobemeta_nounroll1.bpf.o        on_event                                            147                 83         -64 (-43.54%)
strobemeta_nounroll2.bpf.o        on_event                                            312                209        -103 (-33.01%)
strobemeta_subprogs.bpf.o         on_event                                            124                 86         -38 (-30.65%)
test_cls_redirect_subprogs.bpf.o  cls_redirect                                         15                  0        -15 (-100.00%)
timer.bpf.o                       test1                                                30                 15         -15 (-50.00%)

Measured using "do-not-submit" patches from here:
https://github.com/eddyz87/bpf/tree/get-loop-entry-hungup

Reported-by: Patrick Somaru <patsomaru@meta.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 14 +++---
 kernel/bpf/verifier.c        | 91 ++++++++++++++++++++++++++----------
 2 files changed, 75 insertions(+), 30 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 222f6af278ec..f920af30eb06 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -427,11 +427,6 @@ struct bpf_verifier_state {
 	bool active_rcu_lock;
 
 	bool speculative;
-	/* If this state was ever pointed-to by other state's loop_entry field
-	 * this flag would be set to true. Used to avoid freeing such states
-	 * while they are still in use.
-	 */
-	bool used_as_loop_entry;
 	bool in_sleepable;
 
 	/* first and last insn idx of this verifier state */
@@ -458,6 +453,11 @@ struct bpf_verifier_state {
 	u32 dfs_depth;
 	u32 callback_unroll_depth;
 	u32 may_goto_depth;
+	/* If this state was ever pointed-to by other state's loop_entry field
+	 * this flag would be set to true. Used to avoid freeing such states
+	 * while they are still in use.
+	 */
+	u32 used_as_loop_entry;
 };
 
 #define bpf_get_spilled_reg(slot, frame, mask)				\
@@ -499,7 +499,9 @@ struct bpf_verifier_state {
 struct bpf_verifier_state_list {
 	struct bpf_verifier_state state;
 	struct list_head node;
-	int miss_cnt, hit_cnt;
+	u32 miss_cnt;
+	u32 hit_cnt:31;
+	u32 in_free_list:1;
 };
 
 struct bpf_loop_inline_state {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1016481ea754..eadd404ab9ab 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1620,6 +1620,50 @@ static void free_verifier_state(struct bpf_verifier_state *state,
 		kfree(state);
 }
 
+/* struct bpf_verifier_state->{parent,loop_entry} refer to states
+ * that are in either of env->{expored_states,free_list}.
+ * In both cases the state is contained in struct bpf_verifier_state_list.
+ */
+static struct bpf_verifier_state_list *state_parent_as_list(struct bpf_verifier_state *st)
+{
+	if (st->parent)
+		return container_of(st->parent, struct bpf_verifier_state_list, state);
+	return NULL;
+}
+
+static struct bpf_verifier_state_list *state_loop_entry_as_list(struct bpf_verifier_state *st)
+{
+	if (st->loop_entry)
+		return container_of(st->loop_entry, struct bpf_verifier_state_list, state);
+	return NULL;
+}
+
+/* A state can be freed if it is no longer referenced:
+ * - is in the env->free_list;
+ * - has no children states;
+ * - is not used as loop_entry.
+ *
+ * Freeing a state can make it's loop_entry free-able.
+ */
+static void maybe_free_verifier_state(struct bpf_verifier_env *env,
+				      struct bpf_verifier_state_list *sl)
+{
+	struct bpf_verifier_state_list *loop_entry_sl;
+
+	while (sl && sl->in_free_list &&
+		     sl->state.branches == 0 &&
+		     sl->state.used_as_loop_entry == 0) {
+		loop_entry_sl = state_loop_entry_as_list(&sl->state);
+		if (loop_entry_sl)
+			loop_entry_sl->state.used_as_loop_entry--;
+		list_del(&sl->node);
+		free_verifier_state(&sl->state, false);
+		kfree(sl);
+		env->peak_states--;
+		sl = loop_entry_sl;
+	}
+}
+
 /* copy verifier state from src to dst growing dst stack space
  * when necessary to accommodate larger src stack
  */
@@ -1837,7 +1881,8 @@ static struct bpf_verifier_state *get_loop_entry(struct bpf_verifier_env *env,
 	return topmost;
 }
 
-static void update_loop_entry(struct bpf_verifier_state *cur, struct bpf_verifier_state *hdr)
+static void update_loop_entry(struct bpf_verifier_env *env,
+			      struct bpf_verifier_state *cur, struct bpf_verifier_state *hdr)
 {
 	/* The hdr->branches check decides between cases B and C in
 	 * comment for get_loop_entry(). If hdr->branches == 0 then
@@ -1846,13 +1891,20 @@ static void update_loop_entry(struct bpf_verifier_state *cur, struct bpf_verifie
 	 * no need to update cur->loop_entry.
 	 */
 	if (hdr->branches && hdr->dfs_depth < (cur->loop_entry ?: cur)->dfs_depth) {
+		if (cur->loop_entry) {
+			cur->loop_entry->used_as_loop_entry--;
+			maybe_free_verifier_state(env, state_loop_entry_as_list(cur));
+		}
 		cur->loop_entry = hdr;
-		hdr->used_as_loop_entry = true;
+		hdr->used_as_loop_entry++;
 	}
 }
 
 static void update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
 {
+	struct bpf_verifier_state_list *sl = NULL, *parent_sl;
+	struct bpf_verifier_state *parent;
+
 	while (st) {
 		u32 br = --st->branches;
 
@@ -1862,7 +1914,7 @@ static void update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifi
 		 * This is a part of 'case A' in get_loop_entry() comment.
 		 */
 		if (br == 0 && st->parent && st->loop_entry)
-			update_loop_entry(st->parent, st->loop_entry);
+			update_loop_entry(env, st->parent, st->loop_entry);
 
 		/* WARN_ON(br > 1) technically makes sense here,
 		 * but see comment in push_stack(), hence:
@@ -1872,7 +1924,12 @@ static void update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifi
 			  br);
 		if (br)
 			break;
-		st = st->parent;
+		parent = st->parent;
+		parent_sl = state_parent_as_list(st);
+		if (sl)
+			maybe_free_verifier_state(env, sl);
+		st = parent;
+		sl = parent_sl;
 	}
 }
 
@@ -18618,7 +18675,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 					spi = __get_spi(iter_reg->off + iter_reg->var_off.value);
 					iter_state = &func(env, iter_reg)->stack[spi].spilled_ptr;
 					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE) {
-						update_loop_entry(cur, &sl->state);
+						update_loop_entry(env, cur, &sl->state);
 						goto hit;
 					}
 				}
@@ -18627,7 +18684,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			if (is_may_goto_insn_at(env, insn_idx)) {
 				if (sl->state.may_goto_depth != cur->may_goto_depth &&
 				    states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
-					update_loop_entry(cur, &sl->state);
+					update_loop_entry(env, cur, &sl->state);
 					goto hit;
 				}
 			}
@@ -18700,7 +18757,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		force_exact = loop_entry && loop_entry->branches > 0;
 		if (states_equal(env, &sl->state, cur, force_exact ? RANGE_WITHIN : NOT_EXACT)) {
 			if (force_exact)
-				update_loop_entry(cur, loop_entry);
+				update_loop_entry(env, cur, loop_entry);
 hit:
 			sl->hit_cnt++;
 			/* reached equivalent register/stack state,
@@ -18749,24 +18806,10 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			/* the state is unlikely to be useful. Remove it to
 			 * speed up verification
 			 */
+			sl->in_free_list = true;
 			list_del(&sl->node);
-			if (sl->state.frame[0]->regs[0].live & REG_LIVE_DONE &&
-			    !sl->state.used_as_loop_entry) {
-				u32 br = sl->state.branches;
-
-				WARN_ONCE(br,
-					  "BUG live_done but branches_to_explore %d\n",
-					  br);
-				free_verifier_state(&sl->state, false);
-				kfree(sl);
-				env->peak_states--;
-			} else {
-				/* cannot free this state, since parentage chain may
-				 * walk it later. Add it for free_list instead to
-				 * be freed at the end of verification
-				 */
-				list_add(&sl->node, &env->free_list);
-			}
+			list_add(&sl->node, &env->free_list);
+			maybe_free_verifier_state(env, sl);
 		}
 	}
 
-- 
2.48.1


