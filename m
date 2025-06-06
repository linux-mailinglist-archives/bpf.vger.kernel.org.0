Return-Path: <bpf+bounces-59935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF03BAD094A
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B3D3B523A
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877DB21D58F;
	Fri,  6 Jun 2025 21:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGs+zJ5B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89D821FF5F
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749243880; cv=none; b=UNuFGFTWjGiCtPY8xYmrBaJ6K9wdCdT87vzTYYWXWlU4iTUgtjCMLBe4feNfzqlfFJ2/QqwJN//0m88EAUzU0puqRdPqiS7ahNLYHCY2VbRyYkbpDqXgC3M66vZbJSbJpwMLN1HZIWDiMCJfu819zFm59shWQaXyMarzYK1gmQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749243880; c=relaxed/simple;
	bh=mK2RhiztAm7Przmw9mXcGHCdXI6713RTczGVj0D2t0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pM5dloXr5UkQrxMtbbzGaqsBKWNA9YykYrnqxIyYzliUzDmW4UVNL7AerccdgBPjAaTdFOlye5wdVibVqITnof2aSJqGBQQpXLdiBdG52NAtVYZPrjYu633Q7FgrRxBXa66bnK1yCplONKO7qJfFoQDWo2n/xQ15VA7SlkOf57I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGs+zJ5B; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74267c68c11so2156156b3a.0
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 14:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749243877; x=1749848677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heESxlhC9JQn+JOxvYYTiXcfKkLbWNwGshFz4SJllh8=;
        b=RGs+zJ5BG6+Ct4Vh+0MULDS87Ob/UFZojOaH+OOYBwHI67mSyFvJ0xJYnLjABz+nwJ
         z9axzR/yGgB8sgOgz5EKo7HO32RzstUgnrt24n3t8BgKiLfs9rRec4DmeQio+rHM6ez5
         5EiBx8kH5Zu6sxxmPU4Dh/K6c4yNuPjmurwR9e+4DM3s7i/wdIZ7m7YlPPJeB2SwLVVL
         zKAaLL6tk+62CNm3Tx2eGRindsTIpx882M6XkHzycgC+pPFMh2vlLQQwdcLCsjKTtsTz
         h0MixGSGqyoiESbjEocClGBR85C/mSBNIyENf8YvSXpX39fMhWZk7RkykVu5DZPcxHh7
         2KAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749243877; x=1749848677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heESxlhC9JQn+JOxvYYTiXcfKkLbWNwGshFz4SJllh8=;
        b=rkKv+kBOSRQ+78vSF6lWROfaKYOX5VN2vKtdnvwmZuOSQEvRYYrLDulZtefgn+6IWW
         KGGsEoU0/RxGXlp2hKmrcyBi6FcitRpTRg7lqJZYmlRug2p1ECgHugWtMKDENUd0IeR0
         GRIh0ZEaN4sAFj8yuIiVvgjTcJmWwD3sB6wyCLl3eB2guVkhQY3wEr7kXCNISqGH6Aka
         Es2/dEec00Jsz2bDhwJbHRQARkVsTPEgS/pJ86VWkeZNN9Q/CuNesj86QsKgzIFstZSb
         p17esSCahc/oAGUJaoAOGuteKeWQnlaQPuJFLtTSMkUxZhXo6deD3ySKbm5Kqvab/Cop
         pJ3A==
X-Gm-Message-State: AOJu0YyXxBDGMR5xudS51gc2/YzyOJnmJDfDnZfQ/6YGl2opmsJgjfF8
	/AkV8eO/82561w78Zvg/zawCaBwilDx973z8iSHgr58+RJwaF6jTe6vpfy4SAaEo
X-Gm-Gg: ASbGncsMo+lsByrHKdBL75DFhhhDaeG6YBC/kG44HokFUNSY8o8ETjxLCyWvvcZSXQG
	KqhLu5blYwTlHq9KWUuAHoRic5dLFpCrYoPW+ZPZ4i5FrfsMt/jUYJPiuvQ1ALeVPUIrocN6XVe
	G6Z0OBfa4/qjueFstwyiTWhEjIvNtQqtQ9CDEnYBJChOiSxwfhNa+2MTgJiodFAe0z9omYEjUm2
	qUL5nvXJgu+KkXgWgUShWPF+LCAtIZ6rDSxIuHnZUJRsNgsdOKzYdPLCN7To/ocTI8CR8jN0BuG
	SDdBicU8CKi7hyOyRywQq4aOoyOsxeDhgeLZalA5ZT8uweqDRoWCTq/UOg==
X-Google-Smtp-Source: AGHT+IFLepX0sQVbtChaHmmrSO8lH2brisSrZRmfjVO9FRXbXicZekWhz/fmwEdvJeNaHiIosnprqw==
X-Received: by 2002:a05:6a20:9190:b0:215:e1cc:6360 with SMTP id adf61e73a8af0-21ee2555999mr5705466637.11.1749243876398;
        Fri, 06 Jun 2025 14:04:36 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5ed58beasm1352640a12.15.2025.06.06.14.04.35
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
Subject: [PATCH bpf-next v2 08/11] bpf: propagate read/precision marks over state graph backedges
Date: Fri,  6 Jun 2025 14:03:49 -0700
Message-ID: <20250606210352.1692944-9-eddyz87@gmail.com>
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

Current loop_entry-based exact states comparison logic does not handle
the following case:

 .-> A --.  Assume the states are visited in the order A, B, C.
 |   |   |  Assume that state B reaches a state equivalent to state A.
 |   v   v  At this point, state C is not processed yet, so state A
 '-- B   C  has not received any read or precision marks from C.
            As a result, these marks won't be propagated to B.

If B has incomplete marks, it is unsafe to use it in states_equal()
checks.

This commit replaces the existing logic with the following:
- Strongly connected components (SCCs) are computed over the program's
  control flow graph (intraprocedurally).
- When a verifier state enters an SCC, that state is recorded as the
  SCC entry point.
- When a verifier state is found equivalent to another (e.g., B to A
  in the example), it is recorded as a states graph backedge.
  Backedges are accumulated per SCC.
- When an SCC entry state reaches `branches == 0`, read and precision
  marks are propagated through the backedges (e.g., from A to B, from
  C to A, and then again from A to B).

To support nested subprogram calls, the entry state and backedge list
are associated not with the SCC itself but with an object called
`bpf_scc_callchain`. A callchain is a tuple `(callsite*, scc_id)`,
where `callsite` is the index of a call instruction for each frame
except the last.

See the comments added in `is_state_visited()` and
`compute_scc_callchain()` for more details.

Fixes: 2a0992829ea3 ("bpf: correct loop detection for iterators convergence")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  38 +++
 kernel/bpf/verifier.c        | 454 +++++++++++++++++++++++++++++------
 2 files changed, 423 insertions(+), 69 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f0b4e48c9d90..5190d71bd8fb 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -459,6 +459,10 @@ struct bpf_verifier_state {
 	 * See get_loop_entry() for more information.
 	 */
 	struct bpf_verifier_state *loop_entry;
+	/* if this state is a backedge state then equal_state
+	 * records cached state to which this state is equal.
+	 */
+	struct bpf_verifier_state *equal_state;
 	/* jmp history recorded from first to last.
 	 * backtracking is using it to go from last to first.
 	 * For most states jmp_history_cnt is [0-3].
@@ -722,6 +726,37 @@ struct bpf_idset {
 	u32 ids[BPF_ID_MAP_SIZE];
 };
 
+/* see verifier.c:compute_scc_callchain() */
+struct bpf_scc_callchain {
+	/* call sites from bpf_verifier_state->frame[*]->callsite leading to this SCC */
+	u32 callsites[MAX_CALL_FRAMES - 1];
+	/* last frame in a chain is identified by SCC id */
+	u32 scc;
+};
+
+/* verifier state waiting for propagate_backedges() */
+struct bpf_scc_backedge {
+	struct bpf_scc_backedge *next;
+	struct bpf_verifier_state state;
+};
+
+struct bpf_scc_visit {
+	struct bpf_scc_callchain callchain;
+	/* first state in current verification path that entered SCC
+	 * identified by the callchain
+	 */
+	struct bpf_verifier_state *entry_state;
+	struct bpf_scc_backedge *backedges; /* list of backedges */
+};
+
+/* An array of bpf_scc_visit structs sharing tht same bpf_scc_callchain->scc
+ * but having different bpf_scc_callchain->callsites.
+ */
+struct bpf_scc_info {
+	u32 num_visits;
+	struct bpf_scc_visit visits[];
+};
+
 /* single container for all structs
  * one verifier_env per bpf_check() call
  */
@@ -818,6 +853,9 @@ struct bpf_verifier_env {
 	char tmp_str_buf[TMP_STR_BUF_LEN];
 	struct bpf_insn insn_buf[INSN_BUF_SIZE];
 	struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
+	/* array of pointers to bpf_scc_info indexed by SCC id */
+	struct bpf_scc_info **scc_info;
+	u32 scc_cnt;
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4dd95f34f7fd..9a5af34f5917 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1699,6 +1699,9 @@ static struct bpf_verifier_state_list *state_loop_entry_as_list(struct bpf_verif
 	return NULL;
 }
 
+static bool incomplete_read_marks(struct bpf_verifier_env *env,
+				  struct bpf_verifier_state *st);
+
 /* A state can be freed if it is no longer referenced:
  * - is in the env->free_list;
  * - has no children states;
@@ -1709,20 +1712,14 @@ static struct bpf_verifier_state_list *state_loop_entry_as_list(struct bpf_verif
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
-		list_del(&sl->node);
-		free_verifier_state(&sl->state, false);
-		kfree(sl);
-		env->free_list_size--;
-		sl = loop_entry_sl;
-	}
+	if (!sl->in_free_list
+	    || sl->state.branches != 0
+	    || incomplete_read_marks(env, &sl->state))
+		return;
+	list_del(&sl->node);
+	free_verifier_state(&sl->state, false);
+	kfree(sl);
+	env->free_list_size--;
 }
 
 /* copy verifier state from src to dst growing dst stack space
@@ -1770,6 +1767,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->used_as_loop_entry = src->used_as_loop_entry;
 	dst_state->may_goto_depth = src->may_goto_depth;
 	dst_state->loop_entry = src->loop_entry;
+	dst_state->equal_state = src->equal_state;
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
 		if (!dst) {
@@ -1971,22 +1969,218 @@ static u32 frame_insn_idx(struct bpf_verifier_state *st, u32 frame)
 	       : st->frame[frame + 1]->callsite;
 }
 
-static void update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+/* For state @st look for a topmost frame with frame_insn_idx() in some SCC,
+ * if such frame exists form a corresponding @callchain as an array of
+ * call sites leading to this frame and SCC id.
+ * E.g.:
+ *
+ *    void foo()  { A: loop {... SCC#1 ...}; }
+ *    void bar()  { B: loop { C: foo(); ... SCC#2 ... }
+ *                  D: loop { E: foo(); ... SCC#3 ... } }
+ *    void main() { F: bar(); }
+ *
+ * @callchain at (A) would be either (F,SCC#2) or (F,SCC#3) depending
+ * on @st frame call sites being (F,C,A) or (F,E,A).
+ */
+static bool compute_scc_callchain(struct bpf_verifier_env *env,
+				  struct bpf_verifier_state *st,
+				  struct bpf_scc_callchain *callchain)
+{
+	u32 i, scc, insn_idx;
+
+	memset(callchain, 0, sizeof(*callchain));
+	for (i = 0; i <= st->curframe; i++) {
+		insn_idx = frame_insn_idx(st, i);
+		scc = env->insn_aux_data[insn_idx].scc;
+		if (scc) {
+			callchain->scc = scc;
+			break;
+		} else if (i < st->curframe) {
+			callchain->callsites[i] = insn_idx;
+		} else {
+			return false;
+		}
+	}
+	return true;
+}
+
+/* Check if bpf_scc_visit instance for @callchain exists. */
+static struct bpf_scc_visit *scc_visit_lookup(struct bpf_verifier_env *env,
+					      struct bpf_scc_callchain *callchain)
+{
+	struct bpf_scc_info *info = env->scc_info[callchain->scc];
+	struct bpf_scc_visit *visits = info->visits;
+	u32 i;
+
+	if (!info)
+		return NULL;
+	for (i = 0; i < info->num_visits; i++)
+		if (memcmp(callchain, &visits[i].callchain, sizeof(*callchain)) == 0)
+			return &visits[i];
+	return NULL;
+}
+
+/* Allocate a new bpf_scc_visit instance corresponding to @callchain.
+ * Allocated instances are alive for a duration of the do_check_common()
+ * call and are freed by free_states().
+ */
+static struct bpf_scc_visit *scc_visit_alloc(struct bpf_verifier_env *env,
+					     struct bpf_scc_callchain *callchain)
+{
+	struct bpf_scc_visit *visit;
+	struct bpf_scc_info *info;
+	u32 scc, num_visits;
+	u64 new_sz;
+
+	scc = callchain->scc;
+	info = env->scc_info[scc];
+	num_visits = info ? info->num_visits : 0;
+	new_sz = sizeof(*info) + sizeof(struct bpf_scc_visit) * (num_visits + 1);
+	info = kvrealloc(env->scc_info[scc], new_sz, GFP_KERNEL);
+	if (!info)
+		return NULL;
+	env->scc_info[scc] = info;
+	info->num_visits = num_visits + 1;
+	visit = &info->visits[num_visits];
+	memset(visit, 0, sizeof(*visit));
+	memcpy(&visit->callchain, callchain, sizeof(*callchain));
+	return visit;
+}
+
+/* Form a string '(callsite#1,callsite#2,...,scc)' in env->tmp_str_buf */
+static char *format_callchain(struct bpf_verifier_env *env, struct bpf_scc_callchain *callchain)
+{
+	char *buf = env->tmp_str_buf;
+	int i, delta = 0;
+
+	delta += snprintf(buf + delta, TMP_STR_BUF_LEN - delta, "(");
+	for (i = 0; i < ARRAY_SIZE(callchain->callsites); i++) {
+		if (!callchain->callsites[i])
+			break;
+		delta += snprintf(buf + delta, TMP_STR_BUF_LEN - delta, "%u,",
+				  callchain->callsites[i]);
+	}
+	delta += snprintf(buf + delta, TMP_STR_BUF_LEN - delta, "%u)", callchain->scc);
+	return env->tmp_str_buf;
+}
+
+/* If callchain for @st exists (@st is in some SCC), ensure that
+ * bpf_scc_visit instance for this callchain exists.
+ * If instance does not exist or is empty, assign visit->entry_state to @st.
+ */
+static int maybe_enter_scc(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct bpf_scc_callchain callchain;
+	struct bpf_scc_visit *visit;
+
+	if (!compute_scc_callchain(env, st, &callchain))
+		return 0;
+	visit = scc_visit_lookup(env, &callchain);
+	visit = visit ?: scc_visit_alloc(env, &callchain);
+	if (!visit)
+		return -ENOMEM;
+	if (!visit->entry_state) {
+		visit->entry_state = st;
+		if (env->log.level & BPF_LOG_LEVEL2)
+			verbose(env, "SCC enter %s\n", format_callchain(env, &callchain));
+	}
+	return 0;
+}
+
+static int propagate_backedges(struct bpf_verifier_env *env, struct bpf_scc_visit *visit);
+
+/* If callchain for @st exists (@st is in some SCC), make it empty:
+ * - set visit->entry_state to NULL;
+ * - flush accumulated backedges.
+ */
+static int maybe_exit_scc(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct bpf_scc_callchain callchain;
+	struct bpf_scc_visit *visit;
+
+	if (!compute_scc_callchain(env, st, &callchain))
+		return 0;
+	visit = scc_visit_lookup(env, &callchain);
+	if (!visit) {
+		verifier_bug(env, "scc exit: no visit info for call chain %s",
+			     format_callchain(env, &callchain));
+		return -EFAULT;
+	}
+	if (visit->entry_state != st)
+		return 0;
+	if (env->log.level & BPF_LOG_LEVEL2)
+		verbose(env, "SCC exit %s\n", format_callchain(env, &callchain));
+	visit->entry_state = NULL;
+	return propagate_backedges(env, visit);
+}
+
+/* Lookup an bpf_scc_visit instance corresponding to @st callchain
+ * and add @backedge to visit->backedges. @st callchain must exist.
+ */
+static int add_scc_backedge(struct bpf_verifier_env *env,
+			    struct bpf_verifier_state *st,
+			    struct bpf_scc_backedge *backedge)
+{
+	struct bpf_scc_callchain callchain;
+	struct bpf_scc_visit *visit;
+
+	if (!compute_scc_callchain(env, st, &callchain)) {
+		verifier_bug(env, "add backedge: no SCC in verification path, insn_idx %d",
+			     st->insn_idx);
+		return -EFAULT;
+	}
+	visit = scc_visit_lookup(env, &callchain);
+	if (!visit) {
+		verifier_bug(env, "add backedge: no visit info for call chain %s",
+			     format_callchain(env, &callchain));
+		return -EFAULT;
+	}
+	if (env->log.level & BPF_LOG_LEVEL2)
+		verbose(env, "SCC backedge %s\n", format_callchain(env, &callchain));
+	backedge->next = visit->backedges;
+	visit->backedges = backedge;
+	return 0;
+}
+
+/* bpf_reg_state->live marks for registers in a state @st are incomplete,
+ * if state @st is in some SCC and not all execution paths starting at this
+ * SCC are fully explored.
+ */
+static bool incomplete_read_marks(struct bpf_verifier_env *env,
+				  struct bpf_verifier_state *st)
+{
+	struct bpf_scc_callchain callchain;
+	struct bpf_scc_visit *visit;
+
+	if (!compute_scc_callchain(env, st, &callchain))
+		return false;
+	visit = scc_visit_lookup(env, &callchain);
+	if (!visit)
+		return false;
+	return !!visit->backedges;
+}
+
+static void free_backedges(struct bpf_scc_visit *visit)
+{
+	struct bpf_scc_backedge *backedge, *next;
+
+	for (backedge = visit->backedges; backedge; backedge = next) {
+		free_verifier_state(&backedge->state, false);
+		next = backedge->next;
+		kvfree(backedge);
+	}
+	visit->backedges = NULL;
+}
+
+static int update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
 {
 	struct bpf_verifier_state_list *sl = NULL, *parent_sl;
 	struct bpf_verifier_state *parent;
+	int err;
 
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
@@ -1995,6 +2189,9 @@ static void update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifi
 			  br);
 		if (br)
 			break;
+		err = maybe_exit_scc(env, st);
+		if (err)
+			return err;
 		parent = st->parent;
 		parent_sl = state_parent_as_list(st);
 		if (sl)
@@ -2002,6 +2199,7 @@ static void update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifi
 		st = parent;
 		sl = parent_sl;
 	}
+	return 0;
 }
 
 static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
@@ -16504,7 +16702,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	}
 
 	if (insn_flags) {
-		err = push_insn_history(env, this_branch, insn_flags, 0);
+		err = push_jmp_history(env, this_branch, insn_flags, 0);
 		if (err)
 			return err;
 	}
@@ -18329,7 +18527,6 @@ static void clean_verifier_state(struct bpf_verifier_env *env,
 static void clean_live_states(struct bpf_verifier_env *env, int insn,
 			      struct bpf_verifier_state *cur)
 {
-	struct bpf_verifier_state *loop_entry;
 	struct bpf_verifier_state_list *sl;
 	struct list_head *pos, *head;
 
@@ -18338,15 +18535,14 @@ static void clean_live_states(struct bpf_verifier_env *env, int insn,
 		sl = container_of(pos, struct bpf_verifier_state_list, node);
 		if (sl->state.branches)
 			continue;
-		loop_entry = get_loop_entry(env, &sl->state);
-		if (!IS_ERR_OR_NULL(loop_entry) && loop_entry->branches)
-			continue;
 		if (sl->state.insn_idx != insn ||
 		    !same_callsites(&sl->state, cur))
 			continue;
 		if (sl->state.frame[0]->regs[0].live & REG_LIVE_DONE)
 			/* all regs in this state in all frames were already marked */
 			continue;
+		if (incomplete_read_marks(env, &sl->state))
+			continue;
 		clean_verifier_state(env, &sl->state);
 	}
 }
@@ -18948,6 +19144,46 @@ static int propagate_precision(struct bpf_verifier_env *env,
 	return 0;
 }
 
+#define MAX_BACKEDGE_ITERS 64
+
+/* Propagate read and precision marks from visit->backedges[*].state->equal_state
+ * to corresponding parent states of visit->backedges[*].state until fixed point is reached,
+ * then free visit->backedges.
+ * After execution of this function incomplete_read_marks() will return false
+ * for all states corresponding to @visit->callchain.
+ */
+static int propagate_backedges(struct bpf_verifier_env *env, struct bpf_scc_visit *visit)
+{
+	struct bpf_scc_backedge *backedge;
+	struct bpf_verifier_state *st;
+	bool changed;
+	int i, err;
+
+	i = 0;
+	do {
+		if (i++ > MAX_BACKEDGE_ITERS) {
+			if (env->log.level & BPF_LOG_LEVEL2)
+				verbose(env, "%s: too many iterations\n", __func__);
+			for (backedge = visit->backedges; backedge; backedge = backedge->next)
+				mark_all_scalars_precise(env, &backedge->state);
+			break;
+		}
+		changed = false;
+		for (backedge = visit->backedges; backedge; backedge = backedge->next) {
+			st = &backedge->state;
+			err = propagate_liveness(env, st->equal_state, st, &changed);
+			if (err)
+				return err;
+			err = propagate_precision(env, st->equal_state, st, &changed);
+			if (err)
+				return err;
+		}
+	} while (changed);
+
+	free_backedges(visit);
+	return 0;
+}
+
 static bool states_maybe_looping(struct bpf_verifier_state *old,
 				 struct bpf_verifier_state *cur)
 {
@@ -19057,9 +19293,9 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 {
 	struct bpf_verifier_state_list *new_sl;
 	struct bpf_verifier_state_list *sl;
-	struct bpf_verifier_state *cur = env->cur_state, *new, *loop_entry;
+	struct bpf_verifier_state *cur = env->cur_state, *new;
+	bool force_new_state, add_new_state, loop;
 	int i, j, n, err, states_cnt = 0;
-	bool force_new_state, add_new_state, force_exact;
 	struct list_head *pos, *tmp, *head;
 
 	force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx) ||
@@ -19081,6 +19317,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 
 	clean_live_states(env, insn_idx, cur);
 
+	loop = false;
 	head = explored_state(env, insn_idx);
 	list_for_each_safe(pos, tmp, head) {
 		sl = container_of(pos, struct bpf_verifier_state_list, node);
@@ -19160,7 +19397,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 					spi = __get_spi(iter_reg->off + iter_reg->var_off.value);
 					iter_state = &func(env, iter_reg)->stack[spi].spilled_ptr;
 					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE) {
-						update_loop_entry(env, cur, &sl->state);
+						loop = true;
 						goto hit;
 					}
 				}
@@ -19169,7 +19406,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			if (is_may_goto_insn_at(env, insn_idx)) {
 				if (sl->state.may_goto_depth != cur->may_goto_depth &&
 				    states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
-					update_loop_entry(env, cur, &sl->state);
+					loop = true;
 					goto hit;
 				}
 			}
@@ -19211,38 +19448,9 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
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
-		if (states_equal(env, &sl->state, cur, force_exact ? RANGE_WITHIN : NOT_EXACT)) {
-			if (force_exact)
-				update_loop_entry(env, cur, loop_entry);
+		/* See comments for mark_all_regs_read_and_precise() */
+		loop = incomplete_read_marks(env, &sl->state);
+		if (states_equal(env, &sl->state, cur, loop ? RANGE_WITHIN : NOT_EXACT)) {
 hit:
 			sl->hit_cnt++;
 			/* reached equivalent register/stack state,
@@ -19267,6 +19475,94 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			err = err ? : propagate_precision(env, &sl->state, cur, NULL);
 			if (err)
 				return err;
+			/* When processing iterator based loops above propagate_liveness and
+			 * propagate_precision calls are not sufficient to transfer all relevant
+			 * read and precision marks. E.g. consider the following case:
+			 *
+			 *  .-> A --.  Assume the states are visited in the order A, B, C.
+			 *  |   |   |  Assume that state B reaches a state equivalent to state A.
+			 *  |   v   v  At this point, state C is not processed yet, so state A
+			 *  '-- B   C  has not received any read or precision marks from C.
+			 *             Thus, marks propagated from A to B are incomplete.
+			 *
+			 * The verifier mitigates this by performing the following steps:
+			 *
+			 * - Prior to the main verification pass, strongly connected components
+			 *   (SCCs) are computed over the program's control flow graph,
+			 *   intraprocedurally.
+			 *
+			 * - During the main verification pass, `maybe_enter_scc()` checks
+			 *   whether the current verifier state is entering an SCC. If so, an
+			 *   instance of a `bpf_scc_visit` object is created, and the state
+			 *   entering the SCC is recorded as the entry state.
+			 *
+			 * - This instance is associated not with the SCC itself, but with a
+			 *   `bpf_scc_callchain`: a tuple consisting of the call sites leading to
+			 *   the SCC and the SCC id. See `compute_scc_callchain()`.
+			 *
+			 * - When a verification path encounters a `states_equal(...,
+			 *   RANGE_WITHIN)` condition, there exists a call chain describing the
+			 *   current state and a corresponding `bpf_scc_visit` instance. A copy
+			 *   of the current state is created and added to
+			 *   `bpf_scc_visit->backedges`.
+			 *
+			 * - When a verification path terminates, `maybe_exit_scc()` is called
+			 *   from `update_branch_counts()`. For states with `branches == 0`, it
+			 *   checks whether the state is the entry state of any `bpf_scc_visit`
+			 *   instance. If it is, this indicates that all paths originating from
+			 *   this SCC visit have been explored. `propagate_backedges()` is then
+			 *   called, which propagates read and precision marks through the
+			 *   backedges until a fixed point is reached.
+			 *   (In the earlier example, this would propagate marks from A to B,
+			 *    from C to A, and then again from A to B.)
+			 *
+			 * A note on callchains
+			 * --------------------
+			 *
+			 * Consider the following example:
+			 *
+			 *     void foo() { loop { ... SCC#1 ... } }
+			 *     void main() {
+			 *       A: foo();
+			 *       B: ...
+			 *       C: foo();
+			 *     }
+			 *
+			 * Here, there are two distinct callchains leading to SCC#1:
+			 * - (A, SCC#1)
+			 * - (C, SCC#1)
+			 *
+			 * Each callchain identifies a separate `bpf_scc_visit` instance that
+			 * accumulates backedge states. The `propagate_{liveness,precision}()`
+			 * functions traverse the parent state of each backedge state, which
+			 * means these parent states must remain valid (i.e., not freed) while
+			 * the corresponding `bpf_scc_visit` instance exists.
+			 *
+			 * Associating `bpf_scc_visit` instances directly with SCCs instead of
+			 * callchains would break this invariant:
+			 * - States explored during `C: foo()` would contribute backedges to
+			 *   SCC#1, but SCC#1 would only be exited once the exploration of
+			 *   `A: foo()` completes.
+			 * - By that time, the states explored between `A: foo()` and `C: foo()`
+			 *   (i.e., `B: ...`) may have already been freed, causing the parent
+			 *   links for states from `C: foo()` to become invalid.
+			 */
+			if (loop) {
+				struct bpf_scc_backedge *backedge;
+
+				backedge = kzalloc(sizeof(*backedge), GFP_KERNEL);
+				if (!backedge)
+					return -ENOMEM;
+				err = copy_verifier_state(&backedge->state, cur);
+				backedge->state.equal_state = &sl->state;
+				backedge->state.insn_idx = insn_idx;
+				err = err ?: add_scc_backedge(env, &sl->state, backedge);
+				if (err) {
+					free_verifier_state(&backedge->state, false);
+					kvfree(backedge);
+					return err;
+				}
+			}
 			return 1;
 		}
 miss:
@@ -19342,6 +19638,12 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	new->insn_idx = insn_idx;
 	WARN_ONCE(new->branches != 1,
 		  "BUG is_state_visited:branches_to_explore=%d insn %d\n", new->branches, insn_idx);
+	err = maybe_enter_scc(env, new);
+	if (err) {
+		free_verifier_state(new, false);
+		kvfree(new_sl);
+		return err;
+	}
 
 	cur->parent = new;
 	cur->first_insn_idx = insn_idx;
@@ -19719,7 +20021,9 @@ static int do_check(struct bpf_verifier_env *env)
 					return err;
 process_bpf_exit:
 				mark_verifier_state_scratched(env);
-				update_branch_counts(env, env->cur_state);
+				err = update_branch_counts(env, env->cur_state);
+				if (err)
+					return err;
 				err = pop_stack(env, &prev_insn_idx,
 						&env->insn_idx, pop_log);
 				if (err < 0) {
@@ -19727,9 +20031,6 @@ static int do_check(struct bpf_verifier_env *env)
 						return err;
 					break;
 				} else {
-					if (verifier_bug_if(env->cur_state->loop_entry, env,
-							    "broken loop detection"))
-						return -EFAULT;
 					do_print_state = true;
 					continue;
 				}
@@ -22698,7 +22999,8 @@ static void free_states(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state_list *sl;
 	struct list_head *head, *pos, *tmp;
-	int i;
+	struct bpf_scc_info *info;
+	int i, j;
 
 	list_for_each_safe(pos, tmp, &env->free_list) {
 		sl = container_of(pos, struct bpf_verifier_state_list, node);
@@ -22707,6 +23009,14 @@ static void free_states(struct bpf_verifier_env *env)
 	}
 	INIT_LIST_HEAD(&env->free_list);
 
+	for (i = 0; i < env->scc_cnt; ++i) {
+		info = env->scc_info[i];
+		for (j = 0; j < info->num_visits; j++)
+			free_backedges(&info->visits[j]);
+		kvfree(info);
+		env->scc_info[i] = NULL;
+	}
+
 	if (!env->explored_states)
 		return;
 
@@ -24139,6 +24449,11 @@ static int compute_scc(struct bpf_verifier_env *env)
 			dfs_sz--;
 		}
 	}
+	env->scc_info = kvcalloc(next_scc_id, sizeof(*env->scc_info), GFP_KERNEL);
+	if (!env->scc_info) {
+		err = -ENOMEM;
+		goto exit;
+	}
 exit:
 	kvfree(stack);
 	kvfree(pre);
@@ -24414,6 +24729,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	vfree(env->insn_aux_data);
 err_free_env:
 	kvfree(env->cfg.insn_postorder);
+	kvfree(env->scc_info);
 	kvfree(env);
 	return ret;
 }
-- 
2.48.1


