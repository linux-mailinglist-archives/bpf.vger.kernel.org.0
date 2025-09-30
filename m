Return-Path: <bpf+bounces-70011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9FFBAC8D4
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959391922FFC
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 10:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E4F2FABE3;
	Tue, 30 Sep 2025 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WW07DEBm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA6E22CBE6
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229390; cv=none; b=Z2BQ+uhjqqQbtZZqZchcFrbVEinPF7DH5sbZWTuuY94hqVltkNOpEnV7s8zHnvY7fdo6vRP0nvg3p5yx7vYMzxhERej84HsIo6ZkZuxYDqiBrrIDweoO/67cJN6VZygfjX9jdDGnPLGxReEVWHary6N0vXXVGWUsbXlcVyu5V7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229390; c=relaxed/simple;
	bh=9lzryIoxIfu5/aeQ/0L3x8wB87LYi6IIE/Cf5yJ3su8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZtkxuOWqtfB4khrmK7OFoc0g98SboBN20onI4kFP3T2Q7ylBfZlmwvb6uN7uch9SuLAjN678vJY2lFQlT/r7HlqmvtLRVpIPPSjpBmRfbn+esTdNPEfV2xehjf3i4/Tsc/1skMBliPIMgYPX5Pq2LdpZNpl29Nw9JeKYYesHBnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WW07DEBm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e4473d7f6so26063975e9.1
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 03:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759229385; x=1759834185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCQy1tuDeG1Ms6dk4B/xAnraCqj2iNWnwM+yI7cgWFQ=;
        b=WW07DEBmdECMJQelQQxZPBPdK4EkjxIuTnWVS0+DY+DGJelYaubbqNWMFcx+RQHGPt
         QqaIvtplP6Vpmv37taDf8s632/fxDUyKffikFQLqGKavzCAN04GNS0BLSaPKLf8fQWHM
         6na8ynYtGzN/EWXk1rl3NSdwKnZpiRgoYVZEca0UhczaDDJwIOVdN7iyAQECfkPAJVnC
         vrLUQq4FZfrjSwgmSKgp5meYobK5f/6LG0UHaMKw9h//xtdYFcTpRc2BU+uGGd3PQR4t
         cRWubO0cdSElQkuekrq1AnREfU95Vuun9Z/pAteGOPxsdVrREGaRtcOhNf8hVWLhUt5w
         MQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759229385; x=1759834185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCQy1tuDeG1Ms6dk4B/xAnraCqj2iNWnwM+yI7cgWFQ=;
        b=hvb2fwRHLrSnVtNkghGoTiXmGxbEpLxGoZhYheVYcH1t4S823JqhL+1WeDuKHlOjNd
         Qgq+gDg4eLoctRS27nekLAF9fHA7h28z+IB6kqEhYYY8aVgkam/u++BR1QjfzgmmTyWb
         CIdMU92bu8yzVZIolXeQ4WPQduyCvw21YycnfD1OOTs+e2/9LrFGjdY4HuYv6tT0vwcL
         NemE6Pj+U103aI82qfLDO3YCidz4f5eSaQYe+sO+yQi75lKBI3ygD+QY9GbyPucYLYw7
         ASFWqjFQj/5nmWuz9IX4n5WeW4GpL1A6Q6Ps/HFyU3ARIqk49KTxH0G4VnxDHOeOBGV2
         AYhg==
X-Gm-Message-State: AOJu0Yweyskjz+C7yIH0bzGonia1Mx/rEktOhnzWD033CDxmopPtJOEu
	QabilVZ8eCvY1me+JLvJAgyN3/D3ScjehSrNkCEmIpDEqU1R48Nx0TMedFmsAg==
X-Gm-Gg: ASbGncvqT7QVNF6geVlgBNXJ+XpT1rSLeZVyWBguO1z4gBQR19VrxOxZQodFCd65Mw9
	0crLWjfOGyZ77Je+yCc9TlQG/afoaPRPk/1/npbE4UbOkb8D9vV0rysrZi+wpzWOBqc8nB0v2EN
	8cv8UqnNp6gH+BkeSjfq82WyFq0YtKHKcXJ4dpLhUAoSvsNCIP/rDwxtnjf+JV+Lv1CYHBBOKOF
	5zWZ2GcXciDH7676KTdoJ0SSWshHkt2N+u7bHfyrLQwpUkOE2NpSmkAvTy+IbgT5de8aGQ3bf7l
	WiI87N13k6C1Ixht6UKx5OKcdDTnsnVcdREppiL8dnIvlUejxh+1TPI9hNOikPmjzHWku1JinmO
	khTleZQOOfOVMvE/23jcaN+BubZHkKJKB8d0OjevBhmPVcjbJHn1BFChchD03qNjkesGRRG27hZ
	Uh
X-Google-Smtp-Source: AGHT+IFEzd2KfFGHoCTvttW8BiNeSz+bxZc6UBruBVt/kiGrP/pUGVmWYpK3FhCwsnKhzzsB/tkvUw==
X-Received: by 2002:a05:600c:21d1:b0:450:cabd:b4a9 with SMTP id 5b1f17b1804b1-46e32a00a42mr135882295e9.29.1759229385114;
        Tue, 30 Sep 2025 03:49:45 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602dfdsm21982161f8f.33.2025.09.30.03.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:49:44 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 01/15] bpf: fix the return value of push_stack
Date: Tue, 30 Sep 2025 10:55:09 +0000
Message-Id: <20250930105523.1014140-2-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
References: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
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
index 1d4183bc3cd1..9677006bdfe4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2093,7 +2093,7 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 
 	elem = kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL_ACCOUNT);
 	if (!elem)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	elem->insn_idx = insn_idx;
 	elem->prev_insn_idx = prev_insn_idx;
@@ -2103,12 +2103,12 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
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
@@ -2903,7 +2903,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 
 	elem = kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL_ACCOUNT);
 	if (!elem)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	elem->insn_idx = insn_idx;
 	elem->prev_insn_idx = prev_insn_idx;
@@ -2915,7 +2915,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 		verbose(env,
 			"The sequence of %d jumps is too complex for async cb.\n",
 			env->stack_size);
-		return NULL;
+		return ERR_PTR(-E2BIG);
 	}
 	/* Unlike push_stack() do not copy_verifier_state().
 	 * The caller state doesn't matter.
@@ -2926,7 +2926,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	elem->st.in_sleepable = is_sleepable;
 	frame = kzalloc(sizeof(*frame), GFP_KERNEL_ACCOUNT);
 	if (!frame)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	init_func_state(env, frame,
 			BPF_MAIN_FUNC /* callsite */,
 			0 /* frameno within this callchain */,
@@ -8966,8 +8966,8 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 		prev_st = find_prev_entry(env, cur_st->parent, insn_idx);
 		/* branch out active iter state */
 		queued_st = push_stack(env, insn_idx + 1, insn_idx, false);
-		if (!queued_st)
-			return -ENOMEM;
+		if (IS_ERR(queued_st))
+			return PTR_ERR(queued_st);
 
 		queued_iter = get_iter_from_state(queued_st, meta);
 		queued_iter->iter.state = BPF_ITER_STATE_ACTIVE;
@@ -10537,8 +10537,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
 					 insn_idx, subprog,
 					 is_bpf_wq_set_callback_impl_kfunc(insn->imm));
-		if (!async_cb)
-			return -EFAULT;
+		if (IS_ERR(async_cb))
+			return PTR_ERR(async_cb);
 		callee = async_cb->frame[0];
 		callee->async_entry_cnt = caller->async_entry_cnt + 1;
 
@@ -10554,8 +10554,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	 * proceed with next instruction within current frame.
 	 */
 	callback_state = push_stack(env, env->subprog_info[subprog].start, insn_idx, false);
-	if (!callback_state)
-		return -ENOMEM;
+	if (IS_ERR(callback_state))
+		return PTR_ERR(callback_state);
 
 	err = setup_func_entry(env, subprog, insn_idx, set_callee_state_cb,
 			       callback_state);
@@ -13699,9 +13699,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		struct bpf_reg_state *regs;
 
 		branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
-		if (!branch) {
+		if (IS_ERR(branch)) {
 			verbose(env, "failed to push state for failed lock acquisition\n");
-			return -ENOMEM;
+			return PTR_ERR(branch);
 		}
 
 		regs = branch->frame[branch->curframe]->regs;
@@ -14139,16 +14139,15 @@ struct bpf_sanitize_info {
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
@@ -14157,7 +14156,7 @@ sanitize_speculative_path(struct bpf_verifier_env *env,
 			mark_reg_unknown(env, regs, insn->src_reg);
 		}
 	}
-	return branch;
+	return PTR_ERR_OR_ZERO(branch);
 }
 
 static int sanitize_ptr_alu(struct bpf_verifier_env *env,
@@ -14176,7 +14175,6 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 	u8 opcode = BPF_OP(insn->code);
 	u32 alu_state, alu_limit;
 	struct bpf_reg_state tmp;
-	bool ret;
 	int err;
 
 	if (can_skip_alu_sanitation(env, insn))
@@ -14249,11 +14247,12 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
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
@@ -16572,8 +16571,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 
 		/* branch out 'fallthrough' insn as a new state to explore */
 		queued_st = push_stack(env, idx + 1, idx, false);
-		if (!queued_st)
-			return -ENOMEM;
+		if (IS_ERR(queued_st))
+			return PTR_ERR(queued_st);
 
 		queued_st->may_goto_depth++;
 		if (prev_st)
@@ -16651,10 +16650,11 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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
@@ -16664,11 +16664,12 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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
@@ -16689,10 +16690,9 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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


