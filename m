Return-Path: <bpf+bounces-71316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2038CBEEBFA
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 22:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D77A1897DDD
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 20:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D495224B12;
	Sun, 19 Oct 2025 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIdh59Zx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CCD354AEE
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 20:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760904928; cv=none; b=TOwcpo0imYXxPJZzWiZjxZvh9A7OEFrU21TN4cCMK1lq9Zd+aQ/3L7JR3nPCurOAZz+p/S0jKWWZ518Wtpm6cm6L1IPEne/zq6EJeqWyDf+YSxql4E0AqG+8rPhN844yxIOi0dmlKZmnGG2ULCAoQZGC2SctquGYCGeAfBcgEHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760904928; c=relaxed/simple;
	bh=IRMkeDrexMrgzEkK8nN9vm9/e6r8mod34iNeDM5BpVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UDGAuexRbVgrP6323QoJ9pg8uHSEm9ebWjf+6X2mhf9UzMPoXPz1gdtJ1KuvOq1rHyUvfp5KCIfRfVS6sVnvBpLxQV5akwTuqIl1IM4TXvaZzSRbu2TUVIsQoNh7VAPvc0nCUogETIddRoBdhXh9i3JrXxYbUsMQMVWGMRkgFQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIdh59Zx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4712c6d9495so10441005e9.2
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 13:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760904925; x=1761509725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESqk1T3kt16SKINTRG0TIEmxy10LsCF2zPZ7TpAVLZU=;
        b=AIdh59ZxvT5W2v8zlZxKfkWOO25NPtDfYM+LKrBHoQShaX3HHQgVPJIaDPdqjqOFt3
         IdKn4rmSRqDi8vy9cMSt6x+Uyqr/YMOtmLUT6nT4ZBG4jjjGwlmoDDbjJ5wkE97AlzQX
         JDVnY8BWmP6dEHWsMsLux0tG4K0UYbWOywHqP/+yjU3HrxDnsQt9CtHTMsl0jkgZxuS+
         +0NLiFgstZlF2N1Qe5BhtTdafL+QV35gd0OM6RuQfSL/np6SX4vHyX1jszwq/fMSTvzl
         6NBIAbZ/2BcoJk9nescq/3BY5AqAQCrQxfSF9ENrfTDIShVs8tOLnhjTEZWtcuhh+/xF
         EssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760904925; x=1761509725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESqk1T3kt16SKINTRG0TIEmxy10LsCF2zPZ7TpAVLZU=;
        b=PbcbffEti3HETMBf9DdAcOLLExsHMXFEX6BLJYHSUqe2LiVKmeWcy/y0xgjWGw2kGX
         1J5T9gK/EZWXvXhkIYv8TFFUn/FOAkghs4XTwlbm6JgDbFne2HientmVtTQ+/B4c/6Yd
         GT8hvzubgTK3HbDZBNcK+ZYc/2XbYVjIWhQizZWISBhjpIJ6UNHqp4WSiIaZU+zWWh5I
         PYWALu1QT4Powp0dLTfN3p9igN3uecesqGAkUEvLUMpeJ+O46uPn/oS3UJpDeMVG2A3Y
         NAOd58hEqN6mS9aXtXwfUU5reC/Ydq/SqCeIPxhh/dYPFcHvLJo6avzSWNqxFKpqHCse
         rP6Q==
X-Gm-Message-State: AOJu0Yym7xCY/tQVqcObMRmIoejHzwkUGk3+bRkgt2/QuWUiWMqY0r52
	FwRATRh1J60nA5GvG3c/eKrkc/g7Pxx3poK7FNtIhRE1yAiy15FvynxcPcE/QQ==
X-Gm-Gg: ASbGncsyx9vnxJibRLawhxj9SptUHuGkJ2dfX948t0i62mwmQHDUpUhT5kAGc0oP01v
	JXJrKlAHrqa+baVaJPHIH+FK+pKlZvZU4DtfPEkAOMJsKSjJzwCVTYc8OVgZ1N8CyawX7w35YCT
	WDbzrr0djk4G1bQ+JoPWYC0scjxA0vr9KPGlg4YYD4X3UibUbPPdsRohkhKJ++NvYu9UO2SLRfg
	qUYLVyYE3gjJ+DYLUcno/NoeqsW2ggy63nyE6RX5cXJ/v20DVeE9r0dKkjoEQJtmthr3ItQJnqr
	2C3fXPBKQ14levr3TNM9jjJ6ci9PrCyy533e44VBqlJpG7E/wt6RiF9c4nyLNNTskLDHWU6VAYf
	UxhrV4wMHpXUfBFTxzw0Zll8/BsTPuEWWnZ7gzmrSEnAJR5q7TqIyGzM0Em/zfEjbANlTK9wNQq
	J7+rATHbtM5pg+H4UsmltJ4w7dkLT3+Q==
X-Google-Smtp-Source: AGHT+IFmMR9NKqqqh/OjHZpoOU2wZ6xyhvAzFXg0ICbjnehaT9IkJ9ML5Fyj2kJu+OYH9PUhZi8Jpg==
X-Received: by 2002:a05:600c:3104:b0:46e:1fb9:5497 with SMTP id 5b1f17b1804b1-471178a5c6emr74249295e9.18.1760904924687;
        Sun, 19 Oct 2025 13:15:24 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c831asm190460105e9.13.2025.10.19.13.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 13:15:24 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 01/17] bpf: fix the return value of push_stack
Date: Sun, 19 Oct 2025 20:21:29 +0000
Message-Id: <20251019202145.3944697-2-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In [1] Eduard mentioned that on push_stack failure verifier code
should return -ENOMEM instead of -EFAULT. After checking with the
other call sites I've found that code randomly returns either -ENOMEM
or -EFAULT. This patch unifies the return values for the push_stack
(and similar push_async_cb) functions such that error codes are
always assigned properly.

  [1] https://lore.kernel.org/bpf/20250615085943.3871208-1-a.s.protopopov@gmail.com

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 80 +++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9b4f6920f79b..80c99ef4cac5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2109,7 +2109,7 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 
 	elem = kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL_ACCOUNT);
 	if (!elem)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	elem->insn_idx = insn_idx;
 	elem->prev_insn_idx = prev_insn_idx;
@@ -2119,12 +2119,12 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	env->stack_size++;
 	err = copy_verifier_state(&elem->st, cur);
 	if (err)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	elem->st.speculative |= speculative;
 	if (env->stack_size > BPF_COMPLEXITY_LIMIT_JMP_SEQ) {
 		verbose(env, "The sequence of %d jumps is too complex.\n",
 			env->stack_size);
-		return NULL;
+		return ERR_PTR(-E2BIG);
 	}
 	if (elem->st.parent) {
 		++elem->st.parent->branches;
@@ -2919,7 +2919,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 
 	elem = kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL_ACCOUNT);
 	if (!elem)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	elem->insn_idx = insn_idx;
 	elem->prev_insn_idx = prev_insn_idx;
@@ -2931,7 +2931,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 		verbose(env,
 			"The sequence of %d jumps is too complex for async cb.\n",
 			env->stack_size);
-		return NULL;
+		return ERR_PTR(-E2BIG);
 	}
 	/* Unlike push_stack() do not copy_verifier_state().
 	 * The caller state doesn't matter.
@@ -2942,7 +2942,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	elem->st.in_sleepable = is_sleepable;
 	frame = kzalloc(sizeof(*frame), GFP_KERNEL_ACCOUNT);
 	if (!frame)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	init_func_state(env, frame,
 			BPF_MAIN_FUNC /* callsite */,
 			0 /* frameno within this callchain */,
@@ -9045,8 +9045,8 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 		prev_st = find_prev_entry(env, cur_st->parent, insn_idx);
 		/* branch out active iter state */
 		queued_st = push_stack(env, insn_idx + 1, insn_idx, false);
-		if (!queued_st)
-			return -ENOMEM;
+		if (IS_ERR(queued_st))
+			return PTR_ERR(queued_st);
 
 		queued_iter = get_iter_from_state(queued_st, meta);
 		queued_iter->iter.state = BPF_ITER_STATE_ACTIVE;
@@ -10616,8 +10616,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
 					 insn_idx, subprog,
 					 is_async_cb_sleepable(env, insn));
-		if (!async_cb)
-			return -EFAULT;
+		if (IS_ERR(async_cb))
+			return PTR_ERR(async_cb);
 		callee = async_cb->frame[0];
 		callee->async_entry_cnt = caller->async_entry_cnt + 1;
 
@@ -10633,8 +10633,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	 * proceed with next instruction within current frame.
 	 */
 	callback_state = push_stack(env, env->subprog_info[subprog].start, insn_idx, false);
-	if (!callback_state)
-		return -ENOMEM;
+	if (IS_ERR(callback_state))
+		return PTR_ERR(callback_state);
 
 	err = setup_func_entry(env, subprog, insn_idx, set_callee_state_cb,
 			       callback_state);
@@ -13859,9 +13859,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		struct bpf_reg_state *regs;
 
 		branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
-		if (!branch) {
+		if (IS_ERR(branch)) {
 			verbose(env, "failed to push state for failed lock acquisition\n");
-			return -ENOMEM;
+			return PTR_ERR(branch);
 		}
 
 		regs = branch->frame[branch->curframe]->regs;
@@ -14316,16 +14316,15 @@ struct bpf_sanitize_info {
 	bool mask_to_left;
 };
 
-static struct bpf_verifier_state *
-sanitize_speculative_path(struct bpf_verifier_env *env,
-			  const struct bpf_insn *insn,
-			  u32 next_idx, u32 curr_idx)
+static int sanitize_speculative_path(struct bpf_verifier_env *env,
+				     const struct bpf_insn *insn,
+				     u32 next_idx, u32 curr_idx)
 {
 	struct bpf_verifier_state *branch;
 	struct bpf_reg_state *regs;
 
 	branch = push_stack(env, next_idx, curr_idx, true);
-	if (branch && insn) {
+	if (!IS_ERR(branch) && insn) {
 		regs = branch->frame[branch->curframe]->regs;
 		if (BPF_SRC(insn->code) == BPF_K) {
 			mark_reg_unknown(env, regs, insn->dst_reg);
@@ -14334,7 +14333,7 @@ sanitize_speculative_path(struct bpf_verifier_env *env,
 			mark_reg_unknown(env, regs, insn->src_reg);
 		}
 	}
-	return branch;
+	return PTR_ERR_OR_ZERO(branch);
 }
 
 static int sanitize_ptr_alu(struct bpf_verifier_env *env,
@@ -14353,7 +14352,6 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 	u8 opcode = BPF_OP(insn->code);
 	u32 alu_state, alu_limit;
 	struct bpf_reg_state tmp;
-	bool ret;
 	int err;
 
 	if (can_skip_alu_sanitation(env, insn))
@@ -14426,11 +14424,12 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 		tmp = *dst_reg;
 		copy_register_state(dst_reg, ptr_reg);
 	}
-	ret = sanitize_speculative_path(env, NULL, env->insn_idx + 1,
-					env->insn_idx);
-	if (!ptr_is_dst_reg && ret)
+	err = sanitize_speculative_path(env, NULL, env->insn_idx + 1, env->insn_idx);
+	if (err < 0)
+		return REASON_STACK;
+	if (!ptr_is_dst_reg)
 		*dst_reg = tmp;
-	return !ret ? REASON_STACK : 0;
+	return 0;
 }
 
 static void sanitize_mark_insn_seen(struct bpf_verifier_env *env)
@@ -16750,8 +16749,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 
 		/* branch out 'fallthrough' insn as a new state to explore */
 		queued_st = push_stack(env, idx + 1, idx, false);
-		if (!queued_st)
-			return -ENOMEM;
+		if (IS_ERR(queued_st))
+			return PTR_ERR(queued_st);
 
 		queued_st->may_goto_depth++;
 		if (prev_st)
@@ -16829,10 +16828,11 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		 * the fall-through branch for simulation under speculative
 		 * execution.
 		 */
-		if (!env->bypass_spec_v1 &&
-		    !sanitize_speculative_path(env, insn, *insn_idx + 1,
-					       *insn_idx))
-			return -EFAULT;
+		if (!env->bypass_spec_v1) {
+			err = sanitize_speculative_path(env, insn, *insn_idx + 1, *insn_idx);
+			if (err < 0)
+				return err;
+		}
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch, this_branch->curframe);
 		*insn_idx += insn->off;
@@ -16842,11 +16842,12 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		 * program will go. If needed, push the goto branch for
 		 * simulation under speculative execution.
 		 */
-		if (!env->bypass_spec_v1 &&
-		    !sanitize_speculative_path(env, insn,
-					       *insn_idx + insn->off + 1,
-					       *insn_idx))
-			return -EFAULT;
+		if (!env->bypass_spec_v1) {
+			err = sanitize_speculative_path(env, insn, *insn_idx + insn->off + 1,
+							*insn_idx);
+			if (err < 0)
+				return err;
+		}
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch, this_branch->curframe);
 		return 0;
@@ -16867,10 +16868,9 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			return err;
 	}
 
-	other_branch = push_stack(env, *insn_idx + insn->off + 1, *insn_idx,
-				  false);
-	if (!other_branch)
-		return -EFAULT;
+	other_branch = push_stack(env, *insn_idx + insn->off + 1, *insn_idx, false);
+	if (IS_ERR(other_branch))
+		return PTR_ERR(other_branch);
 	other_branch_regs = other_branch->frame[other_branch->curframe]->regs;
 
 	if (BPF_SRC(insn->code) == BPF_X) {
-- 
2.34.1


