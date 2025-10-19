Return-Path: <bpf+bounces-71324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE209BEEC0F
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 22:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A693BCC80
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 20:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235311E00A0;
	Sun, 19 Oct 2025 20:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBQqTVcd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC55A2E54CC
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760904935; cv=none; b=miJdUGhQS9HJWl/IGQUR/lWyldqAm1nQ4ltIIwTaS7/xYdM54jLbWAQDlUF/CzV1v6XLEDvehBEAwtdBvqaVEQRWsGTPwX5ou1SNaWFEZPUH/6EUjrc5mPh88hpt6SQ3HnjvmiUl2fyWx7nLzLctylfs37lD8fubqRhhhjOKkWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760904935; c=relaxed/simple;
	bh=Ue/I7XieoFHlxvBtqAqnDCqSeksLI8Tq9PBiJb8OHlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDoHkZzTK6nl+Q9zSPr663l3PqRW4cXYmmtG4yA9BAM5wBeT1Umnvpc9LdvXVBWPJlUMASMjfF60ySkZyCnlOdlP2X338P4XlOYZ/5rhkmTXt9S1hbAkfSKVwWHCTuISx0avp1XpuK8r2klIdytUxsIE9i8TijTkNsbc+VYCtzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBQqTVcd; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47106fc51faso42958605e9.0
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 13:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760904932; x=1761509732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATm9q5iUk5umsmKM4X7RoStF/oxKLUtnwhp7RXdqlbg=;
        b=BBQqTVcdXP4X4B338Cfw1M2Rr9XysrvajCdNgIbHCOWrGZidJVEjblL95oyGeDrT3S
         uRacT6s9UAK5SscUYmLl1WIu4ArOe2rZfbgPSTjcWm01QNPHj/9ThDABthiyXwx3djxG
         h3dXaardkZJUZYysSFUyJxPIu5KeeyCFahROQ1DtBO+Fjw6XU9hr3+yx0tdw25QMJFdy
         ai7f+v/HzRoFBBPpViFedn8D/7438ISh9xrdwa7t0bNHi0BRUPwWTLhOhegml38GwzXJ
         SUObLiP9VOQ+vx4GLiWvxK3XygVvlK2KxybOo5DsyJKif5WU0pYs4z8At3yNFfVxW0sG
         LQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760904932; x=1761509732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATm9q5iUk5umsmKM4X7RoStF/oxKLUtnwhp7RXdqlbg=;
        b=g4tgF7jP2mPTIvWTfWBdWqWfhCWSUcNyJbmlzkpZiXini74Z9hdd/+rYDK0/BKhcUr
         hbnh0yD6QpDkI/UlepBkEvPyvTL7eh7u+y8VwmCgqCSDHSAuT8rf820gQdwNTGuLjTL/
         YtjSkeLlnUBu45aZNaDLQUVNiU75RZ1IUkBdk/xi/t8hU4xldFDkQzDfWgX9KtWjF6gq
         XJ37XCEP5HWyvxh98/s6qKrN6A4OUAjrBzgv1WsArTN3/mSmj5nFkOiNtvtuVLVzs5Bw
         UpC98HdJXHvl3YQ3ahmBQ9IpHsp1/TbFHWF/0+DxSsJJeadPAznIe/sAeBF2AFeZNFlF
         fvpg==
X-Gm-Message-State: AOJu0YyNzM7XpHUIXyZ0ZafnuoQwspWXptPvBVF0Cb/q8/umWf7A+eP4
	3cvGcDK5ZxfzM8yLcTvqfjyUVkTEB/mgFEK8zyhy8g/uyy7I9V2IKWsDGpP/pA==
X-Gm-Gg: ASbGncvPAtyn0uqhvbkJKlnpLyo0NRqkOlY+EQl1B9MXK7TKlS4QdNoIcm24Eg86TSi
	ByAFpaurU2TxwsPHxsszqn4ykAakcKyjKWfUjyV/8rZZNIhnl6ODH45sAAGCgqXz9XZurZc5Kqa
	ZjhaFI6hFZQtG1RVDqc6spc2P2eaO8k7NsvkxUP1FWX56e1LvHcwgXYce9/Oxy69DJFda3lg4gM
	7LsHxqGXXCwbWEBj4bwW3vno4Th8bu757Y749y0Dyl9qQRRh4us3K5CIG7XG1nJHRhPthVZx08n
	wwn6JGaPJSKCu9/LeIPasdApRw26U8VE0aHQk6q+uF7WGMQ/EHWkUlONgp7iLyZBbKoQtUVG1ZA
	8VAly+s/pmYo7OjL2GVmTVy1kWAB6JeRlGKjqRgBq3EAiQXTn/+bhTT8hS2HKmz2nRmjDjaIirU
	S2ttESjQgPQxvGxIwkYz2a/vRGOIFAiw==
X-Google-Smtp-Source: AGHT+IEQzwbPniks7jYIQWr9VPhemV84nWofE3jacurW3dlajCNll0mFGkI6RLD8Av6cuAanNR7MWQ==
X-Received: by 2002:a05:600c:46c9:b0:471:747:2116 with SMTP id 5b1f17b1804b1-471179303d0mr78391555e9.41.1760904931500;
        Sun, 19 Oct 2025 13:15:31 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c831asm190460105e9.13.2025.10.19.13.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 13:15:30 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 09/17] bpf: make bpf_insn_successors to return a pointer
Date: Sun, 19 Oct 2025 20:21:37 +0000
Message-Id: <20251019202145.3944697-10-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 12 +++++++-
 kernel/bpf/liveness.c        | 36 ++++++++++++++--------
 kernel/bpf/verifier.c        | 60 ++++++++++++++++++++++++------------
 3 files changed, 75 insertions(+), 33 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 142030e7e857..6b820d8d77af 100644
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
+	int cnt;
+	u32 items[];
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
index 1e6538f59a78..78fbde2d2b96 100644
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
@@ -447,7 +447,12 @@ int bpf_jmp_offset(struct bpf_insn *insn)
 __diag_push();
 __diag_ignore_all("-Woverride-init", "Allow field initialization overrides for opcode_info_tbl");
 
-inline int bpf_insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
+/*
+ * Returns an array of instructions succ, with succ->items[0], ...,
+ * succ->items[n-1] with successor instructions, where n=succ->cnt
+ */
+inline struct bpf_iarray *
+bpf_insn_successors(struct bpf_verifier_env *env, u32 idx)
 {
 	static const struct opcode_info {
 		bool can_jump;
@@ -474,19 +479,25 @@ inline int bpf_insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
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
+	succ->cnt = 0;
 
 	opcode_info = &opcode_info_tbl[BPF_CLASS(insn->code) | BPF_OP(insn->code)];
 	insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
 	if (opcode_info->can_fallthrough)
-		succ[i++] = idx + insn_sz;
+		succ->items[succ->cnt++] = idx + insn_sz;
 
 	if (opcode_info->can_jump)
-		succ[i++] = idx + bpf_jmp_offset(insn) + 1;
+		succ->items[succ->cnt++] = idx + bpf_jmp_offset(insn) + 1;
 
-	return i;
+	return succ;
 }
 
 __diag_pop();
@@ -546,11 +557,12 @@ static inline bool update_insn(struct bpf_verifier_env *env,
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
+	if (succ->cnt == 0)
 		return false;
 
 	changed = false;
@@ -562,8 +574,8 @@ static inline bool update_insn(struct bpf_verifier_env *env,
 	 * of successors plus all "must_write" slots of instruction itself.
 	 */
 	must_write_acc = U64_MAX;
-	for (s = 0; s < succ_num; ++s) {
-		succ_insn = get_frame_masks(instance, frame, succ[s]);
+	for (s = 0; s < succ->cnt; ++s) {
+		succ_insn = get_frame_masks(instance, frame, succ->items[s]);
 		new_after |= succ_insn->live_before;
 		must_write_acc &= succ_insn->must_write_acc;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4add3c778f02..ae017c032944 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17807,6 +17807,22 @@ static int mark_fastcall_patterns(struct bpf_verifier_env *env)
 	return 0;
 }
 
+static struct bpf_iarray *iarray_realloc(struct bpf_iarray *old, size_t n_elem)
+{
+	size_t new_size = sizeof(struct bpf_iarray) + n_elem * sizeof(old->items[0]);
+	struct bpf_iarray *new;
+
+	new = kvrealloc(old, new_size, GFP_KERNEL_ACCOUNT);
+	if (!new) {
+		/* this is what callers always want, so simplify the call site */
+		kvfree(old);
+		return NULL;
+	}
+
+	new->cnt = n_elem;
+	return new;
+}
+
 /* Visits the instruction at index t and returns one of the following:
  *  < 0 - an error occurred
  *  DONE_EXPLORING - the instruction was fully explored
@@ -18027,8 +18043,9 @@ static int check_cfg(struct bpf_verifier_env *env)
  */
 static int compute_postorder(struct bpf_verifier_env *env)
 {
-	u32 cur_postorder, i, top, stack_sz, s, succ_cnt, succ[2];
+	u32 cur_postorder, i, top, stack_sz, s;
 	int *stack = NULL, *postorder = NULL, *state = NULL;
+	struct bpf_iarray *succ;
 
 	postorder = kvcalloc(env->prog->len, sizeof(int), GFP_KERNEL_ACCOUNT);
 	state = kvcalloc(env->prog->len, sizeof(int), GFP_KERNEL_ACCOUNT);
@@ -18052,11 +18069,11 @@ static int compute_postorder(struct bpf_verifier_env *env)
 				stack_sz--;
 				continue;
 			}
-			succ_cnt = bpf_insn_successors(env->prog, top, succ);
-			for (s = 0; s < succ_cnt; ++s) {
-				if (!state[succ[s]]) {
-					stack[stack_sz++] = succ[s];
-					state[succ[s]] |= DISCOVERED;
+			succ = bpf_insn_successors(env, top);
+			for (s = 0; s < succ->cnt; ++s) {
+				if (!state[succ->items[s]]) {
+					stack[stack_sz++] = succ->items[s];
+					state[succ->items[s]] |= DISCOVERED;
 				}
 			}
 			state[top] |= EXPLORED;
@@ -24363,14 +24380,13 @@ static int compute_live_registers(struct bpf_verifier_env *env)
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
+			for (int s = 0; s < succ->cnt; ++s)
+				new_out |= state[succ->items[s]].in;
 			new_in = (new_out & ~live->def) | live->use;
 			if (new_out != live->out || new_in != live->in) {
 				live->in = new_in;
@@ -24423,11 +24439,11 @@ static int compute_scc(struct bpf_verifier_env *env)
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
@@ -24534,12 +24550,12 @@ static int compute_scc(struct bpf_verifier_env *env)
 				stack[stack_sz++] = w;
 			}
 			/* Visit 'w' successors */
-			succ_cnt = bpf_insn_successors(env->prog, w, succ);
-			for (j = 0; j < succ_cnt; ++j) {
-				if (pre[succ[j]]) {
-					low[w] = min(low[w], low[succ[j]]);
+			succ = bpf_insn_successors(env, w);
+			for (j = 0; j < succ->cnt; ++j) {
+				if (pre[succ->items[j]]) {
+					low[w] = min(low[w], low[succ->items[j]]);
 				} else {
-					dfs[dfs_sz++] = succ[j];
+					dfs[dfs_sz++] = succ->items[j];
 					goto dfs_continue;
 				}
 			}
@@ -24556,8 +24572,8 @@ static int compute_scc(struct bpf_verifier_env *env)
 			 * or if component has a self reference.
 			 */
 			assign_scc = stack[stack_sz - 1] != w;
-			for (j = 0; j < succ_cnt; ++j) {
-				if (succ[j] == w) {
+			for (j = 0; j < succ->cnt; ++j) {
+				if (succ->items[j] == w) {
 					assign_scc = true;
 					break;
 				}
@@ -24619,6 +24635,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		goto err_free_env;
 	for (i = 0; i < len; i++)
 		env->insn_aux_data[i].orig_idx = i;
+	env->succ = iarray_realloc(NULL, 2);
+	if (!env->succ)
+		goto err_free_env;
 	env->prog = *prog;
 	env->ops = bpf_verifier_ops[env->prog->type];
 
@@ -24869,6 +24888,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	bpf_stack_liveness_free(env);
 	kvfree(env->cfg.insn_postorder);
 	kvfree(env->scc_info);
+	kvfree(env->succ);
 	kvfree(env);
 	return ret;
 }
-- 
2.34.1


