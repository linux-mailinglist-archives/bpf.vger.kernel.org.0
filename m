Return-Path: <bpf+bounces-53169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB43A4D532
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 08:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE413B01C8
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 07:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B181F8917;
	Tue,  4 Mar 2025 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lx3Be5Sx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A3C1F9428
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 07:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074223; cv=none; b=VO3I2Akua+TOVOuy+Sox14YCr+sQCrKcoF3nFIdHhSbKVm1zB3wznvSvHkkwqwBZNVm4PKKZQsWqom+ONLqSleZIxK/EIAJu1jKeaJiTHllhi1IIS90pa2fC1lDDV4TLvI7us6Dd+IBAz0tq0hXQxAiJQLCKUt/h/FdIROXRNaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074223; c=relaxed/simple;
	bh=AsDrgacNyl246KXUPfaAuZM3GyNzowAPE0B758TrbEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNFbb1Md9jNM4jKmOdrtkC+YCPzNxWoE1tAD12CXmEbd7UZdS3PktAqEwQcjKcSpXr3fnSdV1DufGMhzY8Z3ppdcxS8Q5l/ltQwwMGRDYFDvGSALLwfdgNBxS5AhTaRKcBZHk+BvuAAZ/Yf2gKdhcgiJfhes7MjHksaceHpk19s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lx3Be5Sx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2235189adaeso85859115ad.0
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 23:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741074221; x=1741679021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0m5K1oeMi/o9jphWMETSsjoz5kzUJo6FbqB8i5HmWes=;
        b=Lx3Be5Sx1R4gE027B0DVWxr4kS1eIuA6q2/Q6p07W9BfgG+dGlrDGMO1IYfWdD6toL
         pWp0GJgD6LsLjBFbqbttiMeGtsacds+3C41TSs05yhFmxx4/zhPaSICfhRgEIZjv06Kj
         MIeCR81fjUBhMdoIVmRkjGX9cBO1kOhgQjqaoj4MXWkrRFm1eAq4oqldF2v4RXeFy9Ag
         +wm/zHaCXSmAKn5B5wCEnjZf9M9YXEl/Fm6QWXcHQVJuWW9r74nVQsGK36WwimfJqD35
         +9KHR/HVoT+U3jB6Te9SZBaSWv++fuhavlxXJkMLRFyE5P8ORtZwmQ7NEu8d9eDIa1mS
         ZhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741074221; x=1741679021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0m5K1oeMi/o9jphWMETSsjoz5kzUJo6FbqB8i5HmWes=;
        b=oupbz6vo0ST2VyXzBO4rwwxnYqKjCa3YSXEh3Qlp+eMMyty2PuCF04QPH6Epwr3uhr
         1dUvhm/7jq+A3WFyHdgX1fag0PILhJ+cYP85puDb2wQU3Jdi5UZ6WnMiJ9tjyvSXKGdY
         Dl51OCcto7zLHlRcKPqldYXJuX23vDJ9elktlTuLM0LayWf0iPkqFNzpZ7Ftc9iaektl
         adzaMXPPVXA5PYCWHVD5pDbgs0bfUe0y55Bye446OZHa0oBZUZTojO166VBUbak9JAl9
         2GMUmpYlScVIp/eYHYBSBb3+EzvJE2YYjueMYcmZ2mJiVbZW9GS1GTCP7SM3gUPaVf/C
         L80w==
X-Gm-Message-State: AOJu0Yx65ea6EDErUj81pITzrohm/NE0Txx3FdDiGt+GwYXOqDyrVTEU
	oaa90dztAmfZqlbcDt4AFDLOlHz6/GiH4cW7gaCnllqaL9+GRLNwxVoSnA==
X-Gm-Gg: ASbGncv7htWrMhsruuI9m0inWYtTo6IEfnCUsCE++c+9JcVp/QefLMkCVyVf6N1n5pY
	FZRcV4TR2u9OwXsAYB6CbJeU33pTZbkpogFZKhF/UzE9Bjp9ZP4K4L2PFTPBFt87QfRUmP2A8pK
	LrbEILC+OWK1rRlLjayVcr0mUdN8n1ALEX1xvV36WqD8DmSKsqCuYyf7uh7QTc17/QSVLOkt/Wu
	TKsQi6CpzXvbxruxeoxtKM52Pgt8sJz+bJWjNKzrj8ZoZVK/k1do4QhgLjZZoYhN0al8OMA3boG
	c2rJnT81VftA6QttfOmO9QRXflPVhOIxFouyMMS5
X-Google-Smtp-Source: AGHT+IENjinNTLcdFpUbpzGgVeFvnxp5GhjVSg2XXcMhNqwNfYhmVSGsYCK8qCci6wEq1zJN4gOAsA==
X-Received: by 2002:a17:903:1c1:b0:221:751f:cfbe with SMTP id d9443c01a7336-223d9173960mr37860495ad.19.1741074220689;
        Mon, 03 Mar 2025 23:43:40 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050d7c1sm89545125ad.198.2025.03.03.23.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 23:43:40 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 3/5] bpf: simple DFA-based live registers analysis
Date: Mon,  3 Mar 2025 23:42:37 -0800
Message-ID: <20250304074239.2328752-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304074239.2328752-1-eddyz87@gmail.com>
References: <20250304074239.2328752-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compute may-live registers before each instruction in the program.
The register is live before the instruction I if it is read by I or
some instruction S following I during program execution and is not
overwritten between I and S.

This information would be used in the next patch as a hint in
func_states_equal().

Use a simple algorithm described in [1] to compute this information:
- define the following:
  - I.use : a set of all registers read by instruction I;
  - I.def : a set of all registers written by instruction I;
  - I.in  : a set of all registers that may be alive before I execution;
  - I.out : a set of all registers that may be alive after I execution;
  - I.successors : a set of instructions S that might immediately
                   follow I for some program execution;
- associate separate empty sets 'I.in' and 'I.out' with each instruction;
- visit each instruction in a postorder and update corresponding
  'I.in' and 'I.out' sets as follows:

      I.out = U [S.in for S in I.successors]
      I.in  = (I.out / I.def) U I.use

  (where U stands for set union, / stands for set difference)
- repeat the computation while I.{in,out} changes for any instruction.

On implementation side keep things as simple, as possible:
- check_cfg() already marks instructions EXPLORED in post-order,
  modify it to save the index of each EXPLORED instruction in a vector;
- represent I.{in,out,use,def} as bitmasks;
- don't split the program into basic blocks and don't maintain the
  work queue, instead:
  - do fixed-point computation by visiting each instruction;
  - maintain a simple 'changed' flag if I.{in,out} for any instruction
    change;
  Measurements show that even such simplistic implementation does not
  add measurable verification time overhead (for selftests, at-least).

Note on check_cfg() ex_insn_beg/ex_done change:
To avoid out of bounds access to env->cfg.insn_postorder array,
it should be guaranteed that instruction transitions to EXPLORED state
only once. Previously this was not the fact for incorrect programs
with direct calls to exception callbacks.

The 'align' selftest needs adjustment to skip computed insn/live
registers printout. Otherwise it matches lines from the live registers
printout.

[1] https://en.wikipedia.org/wiki/Live-variable_analysis

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h                  |   6 +
 kernel/bpf/verifier.c                         | 309 +++++++++++++++++-
 .../testing/selftests/bpf/prog_tests/align.c  |  11 +-
 3 files changed, 319 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d338f2a96bba..d6cfc4ee6820 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -591,6 +591,8 @@ struct bpf_insn_aux_data {
 	 * accepts callback function as a parameter.
 	 */
 	bool calls_callback;
+	/* registers alive before this instruction. */
+	u16 live_regs_before;
 };
 
 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
@@ -748,7 +750,11 @@ struct bpf_verifier_env {
 	struct {
 		int *insn_state;
 		int *insn_stack;
+		/* vector of instruction indexes sorted in post-order */
+		int *insn_postorder;
 		int cur_stack;
+		/* current position in the insn_postorder vector */
+		int cur_postorder;
 	} cfg;
 	struct backtrack_state bt;
 	struct bpf_insn_hist_entry *insn_hist;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5cc1b6ed0e92..09298e0e4b73 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17402,9 +17402,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 static int check_cfg(struct bpf_verifier_env *env)
 {
 	int insn_cnt = env->prog->len;
-	int *insn_stack, *insn_state;
+	int *insn_stack, *insn_state, *insn_postorder;
 	int ex_insn_beg, i, ret = 0;
-	bool ex_done = false;
 
 	insn_state = env->cfg.insn_state = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
 	if (!insn_state)
@@ -17416,6 +17415,17 @@ static int check_cfg(struct bpf_verifier_env *env)
 		return -ENOMEM;
 	}
 
+	insn_postorder = env->cfg.insn_postorder = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
+	if (!insn_postorder) {
+		kvfree(insn_state);
+		kvfree(insn_stack);
+		return -ENOMEM;
+	}
+
+	ex_insn_beg = env->exception_callback_subprog
+		      ? env->subprog_info[env->exception_callback_subprog].start
+		      : 0;
+
 	insn_state[0] = DISCOVERED; /* mark 1st insn as discovered */
 	insn_stack[0] = 0; /* 0 is the first instruction */
 	env->cfg.cur_stack = 1;
@@ -17429,6 +17439,7 @@ static int check_cfg(struct bpf_verifier_env *env)
 		case DONE_EXPLORING:
 			insn_state[t] = EXPLORED;
 			env->cfg.cur_stack--;
+			insn_postorder[env->cfg.cur_postorder++] = t;
 			break;
 		case KEEP_EXPLORING:
 			break;
@@ -17447,13 +17458,10 @@ static int check_cfg(struct bpf_verifier_env *env)
 		goto err_free;
 	}
 
-	if (env->exception_callback_subprog && !ex_done) {
-		ex_insn_beg = env->subprog_info[env->exception_callback_subprog].start;
-
+	if (ex_insn_beg && insn_state[ex_insn_beg] != EXPLORED) {
 		insn_state[ex_insn_beg] = DISCOVERED;
 		insn_stack[0] = ex_insn_beg;
 		env->cfg.cur_stack = 1;
-		ex_done = true;
 		goto walk_cfg;
 	}
 
@@ -23379,6 +23387,290 @@ static int process_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr,
 	return 0;
 }
 
+static bool can_fallthrough(struct bpf_insn *insn)
+{
+	u8 class = BPF_CLASS(insn->code);
+	u8 opcode = BPF_OP(insn->code);
+
+	if (class != BPF_JMP && class != BPF_JMP32)
+		return true;
+
+	if (opcode == BPF_EXIT || opcode == BPF_JA)
+		return false;
+
+	return true;
+}
+
+static bool can_jump(struct bpf_insn *insn)
+{
+	u8 class = BPF_CLASS(insn->code);
+	u8 opcode = BPF_OP(insn->code);
+
+	if (class != BPF_JMP && class != BPF_JMP32)
+		return false;
+
+	switch (opcode) {
+	case BPF_JA:
+	case BPF_JEQ:
+	case BPF_JNE:
+	case BPF_JLT:
+	case BPF_JLE:
+	case BPF_JGT:
+	case BPF_JGE:
+	case BPF_JSGT:
+	case BPF_JSGE:
+	case BPF_JSLT:
+	case BPF_JSLE:
+	case BPF_JCOND:
+		return true;
+	}
+
+	return false;
+}
+
+static int insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
+{
+	struct bpf_insn *insn = &prog->insnsi[idx];
+	int i = 0, insn_sz;
+	u32 dst;
+
+	insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
+	if (can_fallthrough(insn) && idx + 1 < prog->len)
+		succ[i++] = idx + insn_sz;
+
+	if (can_jump(insn)) {
+		dst = idx + jmp_offset(insn) + 1;
+		if (i == 0 || succ[0] != dst)
+			succ[i++] = dst;
+	}
+
+	return i;
+}
+
+/* Each field is a register bitmask */
+struct insn_live_regs {
+	u16 use;	/* registers read by instruction */
+	u16 def;	/* registers written by instruction */
+	u16 in;		/* registers that may be alive before instruction */
+	u16 out;	/* registers that may be alive after instruction */
+};
+
+/* Bitmask with 1s for all caller saved registers */
+#define ALL_CALLER_SAVED_REGS ((1u << CALLER_SAVED_REGS) - 1)
+
+/* Compute info->{use,def} fields for the instruction */
+static void compute_insn_live_regs(struct bpf_verifier_env *env,
+				   struct bpf_insn *insn,
+				   struct insn_live_regs *info)
+{
+	struct call_summary cs;
+	u8 class = BPF_CLASS(insn->code);
+	u8 code = BPF_OP(insn->code);
+	u8 mode = BPF_MODE(insn->code);
+	u16 src = BIT(insn->src_reg);
+	u16 dst = BIT(insn->dst_reg);
+	u16 r0  = BIT(0);
+	u16 def = 0;
+	u16 use = 0xffff;
+
+	switch (class) {
+	case BPF_LD:
+		switch (mode) {
+		case BPF_IMM:
+			if (BPF_SIZE(insn->code) == BPF_DW) {
+				def = dst;
+				use = 0;
+			}
+			break;
+		case BPF_LD | BPF_ABS:
+		case BPF_LD | BPF_IND:
+			/* stick with defaults */
+			break;
+		}
+		break;
+	case BPF_LDX:
+		switch (mode) {
+		case BPF_MEM:
+		case BPF_MEMSX:
+			def = dst;
+			use = src;
+			break;
+		}
+		break;
+	case BPF_ST:
+		switch (mode) {
+		case BPF_MEM:
+			def = 0;
+			use = dst;
+			break;
+		}
+		break;
+	case BPF_STX:
+		switch (mode) {
+		case BPF_MEM:
+			def = 0;
+			use = dst | src;
+			break;
+		case BPF_ATOMIC:
+			use = dst | src;
+			if (insn->imm & BPF_FETCH) {
+				if (insn->imm == BPF_CMPXCHG)
+					def = r0;
+				else
+					def = src;
+			} else {
+				def = 0;
+			}
+			break;
+		}
+		break;
+	case BPF_ALU:
+	case BPF_ALU64:
+		switch (code) {
+		case BPF_END:
+			use = dst;
+			def = dst;
+			break;
+		case BPF_MOV:
+			def = dst;
+			if (BPF_SRC(insn->code) == BPF_K)
+				use = 0;
+			else
+				use = src;
+			break;
+		default:
+			def = dst;
+			if (BPF_SRC(insn->code) == BPF_K)
+				use = dst;
+			else
+				use = dst | src;
+		}
+		break;
+	case BPF_JMP:
+	case BPF_JMP32:
+		switch (code) {
+		case BPF_JA:
+			def = 0;
+			use = 0;
+			break;
+		case BPF_EXIT:
+			def = 0;
+			use = r0;
+			break;
+		case BPF_CALL:
+			def = ALL_CALLER_SAVED_REGS;
+			use = def & ~BIT(BPF_REG_0);
+			if (get_call_summary(env, insn, &cs))
+				use = GENMASK(cs.num_params, 1);
+			break;
+		default:
+			def = 0;
+			if (BPF_SRC(insn->code) == BPF_K)
+				use = dst;
+			else
+				use = dst | src;
+		}
+		break;
+	}
+
+	info->def = def;
+	info->use = use;
+}
+
+/* Compute may-live registers after each instruction in the program.
+ * The register is live after the instruction I if it is read by some
+ * instruction S following I during program execution and is not
+ * overwritten between I and S.
+ *
+ * Store result in env->insn_aux_data[i].live_regs.
+ */
+static int compute_live_registers(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *insn_aux = env->insn_aux_data;
+	struct bpf_insn *insns = env->prog->insnsi;
+	struct insn_live_regs *state;
+	int insn_cnt = env->prog->len;
+	int err = 0, i, j;
+	bool changed;
+
+	/* Use the following algorithm:
+	 * - define the following:
+	 *   - I.use : a set of all registers read by instruction I;
+	 *   - I.def : a set of all registers written by instruction I;
+	 *   - I.in  : a set of all registers that may be alive before I execution;
+	 *   - I.out : a set of all registers that may be alive after I execution;
+	 *   - insn_successors(I): a set of instructions S that might immediately
+	 *                         follow I for some program execution;
+	 * - associate separate empty sets 'I.in' and 'I.out' with each instruction;
+	 * - visit each instruction in a postorder and update
+	 *   state[i].in, state[i].out as follows:
+	 *
+	 *       state[i].out = U [state[s].in for S in insn_successors(i)]
+	 *       state[i].in  = (state[i].out / state[i].def) U state[i].use
+	 *
+	 *   (where U stands for set union, / stands for set difference)
+	 * - repeat the computation while {in,out} fields changes for
+	 *   any instruction.
+	 */
+	state = kvcalloc(insn_cnt, sizeof(*state), GFP_KERNEL);
+	if (!state) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < insn_cnt; ++i)
+		compute_insn_live_regs(env, &insns[i], &state[i]);
+
+	changed = true;
+	while (changed) {
+		changed = false;
+		for (i = 0; i < env->cfg.cur_postorder; ++i) {
+			int insn_idx = env->cfg.insn_postorder[i];
+			struct insn_live_regs *live = &state[insn_idx];
+			int succ_num;
+			u32 succ[2];
+			u16 new_out = 0;
+			u16 new_in = 0;
+
+			succ_num = insn_successors(env->prog, insn_idx, succ);
+			for (int s = 0; s < succ_num; ++s)
+				new_out |= state[succ[s]].in;
+			new_in = (new_out & ~live->def) | live->use;
+			if (new_out != live->out || new_in != live->in) {
+				live->in = new_in;
+				live->out = new_out;
+				changed = true;
+			}
+		}
+	}
+
+	for (i = 0; i < insn_cnt; ++i)
+		insn_aux[i].live_regs_before = state[i].in;
+
+	if (env->log.level & BPF_LOG_LEVEL2) {
+		verbose(env, "Live regs before insn:\n");
+		for (i = 0; i < insn_cnt; ++i) {
+			verbose(env, "%3d: ", i);
+			for (j = BPF_REG_0; j < BPF_REG_10; ++j)
+				if (insn_aux[i].live_regs_before & BIT(j))
+					verbose(env, "%d", j);
+				else
+					verbose(env, ".");
+			verbose(env, " ");
+			verbose_insn(env, &insns[i]);
+			if (bpf_is_ldimm64(&insns[i]))
+				i++;
+		}
+	}
+
+out:
+	kvfree(state);
+	kvfree(env->cfg.insn_postorder);
+	env->cfg.insn_postorder = NULL;
+	env->cfg.cur_postorder = 0;
+	return err;
+}
+
 int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
 {
 	u64 start_time = ktime_get_ns();
@@ -23500,6 +23792,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret)
 		goto skip_full_check;
 
+	ret = compute_live_registers(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = mark_fastcall_patterns(env);
 	if (ret < 0)
 		goto skip_full_check;
@@ -23638,6 +23934,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	vfree(env->insn_aux_data);
 	kvfree(env->insn_hist);
 err_free_env:
+	kvfree(env->cfg.insn_postorder);
 	kvfree(env);
 	return ret;
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testing/selftests/bpf/prog_tests/align.c
index 4ebd0da898f5..1d53a8561ee2 100644
--- a/tools/testing/selftests/bpf/prog_tests/align.c
+++ b/tools/testing/selftests/bpf/prog_tests/align.c
@@ -610,9 +610,11 @@ static int do_test_single(struct bpf_align_test *test)
 		.log_size = sizeof(bpf_vlog),
 		.log_level = 2,
 	);
+	const char *main_pass_start = "0: R1=ctx() R10=fp0";
 	const char *line_ptr;
 	int cur_line = -1;
 	int prog_len, i;
+	char *start;
 	int fd_prog;
 	int ret;
 
@@ -632,7 +634,13 @@ static int do_test_single(struct bpf_align_test *test)
 		ret = 0;
 		/* We make a local copy so that we can strtok() it */
 		strncpy(bpf_vlog_copy, bpf_vlog, sizeof(bpf_vlog_copy));
-		line_ptr = strtok(bpf_vlog_copy, "\n");
+		start = strstr(bpf_vlog_copy, main_pass_start);
+		if (!start) {
+			ret = 1;
+			printf("Can't find initial line '%s'\n", main_pass_start);
+			goto out;
+		}
+		line_ptr = strtok(start, "\n");
 		for (i = 0; i < MAX_MATCHES; i++) {
 			struct bpf_reg_match m = test->matches[i];
 			const char *p;
@@ -682,6 +690,7 @@ static int do_test_single(struct bpf_align_test *test)
 				break;
 			}
 		}
+out:
 		if (fd_prog >= 0)
 			close(fd_prog);
 	}
-- 
2.48.1


