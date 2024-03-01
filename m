Return-Path: <bpf+bounces-23107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A045986DA42
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 04:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B9C283181
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 03:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCEA4E1D1;
	Fri,  1 Mar 2024 03:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4pdmuY8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2944D5BA
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 03:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264269; cv=none; b=Rw6pw3MQQBhqIqTqs7cYf310KISGu0b02tPuid0RdgTgKhYS0toOQbvQ0VYIL+SKyXmqRmXzs9t6OW7bHK3Nu3Tli9tz9xanibNGwZcfQpDmoQDvpaA38lIFHNCfQ5YPHahcCtuWVtZc4/6q3qnOAYkZRJwfT5G3VyzwMnOcfBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264269; c=relaxed/simple;
	bh=wIdeQUNwiI7lzV8Xg5Y9BGaJwpweAkRHSJHQai+bqcY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LNsiCbdriw8FMyv0dwmk2AdgKr5jEXqGu+5wbSgmILmb5MKryFgv++rlNogQLr3xjyQ8GCJaCg5/uKRhv9W/2vUvRH3L6h7iW0DzXKPWeknCJhsok5UXd7qKrqSUGvWGqZ4/llkqGVwngDVPyZoNA+YAunuvYOk4jRJ8AQJDM50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4pdmuY8; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ce942efda5so1337513a12.2
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 19:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709264266; x=1709869066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+PEqmP0tFRYWN9csRQjsmBuNFCx7wuMvEfX0ueLztY=;
        b=b4pdmuY8c6mplJuO84dl9cKGrzo6LlhHvjlPKU0w5gOTCey33uIc0K+o2u2XyPvOyB
         elziIWzkWJ+AFuAZwv4fKJ2KvKxyBUtvG0dbKtSOBAiGGN5SbGsQmgRkl57oKiKG1pxI
         3HqhMpAyiiy2ZvbAf/Ox0D/7kuUb4K6umYJnAgkbxXlNX0c270gAByTltPVoQ+gbD2E7
         ewsvb2IcRNXcC1EfzllId+r+k3OkeEHy98rdiONRSGwXjRWqjatRX1dig89Te1SIkWy0
         zi/+eS7wkUNIqsE+LleT2iXWbqkpIjFMDw613sm2U6PD6KlOsyr9yduCjP51YH44lYvo
         hLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709264266; x=1709869066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+PEqmP0tFRYWN9csRQjsmBuNFCx7wuMvEfX0ueLztY=;
        b=jl8OIeUCBD6VbGQ/jHUK7AC2bIsXP5trZh73gDxXnwBkIuEi/sfN8PuZlYsLwCnxF6
         /5OI65038B2FBkvF49hLPvHrvIbpT5UmteYUnyVlS3P5iaNkbUUWviUNpqqGppkDvefM
         Fq9UXo0UzR7cotfUkYph/JflU1A7vqVqxx0dXLPTa6c94WMS/QiOLGyB5RAht/TbEkN9
         3LFXoZ7kxnQnDALC4S78rtDwnnw6frRYerrRzZRnRnG1IJa7HczMWzkGztvOuLf2Eadh
         iTNkuC9HK70qdTuGdU9w+UlMemtBKTChFL2vgDbaetq98aEVZzmk7yLVBmz5J4sHR7Nm
         93uw==
X-Gm-Message-State: AOJu0Yyx8xHSzcDa3cE/Yh99Mj5/apaSrK2RPkHEYrTKo4vOk26RFhZE
	QYpIGqxe0gVffT21ZyS42Y1ovqB08PGyeWcp+UvUE68R5C0YYb/lGgU/yP+f
X-Google-Smtp-Source: AGHT+IH2N2UR1waMuGXeT7Y7mwe/0usR/Bj+OA0MF2RbV/8XfI3BJXSnRLh1cOO/n9T3THO6pAKeaQ==
X-Received: by 2002:a05:6a20:43a2:b0:1a1:186e:69e5 with SMTP id i34-20020a056a2043a200b001a1186e69e5mr490501pzl.38.1709264265546;
        Thu, 29 Feb 2024 19:37:45 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:8f17])
        by smtp.gmail.com with ESMTPSA id z9-20020a170903018900b001dba2e99a9esm2282329plg.90.2024.02.29.19.37.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Feb 2024 19:37:45 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 1/4] bpf: Introduce may_goto instruction
Date: Thu, 29 Feb 2024 19:37:31 -0800
Message-Id: <20240301033734.95939-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240301033734.95939-1-alexei.starovoitov@gmail.com>
References: <20240301033734.95939-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Introduce may_goto instruction that acts on a hidden bpf_iter_num, so that
bpf_iter_num_new(), bpf_iter_num_destroy() don't need to be called explicitly.
It can be used in any normal "for" or "while" loop, like

  for (i = zero; i < cnt; cond_break, i++) {

The verifier recognizes that may_goto is used in the program,
reserves additional 8 bytes of stack, initializes them in subprog
prologue, and replaces may_goto instruction with:
aux_reg = *(u64 *)(fp - 40)
if aux_reg == 0 goto pc+off
aux_reg += 1
*(u64 *)(fp - 40) = aux_reg

may_goto instruction can be used by LLVM to implement __builtin_memcpy,
__builtin_strcmp.

may_goto is not a full substitute for bpf_for() macro.
bpf_for() doesn't have induction variable that verifiers sees,
so 'i' in bpf_for(i, 0, 100) is seen as imprecise and bounded.

But when the code is written as:
for (i = 0; i < 100; cond_break, i++)
the verifier see 'i' as precise constant zero,
hence cond_break (aka may_goto) doesn't help to converge the loop.
A static or global variable can be used as a workaround:
static int zero = 0;
for (i = zero; i < 100; cond_break, i++) // works!

may_goto works well with arena pointers that don't need to be bounds-checked
on every iteration. Load/store from arena returns imprecise unbounded scalars.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h   |   2 +
 include/uapi/linux/bpf.h       |   1 +
 kernel/bpf/core.c              |   1 +
 kernel/bpf/disasm.c            |   3 +
 kernel/bpf/verifier.c          | 235 +++++++++++++++++++++++++--------
 tools/include/uapi/linux/bpf.h |   1 +
 6 files changed, 189 insertions(+), 54 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 84365e6dd85d..8bd8bb32bb28 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -449,6 +449,7 @@ struct bpf_verifier_state {
 	u32 jmp_history_cnt;
 	u32 dfs_depth;
 	u32 callback_unroll_depth;
+	struct bpf_reg_state may_goto_reg;
 };
 
 #define bpf_get_spilled_reg(slot, frame, mask)				\
@@ -619,6 +620,7 @@ struct bpf_subprog_info {
 	u32 start; /* insn idx of function entry point */
 	u32 linfo_idx; /* The idx to the main_prog->aux->linfo */
 	u16 stack_depth; /* max. stack depth used by this function */
+	u16 stack_extra;
 	bool has_tail_call: 1;
 	bool tail_call_reachable: 1;
 	bool has_ld_abs: 1;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d2e6c5fcec01..8cf86566ad6d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -42,6 +42,7 @@
 #define BPF_JSGE	0x70	/* SGE is signed '>=', GE in x86 */
 #define BPF_JSLT	0xc0	/* SLT is signed, '<' */
 #define BPF_JSLE	0xd0	/* SLE is signed, '<=' */
+#define BPF_JMA		0xe0	/* may_goto */
 #define BPF_CALL	0x80	/* function call */
 #define BPF_EXIT	0x90	/* function return */
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 71c459a51d9e..ba6101447b49 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1675,6 +1675,7 @@ bool bpf_opcode_in_insntable(u8 code)
 		[BPF_LD | BPF_IND | BPF_B] = true,
 		[BPF_LD | BPF_IND | BPF_H] = true,
 		[BPF_LD | BPF_IND | BPF_W] = true,
+		[BPF_JMP | BPF_JMA] = true,
 	};
 #undef BPF_INSN_3_TBL
 #undef BPF_INSN_2_TBL
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 49940c26a227..598cd38af84c 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -322,6 +322,9 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		} else if (insn->code == (BPF_JMP | BPF_JA)) {
 			verbose(cbs->private_data, "(%02x) goto pc%+d\n",
 				insn->code, insn->off);
+		} else if (insn->code == (BPF_JMP | BPF_JMA)) {
+			verbose(cbs->private_data, "(%02x) may_goto pc%+d\n",
+				insn->code, insn->off);
 		} else if (insn->code == (BPF_JMP32 | BPF_JA)) {
 			verbose(cbs->private_data, "(%02x) gotol pc%+d\n",
 				insn->code, insn->imm);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c34b91b9583..a50395872d58 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1441,6 +1441,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 		if (err)
 			return err;
 	}
+	dst_state->may_goto_reg = src->may_goto_reg;
 	return 0;
 }
 
@@ -7878,6 +7879,43 @@ static int widen_imprecise_scalars(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static bool is_may_goto_insn(struct bpf_verifier_env *env, int insn_idx)
+{
+	return env->prog->insnsi[insn_idx].code == (BPF_JMP | BPF_JMA);
+}
+
+static struct bpf_reg_state *get_iter_reg_meta(struct bpf_verifier_state *st,
+					       struct bpf_kfunc_call_arg_meta *meta)
+{
+	int iter_frameno = meta->iter.frameno;
+	int iter_spi = meta->iter.spi;
+
+	return &st->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
+}
+
+static struct bpf_reg_state *get_iter_reg(struct bpf_verifier_env *env,
+					  struct bpf_verifier_state *st, int insn_idx)
+{
+	struct bpf_reg_state *iter_reg;
+	struct bpf_func_state *frame;
+	int spi;
+
+	if (is_may_goto_insn(env, insn_idx))
+		return &st->may_goto_reg;
+
+	frame = st->frame[st->curframe];
+	/* btf_check_iter_kfuncs() enforces that
+	 * iter state pointer is always the first arg
+	 */
+	iter_reg = &frame->regs[BPF_REG_1];
+	/* current state is valid due to states_equal(),
+	 * so we can assume valid iter and reg state,
+	 * no need for extra (re-)validations
+	 */
+	spi = __get_spi(iter_reg->off + (s32)iter_reg->var_off.value);
+	return &st->frame[iter_reg->frameno]->stack[spi].spilled_ptr;
+}
+
 /* process_iter_next_call() is called when verifier gets to iterator's next
  * "method" (e.g., bpf_iter_num_next() for numbers iterator) call. We'll refer
  * to it as just "iter_next()" in comments below.
@@ -7957,17 +7995,18 @@ static int widen_imprecise_scalars(struct bpf_verifier_env *env,
  *     bpf_iter_num_destroy(&it);
  */
 static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
-				  struct bpf_kfunc_call_arg_meta *meta)
+				  struct bpf_kfunc_call_arg_meta *meta, bool may_goto)
 {
 	struct bpf_verifier_state *cur_st = env->cur_state, *queued_st, *prev_st;
 	struct bpf_func_state *cur_fr = cur_st->frame[cur_st->curframe], *queued_fr;
 	struct bpf_reg_state *cur_iter, *queued_iter;
-	int iter_frameno = meta->iter.frameno;
-	int iter_spi = meta->iter.spi;
 
 	BTF_TYPE_EMIT(struct bpf_iter);
 
-	cur_iter = &env->cur_state->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
+	if (may_goto)
+		cur_iter = &cur_st->may_goto_reg;
+	else
+		cur_iter = get_iter_reg_meta(cur_st, meta);
 
 	if (cur_iter->iter.state != BPF_ITER_STATE_ACTIVE &&
 	    cur_iter->iter.state != BPF_ITER_STATE_DRAINED) {
@@ -7990,25 +8029,32 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 		 * right at this instruction.
 		 */
 		prev_st = find_prev_entry(env, cur_st->parent, insn_idx);
+
 		/* branch out active iter state */
 		queued_st = push_stack(env, insn_idx + 1, insn_idx, false);
 		if (!queued_st)
 			return -ENOMEM;
 
-		queued_iter = &queued_st->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
+		if (may_goto)
+			queued_iter = &queued_st->may_goto_reg;
+		else
+			queued_iter = get_iter_reg_meta(queued_st, meta);
 		queued_iter->iter.state = BPF_ITER_STATE_ACTIVE;
 		queued_iter->iter.depth++;
 		if (prev_st)
 			widen_imprecise_scalars(env, prev_st, queued_st);
 
-		queued_fr = queued_st->frame[queued_st->curframe];
-		mark_ptr_not_null_reg(&queued_fr->regs[BPF_REG_0]);
+		if (!may_goto) {
+			queued_fr = queued_st->frame[queued_st->curframe];
+			mark_ptr_not_null_reg(&queued_fr->regs[BPF_REG_0]);
+		}
 	}
 
 	/* switch to DRAINED state, but keep the depth unchanged */
 	/* mark current iter state as drained and assume returned NULL */
 	cur_iter->iter.state = BPF_ITER_STATE_DRAINED;
-	__mark_reg_const_zero(env, &cur_fr->regs[BPF_REG_0]);
+	if (!may_goto)
+		__mark_reg_const_zero(env, &cur_fr->regs[BPF_REG_0]);
 
 	return 0;
 }
@@ -12433,7 +12479,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	}
 
 	if (is_iter_next_kfunc(&meta)) {
-		err = process_iter_next_call(env, insn_idx, &meta);
+		err = process_iter_next_call(env, insn_idx, &meta, false);
 		if (err)
 			return err;
 	}
@@ -14869,11 +14915,24 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	int err;
 
 	/* Only conditional jumps are expected to reach here. */
-	if (opcode == BPF_JA || opcode > BPF_JSLE) {
+	if (opcode == BPF_JA || opcode > BPF_JMA) {
 		verbose(env, "invalid BPF_JMP/JMP32 opcode %x\n", opcode);
 		return -EINVAL;
 	}
 
+	if (opcode == BPF_JMA) {
+		if (insn->code != (BPF_JMP | BPF_JMA) ||
+		    insn->src_reg || insn->dst_reg) {
+			verbose(env, "invalid may_goto\n");
+			return -EINVAL;
+		}
+		err = process_iter_next_call(env, *insn_idx, NULL, true);
+		if (err)
+			return err;
+		*insn_idx += insn->off;
+		return 0;
+	}
+
 	/* check src2 operand */
 	err = check_reg_arg(env, insn->dst_reg, SRC_OP);
 	if (err)
@@ -15657,6 +15716,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 	default:
 		/* conditional jump with two edges */
 		mark_prune_point(env, t);
+		if (insn->code == (BPF_JMP | BPF_JMA))
+			mark_force_checkpoint(env, t);
 
 		ret = push_insn(t, t + 1, FALLTHROUGH, env);
 		if (ret)
@@ -16767,6 +16828,9 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->active_rcu_lock != cur->active_rcu_lock)
 		return false;
 
+	if (old->may_goto_reg.iter.state != cur->may_goto_reg.iter.state)
+		return false;
+
 	/* for states to be equal callsites have to be the same
 	 * and all frame states need to be equivalent
 	 */
@@ -17005,6 +17069,9 @@ static bool iter_active_depths_differ(struct bpf_verifier_state *old, struct bpf
 	struct bpf_func_state *state;
 	int i, fr;
 
+	if (old->may_goto_reg.iter.depth != cur->may_goto_reg.iter.depth)
+		return true;
+
 	for (fr = old->curframe; fr >= 0; fr--) {
 		state = old->frame[fr];
 		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
@@ -17109,23 +17176,11 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * comparison would discard current state with r7=-32
 			 * => unsafe memory access at 11 would not be caught.
 			 */
-			if (is_iter_next_insn(env, insn_idx)) {
+			if (is_iter_next_insn(env, insn_idx) || is_may_goto_insn(env, insn_idx)) {
 				if (states_equal(env, &sl->state, cur, true)) {
-					struct bpf_func_state *cur_frame;
-					struct bpf_reg_state *iter_state, *iter_reg;
-					int spi;
+					struct bpf_reg_state *iter_state;
 
-					cur_frame = cur->frame[cur->curframe];
-					/* btf_check_iter_kfuncs() enforces that
-					 * iter state pointer is always the first arg
-					 */
-					iter_reg = &cur_frame->regs[BPF_REG_1];
-					/* current state is valid due to states_equal(),
-					 * so we can assume valid iter and reg state,
-					 * no need for extra (re-)validations
-					 */
-					spi = __get_spi(iter_reg->off + iter_reg->var_off.value);
-					iter_state = &func(env, iter_reg)->stack[spi].spilled_ptr;
+					iter_state = get_iter_reg(env, cur, insn_idx);
 					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE) {
 						update_loop_entry(cur, &sl->state);
 						goto hit;
@@ -19406,7 +19461,10 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 	struct bpf_insn insn_buf[16];
 	struct bpf_prog *new_prog;
 	struct bpf_map *map_ptr;
-	int i, ret, cnt, delta = 0;
+	int i, ret, cnt, delta = 0, cur_subprog = 0;
+	struct bpf_subprog_info *subprogs = env->subprog_info;
+	u16 stack_depth = subprogs[cur_subprog].stack_depth;
+	u16 stack_depth_extra = 0;
 
 	if (env->seen_exception && !env->exception_callback_subprog) {
 		struct bpf_insn patch[] = {
@@ -19426,7 +19484,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		mark_subprog_exc_cb(env, env->exception_callback_subprog);
 	}
 
-	for (i = 0; i < insn_cnt; i++, insn++) {
+	for (i = 0; i < insn_cnt;) {
 		/* Make divide-by-zero exceptions impossible. */
 		if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
 		    insn->code == (BPF_ALU64 | BPF_DIV | BPF_X) ||
@@ -19465,7 +19523,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		/* Implement LD_ABS and LD_IND with a rewrite, if supported by the program type. */
@@ -19485,7 +19543,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		/* Rewrite pointer arithmetic to mitigate speculation attacks. */
@@ -19500,7 +19558,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			aux = &env->insn_aux_data[i + delta];
 			if (!aux->alu_state ||
 			    aux->alu_state == BPF_ALU_NON_POINTER)
-				continue;
+				goto next_insn;
 
 			isneg = aux->alu_state & BPF_ALU_NEG_VALUE;
 			issrc = (aux->alu_state & BPF_ALU_SANITIZE) ==
@@ -19538,19 +19596,39 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
+		}
+
+		if (insn->code == (BPF_JMP | BPF_JMA)) {
+			int stack_off = -stack_depth - 8;
+
+			stack_depth_extra = 8;
+			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off);
+			insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off + 2);
+			insn_buf[2] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
+			insn_buf[3] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off);
+			cnt = 4;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta += cnt - 1;
+			env->prog = prog = new_prog;
+			insn = new_prog->insnsi + i + delta;
+			goto next_insn;
 		}
 
 		if (insn->code != (BPF_JMP | BPF_CALL))
-			continue;
+			goto next_insn;
 		if (insn->src_reg == BPF_PSEUDO_CALL)
-			continue;
+			goto next_insn;
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			ret = fixup_kfunc_call(env, insn, insn_buf, i + delta, &cnt);
 			if (ret)
 				return ret;
 			if (cnt == 0)
-				continue;
+				goto next_insn;
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
@@ -19559,7 +19637,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta	 += cnt - 1;
 			env->prog = prog = new_prog;
 			insn	  = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		if (insn->imm == BPF_FUNC_get_route_realm)
@@ -19607,11 +19685,11 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 				}
 
 				insn->imm = ret + 1;
-				continue;
+				goto next_insn;
 			}
 
 			if (!bpf_map_ptr_unpriv(aux))
-				continue;
+				goto next_insn;
 
 			/* instead of changing every JIT dealing with tail_call
 			 * emit two extra insns:
@@ -19640,7 +19718,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		if (insn->imm == BPF_FUNC_timer_set_callback) {
@@ -19752,7 +19830,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 				delta    += cnt - 1;
 				env->prog = prog = new_prog;
 				insn      = new_prog->insnsi + i + delta;
-				continue;
+				goto next_insn;
 			}
 
 			BUILD_BUG_ON(!__same_type(ops->map_lookup_elem,
@@ -19783,31 +19861,31 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			switch (insn->imm) {
 			case BPF_FUNC_map_lookup_elem:
 				insn->imm = BPF_CALL_IMM(ops->map_lookup_elem);
-				continue;
+				goto next_insn;
 			case BPF_FUNC_map_update_elem:
 				insn->imm = BPF_CALL_IMM(ops->map_update_elem);
-				continue;
+				goto next_insn;
 			case BPF_FUNC_map_delete_elem:
 				insn->imm = BPF_CALL_IMM(ops->map_delete_elem);
-				continue;
+				goto next_insn;
 			case BPF_FUNC_map_push_elem:
 				insn->imm = BPF_CALL_IMM(ops->map_push_elem);
-				continue;
+				goto next_insn;
 			case BPF_FUNC_map_pop_elem:
 				insn->imm = BPF_CALL_IMM(ops->map_pop_elem);
-				continue;
+				goto next_insn;
 			case BPF_FUNC_map_peek_elem:
 				insn->imm = BPF_CALL_IMM(ops->map_peek_elem);
-				continue;
+				goto next_insn;
 			case BPF_FUNC_redirect_map:
 				insn->imm = BPF_CALL_IMM(ops->map_redirect);
-				continue;
+				goto next_insn;
 			case BPF_FUNC_for_each_map_elem:
 				insn->imm = BPF_CALL_IMM(ops->map_for_each_callback);
-				continue;
+				goto next_insn;
 			case BPF_FUNC_map_lookup_percpu_elem:
 				insn->imm = BPF_CALL_IMM(ops->map_lookup_percpu_elem);
-				continue;
+				goto next_insn;
 			}
 
 			goto patch_call_imm;
@@ -19835,7 +19913,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		/* Implement bpf_get_func_arg inline. */
@@ -19860,7 +19938,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		/* Implement bpf_get_func_ret inline. */
@@ -19888,7 +19966,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		/* Implement get_func_arg_cnt inline. */
@@ -19903,7 +19981,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		/* Implement bpf_get_func_ip inline. */
@@ -19918,7 +19996,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		/* Implement bpf_kptr_xchg inline */
@@ -19936,7 +20014,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 patch_call_imm:
 		fn = env->ops->get_func_proto(insn->imm, env->prog);
@@ -19950,6 +20028,39 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			return -EFAULT;
 		}
 		insn->imm = fn->func - __bpf_call_base;
+next_insn:
+		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
+			subprogs[cur_subprog].stack_depth += stack_depth_extra;
+			subprogs[cur_subprog].stack_extra = stack_depth_extra;
+			cur_subprog++;
+			stack_depth = subprogs[cur_subprog].stack_depth;
+			stack_depth_extra = 0;
+		}
+		i++; insn++;
+	}
+
+	env->prog->aux->stack_depth = subprogs[0].stack_depth;
+	for (i = 0; i < env->subprog_cnt; i++) {
+		int subprog_start = subprogs[i].start, j;
+		int stack_slots = subprogs[i].stack_extra / 8;
+
+		if (stack_slots >= ARRAY_SIZE(insn_buf)) {
+			verbose(env, "verifier bug: stack_extra is too large\n");
+			return -EFAULT;
+		}
+
+		/* Add insns to subprog prologue to zero init extra stack */
+		for (j = 0; j < stack_slots; j++)
+			insn_buf[j] = BPF_ST_MEM(BPF_DW, BPF_REG_FP,
+						 -subprogs[i].stack_depth + j * 8, BPF_MAX_LOOPS);
+		if (j) {
+			insn_buf[j] = env->prog->insnsi[subprog_start];
+
+			new_prog = bpf_patch_insn_data(env, subprog_start, insn_buf, j + 1);
+			if (!new_prog)
+				return -ENOMEM;
+			env->prog = prog = new_prog;
+		}
 	}
 
 	/* Since poke tab is now finalized, publish aux to tracker. */
@@ -20140,6 +20251,21 @@ static void free_states(struct bpf_verifier_env *env)
 	}
 }
 
+static void init_may_goto_reg(struct bpf_reg_state *st)
+{
+	__mark_reg_known_zero(st);
+	st->type = PTR_TO_STACK;
+	st->live |= REG_LIVE_WRITTEN;
+	st->ref_obj_id = 0;
+	st->iter.btf = NULL;
+	st->iter.btf_id = 0;
+	/* Init register state to sane values.
+	 * Only iter.state and iter.depth are used during verification.
+	 */
+	st->iter.state = BPF_ITER_STATE_ACTIVE;
+	st->iter.depth = 0;
+}
+
 static int do_check_common(struct bpf_verifier_env *env, int subprog)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
@@ -20157,6 +20283,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	state->curframe = 0;
 	state->speculative = false;
 	state->branches = 1;
+	init_may_goto_reg(&state->may_goto_reg);
 	state->frame[0] = kzalloc(sizeof(struct bpf_func_state), GFP_KERNEL);
 	if (!state->frame[0]) {
 		kfree(state);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d2e6c5fcec01..8cf86566ad6d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -42,6 +42,7 @@
 #define BPF_JSGE	0x70	/* SGE is signed '>=', GE in x86 */
 #define BPF_JSLT	0xc0	/* SLT is signed, '<' */
 #define BPF_JSLE	0xd0	/* SLE is signed, '<=' */
+#define BPF_JMA		0xe0	/* may_goto */
 #define BPF_CALL	0x80	/* function call */
 #define BPF_EXIT	0x90	/* function return */
 
-- 
2.34.1


