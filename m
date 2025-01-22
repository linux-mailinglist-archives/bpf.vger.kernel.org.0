Return-Path: <bpf+bounces-49476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4496A1911E
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 13:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE1B18892D7
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 12:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176B0212B39;
	Wed, 22 Jan 2025 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDeuwyv9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91724212D60
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547509; cv=none; b=l6G3QXsmUePYx96Se+NXsLSFyub6ReMJRm/p8jDmgwadc7L1zlIqxeyQoiuA71SDHBX+Rsy2p6LbzqTJ0BOdAtmky2wYAu1k3bfwfXniVVlhPlQaWoYMLvtvHq9Vbo3e/tl6boDNA1phvD2hGARrIHd1R5GRcMg8zC0zw3fcjuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547509; c=relaxed/simple;
	bh=eXvBNDxWQXxp4P3J/r71Hi2RVZk6Y8EC+RH2KpizEL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhGnY+Uk1iWPaNIuWCI153yLteS5RL//MaFZdxr13CWinayfm6pVQ8NA5cz6rHsyM/Uh9uUJjrSvkKCo9VCgYgpbrYw16aFgZXrgG9jTuL4xl8P4XKCrJ7upNtJx6mOIIqI2jFcLtE5EMSfgpEpfd3Quli1RUOBBavIl3t9zhE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDeuwyv9; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so9475935a91.3
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 04:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737547506; x=1738152306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZf3ecuWIOghN+lgZSZBs7yqr/8ijf2Yq0vtSSWuFt4=;
        b=RDeuwyv9bIAs0EAFdBtskZAWGEwBcAjTMksVRddNYrbUpP2Vfp/yYWKDMK7xMarjeK
         N1yCBahnLP8rN9PMqLXLvCJpk2ibS0qBnFyfX7GUZacy13846TVoU9uDEsbUCgdqSpzK
         JJr87tZyens7m0/dYfY1HuPFguG6DbrUFiatkUM/+HDCdScTV0yR+TkP+i8bkjiJoJXM
         VULxgriXzhboHGF9LCGg/SbGFVPuymEchVAsZPE5JdfMZIt0Qs3SPu9Udc6kvtieT5Sh
         KaszZR35JZO/tLgK0h72OpMi+bYaflvvct5tYxdGPqfewytbkGKD5dP52644jf9t/UpP
         +Vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737547506; x=1738152306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZf3ecuWIOghN+lgZSZBs7yqr/8ijf2Yq0vtSSWuFt4=;
        b=wvkCuiUFOQNkAxkT4KVmGbG9JaY3Mc50HzFibYKfr88Mx3UwgxcE7Qca7TJFRQDkGS
         oYpOZUhmHg0KOz/x2V0AXlSkihryHDUZZ7mfnfdM/WlmXlzx+NH71asJWOAq9D/yMpl4
         HGxUV58l6vTxn8s7HFDU9fZWihezqmPm5Wr2H8z/GpeTXQxSz7LKDF48DIE0An4iqmFW
         K9bOhKdfnH36A2suZ9lP3cqVVVMsdPETQb4zOLOD0ju/zp4K470dgDsj8m7CbL/DXzyR
         rNwmU+ID9tvaKHLQXwEoqNz2PPn3vhJyNj3IMscKVgBP1X+cURT+P+HweUCoulkGdOBG
         C6XQ==
X-Gm-Message-State: AOJu0YxYbpgVF5hO+yC1PKqRorECRwJhF5pXrkFu7JTV2jh1xwjL90uM
	xD/odIkmeI/SXkBe0Xdx+B/4YeDRnNk2KGfE52Q3iKa9cZqgTw98FD9HKg==
X-Gm-Gg: ASbGncuwjb5MawJQ9HfpZQIQXtt7LThEI3GxdcP3VoCibosmbj/va1BdS4SCS/iNsYu
	pMPt6+xbAbeAPNNp6g7zX2WmUYTcLP339BlgV8A7L7Q8otX+5mWmREHHpsw8XUzPb+yhWB4USdW
	/W6zQcMtarvW9+g7QvtfeMRMiFadvowtv7lhArjyZEgscZ1SxglS6vac6oTQUFcHPgE9MEDcGDC
	UvJgmWU3sf6KtBxoyxpzNIGNeL+hndzb4sQwtH0hz3vOPE3CPSCjYt3gY7zIeqXdQ==
X-Google-Smtp-Source: AGHT+IGzxHtLLWIObAIsDZNVHlJJ/ToGn0ikoivI/fIiKs+Iw9vE5tmHamdCIKyf4BKWPiTxj6TcyA==
X-Received: by 2002:a05:6a00:c92:b0:725:e499:5b8a with SMTP id d2e1a72fcca58-72dafa9ac70mr27484807b3a.15.1737547505402;
        Wed, 22 Jan 2025 04:05:05 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab816412sm11055732b3a.66.2025.01.22.04.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 04:05:04 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next v1 5/7] bpf: DFA-based liveness analysis for program registers
Date: Wed, 22 Jan 2025 04:04:40 -0800
Message-ID: <20250122120442.3536298-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122120442.3536298-1-eddyz87@gmail.com>
References: <20250122120442.3536298-1-eddyz87@gmail.com>
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
 kernel/bpf/verifier.c                         | 351 ++++++++++++++++--
 .../testing/selftests/bpf/prog_tests/align.c  |  11 +-
 3 files changed, 344 insertions(+), 24 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 32c23f2a3086..2b243a32d846 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -589,6 +589,8 @@ struct bpf_insn_aux_data {
 	 * accepts callback function as a parameter.
 	 */
 	bool calls_callback;
+	/* registers alive before this instruction. */
+	u16 live_regs_before;
 };
 
 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
@@ -742,7 +744,11 @@ struct bpf_verifier_env {
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
index 1c2199a3f38f..d36c5a3309e9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3268,6 +3268,15 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 	return 0;
 }
 
+static int jmp_offset(struct bpf_insn *insn)
+{
+	u8 code = insn->code;
+
+	if (code == (BPF_JMP32 | BPF_JA))
+		return insn->imm;
+	return insn->off;
+}
+
 static int check_subprogs(struct bpf_verifier_env *env)
 {
 	int i, subprog_start, subprog_end, off, cur_subprog = 0;
@@ -3294,10 +3303,7 @@ static int check_subprogs(struct bpf_verifier_env *env)
 			goto next;
 		if (BPF_OP(code) == BPF_EXIT || BPF_OP(code) == BPF_CALL)
 			goto next;
-		if (code == (BPF_JMP32 | BPF_JA))
-			off = i + insn[i].imm + 1;
-		else
-			off = i + insn[i].off + 1;
+		off = i + jmp_offset(&insn[i]) + 1;
 		if (off < subprog_start || off >= subprog_end) {
 			verbose(env, "jump out of range from insn %d to %d\n", i, off);
 			return -EINVAL;
@@ -3827,6 +3833,17 @@ static const char *disasm_kfunc_name(void *data, const struct bpf_insn *insn)
 	return btf_name_by_offset(desc_btf, func->name_off);
 }
 
+static void verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	const struct bpf_insn_cbs cbs = {
+		.cb_call	= disasm_kfunc_name,
+		.cb_print	= verbose,
+		.private_data	= env,
+	};
+
+	print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
+}
+
 static inline void bt_init(struct backtrack_state *bt, u32 frame)
 {
 	bt->frame = frame;
@@ -4027,11 +4044,6 @@ static bool calls_callback(struct bpf_verifier_env *env, int insn_idx);
 static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			  struct bpf_insn_hist_entry *hist, struct backtrack_state *bt)
 {
-	const struct bpf_insn_cbs cbs = {
-		.cb_call	= disasm_kfunc_name,
-		.cb_print	= verbose,
-		.private_data	= env,
-	};
 	struct bpf_insn *insn = env->prog->insnsi + idx;
 	u8 class = BPF_CLASS(insn->code);
 	u8 opcode = BPF_OP(insn->code);
@@ -4049,7 +4061,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 		fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_stack_mask(bt));
 		verbose(env, "stack=%s before ", env->tmp_str_buf);
 		verbose(env, "%d: ", idx);
-		print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
+		verbose_insn(env, insn);
 	}
 
 	/* If there is a history record that some registers gained range at this insn,
@@ -10909,6 +10921,9 @@ static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
 	return *ptr ? 0 : -EINVAL;
 }
 
+/* Bitmask with 1s for all caller saved registers */
+#define ALL_CALLER_SAVED_REGS ((1u << CALLER_SAVED_REGS) - 1)
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -17111,9 +17126,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 static int check_cfg(struct bpf_verifier_env *env)
 {
 	int insn_cnt = env->prog->len;
-	int *insn_stack, *insn_state;
+	int *insn_stack, *insn_state, *insn_postorder;
 	int ex_insn_beg, i, ret = 0;
-	bool ex_done = false;
 
 	insn_state = env->cfg.insn_state = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
 	if (!insn_state)
@@ -17125,6 +17139,17 @@ static int check_cfg(struct bpf_verifier_env *env)
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
@@ -17138,6 +17163,7 @@ static int check_cfg(struct bpf_verifier_env *env)
 		case DONE_EXPLORING:
 			insn_state[t] = EXPLORED;
 			env->cfg.cur_stack--;
+			insn_postorder[env->cfg.cur_postorder++] = t;
 			break;
 		case KEEP_EXPLORING:
 			break;
@@ -17156,13 +17182,10 @@ static int check_cfg(struct bpf_verifier_env *env)
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
 
@@ -19001,19 +19024,13 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 
 		if (env->log.level & BPF_LOG_LEVEL) {
-			const struct bpf_insn_cbs cbs = {
-				.cb_call	= disasm_kfunc_name,
-				.cb_print	= verbose,
-				.private_data	= env,
-			};
-
 			if (verifier_state_scratched(env))
 				print_insn_state(env, state, state->curframe);
 
 			verbose_linfo(env, env->insn_idx, "; ");
 			env->prev_log_pos = env->log.end_pos;
 			verbose(env, "%d: ", env->insn_idx);
-			print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
+			verbose_insn(env, insn);
 			env->prev_insn_print_pos = env->log.end_pos - env->prev_log_pos;
 			env->prev_log_pos = env->log.end_pos;
 		}
@@ -23024,6 +23041,289 @@ static int process_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr,
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
+	succ[0] = prog->len;
+	succ[1] = prog->len;
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
+/* Compute *use and *def values for the call instruction */
+static void compute_call_live_regs(struct bpf_verifier_env *env,
+				   struct bpf_insn *insn,
+				   u16 *use, u16 *def)
+{
+	*def = ALL_CALLER_SAVED_REGS;
+	*use = *def & ~BIT(BPF_REG_0);
+}
+
+/* Compute info->{use,def} fields for the instruction */
+static void compute_insn_live_regs(struct bpf_verifier_env *env,
+				   struct bpf_insn *insn,
+				   struct insn_live_regs *info)
+{
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
+			compute_call_live_regs(env, insn, &use, &def);
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
+	/* Use simple algorithm desribed in:
+	 * https://en.wikipedia.org/wiki/Live-variable_analysis
+	 *
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
@@ -23141,6 +23441,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret)
 		goto skip_full_check;
 
+	ret = compute_live_registers(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = mark_fastcall_patterns(env);
 	if (ret < 0)
 		goto skip_full_check;
@@ -23279,6 +23583,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
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
2.47.1


