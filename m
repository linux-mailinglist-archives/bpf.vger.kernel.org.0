Return-Path: <bpf+bounces-56779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C87A9DA2E
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 12:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB0D926ABC
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 10:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E938227EAA;
	Sat, 26 Apr 2025 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWDAN3ml"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF59B221FC7
	for <bpf@vger.kernel.org>; Sat, 26 Apr 2025 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745664413; cv=none; b=OfVscDO+7mC98KsOWJavE7G+cf/cGOqQ86DivUWNHUIRIrFh9uuK7GgjzeYCymHP0ywK5mzfH4putMmgHll/O40FxXTohbUzGYr0ke1k4ygj01ncdqOiCEwSDgntC9bOnKfI/AFCPeHH54OpHaiHowQZqrRG95X5RWyC5Krx7D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745664413; c=relaxed/simple;
	bh=zmF2Y7l/6GGmYPFPHV256hX0Wfk8l7KoWz/jMgRGTUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRrbMZHJYGwSnYlw7i1KXuenpEfOHHIdbayzS9FsXuLvMQyKiRvoZ0VmOhupFlxGOqynR94ftvGTipxNczavEfJPzNJuZDMDJRv1sD+UpP6Yapec1H2+itYeTtblPH+y0XMvPq6JjivNZViZVqKoc1Q28vsoY3npn5XngCj3jJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWDAN3ml; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223f4c06e9fso28192045ad.1
        for <bpf@vger.kernel.org>; Sat, 26 Apr 2025 03:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745664410; x=1746269210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkaBFU7wUc7OexTcvPZ4j9uS+EKJnpzMwH4QewNg8Es=;
        b=iWDAN3mlcHFeaUKwXzEY0YzX/lMxPAL+EQmBL0HRULLZ/B7cgYLrAZhpP4F+Rbmz6h
         +WNHlXtBn0L4Vj9qOBo7efYtn6y5vpxG2yNBNajqNCTqPyHd+xUpPmPk6eQ7qn2DJs4x
         CurBMzSJlSGTLbWGNwxd1n9JjRqQa25aOL/B3Oj2IrOR5LIC0cusDoiRmETGIvXOep+Y
         a+rX21KgLS3FHTX/3eEZzbkIiAKBYbt5A1+ifk2yZszcYyM1T5KO+ljUuPCS8qaPY2r+
         /HwDbZMUe0iJP++sVWwc4HuKKwPhgHa0h1w55GR67JtLpW3S6O4LPbvvL/1hqAVMe06r
         92PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745664410; x=1746269210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkaBFU7wUc7OexTcvPZ4j9uS+EKJnpzMwH4QewNg8Es=;
        b=TC8qHYiPu+fbL6IywsMAQ9F4LgXcpu5Fd4mdC8h6U1AbMtJcJUR4fbl+UA2C7xNnEc
         0pyxXH3Eqc2cBs0QpB7jtRvRInhBDXc4P7wg9gepjXn/V6D2sN+WByJhrzNixr1A/LtW
         7oSddAZZg5UHaqeTJ/Y6g7vy9RGPLRS5GVN3dHHY/MGVUWZ0ZJu7DNh2ZrTQ5wPcrBzV
         lTQIJNjLKnEaeLt2xWb54e+RSEzJK6/+bpYbrUZgkJD0VnTkHOsd5ApwquBFNTzuRMB+
         gxR+eY7WVTZ0GL4Dsp9S3gCoK/8UEV6oo+FFAnrichJ7oDaqQb+kH8p7xiSJPYXcvWTq
         eZ+w==
X-Gm-Message-State: AOJu0Yx/WtTfFp8a5DHbB4H21jTbCCNh7ORZGomYSr6Xm88kmZ3diYIp
	FYgo/R/pdo2fT3xDT5ye9okWw5kEX4LMrGfrBPJGpTP7MetPRGIiiMxW2zzP
X-Gm-Gg: ASbGncuh2uPl/F9GukLhT2oShhrwVxzgbpvw7uB2dBkanKOTWNMD5DHxB+RqC9c0s4N
	xOD8fwvY4qXdgyUhlXuqQwBTN05y6FM1y+iCT5hofz04V4TRnIEolJbGsrIcK2g3gUZSfVgEFXf
	UPp4Fxll37CPN8MVD35iez7vV4iIXi3My8RNYmT+smAC0rM4F9RbVC/m1nnV9paVU21c1jfUinv
	+J0HFrKL/nY/Klmgw4f6dqi9I04kQz1/Ld2/QiwCjnHrbxbbH8pxrPeyXiHNDDbKpV+oyX1PjKG
	BJBP6IM83m/nXu5MoL4W8KBDalB5zQ8miUxK
X-Google-Smtp-Source: AGHT+IHTF+HjBtVIMqbKZxqEPPu8/Um+vR+IGvZiRef76rJAucdpeCppApxYyBqqKxbMgr0Xi7TWyA==
X-Received: by 2002:a17:902:e851:b0:21a:7e04:7021 with SMTP id d9443c01a7336-22dbf987e51mr71155825ad.24.1745664409394;
        Sat, 26 Apr 2025 03:46:49 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5102e13sm47094115ad.201.2025.04.26.03.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 03:46:48 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 3/4] bpf: use SCC info instead of loop_entry
Date: Sat, 26 Apr 2025 03:46:33 -0700
Message-ID: <20250426104634.744077-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250426104634.744077-1-eddyz87@gmail.com>
References: <20250426104634.744077-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace loop_entry-based exact states comparison logic.
Instead, for states within an iterator based loop, mark all registers
as read and precise. Use control flow graph strongly connected
components information to detect states that are members of a loop.
See comments for mark_all_regs_read_and_precise() for a detailed
explanation.

This change addresses the cases described in [1].
These cases can be illustrated with the following diagram:

 .-> A --.  Assume the states are visited in the order A, B, C.
 |   |   |  Assume that state B reaches a state equivalent to state A.
 |   v   v  At this point, state C is not processed yet, so state A
 '-- B   C  has not received any read or precision marks from C.
            As a result, these marks won't be propagated to B.

If B has incomplete marks, it is unsafe to use it in states_equal()
checks.

See selftests later in a series for examples of unsafe programs that
are not detected without this change.

[1] https://lore.kernel.org/bpf/3c6ac16b7578406e2ddd9ba889ce955748fe636b.camel@gmail.com/

Fixes: 2a0992829ea3 ("bpf: correct loop detection for iterators convergence")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  42 ++--
 kernel/bpf/verifier.c        | 440 ++++++++++++++++++-----------------
 2 files changed, 249 insertions(+), 233 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index cb8e1ae67180..e718ef265a7b 100644
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
 	/* Sub-range of env->insn_hist[] corresponding to this state's
 	 * instruction history.
 	 * Backtracking is using it to go from last to first.
@@ -466,11 +456,10 @@ struct bpf_verifier_state {
 	u32 dfs_depth;
 	u32 callback_unroll_depth;
 	u32 may_goto_depth;
-	/* If this state was ever pointed-to by other state's loop_entry field
-	 * this flag would be set to true. Used to avoid freeing such states
-	 * while they are still in use.
+	/* If this state is a checkpoint at insn_idx that belongs to an SCC,
+	 * record the SCC epoch at the time of checkpoint creation.
 	 */
-	u32 used_as_loop_entry;
+	u32 scc_epoch;
 };
 
 #define bpf_get_spilled_reg(slot, frame, mask)				\
@@ -717,6 +706,29 @@ struct bpf_idset {
 	u32 ids[BPF_ID_MAP_SIZE];
 };
 
+/* Information tracked for CFG strongly connected components */
+struct bpf_scc_info {
+	/* True if states_equal(... RANGE_WITHIN) ever returned
+	 * true for a state with insn_idx within this SCC.
+	 * E.g. for iterator next call.
+	 * Indicates that read and precision marks are incomplete for
+	 * states with insn_idx in this SCC.
+	 */
+	u32 state_loops_possible:1;
+	/* Number of verifier states with .branches > 0 that have
+	 * state->parent->insn_idx within this SCC.
+	 * In other words, the number of states originating from this
+	 * SCC that have not yet been fully explored.
+	 */
+	u32 branches:31;
+	/* Number of times this SCC was entered by some verifier state
+	 * and that state was fully explored.
+	 * In other words, number of times .branches became non-zero
+	 * and then zero again.
+	 */
+	u32 scc_epoch;
+};
+
 /* single container for all structs
  * one verifier_env per bpf_check() call
  */
@@ -809,6 +821,8 @@ struct bpf_verifier_env {
 	u64 prev_log_pos, prev_insn_print_pos;
 	/* buffer used to temporary hold constants as scalar registers */
 	struct bpf_reg_state fake_reg[2];
+	struct bpf_scc_info *scc_info;
+	u32 num_sccs;
 	/* buffer used to generate temporary string representations,
 	 * e.g., in reg_type_str() to generate reg_type string
 	 */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 67903270b217..ae642459f342 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1672,7 +1672,7 @@ static void free_verifier_state(struct bpf_verifier_state *state,
 		kfree(state);
 }
 
-/* struct bpf_verifier_state->{parent,loop_entry} refer to states
+/* struct bpf_verifier_state->parent refers to states
  * that are in either of env->{expored_states,free_list}.
  * In both cases the state is contained in struct bpf_verifier_state_list.
  */
@@ -1683,36 +1683,18 @@ static struct bpf_verifier_state_list *state_parent_as_list(struct bpf_verifier_
 	return NULL;
 }
 
-static struct bpf_verifier_state_list *state_loop_entry_as_list(struct bpf_verifier_state *st)
-{
-	if (st->loop_entry)
-		return container_of(st->loop_entry, struct bpf_verifier_state_list, state);
-	return NULL;
-}
-
 /* A state can be freed if it is no longer referenced:
  * - is in the env->free_list;
  * - has no children states;
- * - is not used as loop_entry.
- *
- * Freeing a state can make it's loop_entry free-able.
  */
 static void maybe_free_verifier_state(struct bpf_verifier_env *env,
 				      struct bpf_verifier_state_list *sl)
 {
-	struct bpf_verifier_state_list *loop_entry_sl;
-
-	while (sl && sl->in_free_list &&
-		     sl->state.branches == 0 &&
-		     sl->state.used_as_loop_entry == 0) {
-		loop_entry_sl = state_loop_entry_as_list(&sl->state);
-		if (loop_entry_sl)
-			loop_entry_sl->state.used_as_loop_entry--;
+	if (sl->in_free_list && sl->state.branches == 0) {
 		list_del(&sl->node);
 		free_verifier_state(&sl->state, false);
 		kfree(sl);
 		env->free_list_size--;
-		sl = loop_entry_sl;
 	}
 }
 
@@ -1753,9 +1735,8 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->insn_hist_end = src->insn_hist_end;
 	dst_state->dfs_depth = src->dfs_depth;
 	dst_state->callback_unroll_depth = src->callback_unroll_depth;
-	dst_state->used_as_loop_entry = src->used_as_loop_entry;
 	dst_state->may_goto_depth = src->may_goto_depth;
-	dst_state->loop_entry = src->loop_entry;
+	dst_state->scc_epoch = src->scc_epoch;
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
 		if (!dst) {
@@ -1798,157 +1779,77 @@ static bool same_callsites(struct bpf_verifier_state *a, struct bpf_verifier_sta
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
+static struct bpf_scc_info *insn_scc(struct bpf_verifier_env *env, int insn_idx)
+{
+	u32 scc;
+
+	scc = env->insn_aux_data[insn_idx].scc;
+	return scc ? &env->scc_info[scc] : NULL;
+}
+
+/* Returns true iff:
+ * - verifier is currently exploring states with origins in some CFG SCCs;
+ * - st->insn_idx belongs to one of these SCCs;
+ * - st->scc_epoch is the current SCC epoch, indicating that some parent
+ *   of st started current SCC exploration epoch.
  *
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
+ * When above conditions are true, mark_all_regs_read_and_precise()
+ * has not yet been called for st, meaning that read and precision
+ * marks can't be relied upon.
  *
- * To adapt this algorithm for use with verifier:
- * - use st->branch == 0 as a signal that DFS of succ had been finished
- *   and cur's loop entry has to be updated (case A), handle this in
- *   update_branch_counts();
- * - use st->branch > 0 as a signal that st is in the current DFS path;
- * - handle cases B and C in is_state_visited().
+ * See comments for mark_all_regs_read_and_precise().
  */
-static struct bpf_verifier_state *get_loop_entry(struct bpf_verifier_env *env,
-						 struct bpf_verifier_state *st)
+static bool incomplete_read_marks(struct bpf_verifier_env *env,
+				  struct bpf_verifier_state *st)
 {
-	struct bpf_verifier_state *topmost = st->loop_entry;
-	u32 steps = 0;
+	struct bpf_scc_info *scc_info;
 
-	while (topmost && topmost->loop_entry) {
-		if (steps++ > st->dfs_depth) {
-			WARN_ONCE(true, "verifier bug: infinite loop in get_loop_entry\n");
-			verbose(env, "verifier bug: infinite loop in get_loop_entry()\n");
-			return ERR_PTR(-EFAULT);
-		}
-		topmost = topmost->loop_entry;
-	}
-	return topmost;
+	scc_info = insn_scc(env, st->insn_idx);
+	return scc_info &&
+	       scc_info->state_loops_possible &&
+	       scc_info->scc_epoch == st->scc_epoch &&
+	       scc_info->branches > 0;
 }
 
-static void update_loop_entry(struct bpf_verifier_env *env,
-			      struct bpf_verifier_state *cur, struct bpf_verifier_state *hdr)
+static void mark_state_loops_possible(struct bpf_verifier_env *env,
+				      struct bpf_verifier_state *st)
 {
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
+	struct bpf_scc_info *scc_info;
+
+	scc_info = insn_scc(env, st->insn_idx);
+	if (scc_info)
+		scc_info->state_loops_possible = 1;
+}
+
+/* See comments for bpf_scc_info->{branches,visit_count} and
+ * mark_all_regs_read_and_precise().
+ */
+static void parent_scc_enter(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct bpf_scc_info *scc_info;
+
+	if (!st->parent)
+		return;
+	scc_info = insn_scc(env, st->parent->insn_idx);
+	if (scc_info)
+		scc_info->branches++;
+}
+
+/* See comments for bpf_scc_info->{branches,visit_count} and
+ * mark_all_regs_read_and_precise().
+ */
+static void parent_scc_exit(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct bpf_scc_info *scc_info;
+
+	if (!st->parent)
+		return;
+	scc_info = insn_scc(env, st->parent->insn_idx);
+	if (scc_info) {
+		WARN_ON_ONCE(scc_info->branches == 0);
+		scc_info->branches--;
+		if (scc_info->branches == 0)
+			scc_info->scc_epoch++;
 	}
 }
 
@@ -1960,14 +1861,6 @@ static void update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifi
 	while (st) {
 		u32 br = --st->branches;
 
-		/* br == 0 signals that DFS exploration for 'st' is finished,
-		 * thus it is necessary to update parent's loop entry if it
-		 * turned out that st is a part of some loop.
-		 * This is a part of 'case A' in get_loop_entry() comment.
-		 */
-		if (br == 0 && st->parent && st->loop_entry)
-			update_loop_entry(env, st->parent, st->loop_entry);
-
 		/* WARN_ON(br > 1) technically makes sense here,
 		 * but see comment in push_stack(), hence:
 		 */
@@ -1976,6 +1869,7 @@ static void update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifi
 			  br);
 		if (br)
 			break;
+		parent_scc_exit(env, st);
 		parent = st->parent;
 		parent_sl = state_parent_as_list(st);
 		if (sl)
@@ -2053,6 +1947,7 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 		 * which might have large 'branches' count.
 		 */
 	}
+	parent_scc_enter(env, &elem->st);
 	return &elem->st;
 err:
 	free_verifier_state(env->cur_state, true);
@@ -2242,6 +2137,18 @@ static void __mark_reg64_unbounded(struct bpf_reg_state *reg)
 	reg->umax_value = U64_MAX;
 }
 
+static bool is_reg_unbounded(struct bpf_reg_state *reg)
+{
+	return reg->smin_value == S64_MIN &&
+	       reg->smax_value == S64_MAX &&
+	       reg->umin_value == 0 &&
+	       reg->umax_value == U64_MAX &&
+	       reg->s32_min_value == S32_MIN &&
+	       reg->s32_max_value == S32_MAX &&
+	       reg->u32_min_value == 0 &&
+	       reg->u32_max_value == U32_MAX;
+}
+
 static void __mark_reg32_unbounded(struct bpf_reg_state *reg)
 {
 	reg->s32_min_value = S32_MIN;
@@ -18222,15 +18129,17 @@ static void clean_func_state(struct bpf_verifier_env *env,
 	}
 }
 
+static bool verifier_state_cleaned(struct bpf_verifier_state *st)
+{
+	/* all regs in this state in all frames were already marked */
+	return st->frame[0]->regs[0].live & REG_LIVE_DONE;
+}
+
 static void clean_verifier_state(struct bpf_verifier_env *env,
 				 struct bpf_verifier_state *st)
 {
 	int i;
 
-	if (st->frame[0]->regs[0].live & REG_LIVE_DONE)
-		/* all regs in this state in all frames were already marked */
-		return;
-
 	for (i = 0; i <= st->curframe; i++)
 		clean_func_state(env, st->frame[i]);
 }
@@ -18243,6 +18152,114 @@ static u32 frame_insn_idx(struct bpf_verifier_state *st, u32 frame)
 	       : st->frame[frame + 1]->callsite;
 }
 
+/* Open coded iterators introduce loops in the verifier state graph.
+ * State graph loops can result in incomplete read and precision marks
+ * on individual states. E.g. consider the following states graph:
+ *
+ *  .-> A --.  Assume the states are visited in the order A, B, C.
+ *  |   |   |  Assume that state B reaches a state equivalent to state A.
+ *  |   v   v  At this point, state C has not been processed yet,
+ *  '-- B   C  so state A does not have any read or precision marks from C yet.
+ *             As a result, these marks won't be propagated to B.
+ *
+ * If the marks on B are incomplete, it would be unsafe to use it in
+ * states_equal() checks.
+ *
+ * To avoid this safety issue, and since states with incomplete read
+ * marks can only occur within control flow graph loops, the verifier
+ * assumes that any state with bpf_verifier_state->insn_idx residing
+ * in a strongly connected component (SCC) has read and precision
+ * marks for all registers. This assumption is enforced by the
+ * function mark_all_regs_read_and_precise(), which assigns
+ * corresponding marks.
+ *
+ * An intuitive point to call mark_all_regs_read_and_precise() would
+ * be when a new state is created in is_state_visited().
+ * However, doing so would interfere with widen_imprecise_scalars(),
+ * which widens scalars in the current state after checking registers in a
+ * parent state. Registers are not widened if they are marked as precise
+ * in the parent state.
+ *
+ * To avoid interfering with widening logic,
+ * a call to mark_all_regs_read_and_precise() for state is postponed
+ * until no widening is possible in any descendant of state S.
+ *
+ * Another intuitive spot to call mark_all_regs_read_and_precise()
+ * would be in update_branch_counts() when S's branches counter
+ * reaches 0. However, this falls short in the following case:
+ *
+ *	sum = 0
+ *	bpf_repeat(10) {                              // a
+ *		if (unlikely(bpf_get_prandom_u32()))  // b
+ *			sum += 1;
+ *		if (bpf_get_prandom_u32())            // c
+ *			asm volatile ("");
+ *		asm volatile ("goto +0;");            // d
+ *	}
+ *
+ * Here a checkpoint is created at (d) with {sum=0} and the branch counter
+ * for (d) reaches 0, so 'sum' would be marked precise.
+ * When second branch of (c) reaches (d), checkpoint would be hit,
+ * and the precision mark for 'sum' propagated to (a).
+ * When the second branch of (b) reaches (a), the state would be {sum=1},
+ * no widening would occur, causing verification to continue forever.
+ *
+ * To avoid such premature precision markings, the verifier postpones
+ * the call to mark_all_regs_read_and_precise() for state S even further.
+ * Suppose state P is a [grand]parent of state S and is the first state
+ * in the current state chain with state->insn_idx within current SCC.
+ * mark_all_regs_read_and_precise() for state S is only called once P
+ * is fully explored.
+ *
+ * The struct 'bpf_scc_info' is used to track this condition:
+ * - bpf_scc_info->branches counts how many states currently
+ *   in env->cur_state or env->head originate from this SCC;
+ * - bpf_scc_info->scc_epoch counts how many times 'branches'
+ *   has reached zero;
+ * - bpf_verifier_state->scc_epoch records the epoch of the SCC
+ *   corresponding to bpf_verifier_state->insn_idx at the moment
+ *   of state creation.
+ *
+ * Functions parent_scc_enter() and parent_scc_exit() maintain the
+ * bpf_scc_info->{branches,scc_epoch} counters.
+ *
+ * bpf_scc_info->branches reaching zero indicates that state P is
+ * fully explored. Its descendants residing in the same SCC have
+ * state->scc_epoch == scc_info->scc_epoch. parent_scc_exit()
+ * increments scc_info->scc_epoch, allowing clean_live_states() to
+ * detect these states and apply mark_all_regs_read_and_precise().
+ */
+static void mark_all_regs_read_and_precise(struct bpf_verifier_env *env,
+					   struct bpf_verifier_state *st)
+{
+	struct bpf_func_state *func;
+	struct bpf_reg_state *reg;
+	u16 live_regs;
+	u32 insn_idx;
+	int i, j;
+
+	for (i = 0; i <= st->curframe; i++) {
+		insn_idx = frame_insn_idx(st, i);
+		live_regs = env->insn_aux_data[st->insn_idx].live_regs_before;
+		func = st->frame[i];
+		for (j = 0; j < BPF_REG_FP; j++) {
+			reg = &func->regs[j];
+			if (!(BIT(j) & live_regs) || reg->type == NOT_INIT)
+				continue;
+			reg->live |= REG_LIVE_READ64;
+			if (reg->type == SCALAR_VALUE && !is_reg_unbounded(reg))
+				reg->precise = true;
+		}
+		for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
+			reg = &func->stack[j].spilled_ptr;
+			reg->live |= REG_LIVE_READ64;
+			if (is_spilled_reg(&func->stack[j]) &&
+			    reg->type == SCALAR_VALUE && !is_reg_unbounded(reg))
+				reg->precise = true;
+		}
+	}
+}
+
 /* the parentage chains form a tree.
  * the verifier states are added to state lists at given insn and
  * pushed into state stack for future exploration.
@@ -18278,21 +18295,27 @@ static u32 frame_insn_idx(struct bpf_verifier_state *st, u32 frame)
 static void clean_live_states(struct bpf_verifier_env *env, int insn,
 			      struct bpf_verifier_state *cur)
 {
-	struct bpf_verifier_state *loop_entry;
 	struct bpf_verifier_state_list *sl;
+	struct bpf_scc_info *scc_info;
 	struct list_head *pos, *head;
 
+	scc_info = insn_scc(env, insn);
 	head = explored_state(env, insn);
 	list_for_each(pos, head) {
 		sl = container_of(pos, struct bpf_verifier_state_list, node);
 		if (sl->state.branches)
 			continue;
-		loop_entry = get_loop_entry(env, &sl->state);
-		if (!IS_ERR_OR_NULL(loop_entry) && loop_entry->branches)
-			continue;
 		if (sl->state.insn_idx != insn ||
 		    !same_callsites(&sl->state, cur))
 			continue;
+		if (verifier_state_cleaned(&sl->state))
+			continue;
+		if (incomplete_read_marks(env, &sl->state))
+			continue;
+		if (scc_info &&
+		    scc_info->state_loops_possible &&
+		    scc_info->scc_epoch > sl->state.scc_epoch)
+			mark_all_regs_read_and_precise(env, &sl->state);
 		clean_verifier_state(env, &sl->state);
 	}
 }
@@ -18996,10 +19019,11 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 {
 	struct bpf_verifier_state_list *new_sl;
 	struct bpf_verifier_state_list *sl;
-	struct bpf_verifier_state *cur = env->cur_state, *new, *loop_entry;
+	struct bpf_verifier_state *cur = env->cur_state, *new;
 	int i, j, n, err, states_cnt = 0;
 	bool force_new_state, add_new_state, force_exact;
 	struct list_head *pos, *tmp, *head;
+	struct bpf_scc_info *scc_info;
 
 	force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx) ||
 			  /* Avoid accumulating infinitely long jmp history */
@@ -19099,7 +19123,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 					spi = __get_spi(iter_reg->off + iter_reg->var_off.value);
 					iter_state = &func(env, iter_reg)->stack[spi].spilled_ptr;
 					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE) {
-						update_loop_entry(env, cur, &sl->state);
+						mark_state_loops_possible(env, &sl->state);
 						goto hit;
 					}
 				}
@@ -19108,7 +19132,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			if (is_may_goto_insn_at(env, insn_idx)) {
 				if (sl->state.may_goto_depth != cur->may_goto_depth &&
 				    states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
-					update_loop_entry(env, cur, &sl->state);
+					mark_state_loops_possible(env, &sl->state);
 					goto hit;
 				}
 			}
@@ -19150,38 +19174,9 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				add_new_state = false;
 			goto miss;
 		}
-		/* If sl->state is a part of a loop and this loop's entry is a part of
-		 * current verification path then states have to be compared exactly.
-		 * 'force_exact' is needed to catch the following case:
-		 *
-		 *                initial     Here state 'succ' was processed first,
-		 *                  |         it was eventually tracked to produce a
-		 *                  V         state identical to 'hdr'.
-		 *     .---------> hdr        All branches from 'succ' had been explored
-		 *     |            |         and thus 'succ' has its .branches == 0.
-		 *     |            V
-		 *     |    .------...        Suppose states 'cur' and 'succ' correspond
-		 *     |    |       |         to the same instruction + callsites.
-		 *     |    V       V         In such case it is necessary to check
-		 *     |   ...     ...        if 'succ' and 'cur' are states_equal().
-		 *     |    |       |         If 'succ' and 'cur' are a part of the
-		 *     |    V       V         same loop exact flag has to be set.
-		 *     |   succ <- cur        To check if that is the case, verify
-		 *     |    |                 if loop entry of 'succ' is in current
-		 *     |    V                 DFS path.
-		 *     |   ...
-		 *     |    |
-		 *     '----'
-		 *
-		 * Additional details are in the comment before get_loop_entry().
-		 */
-		loop_entry = get_loop_entry(env, &sl->state);
-		if (IS_ERR(loop_entry))
-			return PTR_ERR(loop_entry);
-		force_exact = loop_entry && loop_entry->branches > 0;
+		/* See comments for mark_all_regs_read_and_precise() */
+		force_exact = incomplete_read_marks(env, &sl->state);
 		if (states_equal(env, &sl->state, cur, force_exact ? RANGE_WITHIN : NOT_EXACT)) {
-			if (force_exact)
-				update_loop_entry(env, cur, loop_entry);
 hit:
 			sl->hit_cnt++;
 			/* reached equivalent register/stack state,
@@ -19279,6 +19274,9 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		return err;
 	}
 	new->insn_idx = insn_idx;
+	scc_info = insn_scc(env, insn_idx);
+	if (scc_info)
+		new->scc_epoch = scc_info->scc_epoch;
 	WARN_ONCE(new->branches != 1,
 		  "BUG is_state_visited:branches_to_explore=%d insn %d\n", new->branches, insn_idx);
 
@@ -19287,6 +19285,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	cur->insn_hist_start = cur->insn_hist_end;
 	cur->dfs_depth = new->dfs_depth + 1;
 	list_add(&new_sl->node, head);
+	parent_scc_enter(env, env->cur_state);
 
 	/* connect new state to parentage chain. Current frame needs all
 	 * registers connected. Only r6 - r9 of the callers are alive (pushed
@@ -19665,10 +19664,6 @@ static int do_check(struct bpf_verifier_env *env)
 						return err;
 					break;
 				} else {
-					if (WARN_ON_ONCE(env->cur_state->loop_entry)) {
-						verbose(env, "verifier bug: env->cur_state->loop_entry != NULL\n");
-						return -EFAULT;
-					}
 					do_print_state = true;
 					continue;
 				}
@@ -24073,6 +24068,12 @@ static int compute_scc(struct bpf_verifier_env *env)
 			dfs_sz--;
 		}
 	}
+	env->scc_info = kvcalloc(next_scc_id, sizeof(*env->scc_info), GFP_KERNEL);
+	if (!env->scc_info) {
+		err = -ENOMEM;
+		goto exit;
+	}
+	env->num_sccs = next_scc_id;
 exit:
 	kvfree(stack);
 	kvfree(pre);
@@ -24349,6 +24350,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	kvfree(env->insn_hist);
 err_free_env:
 	kvfree(env->cfg.insn_postorder);
+	kvfree(env->scc_info);
 	kvfree(env);
 	return ret;
 }
-- 
2.48.1


