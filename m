Return-Path: <bpf+bounces-15015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5937EA72F
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 00:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68520280FF7
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 23:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABD23E477;
	Mon, 13 Nov 2023 23:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UX38roNW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881773E469
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 23:51:37 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A18DC
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 15:51:36 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41e1974783cso29056901cf.3
        for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 15:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699919494; x=1700524294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vLBDUZ0XJXRAEIn+jp9q+qo2vuPa6g8/F2/g7gbrNd4=;
        b=UX38roNWkKgUqMrf41z00xUgoixmRWttLuDFEdCysAa1VChRYM5j6R3lc7OGdmJsXn
         p2E1EqWvjmqdLmjzG50Xd94A0XVVEOpmS6yLetdNEAv8UUs3x3NxIr7GMP5x4XUwqkVB
         +6JOcKyl347NT/JrF3HPs9WiFMWqwc9S9qtmZw2djt8QGhuN2sDUDEPxLPDBH/bEAVMJ
         1zrP3Hif9+UqeBjeSi7xm+sH2XsQgS19+815PmF2++/wS+x0U4zA8nJ2g216K3ncz326
         9PmL/20qyn2T3s9aXAxpy9nEpSULJABriYN3IEfg0F7EWBOGdPeb7m9Jtd2QHng8JtLl
         dS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699919494; x=1700524294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vLBDUZ0XJXRAEIn+jp9q+qo2vuPa6g8/F2/g7gbrNd4=;
        b=mfLK3PJlh+7w0qZ/a+0UYgclHZTMKzp524nza5gLR7LEuGSifsiXE8/R2ERhYQCE04
         WcP3F3CvY+84h0Cah4pIv5wH/Ap6sSJEDmm85w9ECf3g6mlLtcKIw9td9t4CN/oZSSrM
         KityAKGrCR9UyvwzA/dJqcFemCrLRlmzJ8l0Zt/m1z3KW1GSjvbts/eIu2jqlsLxxEvA
         +6WyARRrbiyh7Re6LazeXpExAU7+jjPwHTcVlB8bNv+VspS5S+gjM9mlPTibc2+wjl+o
         0UpJU5bsdAflEMWcN/lxb+5BKV2FImOfsZ88OG8D1vLkTovkulvlFgDbxvtCAOGq4j+J
         wJHw==
X-Gm-Message-State: AOJu0YyO+eEH7aNkorhb8pr8VNa3yspl73NK5eX/BE22rUYbo9T2PFSm
	c2HG+95QCPdClgYGYlxgJC6gr/RBxg8=
X-Google-Smtp-Source: AGHT+IE3Uqdzoz1s/m7i2WhhAfsou4biz8X8kfog+DWTUBFdNmVODV5QsxKvgFVV1xnKUjAXJIq5Pg==
X-Received: by 2002:a05:622a:1750:b0:41c:bac1:6ad with SMTP id l16-20020a05622a175000b0041cbac106admr665103qtk.18.1699919494538;
        Mon, 13 Nov 2023 15:51:34 -0800 (PST)
Received: from andrei-desktop.taildd130.ts.net ([71.125.252.241])
        by smtp.gmail.com with ESMTPSA id r5-20020ac87ee5000000b00421c272bcbasm2115187qtc.11.2023.11.13.15.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 15:51:34 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	sunhao.th@gmail.com
Cc: kernel-team@dataexmachina.dev,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf] bpf: fix tracking of stack size for var-off access
Date: Mon, 13 Nov 2023 18:50:09 -0500
Message-Id: <20231113235008.127238-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before this patch, writes to the stack using registers containing a
variable offset (as opposed to registers with fixed, known values) were
not properly contributing to the function's needed stack size. As a
result, it was possible for a program to verify, but then to attempt to
read out-of-bounds data at runtime because a too small stack had been
allocated for it.

Each function tracks the size of the stack it needs in
bpf_subprog_info.stack_depth, which is maintained by
update_stack_depth(). For regular memory accesses, check_mem_access()
was calling update_state_depth() but it was passing in only the fixed
part of the offset register, ignoring the variable offset. This was
incorrect; the minimum possible value of that register should be used
instead.

This patch fixes it by pushing down the update_stack_depth() call into
grow_stack_depth(), which then correctly uses the registers lower bound.
grow_stack_depth() is responsible for tracking the maximum stack size
for the current verifier state, so it seems like a good idea to couple
it with also updating the per-function high-water mark. As a result of
this re-arrangement, update_stack_depth() is no longer needlessly called
for reads; it is now called only for writes (plus other cases like
helper memory access). I think this is a good thing, as reads cannot
possibly grow the needed stack.

Reported-by: Hao Sun <sunhao.th@gmail.com>
Fixes: 01f810ace9ed3 ("bpf: Allow variable-offset stack access")
Closes: https://lore.kernel.org/bpf/CABWLsev9g8UP_c3a=1qbuZUi20tGoUXoU07FPf-5FLvhOKOY+Q@mail.gmail.com/
Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 kernel/bpf/verifier.c | 47 ++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a2267d5ed14e..303a3572b169 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1669,8 +1669,29 @@ static int resize_reference_state(struct bpf_func_state *state, size_t n)
 	return 0;
 }
 
-static int grow_stack_state(struct bpf_func_state *state, int size)
+static int update_stack_depth(struct bpf_verifier_env *env,
+			      const struct bpf_func_state *func,
+			      int off)
+{
+	u16 stack = env->subprog_info[func->subprogno].stack_depth;
+
+	if (stack >= -off)
+		return 0;
+
+	/* update known max for given subprogram */
+	env->subprog_info[func->subprogno].stack_depth = -off;
+	return 0;
+}
+
+/* Possibly update state->allocated_stack to be at least size bytes. Also
+ * possibly update the function's high-water mark in its bpf_subprog_info.
+ */
+static int grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state *state, int size)
 {
+	int err = update_stack_depth(env, state, -size);
+	if (err) {
+		return err;
+	}
 	size_t old_n = state->allocated_stack / BPF_REG_SIZE, n = size / BPF_REG_SIZE;
 
 	if (old_n >= n)
@@ -4638,7 +4659,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg = NULL;
 	u32 dst_reg = insn->dst_reg;
 
-	err = grow_stack_state(state, round_up(slot + 1, BPF_REG_SIZE));
+	err = grow_stack_state(env, state, round_up(slot + 1, BPF_REG_SIZE));
 	if (err)
 		return err;
 	/* caller checked that off % size == 0 and -MAX_BPF_STACK <= off < 0,
@@ -4796,7 +4817,7 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 	    (!value_reg && is_bpf_st_mem(insn) && insn->imm == 0))
 		writing_zero = true;
 
-	err = grow_stack_state(state, round_up(-min_off, BPF_REG_SIZE));
+	err = grow_stack_state(env, state, round_up(-min_off, BPF_REG_SIZE));
 	if (err)
 		return err;
 
@@ -5928,20 +5949,6 @@ static int check_ptr_alignment(struct bpf_verifier_env *env,
 					   strict);
 }
 
-static int update_stack_depth(struct bpf_verifier_env *env,
-			      const struct bpf_func_state *func,
-			      int off)
-{
-	u16 stack = env->subprog_info[func->subprogno].stack_depth;
-
-	if (stack >= -off)
-		return 0;
-
-	/* update known max for given subprogram */
-	env->subprog_info[func->subprogno].stack_depth = -off;
-	return 0;
-}
-
 /* starting from main bpf function walk all instructions of the function
  * and recursively walk all callees that given function can call.
  * Ignore jump and exit insns.
@@ -6822,7 +6829,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 {
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_reg_state *reg = regs + regno;
-	struct bpf_func_state *state;
 	int size, err = 0;
 
 	size = bpf_size_to_bytes(bpf_size);
@@ -6965,11 +6971,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		if (err)
 			return err;
 
-		state = func(env, reg);
-		err = update_stack_depth(env, state, off);
-		if (err)
-			return err;
-
 		if (t == BPF_READ)
 			err = check_stack_read(env, regno, off, size,
 					       value_regno);
-- 
2.39.2


