Return-Path: <bpf+bounces-65818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FBBB28FF9
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 20:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA41C7B467A
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 18:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFA21F4171;
	Sat, 16 Aug 2025 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFL/BOpo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2F670838
	for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 18:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755367323; cv=none; b=MVVSkUWcgZVOlqjVy+RSCyGCYGOquhtBsLywst05kD1uBeeENCgBr0wosivLGoShESBTgAuTI1fnhlKCVX6ooPJrS7yd5SC/1Ckp5/LA003+O2L2utmr4zSAlVbVDkt2oFw67j1n7Rh+/26KSR5bgnqjCrVCRWU+zmc9Rry0K5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755367323; c=relaxed/simple;
	bh=xgLAYq6ISYpzZVYeP7294+l7yPXREduNdNtFG4a3ikk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KLuf6ycz8PtC4aMEMt2QsEHTRR/tH9UnL+znyH+mMtC6p5ky/IROkXAmZmEJLiaIT19R+dM03xanPbGy4lgGDgIgc3rFEM8NaX3drhEKICLYCKPjcHrQ2cd5T5QDsupv3NzdtR9BZ3O+9zfhtCzTOzJM/wtsHYkKM95rLHHIUJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFL/BOpo; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a286135c8so1606145e9.0
        for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 11:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755367319; x=1755972119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfyllxowMOBd7uWx8ufeE+hR/6iyBgQ9jmGbj7/6jJY=;
        b=YFL/BOpoizrZYoJsfkyWnRVDR7JDr8iypEMSzNSQhzHX1j5wcpWSWQFaQWzqeWUrcn
         JSbWRGYxr8fjpHN9wbrtzAAhouigjJiFM7suXeuVcfrmzH9LpwvM8DBpf//DD2NDhtCl
         fUjnYMDKNLI0s3oPF1zYhr9ufjHbJvsaczQcxwu5/s3DV0GicKaafc+KNN9rLxadBo5C
         HcZRvR3xeE04SXJVfdarp6QB9Pf2BtaYBYL8cbGM/pzap5PSEPLOBJbKBJHjnK6GylRj
         I5xr0gMXCn1Gq1Ov6/oy8ui6/oPLvbv9yhApsGqaPcxJHQYSi0R7P8sdaoi/YQOhHQt3
         rOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755367319; x=1755972119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfyllxowMOBd7uWx8ufeE+hR/6iyBgQ9jmGbj7/6jJY=;
        b=iPbrP2nZSs9Tbld8B3FLUsO1VD0m2ZTSSrX74JdiDNyAP0nsSsE/XK0e7FL5TkSjtC
         cD/COkkgkc/9NDUXwLDiunhXmxC5yvjuRMfqpkOaEiyK4mHb2oMrB6lMLhQeEEDtOQpu
         N6Z8c5jE8o5DpHh2YtEEJ3SZcyoxomIvTMf9u7lb2uOdB0GnlbFVbYs4YWM6pIKc09Z6
         d0SG9b6gfoOrTlRLdeSJfYhLABOQdNDXMMXTRmp0g2h7DVLLGnvbqwR8xfH0OMImw6+n
         pD8RYAVmTxFke5driZnz8ekNcM1uaMGw7kIxvIJAvE8UUcGq21JGSR0zWMT+SMBvhpLE
         DkEQ==
X-Gm-Message-State: AOJu0YyR2HI/fVVonO8WXPF1BrM3LYnP0UvvEgDBE/EhPgWfGUsUnH7j
	/zTuZoQuOgFkxPoq6HTVK67Pm0aNwjT0da3nApCmHHnMXRFWVi4/UFZVmTajgw==
X-Gm-Gg: ASbGncvCFzR28WMsoplmZGMYLp0hGJ5Rtc86lrhIjz3GCYdwxrM62oKDVNleqlpSw5K
	6O7McreCxqvbGe1ZeeAAZX5fVcl8JU2CUbGm+yeyu+szwpKqV1THIZLUJDG5ejnXsaJftiJ7yh0
	X6I0MHgU0tlS5d66EN4w0qNThjI8K1O2SxRNBzqfxE+nGdMtH8/G8olwcAkwisoHC1gDlOzN3eW
	scc9/sogo64FMyjQMLYGtEJtp2bq8XOcLQbw/dblVUz9R51QneDgaVyV3wyDFNLzX1MmaVPHlwJ
	oSIPolUziVDX0qa66ski63RgLKj0ZdlcmwA4t8A6EmB30lasY3fRSPFFC7N8xLYr5NSOfvcFOV/
	pmMuuhgzf1jKaVIiN2OtO4ArpBaj0mBx5yBMnn+rRaj0=
X-Google-Smtp-Source: AGHT+IH8lr1RUs4lQTnSCWXR32bXVdKHtRyOX2tLIMIpgbiQpG8xX0ygnUnPLzbLS/Tbz8ZfzrZkAg==
X-Received: by 2002:a05:600c:6095:b0:458:6f13:aa4a with SMTP id 5b1f17b1804b1-45a1b66e4b5mr92028335e9.6.1755367318412;
        Sat, 16 Aug 2025 11:01:58 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bd736b88besm1080193f8f.67.2025.08.16.11.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 11:01:57 -0700 (PDT)
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
Subject: [PATCH v1 bpf-next 01/11] bpf: fix the return value of push_stack
Date: Sat, 16 Aug 2025 18:06:21 +0000
Message-Id: <20250816180631.952085-2-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250816180631.952085-1-a.s.protopopov@gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
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
---
 kernel/bpf/verifier.c | 59 ++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3a3982fe20d4..d8a65726cff2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2101,7 +2101,7 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 
 	elem = kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL_ACCOUNT);
 	if (!elem)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	elem->insn_idx = insn_idx;
 	elem->prev_insn_idx = prev_insn_idx;
@@ -2111,12 +2111,12 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
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
+		return ERR_PTR(-EFAULT);
 	}
 	if (elem->st.parent) {
 		++elem->st.parent->branches;
@@ -2912,7 +2912,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 
 	elem = kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL_ACCOUNT);
 	if (!elem)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	elem->insn_idx = insn_idx;
 	elem->prev_insn_idx = prev_insn_idx;
@@ -2924,7 +2924,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 		verbose(env,
 			"The sequence of %d jumps is too complex for async cb.\n",
 			env->stack_size);
-		return NULL;
+		return ERR_PTR(-EFAULT);
 	}
 	/* Unlike push_stack() do not copy_verifier_state().
 	 * The caller state doesn't matter.
@@ -2935,7 +2935,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	elem->st.in_sleepable = is_sleepable;
 	frame = kzalloc(sizeof(*frame), GFP_KERNEL_ACCOUNT);
 	if (!frame)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	init_func_state(env, frame,
 			BPF_MAIN_FUNC /* callsite */,
 			0 /* frameno within this callchain */,
@@ -9046,8 +9046,8 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 		prev_st = find_prev_entry(env, cur_st->parent, insn_idx);
 		/* branch out active iter state */
 		queued_st = push_stack(env, insn_idx + 1, insn_idx, false);
-		if (!queued_st)
-			return -ENOMEM;
+		if (IS_ERR(queued_st))
+			return PTR_ERR(queued_st);
 
 		queued_iter = get_iter_from_state(queued_st, meta);
 		queued_iter->iter.state = BPF_ITER_STATE_ACTIVE;
@@ -10617,8 +10617,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
 					 insn_idx, subprog,
 					 is_bpf_wq_set_callback_impl_kfunc(insn->imm));
-		if (!async_cb)
-			return -EFAULT;
+		if (IS_ERR(async_cb))
+			return PTR_ERR(async_cb);
 		callee = async_cb->frame[0];
 		callee->async_entry_cnt = caller->async_entry_cnt + 1;
 
@@ -10634,8 +10634,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	 * proceed with next instruction within current frame.
 	 */
 	callback_state = push_stack(env, env->subprog_info[subprog].start, insn_idx, false);
-	if (!callback_state)
-		return -ENOMEM;
+	if (IS_ERR(callback_state))
+		return PTR_ERR(callback_state);
 
 	err = setup_func_entry(env, subprog, insn_idx, set_callee_state_cb,
 			       callback_state);
@@ -13778,9 +13778,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		struct bpf_reg_state *regs;
 
 		branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
-		if (!branch) {
+		if (IS_ERR(branch)) {
 			verbose(env, "failed to push state for failed lock acquisition\n");
-			return -ENOMEM;
+			return PTR_ERR(branch);
 		}
 
 		regs = branch->frame[branch->curframe]->regs;
@@ -14217,7 +14217,7 @@ sanitize_speculative_path(struct bpf_verifier_env *env,
 	struct bpf_reg_state *regs;
 
 	branch = push_stack(env, next_idx, curr_idx, true);
-	if (branch && insn) {
+	if (!IS_ERR(branch) && insn) {
 		regs = branch->frame[branch->curframe]->regs;
 		if (BPF_SRC(insn->code) == BPF_K) {
 			mark_reg_unknown(env, regs, insn->dst_reg);
@@ -14245,7 +14245,6 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 	u8 opcode = BPF_OP(insn->code);
 	u32 alu_state, alu_limit;
 	struct bpf_reg_state tmp;
-	bool ret;
 	int err;
 
 	if (can_skip_alu_sanitation(env, insn))
@@ -14318,11 +14317,11 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 		tmp = *dst_reg;
 		copy_register_state(dst_reg, ptr_reg);
 	}
-	ret = sanitize_speculative_path(env, NULL, env->insn_idx + 1,
-					env->insn_idx);
-	if (!ptr_is_dst_reg && ret)
+	if (IS_ERR(sanitize_speculative_path(env, NULL, env->insn_idx + 1, env->insn_idx)))
+		return REASON_STACK;
+	if (!ptr_is_dst_reg)
 		*dst_reg = tmp;
-	return !ret ? REASON_STACK : 0;
+	return 0;
 }
 
 static void sanitize_mark_insn_seen(struct bpf_verifier_env *env)
@@ -16641,8 +16640,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 
 		/* branch out 'fallthrough' insn as a new state to explore */
 		queued_st = push_stack(env, idx + 1, idx, false);
-		if (!queued_st)
-			return -ENOMEM;
+		if (IS_ERR(queued_st))
+			return PTR_ERR(queued_st);
 
 		queued_st->may_goto_depth++;
 		if (prev_st)
@@ -16721,8 +16720,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		 * execution.
 		 */
 		if (!env->bypass_spec_v1 &&
-		    !sanitize_speculative_path(env, insn, *insn_idx + 1,
-					       *insn_idx))
+		    IS_ERR(sanitize_speculative_path(env, insn, *insn_idx + 1, *insn_idx)))
 			return -EFAULT;
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch, this_branch->curframe);
@@ -16734,9 +16732,9 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		 * simulation under speculative execution.
 		 */
 		if (!env->bypass_spec_v1 &&
-		    !sanitize_speculative_path(env, insn,
-					       *insn_idx + insn->off + 1,
-					       *insn_idx))
+		    IS_ERR(sanitize_speculative_path(env, insn,
+						     *insn_idx + insn->off + 1,
+						     *insn_idx)))
 			return -EFAULT;
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch, this_branch->curframe);
@@ -16758,10 +16756,9 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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


