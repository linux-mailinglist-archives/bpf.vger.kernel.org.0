Return-Path: <bpf+bounces-53232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C294A4EDE3
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 20:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F021893D0A
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 19:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DBA27780E;
	Tue,  4 Mar 2025 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUj0ngUx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AC52641E2
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 19:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117851; cv=none; b=MAcgmI1/1UTppGyTgn30/U4saz8i8yH2LU2NmDwnzeOE/9XvOSy84atLkAfwOhSYsN8oG6nfpFLw5O0+9On7fwbHIofd81n/0TGtPn+os9JkdcJbZm9VHOhc5yhzLql44S6OTvz+CtxdB2wVtC3K6zdwP4raJKckzuV1lRnhN2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117851; c=relaxed/simple;
	bh=AXfGSJsA0eV1ViGZEzHOcjONmQQvegpB97yILykbinw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/6u2bxozG8qIBgTdQHvaTGICfx7EZn+3HrN4aAIMba8AG1fMxVoJPxTU6dol8dURGFQHUNhu+dfbgFFBWZIL5iPLemNva0H7MvWY8VRgvfup4n9sj49c93Jy8weE/LTeIHWagXHMqn4Bz9PjxQ1PiGTVpDbaWzGLecu01I+cr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUj0ngUx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2234e5347e2so123850525ad.1
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 11:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741117848; x=1741722648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yVJzsYOCbAgaVgXKT7N0XRKjy8C1iCoGDBhKidKGI0=;
        b=DUj0ngUx6MmtVzVz4lQac6c8bRkI189WtzYPIdATBpgXjgKfWYNGMgAofRKaVbKHzZ
         nTL64yQ97RJyUe7nEZxu+Uun2v6Wl+OqMy9XtP4b3zNaeOlQ1Z2AWPl8hV2jOffAM2CD
         PZaxg8X5b2zLMBv/2E/atKA4CkA65PcwAjXX4kedeob0uOsxZvfqWohygeoSbjMeZ4UU
         hJCxqwxZd85HJvY5w4CaFVkeyW1Y5xynysTi/O3cKXgg6S+tsg5MWBPv3tDM2KJTmlC5
         VQkKA8N80r5cUSVDMnG+SpJXl5D4kTsSkYhSM+CiVHxPWlJ7H4DPjkPjUfEyWNbkkeCg
         Fi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741117848; x=1741722648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yVJzsYOCbAgaVgXKT7N0XRKjy8C1iCoGDBhKidKGI0=;
        b=tqXE21Gh+ZB9EOO4/sP5qOl8MMrNjjreFWVfKcdN91stmFvf9MYe45csuHSPCetQsN
         Cw1hexAegPeZ7xwjKJBWa4XviyUUso1gh8dlgjvuST+d13zaaqwin5CHeosDEVjO+VRB
         wWLjyjwPL4YWWR+SzedJio5ao6WRaE3hykUeOkA+I2a8EXwa5queJP0U553QCSxJJ8ul
         R5U+WcWrkTfbr8NBC8P0A8CggHcPp1Bb/ovyONAIhTdilwYnIyFGF2u+L9s3u6JQRghp
         yYZzH3iRrg9zAZPQvBuwU2XhbCobjcqkELUFsdIPG1Bl3i8Q5KcuYM7VKEmqZQxB2Ha0
         E1CA==
X-Gm-Message-State: AOJu0YyANN88ds2al8PZdFZmfS+b3bsXpBm6WSPS/6koUKvVxCOFijZx
	7hLfD1g+IAts1pTwQtmIsOBdX+n8zQcV4mDeriOtqQDVh8PSdvmxPl09qA==
X-Gm-Gg: ASbGnctGQ/zdXcDt7qf72Xtb3jW8PY2zBx4Ft2zNymWh8y66RWERt7r5Saz0NctFgpU
	2QN/Yt36UYSwA4amQXiIY9WnI1e7JHvIWZNsIaVHgP8xAGCr2DAdeMGO4fJQWqS40Y6UHrByjju
	ylrdQXSpQvfzA079ZCjJue762sNok5P46r216wH4l682jnLmNrOhs1ghRPJY5E8b+trusFFM16g
	6zSAPA7Oa5hv7b1/aY0fMJqCqB4XYbn+boTxwOfR38iuvifjCSkuR9cKoLjug3fQEfnjotkcibK
	pRWE1LwfcIP7TUwY9aSx9pp8lzVYV6gMnGeoyMqk
X-Google-Smtp-Source: AGHT+IHDN2x4xIC9Fgv1gzRSCxu/CX6Jc3K4w2jeUcFF7dD5ARWhGOP2R7HCn8ZkIOVYWhuMUvPmDg==
X-Received: by 2002:a17:902:e74a:b0:223:2675:74d5 with SMTP id d9443c01a7336-223f1c7fde2mr7706865ad.15.1741117846761;
        Tue, 04 Mar 2025 11:50:46 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bc6sm98560925ad.126.2025.03.04.11.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 11:50:46 -0800 (PST)
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
Subject: [PATCH bpf-next v3 3/5] bpf: simple DFA-based live registers analysis
Date: Tue,  4 Mar 2025 11:50:22 -0800
Message-ID: <20250304195024.2478889-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304195024.2478889-1-eddyz87@gmail.com>
References: <20250304195024.2478889-1-eddyz87@gmail.com>
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
 kernel/bpf/verifier.c                         | 320 +++++++++++++++++-
 .../testing/selftests/bpf/prog_tests/align.c  |  11 +-
 3 files changed, 330 insertions(+), 7 deletions(-)

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
index 5cc1b6ed0e92..b434251979b1 100644
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
 
@@ -23379,6 +23387,301 @@ static int process_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr,
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
+			switch (insn->imm) {
+			case BPF_CMPXCHG:
+				use = r0 | dst | src;
+				def = r0;
+				break;
+			case BPF_LOAD_ACQ:
+				def = dst;
+				use = src;
+				break;
+			case BPF_STORE_REL:
+				def = 0;
+				use = dst | src;
+				break;
+			default:
+				use = dst | src;
+				if (insn->imm & BPF_FETCH)
+					def = src;
+				else
+					def = 0;
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
@@ -23500,6 +23803,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret)
 		goto skip_full_check;
 
+	ret = compute_live_registers(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = mark_fastcall_patterns(env);
 	if (ret < 0)
 		goto skip_full_check;
@@ -23638,6 +23945,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
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


