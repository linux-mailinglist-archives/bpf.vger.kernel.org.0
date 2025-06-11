Return-Path: <bpf+bounces-60372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0016EAD5FD4
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 22:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA551BC241F
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 20:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209A32BD5B1;
	Wed, 11 Jun 2025 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cM45BiG6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABB32882A1
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 20:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672526; cv=none; b=ktORJdrjvo/27uEFYeHxQZh/x7b21AflMsVqjwvjPvpTiPdVT8R4STCxYC52CQ2ecspLiNrJq7l6Lzp9JfNDsBeagHmPqFfUdrbjNZmxGZdOAsx1sDhTiL4NF4t6xJGxEYRTuQzIg1YgwQIb2e7hOZmrk8eEBxHNlEEInRZnja0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672526; c=relaxed/simple;
	bh=Dwbu1y0CTnASohQ7aJBFxKBxsmXOhjL/cj44YNatWoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ft+vXatHZbXI8T3QZgT6RSg5il/a/vbf1Ru5SHIRQZpsS3N3Xe3Nhy21DhcR3gztN1gxe0f5ZHN490hbt3YsihDZDcVP2em6i4rQpGVjALimNs+2yCxyidUSXc/GG266VHnaIdeDiZD5SOFG4xuhXmiLUOxJgtdK4AdXnnx1DNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cM45BiG6; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70e75f30452so1189687b3.2
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 13:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749672523; x=1750277323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7CXJYWCYAUJtqReOavwClL8UzyDoynz3OH4DdtExvH0=;
        b=cM45BiG6lQHLNpxRMkXZoFiLjesAZ4hL6Uhle9OaDrpbuTu5jJ9NAq7Qf/8fuupziq
         z/CofnsKIauNKam0720o2vGega/4470cIQQ/aNPeBCfnhRaFzzWdOhYJ9nrmx1vaiPDj
         Utb+frAELjvONl1AN8VRaGUbjppVZM60Vkq8Fzj/YtYLoZfQMTR/4EMLJUI491GO8l0t
         rrSeF7H5Y0OQJpruVFQ+pzbrozZnsMWNoxVE/g4OrGBgEjCbB51iq7v3wtEsGtjw0UQx
         SciCJOdpndr/dFaYBdqHAAKzAs59sToVtaXhYDow35/9jR9F3WMM2In4evxsX2hOnBUh
         MRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749672523; x=1750277323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CXJYWCYAUJtqReOavwClL8UzyDoynz3OH4DdtExvH0=;
        b=G8poAcfFgpe+o6s/YFqA0bHc/fRz57/TPNqfhuCoXzQmF8Re/ahTsdzpDdgCKqA0wf
         3AuFrWmGURNKb7wW4l/MXPZDWzP541OuX5rh3ROSn6UCVm+7TCPNh7q3qh/CBJaB9xcB
         XBWfTfFtPuLVrbx1G4xPlLzfiHdT1OKmXyH3nvZ9rlEwP4fVnndUbzCa7SQkZYJ0GFSH
         UajCAlRxiTWzhAUHvYTLeS4osYWd8oSQa9+x1wHCtPQZt2z0vMCyKcxlgQ2mLLgS3+2L
         L35PXEnqLsWASBm4P4dPnSgaJ97mI1w/cRbHZzXh5q/3QSYRaCbq3d6639zghMOzfuSE
         WH2Q==
X-Gm-Message-State: AOJu0Yzegbj++BXlFhZ1lP1BV+ooera9Tgt0xw5qtViEP+/Lt60K4yCV
	zb+aaJciW56Tv5L3k2MROBTvzCpE/CwQ00totOC4H55nzEltFlxWbR+5f4p7m/uz
X-Gm-Gg: ASbGncszijccwJTVUIDE+NeAFxNNn9LwKK52BkGF0zwvGttJZ6lNqBKfa1uzjtbIiTu
	mG7jY8SyZ4dtSVr53kbPccibDqd4GNOTfckrReOyaj3L9zyq/pzQBz8ExxEvoMv63L8HNTTQgr9
	gk4XyT/q91vll2pCKl2pDTWscCfgTj+3FxxeVpMvVQrTUtmW7rM4pa/5DEIJ34Rx2n/kOyloL8Z
	MF/JvwpR3AiBMOdBl2HMmH46wajpF/2WOcoJROqB+gKE8p5lH5Havmqh6VLLjZ0bftHcdHIftjS
	2xpypHSVZJSahdU8RmyPmY34MiRR8ZMv9MdXf7cqh6R69nxS55TjaQ==
X-Google-Smtp-Source: AGHT+IEgvMms1KAUzdhpN7+TOH9R+ngvbeP2oVikYPrtS7pHMqe9d7epTlNEJTZENAGZIJGrF/TVTw==
X-Received: by 2002:a05:690c:389:b0:710:f74b:61ab with SMTP id 00721157ae682-71140a0e490mr63769177b3.9.1749672523318;
        Wed, 11 Jun 2025 13:08:43 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:55::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-711527b7920sm110427b3.89.2025.06.11.13.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 13:08:43 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v3 01/11] Revert "bpf: use common instruction history across all states"
Date: Wed, 11 Jun 2025 13:08:26 -0700
Message-ID: <20250611200836.4135542-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 96a30e469ca1d2b8cc7811b40911f8614b558241.
Next patches in the series modify propagate_precision() to allow
arbitrary starting state. Precision propagation requires access to
jump history, and arbitrary states represent history not belonging to
`env->cur_state`.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  19 +++----
 kernel/bpf/verifier.c        | 107 ++++++++++++++++++-----------------
 2 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e6c26393c029..3e77befdbc4b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -344,7 +344,7 @@ struct bpf_func_state {
 
 #define MAX_CALL_FRAMES 8
 
-/* instruction history flags, used in bpf_insn_hist_entry.flags field */
+/* instruction history flags, used in bpf_jmp_history_entry.flags field */
 enum {
 	/* instruction references stack slot through PTR_TO_STACK register;
 	 * we also store stack's frame number in lower 3 bits (MAX_CALL_FRAMES is 8)
@@ -366,7 +366,7 @@ enum {
 static_assert(INSN_F_FRAMENO_MASK + 1 >= MAX_CALL_FRAMES);
 static_assert(INSN_F_SPI_MASK + 1 >= MAX_BPF_STACK / 8);
 
-struct bpf_insn_hist_entry {
+struct bpf_jmp_history_entry {
 	u32 idx;
 	/* insn idx can't be bigger than 1 million */
 	u32 prev_idx : 20;
@@ -459,14 +459,13 @@ struct bpf_verifier_state {
 	 * See get_loop_entry() for more information.
 	 */
 	struct bpf_verifier_state *loop_entry;
-	/* Sub-range of env->insn_hist[] corresponding to this state's
-	 * instruction history.
-	 * Backtracking is using it to go from last to first.
-	 * For most states instruction history is short, 0-3 instructions.
+	/* jmp history recorded from first to last.
+	 * backtracking is using it to go from last to first.
+	 * For most states jmp_history_cnt is [0-3].
 	 * For loops can go up to ~40.
 	 */
-	u32 insn_hist_start;
-	u32 insn_hist_end;
+	struct bpf_jmp_history_entry *jmp_history;
+	u32 jmp_history_cnt;
 	u32 dfs_depth;
 	u32 callback_unroll_depth;
 	u32 may_goto_depth;
@@ -776,9 +775,7 @@ struct bpf_verifier_env {
 		int cur_postorder;
 	} cfg;
 	struct backtrack_state bt;
-	struct bpf_insn_hist_entry *insn_hist;
-	struct bpf_insn_hist_entry *cur_hist_ent;
-	u32 insn_hist_cap;
+	struct bpf_jmp_history_entry *cur_hist_ent;
 	u32 pass_cnt; /* number of times do_check() was called */
 	u32 subprog_cnt;
 	/* number of instructions analyzed by the verifier */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b1f797616f20..2eee3a5d6797 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1660,6 +1660,13 @@ static void free_func_state(struct bpf_func_state *state)
 	kfree(state);
 }
 
+static void clear_jmp_history(struct bpf_verifier_state *state)
+{
+	kfree(state->jmp_history);
+	state->jmp_history = NULL;
+	state->jmp_history_cnt = 0;
+}
+
 static void free_verifier_state(struct bpf_verifier_state *state,
 				bool free_self)
 {
@@ -1670,6 +1677,7 @@ static void free_verifier_state(struct bpf_verifier_state *state,
 		state->frame[i] = NULL;
 	}
 	kfree(state->refs);
+	clear_jmp_history(state);
 	if (free_self)
 		kfree(state);
 }
@@ -1734,6 +1742,13 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	struct bpf_func_state *dst;
 	int i, err;
 
+	dst_state->jmp_history = copy_array(dst_state->jmp_history, src->jmp_history,
+					  src->jmp_history_cnt, sizeof(*dst_state->jmp_history),
+					  GFP_USER);
+	if (!dst_state->jmp_history)
+		return -ENOMEM;
+	dst_state->jmp_history_cnt = src->jmp_history_cnt;
+
 	/* if dst has more stack frames then src frame, free them, this is also
 	 * necessary in case of exceptional exits using bpf_throw.
 	 */
@@ -1751,8 +1766,6 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->parent = src->parent;
 	dst_state->first_insn_idx = src->first_insn_idx;
 	dst_state->last_insn_idx = src->last_insn_idx;
-	dst_state->insn_hist_start = src->insn_hist_start;
-	dst_state->insn_hist_end = src->insn_hist_end;
 	dst_state->dfs_depth = src->dfs_depth;
 	dst_state->callback_unroll_depth = src->callback_unroll_depth;
 	dst_state->used_as_loop_entry = src->used_as_loop_entry;
@@ -2820,14 +2833,9 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	 * The caller state doesn't matter.
 	 * This is async callback. It starts in a fresh stack.
 	 * Initialize it similar to do_check_common().
-	 * But we do need to make sure to not clobber insn_hist, so we keep
-	 * chaining insn_hist_start/insn_hist_end indices as for a normal
-	 * child state.
 	 */
 	elem->st.branches = 1;
 	elem->st.in_sleepable = is_sleepable;
-	elem->st.insn_hist_start = env->cur_state->insn_hist_end;
-	elem->st.insn_hist_end = elem->st.insn_hist_start;
 	frame = kzalloc(sizeof(*frame), GFP_KERNEL);
 	if (!frame)
 		goto err;
@@ -3856,10 +3864,11 @@ static void linked_regs_unpack(u64 val, struct linked_regs *s)
 }
 
 /* for any branch, call, exit record the history of jmps in the given state */
-static int push_insn_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
-			     int insn_flags, u64 linked_regs)
+static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
+			    int insn_flags, u64 linked_regs)
 {
-	struct bpf_insn_hist_entry *p;
+	u32 cnt = cur->jmp_history_cnt;
+	struct bpf_jmp_history_entry *p;
 	size_t alloc_size;
 
 	/* combine instruction flags if we already recorded this instruction */
@@ -3879,32 +3888,29 @@ static int push_insn_history(struct bpf_verifier_env *env, struct bpf_verifier_s
 		return 0;
 	}
 
-	if (cur->insn_hist_end + 1 > env->insn_hist_cap) {
-		alloc_size = size_mul(cur->insn_hist_end + 1, sizeof(*p));
-		p = kvrealloc(env->insn_hist, alloc_size, GFP_USER);
-		if (!p)
-			return -ENOMEM;
-		env->insn_hist = p;
-		env->insn_hist_cap = alloc_size / sizeof(*p);
-	}
+	cnt++;
+	alloc_size = kmalloc_size_roundup(size_mul(cnt, sizeof(*p)));
+	p = krealloc(cur->jmp_history, alloc_size, GFP_USER);
+	if (!p)
+		return -ENOMEM;
+	cur->jmp_history = p;
 
-	p = &env->insn_hist[cur->insn_hist_end];
+	p = &cur->jmp_history[cnt - 1];
 	p->idx = env->insn_idx;
 	p->prev_idx = env->prev_insn_idx;
 	p->flags = insn_flags;
 	p->linked_regs = linked_regs;
-
-	cur->insn_hist_end++;
+	cur->jmp_history_cnt = cnt;
 	env->cur_hist_ent = p;
 
 	return 0;
 }
 
-static struct bpf_insn_hist_entry *get_insn_hist_entry(struct bpf_verifier_env *env,
-						       u32 hist_start, u32 hist_end, int insn_idx)
+static struct bpf_jmp_history_entry *get_jmp_hist_entry(struct bpf_verifier_state *st,
+						        u32 hist_end, int insn_idx)
 {
-	if (hist_end > hist_start && env->insn_hist[hist_end - 1].idx == insn_idx)
-		return &env->insn_hist[hist_end - 1];
+	if (hist_end > 0 && st->jmp_history[hist_end - 1].idx == insn_idx)
+		return &st->jmp_history[hist_end - 1];
 	return NULL;
 }
 
@@ -3921,26 +3927,25 @@ static struct bpf_insn_hist_entry *get_insn_hist_entry(struct bpf_verifier_env *
  * history entry recording a jump from last instruction of parent state and
  * first instruction of given state.
  */
-static int get_prev_insn_idx(const struct bpf_verifier_env *env,
-			     struct bpf_verifier_state *st,
-			     int insn_idx, u32 hist_start, u32 *hist_endp)
+static int get_prev_insn_idx(struct bpf_verifier_state *st, int i,
+			     u32 *history)
 {
-	u32 hist_end = *hist_endp;
-	u32 cnt = hist_end - hist_start;
+	u32 cnt = *history;
 
-	if (insn_idx == st->first_insn_idx) {
+	if (i == st->first_insn_idx) {
 		if (cnt == 0)
 			return -ENOENT;
-		if (cnt == 1 && env->insn_hist[hist_start].idx == insn_idx)
+		if (cnt == 1 && st->jmp_history[0].idx == i)
 			return -ENOENT;
 	}
 
-	if (cnt && env->insn_hist[hist_end - 1].idx == insn_idx) {
-		(*hist_endp)--;
-		return env->insn_hist[hist_end - 1].prev_idx;
+	if (cnt && st->jmp_history[cnt - 1].idx == i) {
+		i = st->jmp_history[cnt - 1].prev_idx;
+		(*history)--;
 	} else {
-		return insn_idx - 1;
+		i--;
 	}
+	return i;
 }
 
 static const char *disasm_kfunc_name(void *data, const struct bpf_insn *insn)
@@ -4121,7 +4126,7 @@ static void fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask)
 /* If any register R in hist->linked_regs is marked as precise in bt,
  * do bt_set_frame_{reg,slot}(bt, R) for all registers in hist->linked_regs.
  */
-static void bt_sync_linked_regs(struct backtrack_state *bt, struct bpf_insn_hist_entry *hist)
+static void bt_sync_linked_regs(struct backtrack_state *bt, struct bpf_jmp_history_entry *hist)
 {
 	struct linked_regs linked_regs;
 	bool some_precise = false;
@@ -4166,7 +4171,7 @@ static bool calls_callback(struct bpf_verifier_env *env, int insn_idx);
  *   - *was* processed previously during backtracking.
  */
 static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
-			  struct bpf_insn_hist_entry *hist, struct backtrack_state *bt)
+			  struct bpf_jmp_history_entry *hist, struct backtrack_state *bt)
 {
 	struct bpf_insn *insn = env->prog->insnsi + idx;
 	u8 class = BPF_CLASS(insn->code);
@@ -4584,7 +4589,7 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
  * SCALARS, as well as any other registers and slots that contribute to
  * a tracked state of given registers/stack slots, depending on specific BPF
  * assembly instructions (see backtrack_insns() for exact instruction handling
- * logic). This backtracking relies on recorded insn_hist and is able to
+ * logic). This backtracking relies on recorded jmp_history and is able to
  * traverse entire chain of parent states. This process ends only when all the
  * necessary registers/slots and their transitive dependencies are marked as
  * precise.
@@ -4701,9 +4706,8 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 
 	for (;;) {
 		DECLARE_BITMAP(mask, 64);
-		u32 hist_start = st->insn_hist_start;
-		u32 hist_end = st->insn_hist_end;
-		struct bpf_insn_hist_entry *hist;
+		u32 history = st->jmp_history_cnt;
+		struct bpf_jmp_history_entry *hist;
 
 		if (env->log.level & BPF_LOG_LEVEL2) {
 			verbose(env, "mark_precise: frame%d: last_idx %d first_idx %d subseq_idx %d \n",
@@ -4741,7 +4745,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				err = 0;
 				skip_first = false;
 			} else {
-				hist = get_insn_hist_entry(env, hist_start, hist_end, i);
+				hist = get_jmp_hist_entry(st, history, i);
 				err = backtrack_insn(env, i, subseq_idx, hist, bt);
 			}
 			if (err == -ENOTSUPP) {
@@ -4758,7 +4762,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				 */
 				return 0;
 			subseq_idx = i;
-			i = get_prev_insn_idx(env, st, i, hist_start, &hist_end);
+			i = get_prev_insn_idx(st, i, &history);
 			if (i == -ENOENT)
 				break;
 			if (i >= env->prog->len) {
@@ -5122,7 +5126,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	}
 
 	if (insn_flags)
-		return push_insn_history(env, env->cur_state, insn_flags, 0);
+		return push_jmp_history(env, env->cur_state, insn_flags, 0);
 	return 0;
 }
 
@@ -5429,7 +5433,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 		insn_flags = 0; /* we are not restoring spilled register */
 	}
 	if (insn_flags)
-		return push_insn_history(env, env->cur_state, insn_flags, 0);
+		return push_jmp_history(env, env->cur_state, insn_flags, 0);
 	return 0;
 }
 
@@ -16554,7 +16558,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	if (dst_reg->type == SCALAR_VALUE && dst_reg->id)
 		collect_linked_regs(this_branch, dst_reg->id, &linked_regs);
 	if (linked_regs.cnt > 1) {
-		err = push_insn_history(env, this_branch, 0, linked_regs_pack(&linked_regs));
+		err = push_jmp_history(env, this_branch, 0, linked_regs_pack(&linked_regs));
 		if (err)
 			return err;
 	}
@@ -19052,7 +19056,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 
 	force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx) ||
 			  /* Avoid accumulating infinitely long jmp history */
-			  cur->insn_hist_end - cur->insn_hist_start > 40;
+			  cur->jmp_history_cnt > 40;
 
 	/* bpf progs typically have pruning point every 4 instructions
 	 * http://vger.kernel.org/bpfconf2019.html#session-1
@@ -19251,7 +19255,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * the current state.
 			 */
 			if (is_jmp_point(env, env->insn_idx))
-				err = err ? : push_insn_history(env, cur, 0, 0);
+				err = err ? : push_jmp_history(env, cur, 0, 0);
 			err = err ? : propagate_precision(env, &sl->state);
 			if (err)
 				return err;
@@ -19333,8 +19337,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 
 	cur->parent = new;
 	cur->first_insn_idx = insn_idx;
-	cur->insn_hist_start = cur->insn_hist_end;
 	cur->dfs_depth = new->dfs_depth + 1;
+	clear_jmp_history(cur);
 	list_add(&new_sl->node, head);
 
 	/* connect new state to parentage chain. Current frame needs all
@@ -19704,7 +19708,7 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 
 		if (is_jmp_point(env, env->insn_idx)) {
-			err = push_insn_history(env, state, 0, 0);
+			err = push_jmp_history(env, state, 0, 0);
 			if (err)
 				return err;
 		}
@@ -24291,7 +24295,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
 	vfree(env->insn_aux_data);
-	kvfree(env->insn_hist);
 err_free_env:
 	kvfree(env->cfg.insn_postorder);
 	kvfree(env);
-- 
2.47.1


