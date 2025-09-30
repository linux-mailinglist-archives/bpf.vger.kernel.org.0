Return-Path: <bpf+bounces-70038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D713BACE98
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 14:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 210BA7A535C
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E6C3019D1;
	Tue, 30 Sep 2025 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnXKNWQK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E5C301714
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236351; cv=none; b=AScZFYpuedWBNv9FmzjrSmF3mPmtdQYVHiHGIJPDqms7myE+RUs7S0fEy2OO+6HdGd820yvwb0KSCLn5W2E73XEcLkwZpfIDPYw67DiOzuK13jndQJlb4nQQgli8LKvSEj5L4CqHu3QWJ0yQbUhv8VSTysht/OPGUotCh35hABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236351; c=relaxed/simple;
	bh=D2ve1Z2BnnfnjuJaTL9RLgNWY7fB2R2renKNEMAZCYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BS2G9hfRsaOCFcp6c45eSZCuWimzFGLvIAnkzBVoX6ICuHbd3l+maZxqtA3RSKeYhBwpauX98Ocp4f+ZgBrPLWqJAlnh7SIAEWzJ6T5m+jNCVgZUj3mYrseqMi6aU7xn4eBf/cwwABopnWTuBCasOlrM4BsU/Q48QELPU5GLgso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnXKNWQK; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso4007656f8f.2
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 05:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759236345; x=1759841145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNqc27kSWG91vhiGJj/R4NFiMzpAII5kSswbAIZLCfA=;
        b=WnXKNWQKlrL3hU4noDIISjgixZRhefEtl//Ew87NB8B1a9Uy2YldvkaCsrBWVWTYz7
         v6NeeQMCYCKs92vMSdbIQonGFdEi7+/24sQ9h0t/SG5nPbnNsLbPTLPX0BMYr44qVl5z
         wjTa1DhjvQZ4xcsqoTEL0bB0RD0Z3m8Vb2R3+MoyHcCN/wBcJeSwnjFziirmjqjeIx64
         LTfPusMOFpH1DUi7mFdiUK36DU/VMFa5zLWrCHvU42p9mo6RTJX7uljeVqFv4NLYRiDf
         K5f9BznveXzEMb8NJrDy8ERZ1cR9cHs07KnLUzXNjpYyd6j2x9vxrwhHq9XAOuumTphI
         zQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759236345; x=1759841145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNqc27kSWG91vhiGJj/R4NFiMzpAII5kSswbAIZLCfA=;
        b=LMIsdFS7US/PHSzq9k2C6BXcwe7SkhAjyytR2yZaSoQnE+t65xt1gtKDVZ6wn02up4
         Dtg9lT/qu/ytZO4ypKAOpFsRk7Y5tYdgiPlytrNjFWeBO7no5DNrS1doIbX4Oo2BEDlf
         IM0BjaWCcwx6qzwf/YDxVx/j+gTeKtWQ68//DxKcBOBbBodz1ft+7HXKlRyFWxot1+iV
         A7EVxW8uVC1YYlMEC9v+wX8+36Tz7KgL774uiynY5zlKwFVvPQoSWH6sasfJJwWF7mhl
         YfW00VOugFfnqcsWdBDT2jC0t8R/Y6FRhyI9j49HZDvvSaxyr7ovWHMCjxPJGwY9CfqY
         LZPg==
X-Gm-Message-State: AOJu0YxxxP5q7vuSQ5lvjR10xyzK3m8NYZqqsbIZ3vjHt9h0Lm26ADfW
	iydtZbt6XPk0KIAVmQXCSg8mUE1nCJ/MQp0pd4wY6S5vEbNJTJdGncCDUBvpjA==
X-Gm-Gg: ASbGncuzvJzTNMCIgRNpecFeNIheKchu2YiuvTFlIkap0aDJGVSug5Olu1YqMgd9rTJ
	Ici8pFJj5SvyS9l+DJgEqpqX4bNDAIcAAo7evLBu9+KQ4vibfgRw7nopxB9Cauj2yPLEIfkDetQ
	4y2puu/fbyKk91tLE4tPySGOTKfiqtmQCAx9/0ZI3fBS+hmVM1TbuET8Uci7ccA8QxpPVqzd8aE
	zg2oeOmFEfLe9EKbrl4m7eVALghZXiWoGDzi7qdDG9ZCrFgr03CEedZ21aW/wqtdB7PGONCVrBk
	+xk9qzrQQ6NPa+w2j3zUDVZO4XG7Qmg2woJf44rRftFneA/T1pQbpZWjaOtoEfmWsJ+M3qzL1FE
	YV6lxpPS0jE8R/C41hXcv/JctHu+snRj74CY2ADME4+pY+WRt5pPA9wjjjSuB9gafyZcJgsqxgr
	y3
X-Google-Smtp-Source: AGHT+IE4UT9TsOU4sCMOWjLgm9hW3vgaLElLwGzwe+F1Mflc1sVFBCoCyr6bVSe7FYQHe9N7BnhSLg==
X-Received: by 2002:a05:6000:310c:b0:3f6:b242:a519 with SMTP id ffacd0b85a97d-40e4886df21mr17965940f8f.41.1759236344717;
        Tue, 30 Sep 2025 05:45:44 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc8aa0078sm22392586f8f.59.2025.09.30.05.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:45:43 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v5 bpf-next 09/15] bpf: make bpf_insn_successors to return a pointer
Date: Tue, 30 Sep 2025 12:51:05 +0000
Message-Id: <20250930125111.1269861-10-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The bpf_insn_successors() function is used to return successors
to a BPF instruction. So far, an instruction could have 0, 1 or 2
successors. Prepare the verifier code to introduction of instructions
with more than 2 successors (namely, indirect jumps).

To do this, introduce a new struct, struct bpf_iarray, containing
an array of bpf instruction indexes and make bpf_insn_successors
to return a pointer of that type. The storage for all instructions
is allocated in the env->succ, which holds an array of size 2,
to be used for all instructions.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 include/linux/bpf_verifier.h | 12 ++++++-
 kernel/bpf/liveness.c        | 36 ++++++++++++-------
 kernel/bpf/verifier.c        | 70 +++++++++++++++++++++++++-----------
 3 files changed, 85 insertions(+), 33 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index cc06e6d57faa..19d579f1f829 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -509,6 +509,15 @@ struct bpf_map_ptr_state {
 #define BPF_ALU_SANITIZE		(BPF_ALU_SANITIZE_SRC | \
 					 BPF_ALU_SANITIZE_DST)
 
+/*
+ * An array of BPF instructions.
+ * Primary usage: return value of bpf_insn_successors.
+ */
+struct bpf_iarray {
+	int off_cnt;
+	u32 off[];
+};
+
 struct bpf_insn_aux_data {
 	union {
 		enum bpf_reg_type ptr_type;	/* pointer type for load/store insns */
@@ -830,6 +839,7 @@ struct bpf_verifier_env {
 	/* array of pointers to bpf_scc_info indexed by SCC id */
 	struct bpf_scc_info **scc_info;
 	u32 scc_cnt;
+	struct bpf_iarray *succ;
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
@@ -1052,7 +1062,7 @@ void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_st
 
 struct bpf_subprog_info *bpf_find_containing_subprog(struct bpf_verifier_env *env, int off);
 int bpf_jmp_offset(struct bpf_insn *insn);
-int bpf_insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2]);
+struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env, u32 idx);
 void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
 bool bpf_calls_callback(struct bpf_verifier_env *env, int insn_idx);
 
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 3c611aba7f52..9312cd6b24d3 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -34,7 +34,7 @@
  *   - read and write marks propagation.
  * - The propagation phase is a textbook live variable data flow analysis:
  *
- *     state[cc, i].live_after = U [state[cc, s].live_before for s in insn_successors(i)]
+ *     state[cc, i].live_after = U [state[cc, s].live_before for s in bpf_insn_successors(i)]
  *     state[cc, i].live_before =
  *       (state[cc, i].live_after / state[cc, i].must_write) U state[i].may_read
  *
@@ -54,7 +54,7 @@
  *   The equation for "must_write_acc" propagation looks as follows:
  *
  *     state[cc, i].must_write_acc =
- *       ∩ [state[cc, s].must_write_acc for s in insn_successors(i)]
+ *       ∩ [state[cc, s].must_write_acc for s in bpf_insn_successors(i)]
  *       U state[cc, i].must_write
  *
  *   (An intersection of all "must_write_acc" for instruction successors
@@ -445,7 +445,12 @@ int bpf_jmp_offset(struct bpf_insn *insn)
 __diag_push();
 __diag_ignore_all("-Woverride-init", "Allow field initialization overrides for opcode_info_tbl");
 
-inline int bpf_insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
+/*
+ * Returns an array of instructions succ, with succ->off[0], ...,
+ * succ->off[n-1] with successor instructions, where n=succ->off_cnt
+ */
+inline struct bpf_iarray *
+bpf_insn_successors(struct bpf_verifier_env *env, u32 idx)
 {
 	static const struct opcode_info {
 		bool can_jump;
@@ -472,19 +477,25 @@ inline int bpf_insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
 		_J(BPF_JSET,  {.can_jump = true,  .can_fallthrough = true}),
 	#undef _J
 	};
+	struct bpf_prog *prog = env->prog;
 	struct bpf_insn *insn = &prog->insnsi[idx];
 	const struct opcode_info *opcode_info;
-	int i = 0, insn_sz;
+	struct bpf_iarray *succ;
+	int insn_sz;
+
+	/* pre-allocated array of size up to 2; reset cnt, as it may have been used already */
+	succ = env->succ;
+	succ->off_cnt = 0;
 
 	opcode_info = &opcode_info_tbl[BPF_CLASS(insn->code) | BPF_OP(insn->code)];
 	insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
 	if (opcode_info->can_fallthrough)
-		succ[i++] = idx + insn_sz;
+		succ->off[succ->off_cnt++] = idx + insn_sz;
 
 	if (opcode_info->can_jump)
-		succ[i++] = idx + bpf_jmp_offset(insn) + 1;
+		succ->off[succ->off_cnt++] = idx + bpf_jmp_offset(insn) + 1;
 
-	return i;
+	return succ;
 }
 
 __diag_pop();
@@ -544,11 +555,12 @@ static inline bool update_insn(struct bpf_verifier_env *env,
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	u64 new_before, new_after, must_write_acc;
 	struct per_frame_masks *insn, *succ_insn;
-	u32 succ_num, s, succ[2];
+	struct bpf_iarray *succ;
+	u32 s;
 	bool changed;
 
-	succ_num = bpf_insn_successors(env->prog, insn_idx, succ);
-	if (unlikely(succ_num == 0))
+	succ = bpf_insn_successors(env, insn_idx);
+	if (succ->off_cnt == 0)
 		return false;
 
 	changed = false;
@@ -560,8 +572,8 @@ static inline bool update_insn(struct bpf_verifier_env *env,
 	 * of successors plus all "must_write" slots of instruction itself.
 	 */
 	must_write_acc = U64_MAX;
-	for (s = 0; s < succ_num; ++s) {
-		succ_insn = get_frame_masks(instance, frame, succ[s]);
+	for (s = 0; s < succ->off_cnt; ++s) {
+		succ_insn = get_frame_masks(instance, frame, succ->off[s]);
 		new_after |= succ_insn->live_before;
 		must_write_acc &= succ_insn->must_write_acc;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 705535711d10..6c742d2f4c04 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17770,6 +17770,22 @@ static int mark_fastcall_patterns(struct bpf_verifier_env *env)
 	return 0;
 }
 
+static struct bpf_iarray *iarray_realloc(struct bpf_iarray *old, size_t n_elem)
+{
+	size_t new_size = sizeof(struct bpf_iarray) + n_elem * 4;
+	struct bpf_iarray *new;
+
+	new = kvrealloc(old, new_size, GFP_KERNEL_ACCOUNT);
+	if (!new) {
+		/* this is what callers always want, so simplify the call site */
+		kvfree(old);
+		return NULL;
+	}
+
+	new->off_cnt = n_elem;
+	return new;
+}
+
 /* Visits the instruction at index t and returns one of the following:
  *  < 0 - an error occurred
  *  DONE_EXPLORING - the instruction was fully explored
@@ -17990,8 +18006,9 @@ static int check_cfg(struct bpf_verifier_env *env)
  */
 static int compute_postorder(struct bpf_verifier_env *env)
 {
-	u32 cur_postorder, i, top, stack_sz, s, succ_cnt, succ[2];
+	u32 cur_postorder, i, top, stack_sz, s;
 	int *stack = NULL, *postorder = NULL, *state = NULL;
+	struct bpf_iarray *succ;
 
 	postorder = kvcalloc(env->prog->len, sizeof(int), GFP_KERNEL_ACCOUNT);
 	state = kvcalloc(env->prog->len, sizeof(int), GFP_KERNEL_ACCOUNT);
@@ -18015,11 +18032,11 @@ static int compute_postorder(struct bpf_verifier_env *env)
 				stack_sz--;
 				continue;
 			}
-			succ_cnt = bpf_insn_successors(env->prog, top, succ);
-			for (s = 0; s < succ_cnt; ++s) {
-				if (!state[succ[s]]) {
-					stack[stack_sz++] = succ[s];
-					state[succ[s]] |= DISCOVERED;
+			succ = bpf_insn_successors(env, top);
+			for (s = 0; s < succ->off_cnt; ++s) {
+				if (!state[succ->off[s]]) {
+					stack[stack_sz++] = succ->off[s];
+					state[succ->off[s]] |= DISCOVERED;
 				}
 			}
 			state[top] |= EXPLORED;
@@ -24325,14 +24342,18 @@ static int compute_live_registers(struct bpf_verifier_env *env)
 		for (i = 0; i < env->cfg.cur_postorder; ++i) {
 			int insn_idx = env->cfg.insn_postorder[i];
 			struct insn_live_regs *live = &state[insn_idx];
-			int succ_num;
-			u32 succ[2];
+			struct bpf_iarray *succ;
 			u16 new_out = 0;
 			u16 new_in = 0;
 
-			succ_num = bpf_insn_successors(env->prog, insn_idx, succ);
-			for (int s = 0; s < succ_num; ++s)
-				new_out |= state[succ[s]].in;
+			succ = bpf_insn_successors(env, insn_idx);
+			if (IS_ERR(succ)) {
+				err = PTR_ERR(succ);
+				goto out;
+
+			}
+			for (int s = 0; s < succ->off_cnt; ++s)
+				new_out |= state[succ->off[s]].in;
 			new_in = (new_out & ~live->def) | live->use;
 			if (new_out != live->out || new_in != live->in) {
 				live->in = new_in;
@@ -24385,11 +24406,11 @@ static int compute_scc(struct bpf_verifier_env *env)
 	const u32 insn_cnt = env->prog->len;
 	int stack_sz, dfs_sz, err = 0;
 	u32 *stack, *pre, *low, *dfs;
-	u32 succ_cnt, i, j, t, w;
+	u32 i, j, t, w;
 	u32 next_preorder_num;
 	u32 next_scc_id;
 	bool assign_scc;
-	u32 succ[2];
+	struct bpf_iarray *succ;
 
 	next_preorder_num = 1;
 	next_scc_id = 1;
@@ -24496,12 +24517,17 @@ static int compute_scc(struct bpf_verifier_env *env)
 				stack[stack_sz++] = w;
 			}
 			/* Visit 'w' successors */
-			succ_cnt = bpf_insn_successors(env->prog, w, succ);
-			for (j = 0; j < succ_cnt; ++j) {
-				if (pre[succ[j]]) {
-					low[w] = min(low[w], low[succ[j]]);
+			succ = bpf_insn_successors(env, w);
+			if (IS_ERR(succ)) {
+				err = PTR_ERR(succ);
+				goto exit;
+
+			}
+			for (j = 0; j < succ->off_cnt; ++j) {
+				if (pre[succ->off[j]]) {
+					low[w] = min(low[w], low[succ->off[j]]);
 				} else {
-					dfs[dfs_sz++] = succ[j];
+					dfs[dfs_sz++] = succ->off[j];
 					goto dfs_continue;
 				}
 			}
@@ -24518,8 +24544,8 @@ static int compute_scc(struct bpf_verifier_env *env)
 			 * or if component has a self reference.
 			 */
 			assign_scc = stack[stack_sz - 1] != w;
-			for (j = 0; j < succ_cnt; ++j) {
-				if (succ[j] == w) {
+			for (j = 0; j < succ->off_cnt; ++j) {
+				if (succ->off[j] == w) {
 					assign_scc = true;
 					break;
 				}
@@ -24581,6 +24607,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		goto err_free_env;
 	for (i = 0; i < len; i++)
 		env->insn_aux_data[i].orig_idx = i;
+	env->succ = iarray_realloc(NULL, 2);
+	if (!env->succ)
+		goto err_free_env;
 	env->prog = *prog;
 	env->ops = bpf_verifier_ops[env->prog->type];
 
@@ -24831,6 +24860,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	bpf_stack_liveness_free(env);
 	kvfree(env->cfg.insn_postorder);
 	kvfree(env->scc_info);
+	kvfree(env->succ);
 	kvfree(env);
 	return ret;
 }
-- 
2.34.1


