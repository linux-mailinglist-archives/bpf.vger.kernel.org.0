Return-Path: <bpf+bounces-59934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F895AD094E
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4CD189FB59
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC492206AF;
	Fri,  6 Jun 2025 21:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdfGzlIi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134A2A31
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749243879; cv=none; b=QaUEFjOC/4d+RubgcpG+pzIvOTGVRCh6hy1PRvVPDF+bPl2DYMbqpINJqrql41LR1PnmtKJEXvro6huYA7afGpyTq01Txh687C+81fYtQifbRKFbRGD4vPvSDu3ebdbjFU9Lqu+RlkBgJT8YCvlqe13VzLKUmlK9Vrw9CbFOpig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749243879; c=relaxed/simple;
	bh=KTtEb4wagxL9vt7xP7Ce+dKRltTcbp2yXqUPNpwqBRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbvQ8dBB5TnRkRRIVDFXV6uj6fZCToysJC1iI40/7DDKWsIcoGSBJy/QMQpjW4UE6h6jeKZUmt5I/iTU7mnIoqLpUfnN1t2lT3oNts7Tgr5MK73SGKFEjVZHc2o05DGeTCxhtbFD/u3rL1JXz/QZUFIINFqIx16+TtlMZylMA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdfGzlIi; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742c73f82dfso2102798b3a.2
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 14:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749243877; x=1749848677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdoaYPBbQboKH/t6N9Ka5npmEZo+1P2bF4p/641jhzU=;
        b=AdfGzlIiYXB2wddrOUL7pG+PCAk6h7YGCodIKwJLlFxwulQgHXKa87ssrnbTdj6WiH
         9AaVDJTXAfe0L9uqNKw5xtzlr/kDtKFbiXUDZmv1o6nqZe+PS/RT5w7Gpk6Youq6uQuF
         GaCgc1VSjKgeFOOp/4+KKFQrLUME5kmndhWsW8s8mbURjxKOvfMQrdx1AGTVO0Z8TIRI
         IzFs1PaD3xPsNaJYo74o+XwPEt9C6f7v5mWpRFD5Se90ycX9dj8orHPmp3cMKA9aKa3s
         7C1SVd5012d3rPxOMq2edQzAmIv8NM+mo9nHw4ddm7fMh/xjNQhzuxsUOsbgEd35D7bW
         Ii3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749243877; x=1749848677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdoaYPBbQboKH/t6N9Ka5npmEZo+1P2bF4p/641jhzU=;
        b=hqNIlA7YWk69FMvBjGCb2hIopvwdA3KFKDpSJBX/k8HO7tCIpUD0crt4PY9A7aD+hL
         WAljb3xI0inIPRGs/5zIf60HIqNS775fuiCnAX735eUB1RWGN2/FBDeyyraRVNVqNVQV
         Cbw9eHKC90pkIqLBpF3SM73yrrc514Suo5bHvf5OMIIyf9Rzd4rsnM4K3WiH3nqsacOU
         8vLVWBWh4F8g05QhD3jUiZCNrj9sao7IZ0PeNkK6zfzk77e73MHf/mvxrwcdmbrhVBcm
         YTC20PVc6gaH+rx2WN6sy08cE2CqeNcDDKdc0dJUly6VwVqJ2f7upjZSYxKIk0WtvuKW
         Umfw==
X-Gm-Message-State: AOJu0YzVU0mj40kk1MSYM7u8LBefV3yajGrgrkm23C2d6M9ALjUmb8Q6
	W0ZpX963FN3EIaIp5+PU/v9TcRUns6Nqq4L+ooHbfPSLc5vLi+QfvFtjb66KwSnM
X-Gm-Gg: ASbGnctJ5upUQk7aokddhJHa6mcjvxCuLaBUVHO6+fkim2npfQFDWj0VLdAa1ujAwvv
	BqOU7D8Rw5WarXFK9NT8fkWvtlZSGIFsfun44rDqLX925+E3VtCzFnsrf75uUdiBz57WT0CEEUE
	udJy5AtNCw8iB9aDCUJZP1DTn0CeR6IH017Neohs8yHevDRHBtBJmmvi5gAmS6FY3eyWIaPmVaG
	ARh2b7FRgeR6DrDP7qT7Q99CgrPbp2cEaMhO0NE12axsB9ge3vDTNU8kWaCPX+I5PAsDlxxsR/b
	lJG9yUkYHU810mhVMflYt4sGz88qX1LiPN1QcXdET3zfQsbe2GsX7l9T9kqIrzHjz4HP
X-Google-Smtp-Source: AGHT+IHbuSk+FXgIK49/ybj8ynLvQGho0iodGcwJUUZS1rv749P22Coe2BBlNyo462PwtkI/1EEvAA==
X-Received: by 2002:a05:6a00:b85:b0:748:3a1a:ba72 with SMTP id d2e1a72fcca58-7483a1acfdamr110719b3a.20.1749243877112;
        Fri, 06 Jun 2025 14:04:37 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5ed58beasm1352640a12.15.2025.06.06.14.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 14:04:36 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 09/11] bpf: remove {update,get}_loop_entry functions
Date: Fri,  6 Jun 2025 14:03:50 -0700
Message-ID: <20250606210352.1692944-10-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606210352.1692944-1-eddyz87@gmail.com>
References: <20250606210352.1692944-1-eddyz87@gmail.com>
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
index 5190d71bd8fb..06848291ed21 100644
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
index 9a5af34f5917..6cf3a9654e91 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1681,7 +1681,7 @@ static void free_verifier_state(struct bpf_verifier_state *state,
 		kfree(state);
 }
 
-/* struct bpf_verifier_state->{parent,loop_entry} refer to states
+/* struct bpf_verifier_state->parent refers to states
  * that are in either of env->{expored_states,free_list}.
  * In both cases the state is contained in struct bpf_verifier_state_list.
  */
@@ -1692,22 +1692,12 @@ static struct bpf_verifier_state_list *state_parent_as_list(struct bpf_verifier_
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
@@ -1764,9 +1754,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->last_insn_idx = src->last_insn_idx;
 	dst_state->dfs_depth = src->dfs_depth;
 	dst_state->callback_unroll_depth = src->callback_unroll_depth;
-	dst_state->used_as_loop_entry = src->used_as_loop_entry;
 	dst_state->may_goto_depth = src->may_goto_depth;
-	dst_state->loop_entry = src->loop_entry;
 	dst_state->equal_state = src->equal_state;
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
@@ -1810,157 +1798,6 @@ static bool same_callsites(struct bpf_verifier_state *a, struct bpf_verifier_sta
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
2.48.1


