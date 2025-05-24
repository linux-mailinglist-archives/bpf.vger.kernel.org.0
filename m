Return-Path: <bpf+bounces-58901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56452AC3111
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 21:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B45317B951
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 19:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB17D1EBA19;
	Sat, 24 May 2025 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR77UUvE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9678E1F09B6
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748114398; cv=none; b=ZE0lII3ScRhMfxnn0R5MGWGfpJ62NfngBZ+xzvhI0RiNkIDyVyJQT4Q1pMzju3G9UliR7vp+p5cSEcX8B8oee6ucHM6ftCDbD+Gt6xiRAetrMlTW0CKLbkVLptblSkaMiOa5pC9dkL8wPZBpsPuR9K6bqo74ESJD6hj0amb6Gzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748114398; c=relaxed/simple;
	bh=0CUpxK+JdoWRAYjfOBIq8RQClwDhZk+fEgoaT0wiNlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbLe5/94agXUzC3/Ad5bSo7BUKkiaWevhUcAAutG7a+4MtfBIE0lgADvgDccx6q+nY20tYIUSToia4VqsGh8ITzPvDuHvRHcY1WZqIvokXlRGIjmg8ukARwcgZLp1lOLJqFZVrG0AKcNDiT0+oJoxYtUsaWOJz7JFARiL4ZFL6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IR77UUvE; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-742c035f2afso608051b3a.2
        for <bpf@vger.kernel.org>; Sat, 24 May 2025 12:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748114396; x=1748719196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXQ8YiHA9ZUkO+6JJmbwAmR/J7LrMM3GXV9cUQhJLEE=;
        b=IR77UUvElglwIUNbXjqWKUmoJBxyfhsGWWDLLKzYIuS3xShKDIQsqJTluMkW3nBADs
         CFg5oZg/2FAmOjvzOkjZYW02vsMr2QWm8ywnL3ZmDePxLyObM01KQA7dfUOjYS4tJUan
         8wYXX/qi0ppmuAyF5LZB9Wu1aavomVVTRYtxr87XJYSHraUxqnRPf4u6sacFKj1OKrw7
         JCpWQdHJsEQxaAiROnNPhiEiiEorKG+3AByCginiivzWwbBLRvpkw+/tL4uGkdqozZvw
         Q5jUD58ZIWXowetZU8IQ3zrnVV5OSNsxlUsGzewrD3a9zeTtJMK9nVuGTrtkDf3n7lx3
         WmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748114396; x=1748719196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXQ8YiHA9ZUkO+6JJmbwAmR/J7LrMM3GXV9cUQhJLEE=;
        b=qj7YAX00OaU96jOkL6FMEN2NtvAaLzA9sXdD0JTG7o1tjGpwE/e4krkLaVEMkgRE+O
         n9/QCWNpAj4EdGD2k+LAxTJy3eqtfixaP9vpiuIAk/FrZqx3oPP42kBdMSTjYLsLyZo3
         cFYldu9kzhbi6PDGssNpTBDTWZPPeqcpg3wwslZEMtSZ4R/7t0Do1hfXa6bizGSCtL1j
         7bk/yUWW6vOeym2A2t6+hEF99INBhJ/KSEYkb7s4mqpF2tMNChtat8HhkLc3Dny3XRN/
         fguFyoCsWYF2nU5pJWJB8oQZeI8/ExuotWaDI5aMve6FYV4XiCCPzfqX1hyLKN6FJWKl
         L4eA==
X-Gm-Message-State: AOJu0Yw9ADVn+dhCQ+YLxRHzhcVMD8hIAviLkxwwT84DGsgWuJbsTZro
	KuosCvEZ33Ien5ib6X+B1mrmc4vbeizvvTtl01x64tp0FFsG9yu8ITMEAgrh16oz
X-Gm-Gg: ASbGnct1gk4xLGeVxZHsLKIQJiT38EtWOyEyowykjiM0nOTNXE0VcYWXrhOASIRzf0E
	x9S95qJmkKqSvZJ3G8dEb84+BW7uf8TywWP2f+oB5qggYyX9zfVwt6nMsg+QXHXheFOqNq4jfj/
	JogaI4BHKaA2rX75k4z/IUP+RmcTlDkjv3gGhdd1zsnEQIh1KOwKAul/26vnXBDl66d1qoYslJr
	KfuYNwSPRrKX3u7ncPynbii1ZULpRn+X8nEZDb5QLHaoRFvYnjSIN9SKqXX90pQTCNAdoi9DwgY
	jQvr/Z+mHvB0K8+mjvSzQaR8smqqDmty78g6bJcJJvlumGc=
X-Google-Smtp-Source: AGHT+IERJb+lk3XyhnBqclrsdsu26abpxNtSI2H9+QQ/7l7ebJQ62MFQNwq3K4rleIRYQRlrgPI7aw==
X-Received: by 2002:a05:6a00:3909:b0:742:aecc:c47c with SMTP id d2e1a72fcca58-745fde9e407mr6124584b3a.7.1748114395509;
        Sat, 24 May 2025 12:19:55 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a986b38bsm14558298b3a.129.2025.05.24.12.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 12:19:55 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 09/11] bpf: remove {update,get}_loop_entry functions
Date: Sat, 24 May 2025 12:19:30 -0700
Message-ID: <20250524191932.389444-10-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250524191932.389444-1-eddyz87@gmail.com>
References: <20250524191932.389444-1-eddyz87@gmail.com>
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
index 9a9fcecace53..7b6440d4e29a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -445,16 +445,6 @@ struct bpf_verifier_state {
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
@@ -469,11 +459,6 @@ struct bpf_verifier_state {
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
index f61b53121048..e9254b3b9cb8 100644
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


