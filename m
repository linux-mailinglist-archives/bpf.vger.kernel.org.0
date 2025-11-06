Return-Path: <bpf+bounces-73847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B29E8C3B114
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 14:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E81704FEEA5
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF90330B21;
	Thu,  6 Nov 2025 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wg1bueW+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E192330338
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433627; cv=none; b=U3TMh23qWgas4DOHVGxzGOVlSbTdN4jnEjVs6d7nAiPLO1My+dV7Mak4ecI/cJwTsLYgX+phe4vOeQJLNXa9smBYEU9eYojlLYIWHi7bgFK2CKkHHO9jhEVNX5/DjNwy0OQl/SqtSN3MRTBTUC/hg94kyW3jUaJB6DNTdYU9/VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433627; c=relaxed/simple;
	bh=VcMIYDcgbIp7gzck2lmzT1DdYedQDnPc1OGCfRsQ8Rw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TtDtnNRQwOy5o3tAVpgkZyQJo0zzyRxnJ89+Xb57/kEhi4b/42OmebJyBTh5UQLdMV5jXMGeEDn5VMd2wA9kS1yFLxqr4tMG3ZPvo9jo/tpx8zo2WRPn5bEaXdAOpbmwiEb24i0x9AAsFk4E4TKSJ2J/h7YXEdA6dfPoVS+eq5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wg1bueW+; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-429b9b6ce96so693804f8f.3
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 04:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762433623; x=1763038423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAHXlerzYNMFVMdi3HCj0A57dbSsWmdWDXdM/zHlcgQ=;
        b=Wg1bueW+3QVsiD1y43hZKpA9SiKfrNpOG1yhK41STqCEKrv/lZ1/Vp9hEeze79znuh
         tox5FTE52Z3H3aQKgwQtr/r6WG/cqLzzu8tu4JdzP/XnBglw4uVWy3E4pQI4tWiwKiN7
         2ny7j7ZT1Sg4hmag9Q2WRSFu9EPCcN6l1QQWnzBHHO4Y0RYqiM3JNP+LkurMTuKSZetH
         j25fKmYZIB/Sd/96xt7sFDwZ/Gen0fWfABbi9A3psimBIH/wZpuNFzSr44pHks9Kg2wk
         ESOLWWravQ3QhbgmhGKF0QmsbFVSA3e7zjcbxUr59K5p74Emv9lTOfecbF8WtPEfs3rE
         U+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433623; x=1763038423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAHXlerzYNMFVMdi3HCj0A57dbSsWmdWDXdM/zHlcgQ=;
        b=prsL0DATjY4flkI8n/I4h2QHCy0I1XKgRtG503Hf549Y4c71to4JG9xKFxStNuHhE0
         cAryEQ5Y+y+APmy5bF9CHSUSQTeIq4MdD8SRjnrDblEPX32RP2/oyEiNC8SAga00yuLs
         AfEJ+Rn/qvNZxz32t6b+iGZ539TAvZo+AyE30F0K5TUwT6iN056vHTmeC2H8MeCzmcDy
         ei+zaygvPo4q5dOfUpaTgnj53cemCWMsIi9zyBX9LCzLVVW6Sn3VY15uuYw63oCqqT/8
         qtWcVLVWw6WUH5n+BiN9rUMAFPPVyaZG3EhLacWVK7FNB+5LtQuvYhrED7mWIsy1KBoG
         vhYg==
X-Gm-Message-State: AOJu0Yxg8NuMpd8QdFVKhjwcBVBJRqyKu6EHrqsQO6/zctdCTRRqpZwO
	PeJvG536srLMLE39zn6r5rUzB6+14fbZW13xLX5rM1jhUuhmQyzfo9XvhMNI
X-Gm-Gg: ASbGncu1Rg/y3cBjO+/UBVSLJy9Tkvy+gEjRkarXFLTggSzs19LJWBiSa5cXVRW30gd
	IJIIttuxyvl5QgOnGPV1OmOJsiBYsSBK1+gqszyqk0T+UwLMmxhHCDAU6Poj6OZOYF4jZ4EPhfZ
	JqejPtnVYYL6e6XttclsvlUXMPCP0Pg5DfqYe3gOsqGRmkA7q7dHzfqr2PuUHWUrQY18ns7EYcy
	0ERUkR2hlgujjDG0bfClS09AXa1bPmV9Q0Xx5WVanBS1RHOg2uaByjzWzPDP/yN2cVOzHHz1UI0
	5ADeiBDoma6W0+c2REDoWuD81RL0W6HCm6iHSsUMqrc98ZnB9t0Mj4kksT2L5Dr+EA1hfVxUeZ4
	2UrN4nFhdjbSsPIujN04aeLCbXy3Ur+OusW9Q+sS33A8EYiC18DuQx6AqM9NAFSX+R2WKO7CrfD
	vJZ8F1fVvNLquXlNNSkl5EfjYt6aaz9CgW0GZmbKsYLaqrT6ZVbmIIiQE=
X-Google-Smtp-Source: AGHT+IEpSkzz80Ete4RN99YnH1gQLlKEKMFwhAKzS6oQ8PF5tpjR7FJdfvzr60LpAUuxBGi+08V9xA==
X-Received: by 2002:a5d:5f87:0:b0:429:bc93:9d8a with SMTP id ffacd0b85a97d-429e3307958mr6150736f8f.37.1762433622868;
        Thu, 06 Nov 2025 04:53:42 -0800 (PST)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4788856f8f.9.2025.11.06.04.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:53:42 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
X-Google-Original-From: Hao Sun <hao.sun@inf.ethz.ch>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	linux-kernel@vger.kernel.org,
	sunhao.th@gmail.com,
	Hao Sun <hao.sun@inf.ethz.ch>
Subject: [PATCH RFC 12/17] bpf: Track path constraint
Date: Thu,  6 Nov 2025 13:52:50 +0100
Message-Id: <20251106125255.1969938-13-hao.sun@inf.ethz.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
References: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Record per-branch conditions during `bcf_track()` and build a single
conjunction to represent the path suffix constraint.

- Add `record_path_cond()`: after processing each instruction under tracking,
  examine the previous instruction; if it is a conditional jump over scalars,
  construct a boolean condition that matches the taken/not-taken edge, and then
  append the condition id to `env->bcf.br_conds`.

- When tracking completes, if there are recorded conditions, build
  `env->bcf.path_cond` as either the single condition or a BCF_BOOL|BCF_CONJ
  of all collected conditions.

- In `bcf_refine()`, if both `path_cond` and a refinement-specific
  `refine_cond` exist, combine them via a 2-ary conjunction so userspace proves
  exactly the path-specific condition.

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
---
 kernel/bpf/verifier.c | 113 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 107 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3f2981db1d40..f1e8e70f9f61 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20589,6 +20589,70 @@ static int bcf_match_path(struct bpf_verifier_env *env)
 	return PATH_MATCH;
 }
 
+static int record_path_cond(struct bpf_verifier_env *env)
+{
+	int prev_insn_idx = env->prev_insn_idx;
+	struct bpf_reg_state *regs = cur_regs(env);
+	struct bpf_reg_state *dst, *src;
+	int dst_expr, src_expr;
+	struct bpf_insn *insn;
+	u8 class, op, bits;
+	bool jmp32, non_taken;
+	int cond_expr;
+
+	if (prev_insn_idx < 0)
+		return 0;
+
+	insn = &env->prog->insnsi[prev_insn_idx];
+	class = BPF_CLASS(insn->code);
+	op = BPF_OP(insn->code);
+	if (class != BPF_JMP && class != BPF_JMP32)
+		return 0;
+	if (op == BPF_CALL || op == BPF_EXIT || op == BPF_JA || op == BPF_JCOND)
+		return 0;
+	if (insn->off == 0)
+		return 0;
+
+	dst = regs + insn->dst_reg;
+	src = regs + insn->src_reg;
+	if (BPF_SRC(insn->code) == BPF_K) {
+		src = &env->fake_reg[0];
+		memset(src, 0, sizeof(*src));
+		src->type = SCALAR_VALUE;
+		__mark_reg_known(src, insn->imm);
+	}
+	if (dst->type != SCALAR_VALUE || src->type != SCALAR_VALUE)
+		return 0;
+
+	jmp32 = (class == BPF_JMP32);
+	bits = jmp32 ? 32 : 64;
+	dst_expr = bcf_reg_expr(env, dst, jmp32);
+	src_expr = bcf_reg_expr(env, src, jmp32);
+	if (dst_expr < 0 || src_expr < 0)
+		return -ENOMEM;
+
+	non_taken = (prev_insn_idx + 1 == env->insn_idx);
+	if (op == BPF_JSET) {
+		int and_expr, zero_expr;
+
+		and_expr = bcf_build_expr(env, BCF_BV | BPF_AND, bits, 2,
+					  dst_expr, src_expr);
+		zero_expr = bcf_val(env, 0, jmp32);
+		op = BPF_JNE;
+		if (non_taken)
+			op = BPF_JEQ;
+		cond_expr = bcf_build_expr(env, BCF_BOOL | op, 0, 2,
+					   and_expr, zero_expr);
+	} else {
+		if (non_taken)
+			op = rev_opcode(op);
+		cond_expr = bcf_build_expr(env, BCF_BOOL | op, 0, 2, dst_expr,
+					   src_expr);
+	}
+
+	return bcf_add_cond(env, cond_expr);
+}
+
 static int do_check(struct bpf_verifier_env *env)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
@@ -20656,8 +20720,9 @@ static int do_check(struct bpf_verifier_env *env)
 
 			if (path == PATH_MISMATCH)
 				goto process_bpf_exit;
-			else if (path == PATH_DONE)
-				return 0;
+			err = record_path_cond(env);
+			if (err || path == PATH_DONE)
+				return err;
 		}
 
 		if (signal_pending(current))
@@ -24023,11 +24088,37 @@ static int bcf_track(struct bpf_verifier_env *env,
 	if (!err && !same_callsites(env->cur_state, st))
 		err = -EFAULT;
 
-	if (!err) {
-		tracked_regs = cur_regs(env);
-		for (i = 0; i < BPF_REG_FP; i++)
-			regs[i].bcf_expr = tracked_regs[i].bcf_expr;
+	if (err)
+		goto out;
+
+	tracked_regs = cur_regs(env);
+	for (i = 0; i < BPF_REG_FP; i++)
+		regs[i].bcf_expr = tracked_regs[i].bcf_expr;
+
+	/* Build the path constraint. */
+	if (bcf->br_cond_cnt == 1) {
+		bcf->path_cond = *bcf->br_conds;
+	} else if (bcf->br_cond_cnt > 1) {
+		struct bcf_expr *cond_expr;
+		int cond;
+
+		cond = bcf_alloc_expr(env, bcf->br_cond_cnt + 1);
+		if (cond < 0) {
+			err = cond;
+			goto out;
+		}
+		cond_expr = bcf->exprs + cond;
+		cond_expr->code = BCF_BOOL | BCF_CONJ;
+		cond_expr->params = 0;
+		cond_expr->vlen = bcf->br_cond_cnt;
+		memcpy(cond_expr->args, bcf->br_conds,
+		       sizeof(u32) * bcf->br_cond_cnt);
+		bcf->path_cond = cond;
 	}
+out:
+	kfree(bcf->br_conds);
+	bcf->br_conds = NULL;
+	bcf->br_cond_cnt = 0;
 
 	free_verifier_state(env->cur_state, true);
 	env->cur_state = NULL;
@@ -24134,6 +24225,7 @@ static int __used bcf_refine(struct bpf_verifier_env *env,
 			     refine_state_fn refine_cb, void *ctx)
 {
 	struct bpf_reg_state *regs = st->frame[st->curframe]->regs;
+	struct bcf_refine_state *bcf = &env->bcf;
 	struct bpf_verifier_state *base;
 	int i, err;
 
@@ -24168,6 +24260,15 @@ static int __used bcf_refine(struct bpf_verifier_env *env,
 	if (!err && refine_cb)
 		err = refine_cb(env, st, ctx);
 
+	/* The final condition is the conj of path_cond and refine_cond. */
+	if (!err && bcf->refine_cond >= 0 && bcf->path_cond >= 0) {
+		bcf->refine_cond = bcf_build_expr(env, BCF_BOOL | BCF_CONJ, 0,
+						  2, bcf->path_cond,
+						  bcf->refine_cond);
+		if (bcf->refine_cond < 0)
+			err = bcf->refine_cond;
+	}
+
 	if (!err && (env->bcf.refine_cond >= 0 || env->bcf.path_cond >= 0))
 		mark_bcf_requested(env);
 
-- 
2.34.1


