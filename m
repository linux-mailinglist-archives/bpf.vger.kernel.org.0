Return-Path: <bpf+bounces-70018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41F2BAC8EF
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81023A9B37
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 10:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D0B2FB60E;
	Tue, 30 Sep 2025 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgHtTrNk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB30A2FB0AF
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229396; cv=none; b=fZ+KocqJQfdz/7keTS8n2ZL/q6wBumwicMTo6ZyoKSrdzPC8+hOUlkGqRKEYXasWNDTUXE/5XJ+S3S5XefrIs807C8XRCERUBwoWOXpmrFDj6pVBO/3SjfO4qJ/L82cfzoZ9/R8m9rClYB/VnglkVtdDhDYxfkNXjHEANK1a1wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229396; c=relaxed/simple;
	bh=Q/4b9O6kQcJnCWT7t4lyfoQSnDLdm+aB0P1qUgLSGQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klfYIJaYmsX/aIKWHkIRMLQFeXyTkQR2qwlNUsex/CnD29rh/umYhxnTZyRa5ZEXU0efJ18n8PIQF8epunJTxNmZi8+2o0Hb0cMzYtwmA55Phcwd9kwQ8AqAMzfKrfTkCKmucTetv8GvApwRwctkWarrTS43cpu2OltWHRJe0dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgHtTrNk; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so4536919f8f.3
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759229393; x=1759834193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPe14uigRHQp0rqDqAAwnstyTWnrxOBW3SFwlAWm+h0=;
        b=SgHtTrNksZwOqUdGRHrq3sKpCoZ+U/SFt/5uW1NRd3R3ij2DwoiE9uXI721l46gAgw
         0unx6fSD292pXfr/pfOiIIGFfAeV3Ci34BLwDhmswVyP9uux14yPOKAtjn8sfJX8t9p1
         RHg7BPcAL+nskI3Z7lSQ4sEFNupuboF27ZFKfN7h8/h3+VW7j5JV2SG/fN8r1lmFEV60
         hN4hKQ1DbGpTl9GEQV4xZFWKvPDQJTxxnyCu3vENXa3EczzZYoXKSUugs5NGzKtXSau+
         VoDiL1dy/WeFFibdFG2cwZqCVajNH40wIEH/g4+eDJxAiJRvUTmy1Qx2QX4TuGgAfb4M
         XtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759229393; x=1759834193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPe14uigRHQp0rqDqAAwnstyTWnrxOBW3SFwlAWm+h0=;
        b=d6HrO2kSFv6b5xVST3L7R0qBz+4C6+pHm/t48aFyWD3aALSJQcnWc0I0E921edmHQG
         UHJ+oanRWvRaYr/9xb1nT6N+pjQmUUJcqb1Rhcp+4Ytho0o2rPtu2SO+e7I0nSLaL1v7
         c7X7Ya/Fz2B69b+Fn0P2BK7e+lD1cdMa6giCmUxx0VRX6lrMWrWkW4xQkSEjaSEGDdei
         PUVd7bDJURfOGQU931q7BH5ckD/t3GvDSP1cpAWt48x4zYWzKVI8P/mhm0w0lyHRFFtc
         K13LUE8EdV/BkioHX2arjs+yf6DfwjrxL7IFwk+NxgXkHxcCdTAvYKyTdnZylld1+fjO
         tVRA==
X-Gm-Message-State: AOJu0YwYdgnabL0cnXN/vFlwL7nYai3FD7JQuSzCFitMwabzCVrx+x9j
	mTmZYF5KAW4M9zPMx0DqIpzU3sBZ1bZVOPcsFCOKLLCS9aVkuhPFXhcncXU65w==
X-Gm-Gg: ASbGncuo681APYdiJg1n8W2LYG7D+sAKrF6EwvM5lxeboDV7dcPJjmjdFHaG5AjTDfJ
	7kwB7dKI1LWcMFz6MPvEj2kyR7AH/CrFnPOucGafoaldgonKUUADJHMOaP7CIcEIr/vVzOXtHFi
	J9K/0Iz1Qm7f5Dn83ShTRoqIrvoDvE0Kz8Ioha/cZ1EMClYZIZdBxb7hIVAfkTRZeyOtL+Uvhen
	nEIpLzT/WzGE/DGr+/6Gc1igVSD6wGKH6Hd5s2m/MOkJdK9fXPhHbDpiqN9ARHSWHEEDGlhI1p8
	Hs2hhXTro7tUHq3O8YKCScjxsU05HwQXBnNA5MAi34KYXVpLTN1YWPJbzn+vXnv7Wmkafwa/nW7
	S/72TYT6tNtJjAWbpOTAcQN0M/zhnGVuf9AbWPGWUWt9156cNYO+96SwREJ7g5tuu/g==
X-Google-Smtp-Source: AGHT+IFSIcN/Gzunsrl51F5Nphj6cTUTnG850jaFyQz/qewvaJJFMLSoL26JiXgbCDe1K55OXNUvmA==
X-Received: by 2002:a05:6000:609:b0:3ec:6259:5079 with SMTP id ffacd0b85a97d-40e458a9810mr20684751f8f.11.1759229392649;
        Tue, 30 Sep 2025 03:49:52 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602dfdsm21982161f8f.33.2025.09.30.03.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:49:51 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 09/15] bpf: make bpf_insn_successors to return a pointer
Date: Tue, 30 Sep 2025 10:55:17 +0000
Message-Id: <20250930105523.1014140-10-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
References: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
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
index c7f2a1e97ff6..5794797858c4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17630,6 +17630,22 @@ static int mark_fastcall_patterns(struct bpf_verifier_env *env)
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
@@ -17848,8 +17864,9 @@ static int check_cfg(struct bpf_verifier_env *env)
  */
 static int compute_postorder(struct bpf_verifier_env *env)
 {
-	u32 cur_postorder, i, top, stack_sz, s, succ_cnt, succ[2];
+	u32 cur_postorder, i, top, stack_sz, s;
 	int *stack = NULL, *postorder = NULL, *state = NULL;
+	struct bpf_iarray *succ;
 
 	postorder = kvcalloc(env->prog->len, sizeof(int), GFP_KERNEL_ACCOUNT);
 	state = kvcalloc(env->prog->len, sizeof(int), GFP_KERNEL_ACCOUNT);
@@ -17873,11 +17890,11 @@ static int compute_postorder(struct bpf_verifier_env *env)
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
@@ -24178,14 +24195,18 @@ static int compute_live_registers(struct bpf_verifier_env *env)
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
@@ -24238,11 +24259,11 @@ static int compute_scc(struct bpf_verifier_env *env)
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
@@ -24349,12 +24370,17 @@ static int compute_scc(struct bpf_verifier_env *env)
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
@@ -24371,8 +24397,8 @@ static int compute_scc(struct bpf_verifier_env *env)
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
@@ -24434,6 +24460,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		goto err_free_env;
 	for (i = 0; i < len; i++)
 		env->insn_aux_data[i].orig_idx = i;
+	env->succ = iarray_realloc(NULL, 2);
+	if (!env->succ)
+		goto err_free_env;
 	env->prog = *prog;
 	env->ops = bpf_verifier_ops[env->prog->type];
 
@@ -24684,6 +24713,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	bpf_stack_liveness_free(env);
 	kvfree(env->cfg.insn_postorder);
 	kvfree(env->scc_info);
+	kvfree(env->succ);
 	kvfree(env);
 	return ret;
 }
-- 
2.34.1


