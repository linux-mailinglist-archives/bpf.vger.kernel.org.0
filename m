Return-Path: <bpf+bounces-44281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93639C0D4A
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 18:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A1A2845D2
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C9921746C;
	Thu,  7 Nov 2024 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNXfTNGK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3111D216437
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001883; cv=none; b=TsqZk2kXvgQdllQuGIwjjz/3Rm8wNwGec1XRrnLh6aKtWxCdsFeJ0rF9usWd+cyXC8qodbeA5Fon35L+Bq4GcIZ2gyRlc3Wy90F4TiOGobHBEWbBoZKqzVKY1RlC8ZXRbmA5mplqqcNKWJGVGh94DaMJRkGyWJJH/tHsTsZ4MWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001883; c=relaxed/simple;
	bh=OkOmvkDH8eAFo6E6G3Mq9l3JMorEBQjgrp/n6kt9Tiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQUjst6q3PBs6bUWVEVfjhZ24MntRVbIIL0eYPmZdwn2vry8akouRlQ2u/i0KWz2+yPC6VKqZMmsmUq1lHspAYz9TvRIRcQEmpZ8Pq3vIZFJ1bfkx3co3E24t1qoqddAWBJiCrZlTh9hoJ/ZZMcfJS/YOCHDLbhrcXq2YTa5BHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNXfTNGK; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2fb304e7dso1019818a91.1
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 09:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731001880; x=1731606680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izpnNlirimuPAnth/LlfOO7NSZw79x18bvVJDXozcS0=;
        b=TNXfTNGKtOiydw7ljyvkADhqAuxyAY5WYYexfEe33aTmdz+tLAHyD72+858iFzpgWw
         hFpjQIHctFq0YYEdn+e19iBcFQWj+ANeFewXk3S9EgicZRCDkBPQHbQzZ7MpmdI69DP6
         XAOJPYxSIL7scA5Osw91zZZje1aOcpUtciCwx0ApEkQSfvRANIly1jhhfc2ikwwsDn5W
         8s9/mFOqo4YzhbzwZgTtjN3cXjQWMnh0657koZaGDr4a7umXHRrCBvhHiLh/vXfgkjqJ
         g1CHTgcjZkoKZfKCG1JwhyFWTcby2EAPuvsiOvNjmRTSdKarCS3ZXYUe1dT4++ntL71M
         Mdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731001880; x=1731606680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izpnNlirimuPAnth/LlfOO7NSZw79x18bvVJDXozcS0=;
        b=h7aE2A5QlVhEsQoYC7QilWH38DQGNVuw2Rbq3qtZnIB3Q9A7oeUElomJHH9r6Zz0uI
         OGGlF6795i+/8kQuIasJS+rm9evcChqaC+O7txUng6X50OX7L91/GLbGddhMCsHR1132
         mjWI97slSmBtwkiOP1/RAF6ccfe+7dulO8xRL1P7aPJ272cTapmYk/jYz3HsI9oEKU3t
         N4PE0jvTRSMy+y+JVZifpx2MLKeSUod+hpr2Vg6H5asGTjKNxHGVoKuiSOSaMerh+Jma
         ewGCK4oINYHFKSlhhwMAQun8gMLQX4BiuSPtdtVNAAGNnrk9YQ/+KQNStXxNv9ywhXKa
         VpOA==
X-Gm-Message-State: AOJu0Yzw1xvWJskXSJ9l3EI5QREHjTIKFGRQbiqN51/jYobV5XkAZPbZ
	eNKgFKx4YokXUf98VKVWbYmqt26dqKf4rrNBnkyUAviwd6fuR/EHGumoPIn+
X-Google-Smtp-Source: AGHT+IGXdZwqGuyAAnhbfjOmNc9jtoXGGbJtca8nKCLLd8G4eraQQ2lYwDTEZfPmMnV9KGE8x6UiZg==
X-Received: by 2002:a17:90b:3b50:b0:2e2:e743:74f7 with SMTP id 98e67ed59e1d1-2e9b16ef572mr57159a91.2.1731001880171;
        Thu, 07 Nov 2024 09:51:20 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f52b32sm1730686a91.5.2024.11.07.09.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 09:51:19 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 07/11] bpf: instantiate inlinable kfuncs before verification
Date: Thu,  7 Nov 2024 09:50:36 -0800
Message-ID: <20241107175040.1659341-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107175040.1659341-1-eddyz87@gmail.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to detect which branches inside kfuncs are always to true or
always false (e.g. because of parameters being constants) visit bodies
of inlinable kfuncs during main verification pass. Such conditionals
would be replaced by gotos before jiting. Verify kfunc calls in
(almost) identical way, regardless of kfunc being inlinable or not.

To facilitate this:
- before main verification pass, for each inlinable kfunc callsite,
  create a hidden subprogram with a body being a copy of inlinable
  kfunc body; let's call such subprograms inlinable kfunc instances;
- during main verification pass:
  - when visiting inlinable kfunc call:
    - verify call instruction using regular kfunc rules;
    - mark scalar call parameters as precise;
    - do a push_stack() for a state visiting kfunc instance body in a
      distilled context:
      - no caller stack frame;
      - values of scalar parameters and null pointers from the calling
        frame are copied as-is (it is ok if some of the scalar
        parameters would be marked precise during instance body
        verification, as these parameters are already marked precise
        at the call site);
      - dynptrs are represented as two register spills in a fake stack
        frame crafted in a way allowing verifier to recover dynptr type
        when code generated for bpf_dynptr_get_type() is processed;
      - all other parameters are passed as registers of type
        KERNEL_VALUE.
  - when 'exit' instruction within instance body is verified, do not
    return to the callsite, assume a valid end of verification path;
- after main verification pass:
  - rely on existing passes opt_hard_wire_dead_code_branches() and
    opt_remove_dead_code() to simplify kfunc instance bodies;
  - adjust inline_kfunc_calls() to copy kfunc instance bodies at the
    corresponding call sites;
  - remove kfunc instance bodies before jit.

Note, that steps taken at main verification pass make kfunc instance
bodies "hermetic", verification of these bodies does not change state
of the call site.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |   5 +
 kernel/bpf/verifier.c        | 346 +++++++++++++++++++++++++++++++----
 2 files changed, 317 insertions(+), 34 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b683dc3ede4a..2de3536e4133 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -560,6 +560,8 @@ struct bpf_insn_aux_data {
 		 * the state of the relevant registers to make decision about inlining
 		 */
 		struct bpf_loop_inline_state loop_inline_state;
+		/* for kfunc calls, instance of the inlinable kfunc instance subprog */
+		u32 kfunc_instance_subprog;
 	};
 	union {
 		/* remember the size of type passed to bpf_obj_new to rewrite R1 */
@@ -722,6 +724,8 @@ struct bpf_verifier_env {
 	u32 used_btf_cnt;		/* number of used BTF objects */
 	u32 id_gen;			/* used to generate unique reg IDs */
 	u32 hidden_subprog_cnt;		/* number of hidden subprogs */
+	u32 first_kfunc_instance;	/* first inlinable kfunc instance subprog number */
+	u32 last_kfunc_instance;	/* last inlinable kfunc instance subprog number */
 	int exception_callback_subprog;
 	bool explore_alu_limits;
 	bool allow_ptr_leaks;
@@ -785,6 +789,7 @@ struct bpf_verifier_env {
 	 * e.g., in reg_type_str() to generate reg_type string
 	 */
 	char tmp_str_buf[TMP_STR_BUF_LEN];
+	char tmp_str_buf2[TMP_STR_BUF_LEN];
 	struct bpf_insn insn_buf[INSN_BUF_SIZE];
 	struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f38f73cc740b..87b6cc8c94f8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3420,6 +3420,25 @@ static bool is_jmp_point(struct bpf_verifier_env *env, int insn_idx)
 	return env->insn_aux_data[insn_idx].jmp_point;
 }
 
+static bool is_inlinable_kfunc_call(struct bpf_verifier_env *env, int idx)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[idx];
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+
+	return bpf_pseudo_kfunc_call(insn) &&
+	       aux->kfunc_instance_subprog != 0;
+}
+
+static int inlinable_kfunc_instance_start(struct bpf_verifier_env *env, int idx)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[idx];
+	int subprog = aux->kfunc_instance_subprog;
+
+	if (!subprog)
+		return -1;
+	return env->subprog_info[subprog].start;
+}
+
 #define LR_FRAMENO_BITS	3
 #define LR_SPI_BITS	6
 #define LR_ENTRY_BITS	(LR_SPI_BITS + LR_FRAMENO_BITS + 1)
@@ -3906,13 +3925,20 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 		if (class == BPF_STX)
 			bt_set_reg(bt, sreg);
 	} else if (class == BPF_JMP || class == BPF_JMP32) {
-		if (bpf_pseudo_call(insn)) {
+		bool return_from_inlinable_kfunc_call =
+			is_inlinable_kfunc_call(env, idx) && subseq_idx == inlinable_kfunc_instance_start(env, idx);
+
+		if (bpf_pseudo_call(insn) || return_from_inlinable_kfunc_call) {
 			int subprog_insn_idx, subprog;
 
-			subprog_insn_idx = idx + insn->imm + 1;
-			subprog = find_subprog(env, subprog_insn_idx);
-			if (subprog < 0)
-				return -EFAULT;
+			if (is_inlinable_kfunc_call(env, idx)) {
+				subprog = env->insn_aux_data[idx].kfunc_instance_subprog;
+			} else {
+				subprog_insn_idx = idx + insn->imm + 1;
+				subprog = find_subprog(env, subprog_insn_idx);
+				if (subprog < 0)
+					return -EFAULT;
+			}
 
 			if (subprog_is_global(env, subprog)) {
 				/* check that jump history doesn't have any
@@ -3934,6 +3960,17 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				/* global subprog always sets R0 */
 				bt_clear_reg(bt, BPF_REG_0);
 				return 0;
+			} else if (is_inlinable_kfunc_call(env, idx)) {
+				if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
+					verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
+					WARN_ONCE(1, "verifier backtracking bug");
+					return -EFAULT;
+				}
+				/* do not backtrack to the callsite, clear any precision marks
+				 * that might be present in the fake frame (e.g. dynptr type spill).
+				 */
+				bt_reset(bt);
+				return 0;
 			} else {
 				/* static subprog call instruction, which
 				 * means that we are exiting current subprog,
@@ -12525,6 +12562,123 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 	return 0;
 }
 
+/* Establish an independent call stack for inlinable kfunc instance verification,
+ * copy "distilled" view of parameters from the callsite:
+ * - Scalars copied as-is.
+ * - Null pointers copied as-is.
+ * - For dynptrs:
+ *   - a fake frame #0 is created;
+ *   - a register spill corresponding to bpf_dynptr_kern->size field is created,
+ *     this spill range/tnum is set to represent dynptr type;
+ *   - a register spill corresponding to bpf_dynptr_kern->data field is created,
+ *     this spill's type is set to KERNEL_VALUE.
+ *   - the parameter itself is represented as pointer to stack.
+ * - Everything else is copied as KERNEL_VALUE.
+ *
+ * This allows to isolate main program verification from verification of
+ * kfunc instance bodies.
+ */
+static int push_inlinable_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta,
+			      u32 subprog)
+{
+	struct bpf_reg_state *reg, *sh_reg, *sh_regs, *regs = cur_regs(env);
+	const struct btf_param *args, *arg;
+	const struct btf *btf = meta->btf;
+	struct bpf_verifier_state *st;
+	struct bpf_func_state *frame;
+	const struct btf_type *t;
+	int fake_spi = 0;
+	u32 i, nargs;
+
+	st = push_async_cb(env, env->subprog_info[subprog].start,
+			   env->insn_idx, subprog, false);
+	if (!st)
+		return -ENOMEM;
+
+	frame = kzalloc(sizeof(*frame), GFP_KERNEL);
+	if (!frame)
+		return -ENOMEM;
+	init_func_state(env, frame,
+			BPF_MAIN_FUNC /* callsite */,
+			1 /* frameno within this callchain */,
+			subprog /* subprog number within this prog */);
+	/* Use frame #0 to represent memory objects with some known bits. */
+	st->frame[1] = frame;
+	st->curframe = 1;
+
+	args = (const struct btf_param *)(meta->func_proto + 1);
+	nargs = btf_type_vlen(meta->func_proto);
+	sh_regs = st->frame[1]->regs;
+	for (i = 0; i < nargs; i++) {
+		arg = &args[i];
+		reg = &regs[i + 1];
+		sh_reg = &sh_regs[i + 1];
+		t = btf_type_skip_modifiers(btf, arg->type, NULL);
+
+		if (is_kfunc_arg_dynptr(meta->btf, arg)) {
+			struct bpf_reg_state *fake_reg = &env->fake_reg[0];
+			enum bpf_dynptr_type type;
+			struct tnum a, b, c;
+			int spi;
+
+			if (reg->type == CONST_PTR_TO_DYNPTR) {
+				type = reg->dynptr.type;
+			} else if (reg->type == PTR_TO_STACK) {
+				spi = dynptr_get_spi(env, reg);
+				if (spi < 0) {
+					verbose(env, "BUG: can't recognize dynptr param\n");
+					return -EFAULT;
+				}
+				type = func(env, reg)->stack[spi].spilled_ptr.dynptr.type;
+			} else {
+				return -EFAULT;
+			}
+			grow_stack_state(env, st->frame[0], (fake_spi + 2) * BPF_REG_SIZE);
+
+			memset(fake_reg, 0, sizeof(*fake_reg));
+			__mark_reg_unknown_imprecise(fake_reg);
+			/* Setup bpf_dynptr_kern->size as expected by bpf_dynptr_get_type().
+			 * Exact value of the dynptr type could be recovered by verifier
+			 * when BPF code generated for bpf_dynptr_get_type() is processed.
+			 */
+			a = tnum_lshift(tnum_const(type), 28);	/* type */
+			b = tnum_rshift(tnum_unknown, 64 - 28);	/* size */
+			c = tnum_lshift(tnum_unknown, 31);		/* read-only bit */
+			fake_reg->var_off = tnum_or(tnum_or(a, b), c);
+			reg_bounds_sync(fake_reg);
+			save_register_state(env, st->frame[0], fake_spi++, fake_reg, 4);
+
+			/* bpf_dynptr_kern->data */
+			mark_reg_kernel_value(fake_reg);
+			save_register_state(env, st->frame[0], fake_spi++, fake_reg, BPF_REG_SIZE);
+
+			sh_reg->type = PTR_TO_STACK;
+			sh_reg->var_off = tnum_const(- fake_spi * BPF_REG_SIZE);
+			sh_reg->frameno = 0;
+			reg_bounds_sync(sh_reg);
+		} else if (register_is_null(reg) && btf_is_ptr(t)) {
+			__mark_reg_known_zero(sh_reg);
+			sh_reg->type = SCALAR_VALUE;
+		} else if (reg->type == SCALAR_VALUE) {
+			copy_register_state(sh_reg, reg);
+			sh_reg->subreg_def = 0;
+			sh_reg->id = 0;
+		} else {
+			mark_reg_kernel_value(sh_reg);
+		}
+	}
+	return 0;
+}
+
+static bool inside_inlinable_kfunc(struct bpf_verifier_env *env, u32 idx)
+{
+	struct bpf_subprog_info *subprog_info = env->subprog_info;
+
+	return env->first_kfunc_instance &&
+	       idx >= subprog_info[env->first_kfunc_instance].start &&
+	       idx < subprog_info[env->last_kfunc_instance + 1].start;
+}
+
 static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 			    struct bpf_insn *insn,
 			    struct bpf_kfunc_call_arg_meta *meta,
@@ -12534,6 +12688,7 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 	u32 func_id, *kfunc_flags;
 	const char *func_name;
 	struct btf *desc_btf;
+	u32 zero = 0;
 
 	if (kfunc_name)
 		*kfunc_name = NULL;
@@ -12554,7 +12709,13 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 
 	kfunc_flags = btf_kfunc_id_set_contains(desc_btf, func_id, env->prog);
 	if (!kfunc_flags) {
-		return -EACCES;
+		/* inlinable kfuncs can call any kernel functions,
+		 * not just those residing in id sets.
+		 */
+		if (inside_inlinable_kfunc(env, env->insn_idx))
+			kfunc_flags = &zero;
+		else
+			return -EACCES;
 	}
 
 	memset(meta, 0, sizeof(*meta));
@@ -12595,6 +12756,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return err;
 	desc_btf = meta.btf;
 	insn_aux = &env->insn_aux_data[insn_idx];
+	nargs = btf_type_vlen(meta.func_proto);
 
 	insn_aux->is_iter_next = is_iter_next_kfunc(&meta);
 
@@ -12614,6 +12776,22 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err < 0)
 		return err;
 
+	if (is_inlinable_kfunc_call(env, insn_idx)) {
+		err = push_inlinable_kfunc(env, &meta, insn_aux->kfunc_instance_subprog);
+		if (err < 0)
+			return err;
+		/* At the moment mark_chain_precision() does not
+                 * propagate precision from within inlinable kfunc
+                 * instance body. As push_inlinable_kfunc() passes
+                 * scalar parameters as-is any such parameter might be
+                 * used in the precise context. Conservatively mark
+                 * these parameters as precise.
+		 */
+		for (i = 0; i < nargs; ++i)
+			if (regs[i + 1].type == SCALAR_VALUE)
+				mark_chain_precision(env, i + 1);
+	}
+
 	if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
 		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
 					 set_rbtree_add_callback_state);
@@ -13010,7 +13188,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
-	nargs = btf_type_vlen(meta.func_proto);
 	args = (const struct btf_param *)(meta.func_proto + 1);
 	for (i = 0; i < nargs; i++) {
 		u32 regno = i + 1;
@@ -16258,7 +16435,11 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
 
 	if (visit_callee) {
 		mark_prune_point(env, t);
-		ret = push_insn(t, t + insns[t].imm + 1, BRANCH, env);
+		if (is_inlinable_kfunc_call(env, t))
+			/* visit inlinable kfunc instance bodies to establish prune point marks */
+			ret = push_insn(t, inlinable_kfunc_instance_start(env, t), BRANCH, env);
+		else
+			ret = push_insn(t, t + insns[t].imm + 1, BRANCH, env);
 	}
 	return ret;
 }
@@ -16595,7 +16776,9 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 				mark_force_checkpoint(env, t);
 			}
 		}
-		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
+		return visit_func_call_insn(t, insns, env,
+					    insn->src_reg == BPF_PSEUDO_CALL ||
+					    is_inlinable_kfunc_call(env, t));
 
 	case BPF_JA:
 		if (BPF_SRC(insn->code) != BPF_K)
@@ -18718,7 +18901,8 @@ static int do_check(struct bpf_verifier_env *env)
 				if (exception_exit)
 					goto process_bpf_exit;
 
-				if (state->curframe) {
+				if (state->curframe &&
+				    state->frame[state->curframe]->callsite != BPF_MAIN_FUNC) {
 					/* exit from nested function */
 					err = prepare_func_exit(env, &env->insn_idx);
 					if (err)
@@ -21041,18 +21225,21 @@ static struct inlinable_kfunc *find_inlinable_kfunc(struct btf *btf, u32 btf_id)
  * report extra stack used in 'stack_depth_extra'.
  */
 static struct bpf_prog *inline_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
-					  int insn_idx, int *cnt, s32 stack_base, u16 *stack_depth_extra)
+					  int insn_idx, int *cnt, s32 stack_base, u16 *stack_depth_extra,
+					  u32 subprog)
 {
 	struct inlinable_kfunc_regs_usage regs_usage;
+	struct bpf_insn *insn_buf, *subprog_insns;
+	struct bpf_subprog_info *subprog_info;
 	struct bpf_kfunc_call_arg_meta meta;
 	struct bpf_prog *new_prog;
-	struct bpf_insn *insn_buf;
 	struct inlinable_kfunc *sh;
-	int i, j, r, off, err, exit;
+	int i, j, r, off, exit;
 	u32 subprog_insn_cnt;
 	u16 extra_slots;
 	s16 stack_off;
 	u32 insn_num;
+	int err;
 
 	err = fetch_kfunc_meta(env, insn, &meta, NULL);
 	if (err < 0)
@@ -21061,8 +21248,10 @@ static struct bpf_prog *inline_kfunc_call(struct bpf_verifier_env *env, struct b
 	if (!sh)
 		return NULL;
 
-	subprog_insn_cnt = sh->insn_num;
-	scan_regs_usage(sh->insns, subprog_insn_cnt, &regs_usage);
+	subprog_info = &env->subprog_info[subprog];
+	subprog_insn_cnt = (subprog_info + 1)->start - subprog_info->start;
+	subprog_insns = env->prog->insnsi + subprog_info->start;
+	scan_regs_usage(subprog_insns, subprog_insn_cnt, &regs_usage);
 	if (regs_usage.r10_escapes) {
 		if (env->log.level & BPF_LOG_LEVEL2)
 			verbose(env, "can't inline kfunc %s at insn %d, r10 escapes\n",
@@ -21082,7 +21271,7 @@ static struct bpf_prog *inline_kfunc_call(struct bpf_verifier_env *env, struct b
 
 	if (env->log.level & BPF_LOG_LEVEL2)
 		verbose(env, "inlining kfunc %s at insn %d\n", sh->name, insn_idx);
-	memcpy(insn_buf + extra_slots, sh->insns, subprog_insn_cnt * sizeof(*insn_buf));
+	memcpy(insn_buf + extra_slots, subprog_insns, subprog_insn_cnt * sizeof(*insn_buf));
 	off = stack_base;
 	i = 0;
 	j = insn_num - 1;
@@ -21135,13 +21324,6 @@ static struct bpf_prog *inline_kfunc_call(struct bpf_verifier_env *env, struct b
 		default:
 			break;
 		}
-
-		/* Make sure kernel function calls from within kfunc body could be jitted. */
-		if (bpf_pseudo_kfunc_call(insn)) {
-			err = add_kfunc_call(env, insn->imm, insn->off);
-			if (err < 0)
-				return ERR_PTR(err);
-		}
 	}
 
 	*cnt = insn_num;
@@ -21149,24 +21331,33 @@ static struct bpf_prog *inline_kfunc_call(struct bpf_verifier_env *env, struct b
 	return new_prog;
 }
 
-/* Do this after all stack depth adjustments */
+/* Copy bodies of inlinable kfunc instances to the callsites
+ * and remove instance subprograms.
+ * Do this after all stack depth adjustments.
+ */
 static int inline_kfunc_calls(struct bpf_verifier_env *env)
 {
 	struct bpf_prog *prog = env->prog;
 	struct bpf_insn *insn = prog->insnsi;
 	const int insn_cnt = prog->len;
 	struct bpf_prog *new_prog;
-	int i, cnt, delta = 0, cur_subprog = 0;
+	int err, i, cnt, delta = 0, cur_subprog = 0;
 	struct bpf_subprog_info *subprogs = env->subprog_info;
 	u16 stack_depth = subprogs[cur_subprog].stack_depth;
 	u16 call_extra_stack = 0, subprog_extra_stack = 0;
+	struct bpf_insn_aux_data *aux;
 
 	for (i = 0; i < insn_cnt;) {
 		if (!bpf_pseudo_kfunc_call(insn))
 			goto next_insn;
 
+		aux = &env->insn_aux_data[i + delta];
+		if (!aux->kfunc_instance_subprog)
+			goto next_insn;
+
 		new_prog = inline_kfunc_call(env, insn, i + delta, &cnt,
-					     -stack_depth, &call_extra_stack);
+					     -stack_depth, &call_extra_stack,
+					     aux->kfunc_instance_subprog);
 		if (IS_ERR(new_prog))
 			return PTR_ERR(new_prog);
 		if (!new_prog)
@@ -21189,7 +21380,14 @@ static int inline_kfunc_calls(struct bpf_verifier_env *env)
 	}
 
 	env->prog->aux->stack_depth = subprogs[0].stack_depth;
-
+	if (env->first_kfunc_instance) {
+		/* Do not jit instance subprograms. */
+		cnt = subprogs[env->last_kfunc_instance + 1].start -
+		      subprogs[env->first_kfunc_instance].start;
+		err = verifier_remove_insns(env, subprogs[env->first_kfunc_instance].start, cnt);
+		if (err < 0)
+			return err;
+	}
 	return 0;
 }
 
@@ -21268,6 +21466,82 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
 	return 0;
 }
 
+/* For each callsite of the inlinable kfunc add a hidden subprogram
+ * with a copy of kfunc body (instance). Record the number of the
+ * added subprogram in bpf_insn_aux_data->kfunc_instance_subprog
+ * field for the callsite.
+ *
+ * During main verification pass verifier would discover if some of
+ * the branches / code inside each body could be removed because of
+ * known parameter values.
+ *
+ * At the end of program processing inline_kfunc_calls()
+ * would copy bodies to callsites and delete the subprograms.
+ */
+static int instantiate_inlinable_kfuncs(struct bpf_verifier_env *env)
+{
+	struct bpf_prog_aux *aux = env->prog->aux;
+	const int insn_cnt = env->prog->len;
+	struct bpf_kfunc_call_arg_meta meta;
+	struct bpf_insn *insn, *insn_buf;
+	struct inlinable_kfunc *sh = NULL;
+	int i, j, err;
+	u32 subprog;
+	void *tmp;
+
+	for (i = 0; i < insn_cnt; ++i) {
+		insn = env->prog->insnsi + i;
+		if (!bpf_pseudo_kfunc_call(insn))
+			continue;
+		err = fetch_kfunc_meta(env, insn, &meta, NULL);
+		if (err < 0)
+			/* missing kfunc, error would be reported later */
+			continue;
+		sh = find_inlinable_kfunc(meta.btf, meta.func_id);
+		if (!sh)
+			continue;
+		for (j = 0; j < sh->insn_num; ++j) {
+			if (!bpf_pseudo_kfunc_call(&sh->insns[j]))
+				continue;
+			err = add_kfunc_call(env, sh->insns[j].imm, sh->insns[j].off);
+			if (err < 0)
+				return err;
+		}
+		subprog = env->subprog_cnt;
+		insn_buf = kmalloc_array(sh->insn_num + 1, sizeof(*insn_buf), GFP_KERNEL);
+		if (!insn_buf)
+			return -ENOMEM;
+		/* this is an unfortunate requirement of add_hidden_subprog() */
+		insn_buf[0] = env->prog->insnsi[env->prog->len - 1];
+		memcpy(insn_buf + 1, sh->insns,  sh->insn_num * sizeof(*insn_buf));
+		err = add_hidden_subprog(env, insn_buf, sh->insn_num + 1);
+		kfree(insn_buf);
+		if (err)
+			return err;
+		tmp = krealloc_array(aux->func_info, aux->func_info_cnt + 1,
+				     sizeof(*aux->func_info), GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+		aux->func_info = tmp;
+		memset(&aux->func_info[aux->func_info_cnt], 0, sizeof(*aux->func_info));
+		aux->func_info[aux->func_info_cnt].insn_off = env->subprog_info[subprog].start;
+		tmp = krealloc_array(aux->func_info_aux, aux->func_info_cnt + 1,
+				     sizeof(*aux->func_info_aux), GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+		aux->func_info_aux = tmp;
+		memset(&aux->func_info_aux[aux->func_info_cnt], 0, sizeof(*aux->func_info_aux));
+		aux->func_info_aux[aux->func_info_cnt].linkage = BTF_FUNC_STATIC;
+		aux->func_info_cnt++;
+
+		if (!env->first_kfunc_instance)
+			env->first_kfunc_instance = subprog;
+		env->last_kfunc_instance = subprog;
+		env->insn_aux_data[i].kfunc_instance_subprog = subprog;
+	}
+	return 0;
+}
+
 /* Do various post-verification rewrites in a single program pass.
  * These rewrites simplify JIT and interpreter implementations.
  */
@@ -23204,13 +23478,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		env->test_state_freq = attr->prog_flags & BPF_F_TEST_STATE_FREQ;
 	env->test_reg_invariants = attr->prog_flags & BPF_F_TEST_REG_INVARIANTS;
 
-	env->explored_states = kvcalloc(state_htab_size(env),
-				       sizeof(struct bpf_verifier_state_list *),
-				       GFP_USER);
-	ret = -ENOMEM;
-	if (!env->explored_states)
-		goto skip_full_check;
-
 	ret = check_btf_info_early(env, attr, uattr);
 	if (ret < 0)
 		goto skip_full_check;
@@ -23241,10 +23508,21 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 			goto skip_full_check;
 	}
 
+	ret = instantiate_inlinable_kfuncs(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = check_cfg(env);
 	if (ret < 0)
 		goto skip_full_check;
 
+	env->explored_states = kvcalloc(state_htab_size(env),
+				       sizeof(struct bpf_verifier_state_list *),
+				       GFP_USER);
+	ret = -ENOMEM;
+	if (!env->explored_states)
+		goto skip_full_check;
+
 	ret = mark_fastcall_patterns(env);
 	if (ret < 0)
 		goto skip_full_check;
-- 
2.47.0


