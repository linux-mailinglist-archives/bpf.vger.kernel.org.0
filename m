Return-Path: <bpf+bounces-13082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC027D43B4
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 02:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA669281777
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 00:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552D41118;
	Tue, 24 Oct 2023 00:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDU96Q5Z"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F89D15D1
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 00:09:39 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C3310D
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:09:36 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99357737980so615284966b.2
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698106175; x=1698710975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFx18TieiGAD8AINk0vIlPQRAWttnvXlU3A6U1NoT7E=;
        b=SDU96Q5ZJxC3EN19tvZo7JKV8CxjvgTNkqGnsmVQK8KS40uwUIwLu+JQZa/5jkPjub
         dsW4T0HSIw1nvpbA6+83WOvzqjvbkUK6O0UYZPDOTNyzUCzBGT148UaVvKANVT4AAwef
         paihJO9BvmMrpRIjxwdi6xVIcb7nX3AANiX2RNT4abeo4hnxuzxSMK12lzaVuer+1ffj
         RUxGSgVBPOjTLie2NU9Jz3FVLfHLEt1f39jQfUU5DAojkT/cJ3uyNf1ePbVo4TC+lOEa
         yidSrnF142JFXT0pt6iWmuxFPLB9zSiMhUrpC+4otEejwLqCpDPPqHfhxP13wWf+lyHZ
         UVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698106175; x=1698710975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFx18TieiGAD8AINk0vIlPQRAWttnvXlU3A6U1NoT7E=;
        b=GI8kf1j1U+fMRMKzpVyNY7Tv1i7oElXbEJGCT6ScyRV/dX8ovQscfJEiwZt3VkirRH
         RokKaowudP20B+Gaz5LUT7y55+0J7Z/EPe+cQyiNvhtaPX1cJg6xB147y37+SpxMyiic
         Aj5FYOVpG5J1S0rfUYBX7H7vC04JLaIvsUNE+Qea612FR/+/Mg7VTd8xDNmrLhht7xQp
         WLvVKGObEC8BcCKyWRWsHehCtMZOW9eExcPKgygFrfDMr37Qfww9ic2fva+RPCXRntrp
         J0zvfJyf1DwRRsbvxSlWF6B08noyOE6QD57gW77XpspxlhUwz/FN7zmzpxQ3ANUHUVI4
         qxOQ==
X-Gm-Message-State: AOJu0YwXJCQyo+sUYwkefSKog9YEF2RxWs247mAXyyuD2CMAGfJjxtXF
	pW2z6p5C9m0qvleTFTWWKf9Q3v56DlkmLFRg
X-Google-Smtp-Source: AGHT+IH2kXNEXvRzXdAMdqCtQYao4OaoGWTxKKEfIjs/Yj15Miubs3KvmjnA8DOODNs07FS8a0XTiQ==
X-Received: by 2002:a17:907:608b:b0:9b2:9e44:222e with SMTP id ht11-20020a170907608b00b009b29e44222emr10553775ejc.19.1698106175049;
        Mon, 23 Oct 2023 17:09:35 -0700 (PDT)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d13-20020a1709064c4d00b009a5f1d15642sm7264516ejw.158.2023.10.23.17.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 17:09:34 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	awerner32@gmail.com,
	john.fastabend@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next v3 5/7] bpf: correct loop detection for iterators convergence
Date: Tue, 24 Oct 2023 03:09:15 +0300
Message-ID: <20231024000917.12153-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024000917.12153-1-eddyz87@gmail.com>
References: <20231024000917.12153-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It turns out that .branches > 0 in is_state_visited() is not a
sufficient condition to identify if two verifier states form a loop
when iterators convergence is computed. This commit adds logic to
distinguish situations like below:

 (I)            initial       (II)            initial
                  |                             |
                  V                             V
     .---------> hdr                           ..
     |            |                             |
     |            V                             V
     |    .------...                    .------..
     |    |       |                     |       |
     |    V       V                     V       V
     |   ...     ...               .-> hdr     ..
     |    |       |                |    |       |
     |    V       V                |    V       V
     |   succ <- cur               |   succ <- cur
     |    |                        |    |
     |    V                        |    V
     |   ...                       |   ...
     |    |                        |    |
     '----'                        '----'

For both (I) and (II) successor 'succ' of the current state 'cur' was
previously explored and has branches count at 0. However, loop entry
'hdr' corresponding to 'succ' might be a part of current DFS path.
If that is the case 'succ' and 'cur' are members of the same loop
and have to be compared exactly.

Co-developed-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Co-developed-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  15 +++
 kernel/bpf/verifier.c        | 207 ++++++++++++++++++++++++++++++++++-
 2 files changed, 218 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 38b788228594..24213a99cc79 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -373,10 +373,25 @@ struct bpf_verifier_state {
 	struct bpf_active_lock active_lock;
 	bool speculative;
 	bool active_rcu_lock;
+	/* If this state was ever pointed-to by other state's loop_entry field
+	 * this flag would be set to true. Used to avoid freeing such states
+	 * while they are still in use.
+	 */
+	bool used_as_loop_entry;
 
 	/* first and last insn idx of this verifier state */
 	u32 first_insn_idx;
 	u32 last_insn_idx;
+	/* If this state is a part of states loop this field points to some
+	 * parent of this state such that:
+	 * - it is also a member of the same states loop;
+	 * - DFS states traversal starting from initial state visits loop_entry
+	 *   state before this state.
+	 * Used to compute topmost loop entry for state loops.
+	 * State loops might appear because of open coded iterators logic.
+	 * See get_loop_entry() for more information.
+	 */
+	struct bpf_verifier_state *loop_entry;
 	/* jmp history recorded from first to last.
 	 * backtracking is using it to go from last to first.
 	 * For most states jmp_history_cnt is [0-3].
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6573e8c77329..f23fbfe82c59 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1803,6 +1803,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->first_insn_idx = src->first_insn_idx;
 	dst_state->last_insn_idx = src->last_insn_idx;
 	dst_state->dfs_depth = src->dfs_depth;
+	dst_state->used_as_loop_entry = src->used_as_loop_entry;
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
 		if (!dst) {
@@ -1845,11 +1846,176 @@ static bool same_callsites(struct bpf_verifier_state *a, struct bpf_verifier_sta
 	return true;
 }
 
+/* Open coded iterators allow back-edges in the state graph in order to
+ * check unbounded loops that iterators.
+ *
+ * In is_state_visited() it is necessary to know if explored states are
+ * part of some loops in order to decide whether non-exact states
+ * comparison could be used:
+ * - non-exact states comparison establishes sub-state relation and uses
+ *   read and precision marks to do so, these marks are propagated from
+ *   children states and thus are not guaranteed to be final in a loop;
+ * - exact states comparison just checks if current and explored states
+ *   are identical (and thus form a back-edge).
+ *
+ * Paper "A New Algorithm for Identifying Loops in Decompilation"
+ * by Tao Wei, Jian Mao, Wei Zou and Yu Chen [1] presents a convenient
+ * algorithm for loop structure detection and gives an overview of
+ * relevant terminology. It also has helpful illustrations.
+ *
+ * [1] https://api.semanticscholar.org/CorpusID:15784067
+ *
+ * We use a similar algorithm but because loop nested structure is
+ * irrelevant for verifier ours is significantly simpler and resembles
+ * strongly connected components algorithm from Sedgewick's textbook.
+ *
+ * Define topmost loop entry as a first node of the loop traversed in a
+ * depth first search starting from initial state. The goal of the loop
+ * tracking algorithm is to associate topmost loop entries with states
+ * derived from these entries.
+ *
+ * For each step in the DFS states traversal algorithm needs to identify
+ * the following situations:
+ *
+ *          initial                     initial                   initial
+ *            |                           |                         |
+ *            V                           V                         V
+ *           ...                         ...           .---------> hdr
+ *            |                           |            |            |
+ *            V                           V            |            V
+ *           cur                     .-> succ          |    .------...
+ *            |                      |    |            |    |       |
+ *            V                      |    V            |    V       V
+ *           succ                    '-- cur           |   ...     ...
+ *                                                     |    |       |
+ *                                                     |    V       V
+ *                                                     |   succ <- cur
+ *                                                     |    |
+ *                                                     |    V
+ *                                                     |   ...
+ *                                                     |    |
+ *                                                     '----'
+ *
+ *  (A) successor state of cur   (B) successor state of cur or it's entry
+ *      not yet traversed            are in current DFS path, thus cur and succ
+ *                                   are members of the same outermost loop
+ *
+ *                      initial                  initial
+ *                        |                        |
+ *                        V                        V
+ *                       ...                      ...
+ *                        |                        |
+ *                        V                        V
+ *                .------...               .------...
+ *                |       |                |       |
+ *                V       V                V       V
+ *           .-> hdr     ...              ...     ...
+ *           |    |       |                |       |
+ *           |    V       V                V       V
+ *           |   succ <- cur              succ <- cur
+ *           |    |                        |
+ *           |    V                        V
+ *           |   ...                      ...
+ *           |    |                        |
+ *           '----'                       exit
+ *
+ * (C) successor state of cur is a part of some loop but this loop
+ *     does not include cur or successor state is not in a loop at all.
+ *
+ * Algorithm could be described as the following python code:
+ *
+ *     traversed = set()   # Set of traversed nodes
+ *     entries = {}        # Mapping from node to loop entry
+ *     depths = {}         # Depth level assigned to graph node
+ *     path = set()        # Current DFS path
+ *
+ *     # Find outermost loop entry known for n
+ *     def get_loop_entry(n):
+ *         h = entries.get(n, None)
+ *         while h in entries and entries[h] != h:
+ *             h = entries[h]
+ *         return h
+ *
+ *     # Update n's loop entry if h's outermost entry comes
+ *     # before n's outermost entry in current DFS path.
+ *     def update_loop_entry(n, h):
+ *         n1 = get_loop_entry(n) or n
+ *         h1 = get_loop_entry(h) or h
+ *         if h1 in path and depths[h1] <= depths[n1]:
+ *             entries[n] = h1
+ *
+ *     def dfs(n, depth):
+ *         traversed.add(n)
+ *         path.add(n)
+ *         depths[n] = depth
+ *         for succ in G.successors(n):
+ *             if succ not in traversed:
+ *                 # Case A: explore succ and update cur's loop entry
+ *                 #         only if succ's entry is in current DFS path.
+ *                 dfs(succ, depth + 1)
+ *                 h = get_loop_entry(succ)
+ *                 update_loop_entry(n, h)
+ *             else:
+ *                 # Case B or C depending on `h1 in path` check in update_loop_entry().
+ *                 update_loop_entry(n, succ)
+ *         path.remove(n)
+ *
+ * To adapt this algorithm for use with verifier:
+ * - use st->branch == 0 as a signal that DFS of succ had been finished
+ *   and cur's loop entry has to be updated (case A), handle this in
+ *   update_branch_counts();
+ * - use st->branch > 0 as a signal that st is in the current DFS path;
+ * - handle cases B and C in is_state_visited();
+ * - update topmost loop entry for intermediate states in get_loop_entry().
+ */
+static struct bpf_verifier_state *get_loop_entry(struct bpf_verifier_state *st)
+{
+	struct bpf_verifier_state *topmost = st->loop_entry, *old;
+
+	while (topmost && topmost->loop_entry && topmost != topmost->loop_entry)
+		topmost = topmost->loop_entry;
+	/* Update loop entries for intermediate states to avoid this
+	 * traversal in future get_loop_entry() calls.
+	 */
+	while (st && st->loop_entry != topmost) {
+		old = st->loop_entry;
+		st->loop_entry = topmost;
+		st = old;
+	}
+	return topmost;
+}
+
+static void update_loop_entry(struct bpf_verifier_state *cur, struct bpf_verifier_state *hdr)
+{
+	struct bpf_verifier_state *cur1, *hdr1;
+
+	cur1 = get_loop_entry(cur) ?: cur;
+	hdr1 = get_loop_entry(hdr) ?: hdr;
+	/* The head1->branches check decides between cases B and C in
+	 * comment for get_loop_entry(). If hdr1->branches == 0 then
+	 * head's topmost loop entry is not in current DFS path,
+	 * hence 'cur' and 'hdr' are not in the same loop and there is
+	 * no need to update cur->loop_entry.
+	 */
+	if (hdr1->branches && hdr1->dfs_depth <= cur1->dfs_depth) {
+		cur->loop_entry = hdr;
+		hdr->used_as_loop_entry = true;
+	}
+}
+
 static void update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
 {
 	while (st) {
 		u32 br = --st->branches;
 
+		/* br == 0 signals that DFS exploration for 'st' is finished,
+		 * thus it is necessary to update parent's loop entry if it
+		 * turned out that st is a part of some loop.
+		 * This is a part of 'case A' in get_loop_entry() comment.
+		 */
+		if (br == 0 && st->parent && st->loop_entry)
+			update_loop_entry(st->parent, st->loop_entry);
+
 		/* WARN_ON(br > 1) technically makes sense here,
 		 * but see comment in push_stack(), hence:
 		 */
@@ -16650,10 +16816,11 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 {
 	struct bpf_verifier_state_list *new_sl;
 	struct bpf_verifier_state_list *sl, **pprev;
-	struct bpf_verifier_state *cur = env->cur_state, *new;
+	struct bpf_verifier_state *cur = env->cur_state, *new, *loop_entry;
 	int i, j, n, err, states_cnt = 0;
 	bool force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx);
 	bool add_new_state = force_new_state;
+	bool force_exact;
 
 	/* bpf progs typically have pruning point every 4 instructions
 	 * http://vger.kernel.org/bpfconf2019.html#session-1
@@ -16748,8 +16915,10 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 					 */
 					spi = __get_spi(iter_reg->off + iter_reg->var_off.value);
 					iter_state = &func(env, iter_reg)->stack[spi].spilled_ptr;
-					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE)
+					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE) {
+						update_loop_entry(cur, &sl->state);
 						goto hit;
+					}
 				}
 				goto skip_inf_loop_check;
 			}
@@ -16780,7 +16949,36 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				add_new_state = false;
 			goto miss;
 		}
-		if (states_equal(env, &sl->state, cur, false)) {
+		/* If sl->state is a part of a loop and this loop's entry is a part of
+		 * current verification path then states have to be compared exactly.
+		 * 'force_exact' is needed to catch the following case:
+		 *
+		 *                initial     Here state 'succ' was processed first,
+		 *                  |         it was eventually tracked to produce a
+		 *                  V         state identical to 'hdr'.
+		 *     .---------> hdr        All branches from 'succ' had been explored
+		 *     |            |         and thus 'succ' has its .branches == 0.
+		 *     |            V
+		 *     |    .------...        Suppose states 'cur' and 'succ' correspond
+		 *     |    |       |         to the same instruction + callsites.
+		 *     |    V       V         In such case it is necessary to check
+		 *     |   ...     ...        if 'succ' and 'cur' are states_equal().
+		 *     |    |       |         If 'succ' and 'cur' are a part of the
+		 *     |    V       V         same loop exact flag has to be set.
+		 *     |   succ <- cur        To check if that is the case, verify
+		 *     |    |                 if loop entry of 'succ' is in current
+		 *     |    V                 DFS path.
+		 *     |   ...
+		 *     |    |
+		 *     '----'
+		 *
+		 * Additional details are in the comment before get_loop_entry().
+		 */
+		loop_entry = get_loop_entry(&sl->state);
+		force_exact = loop_entry && loop_entry->branches > 0;
+		if (states_equal(env, &sl->state, cur, force_exact)) {
+			if (force_exact)
+				update_loop_entry(cur, loop_entry);
 hit:
 			sl->hit_cnt++;
 			/* reached equivalent register/stack state,
@@ -16829,7 +17027,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * speed up verification
 			 */
 			*pprev = sl->next;
-			if (sl->state.frame[0]->regs[0].live & REG_LIVE_DONE) {
+			if (sl->state.frame[0]->regs[0].live & REG_LIVE_DONE &&
+			    !sl->state.used_as_loop_entry) {
 				u32 br = sl->state.branches;
 
 				WARN_ONCE(br,
-- 
2.42.0


