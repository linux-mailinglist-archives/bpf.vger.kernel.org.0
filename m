Return-Path: <bpf+bounces-60380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA32AD5FDA
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 22:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BD83A90C4
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 20:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1656D2BE7A1;
	Wed, 11 Jun 2025 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdZwdPeR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBC32874F9
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672548; cv=none; b=EIOpciYs5RnnSh8PLbhYzIQ0qpHxsItkgbY4lr+pmrpEPClUbBNKAGwsi4gCJFktiLTcyctxkxxyz9Xca93PqjiG26uAO9fnMxRMcujSWaSdkJDHzaf4p46pUTP/SxsHwf/bA9JALTgCL/6FAtX34cP86E7z7rKJhk8Fju08Rgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672548; c=relaxed/simple;
	bh=NAOqTPROO6rSRo3d8DaJ3wVyXuKhBc0XcNEBs6KmPSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzA/LQNZpwxoe29kpV7G2/ml1W/7yHrtwlEZu8N26rTVgY/wTg4PX66PgzqB6TW9IAfRCzS1filKHrLTC/RbsbPHJDPb/i0Y5TdK/OkdwhJyd4pnS9eMjSaRcqr10vqKEG3pEBqUNTIYxvSnbPVmSVNX08wFhgXxr5z/RJZBPrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdZwdPeR; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e81cf6103a6so201821276.3
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 13:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749672546; x=1750277346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SSdp+mwJdY2aB9Le/kxjjsyoC2lrvaUwCcmMdzCQhg=;
        b=RdZwdPeRhLYgMI5MdOpuLHz5smFfp4u1rdEtB8tf62gL4aH/j61xVleR8E5IMu879D
         EHTmBRzUdfuWj/JB64agGg/LxMgbC1q4hvCY9jUusQBtXgFw+IQ+Bfcek8TC8Y98DQU/
         1cQi0Hl/tbzUrIMsofHU7OF+S+fIpW5sjTwEtD5Z540d5WLEm7YPmUciBHs7cGBdSN1i
         XtlTgMWHeZ9SENt9r6TJqLFoVOrBwv3u8H1rjP8rtUZdVHdP8hQXvgVJLnpHPJxCamKs
         oPMAFQZu08PBpLnsN1CWwD9PZT14alqgq2AiYqZIjKHIsZvtGgNJt2H+AHPISGpzNc2M
         UWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749672546; x=1750277346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SSdp+mwJdY2aB9Le/kxjjsyoC2lrvaUwCcmMdzCQhg=;
        b=m4OXVvFQwMTdAIShfLaWv+oj9FEiM97Jznfdvr8vgBRHope3Z+y8vE8bskZfPB7diB
         S3KPrelkNHa50VykDGZZ1NVZ7x5DbKtrahZpQJpKvKRYeqmefYFq87mr9Hhnhbc5Ry8E
         2ouVOAXsOA1qZKp+2G6qYFQvO+XMGP6LxeLLCHvufPFzzFU938YVysntRuWIGCq/R3l6
         r89O3fKdojYppMNKnerxpjPfUce8eEagkiTmAqjjdgx5e5hnbn+pCba0J1Gir3oP4xRX
         +Wo/pFKD22KjPjp/421YYY6tEgiRKHQSs1EcQo7fgv9TwaS4MDDoNevSfx3XyGwNiq7+
         r0Gg==
X-Gm-Message-State: AOJu0YyJTqqYiMT9gWcjsfr0zkCArlng/Y5r4+tcZ7wcl+eXLRPRNQLF
	PfGgh3wZelSc2CO9sAWduPn9XhZbRkcQ1RtZJ0+XG/MXL850IKB6J2JdE1R1oR3D
X-Gm-Gg: ASbGnct30FihxGH+U0vORNnKAXm9PmYrN7AYL25opeOJ4CzBe+5SuqCCiMmj/V9WQmh
	ThuHe5zlD2KVGlZksbbt+3JFgXX1aT5AEv5ZRy2RVXQbWSTjfvxyvfEinnCSZaTmWfmj5/sjCKh
	UYIQLGpaguU9o65vVyhGE9WQXMCYog1AH3KfwOvIAZiHd9sMA/KGdOh6sA6BZZCT+fO/Q4pkZHz
	8aGiFWPFs1n/PSAnLGmrBIjQSm0Nk8aSnZCmOQGMKC39gQhlZTG4m6zo9HvdvdnMe8mOJ18yS3A
	f6174Qpc2WZHgnygo9zljGl3gCDr6pSQ2Vx5MBKFfeunTos6PgOofg==
X-Google-Smtp-Source: AGHT+IE1qz26piqKsUF/5R9Ql9sbqS4Bzv1Hlw9mzuPjDIqcFwDVZFbAYaBiaHhZb/QBWhBjoAFX7w==
X-Received: by 2002:a05:6902:161b:b0:e7d:7e4a:24db with SMTP id 3f1490d57ef6-e820b65cca0mr1308848276.9.1749672545582;
        Wed, 11 Jun 2025 13:09:05 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e820e06b3c6sm20587276.16.2025.06.11.13.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 13:09:05 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v3 09/11] bpf: remove {update,get}_loop_entry functions
Date: Wed, 11 Jun 2025 13:08:34 -0700
Message-ID: <20250611200836.4135542-9-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250611200836.4135542-1-eddyz87@gmail.com>
References: <20250611200836.4135542-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous patch switched read and precision tracking for
iterator-based loops from state-graph-based loop tracking to
control-flow-graph-based loop tracking.

This patch removes the now-unused `update_loop_entry()` and
`get_loop_entry()` functions, which were part of the state-graph-based
logic.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  15 ----
 kernel/bpf/verifier.c        | 165 +----------------------------------
 2 files changed, 1 insertion(+), 179 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b0273f759589..1ae588679e20 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -449,16 +449,6 @@ struct bpf_verifier_state {
 	/* first and last insn idx of this verifier state */
 	u32 first_insn_idx;
 	u32 last_insn_idx;
-	/* If this state is a part of states loop this field points to some
-	 * parent of this state such that:
-	 * - it is also a member of the same states loop;
-	 * - DFS states traversal starting from initial state visits loop_entry
-	 *   state before this state.
-	 * Used to compute topmost loop entry for state loops.
-	 * State loops might appear because of open coded iterators logic.
-	 * See get_loop_entry() for more information.
-	 */
-	struct bpf_verifier_state *loop_entry;
 	/* if this state is a backedge state then equal_state
 	 * records cached state to which this state is equal.
 	 */
@@ -473,11 +463,6 @@ struct bpf_verifier_state {
 	u32 dfs_depth;
 	u32 callback_unroll_depth;
 	u32 may_goto_depth;
-	/* If this state was ever pointed-to by other state's loop_entry field
-	 * this flag would be set to true. Used to avoid freeing such states
-	 * while they are still in use.
-	 */
-	u32 used_as_loop_entry;
 };
 
 #define bpf_get_spilled_reg(slot, frame, mask)				\
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index aa1bb4be7b8b..48847f8da5b1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1682,7 +1682,7 @@ static void free_verifier_state(struct bpf_verifier_state *state,
 		kfree(state);
 }
 
-/* struct bpf_verifier_state->{parent,loop_entry} refer to states
+/* struct bpf_verifier_state->parent refers to states
  * that are in either of env->{expored_states,free_list}.
  * In both cases the state is contained in struct bpf_verifier_state_list.
  */
@@ -1693,22 +1693,12 @@ static struct bpf_verifier_state_list *state_parent_as_list(struct bpf_verifier_
 	return NULL;
 }
 
-static struct bpf_verifier_state_list *state_loop_entry_as_list(struct bpf_verifier_state *st)
-{
-	if (st->loop_entry)
-		return container_of(st->loop_entry, struct bpf_verifier_state_list, state);
-	return NULL;
-}
-
 static bool incomplete_read_marks(struct bpf_verifier_env *env,
 				  struct bpf_verifier_state *st);
 
 /* A state can be freed if it is no longer referenced:
  * - is in the env->free_list;
  * - has no children states;
- * - is not used as loop_entry.
- *
- * Freeing a state can make it's loop_entry free-able.
  */
 static void maybe_free_verifier_state(struct bpf_verifier_env *env,
 				      struct bpf_verifier_state_list *sl)
@@ -1765,9 +1755,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->last_insn_idx = src->last_insn_idx;
 	dst_state->dfs_depth = src->dfs_depth;
 	dst_state->callback_unroll_depth = src->callback_unroll_depth;
-	dst_state->used_as_loop_entry = src->used_as_loop_entry;
 	dst_state->may_goto_depth = src->may_goto_depth;
-	dst_state->loop_entry = src->loop_entry;
 	dst_state->equal_state = src->equal_state;
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
@@ -1811,157 +1799,6 @@ static bool same_callsites(struct bpf_verifier_state *a, struct bpf_verifier_sta
 	return true;
 }
 
-/* Open coded iterators allow back-edges in the state graph in order to
- * check unbounded loops that iterators.
- *
- * In is_state_visited() it is necessary to know if explored states are
- * part of some loops in order to decide whether non-exact states
- * comparison could be used:
- * - non-exact states comparison establishes sub-state relation and uses
- *   read and precision marks to do so, these marks are propagated from
- *   children states and thus are not guaranteed to be final in a loop;
- * - exact states comparison just checks if current and explored states
- *   are identical (and thus form a back-edge).
- *
- * Paper "A New Algorithm for Identifying Loops in Decompilation"
- * by Tao Wei, Jian Mao, Wei Zou and Yu Chen [1] presents a convenient
- * algorithm for loop structure detection and gives an overview of
- * relevant terminology. It also has helpful illustrations.
- *
- * [1] https://api.semanticscholar.org/CorpusID:15784067
- *
- * We use a similar algorithm but because loop nested structure is
- * irrelevant for verifier ours is significantly simpler and resembles
- * strongly connected components algorithm from Sedgewick's textbook.
- *
- * Define topmost loop entry as a first node of the loop traversed in a
- * depth first search starting from initial state. The goal of the loop
- * tracking algorithm is to associate topmost loop entries with states
- * derived from these entries.
- *
- * For each step in the DFS states traversal algorithm needs to identify
- * the following situations:
- *
- *          initial                     initial                   initial
- *            |                           |                         |
- *            V                           V                         V
- *           ...                         ...           .---------> hdr
- *            |                           |            |            |
- *            V                           V            |            V
- *           cur                     .-> succ          |    .------...
- *            |                      |    |            |    |       |
- *            V                      |    V            |    V       V
- *           succ                    '-- cur           |   ...     ...
- *                                                     |    |       |
- *                                                     |    V       V
- *                                                     |   succ <- cur
- *                                                     |    |
- *                                                     |    V
- *                                                     |   ...
- *                                                     |    |
- *                                                     '----'
- *
- *  (A) successor state of cur   (B) successor state of cur or it's entry
- *      not yet traversed            are in current DFS path, thus cur and succ
- *                                   are members of the same outermost loop
- *
- *                      initial                  initial
- *                        |                        |
- *                        V                        V
- *                       ...                      ...
- *                        |                        |
- *                        V                        V
- *                .------...               .------...
- *                |       |                |       |
- *                V       V                V       V
- *           .-> hdr     ...              ...     ...
- *           |    |       |                |       |
- *           |    V       V                V       V
- *           |   succ <- cur              succ <- cur
- *           |    |                        |
- *           |    V                        V
- *           |   ...                      ...
- *           |    |                        |
- *           '----'                       exit
- *
- * (C) successor state of cur is a part of some loop but this loop
- *     does not include cur or successor state is not in a loop at all.
- *
- * Algorithm could be described as the following python code:
- *
- *     traversed = set()   # Set of traversed nodes
- *     entries = {}        # Mapping from node to loop entry
- *     depths = {}         # Depth level assigned to graph node
- *     path = set()        # Current DFS path
- *
- *     # Find outermost loop entry known for n
- *     def get_loop_entry(n):
- *         h = entries.get(n, None)
- *         while h in entries:
- *             h = entries[h]
- *         return h
- *
- *     # Update n's loop entry if h comes before n in current DFS path.
- *     def update_loop_entry(n, h):
- *         if h in path and depths[entries.get(n, n)] < depths[n]:
- *             entries[n] = h1
- *
- *     def dfs(n, depth):
- *         traversed.add(n)
- *         path.add(n)
- *         depths[n] = depth
- *         for succ in G.successors(n):
- *             if succ not in traversed:
- *                 # Case A: explore succ and update cur's loop entry
- *                 #         only if succ's entry is in current DFS path.
- *                 dfs(succ, depth + 1)
- *                 h = entries.get(succ, None)
- *                 update_loop_entry(n, h)
- *             else:
- *                 # Case B or C depending on `h1 in path` check in update_loop_entry().
- *                 update_loop_entry(n, succ)
- *         path.remove(n)
- *
- * To adapt this algorithm for use with verifier:
- * - use st->branch == 0 as a signal that DFS of succ had been finished
- *   and cur's loop entry has to be updated (case A), handle this in
- *   update_branch_counts();
- * - use st->branch > 0 as a signal that st is in the current DFS path;
- * - handle cases B and C in is_state_visited().
- */
-static struct bpf_verifier_state *get_loop_entry(struct bpf_verifier_env *env,
-						 struct bpf_verifier_state *st)
-{
-	struct bpf_verifier_state *topmost = st->loop_entry;
-	u32 steps = 0;
-
-	while (topmost && topmost->loop_entry) {
-		if (verifier_bug_if(steps++ > st->dfs_depth, env, "infinite loop"))
-			return ERR_PTR(-EFAULT);
-		topmost = topmost->loop_entry;
-	}
-	return topmost;
-}
-
-static void update_loop_entry(struct bpf_verifier_env *env,
-			      struct bpf_verifier_state *cur, struct bpf_verifier_state *hdr)
-{
-	/* The hdr->branches check decides between cases B and C in
-	 * comment for get_loop_entry(). If hdr->branches == 0 then
-	 * head's topmost loop entry is not in current DFS path,
-	 * hence 'cur' and 'hdr' are not in the same loop and there is
-	 * no need to update cur->loop_entry.
-	 */
-	if (hdr->branches && hdr->dfs_depth < (cur->loop_entry ?: cur)->dfs_depth) {
-		if (cur->loop_entry) {
-			cur->loop_entry->used_as_loop_entry--;
-			maybe_free_verifier_state(env, state_loop_entry_as_list(cur));
-		}
-		cur->loop_entry = hdr;
-		hdr->used_as_loop_entry++;
-	}
-}
-
 /* Return IP for a given frame in a call stack */
 static u32 frame_insn_idx(struct bpf_verifier_state *st, u32 frame)
 {
-- 
2.47.1


