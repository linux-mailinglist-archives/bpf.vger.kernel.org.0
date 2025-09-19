Return-Path: <bpf+bounces-68891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C30B87B60
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 04:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DBD71CC1FD9
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 02:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BC027055D;
	Fri, 19 Sep 2025 02:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXfLNE3Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE9826FDBF
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 02:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248348; cv=none; b=buJ8YVg2jGmLnC9Q88tnL6cPGUandSdlnPXxMeCu/aH/vRYlodUnkZJgJ/B0aC0U7DJl/wEX3hi6zYsiTUEO9zluQmsUTOedrjKMvmlDwlIHkqB0PKNiqvIzYkywjEUEaBOeuWksaGhKomgiY8FuvdejMSCqkkr1d6ZqFGQHu/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248348; c=relaxed/simple;
	bh=gjv01QNbmwtJuKFUhbcToNN8TRMPQ37N3acfewJMrpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tIrBWxR5GK9A8ENuRKtcJc0GIPE7v4OPRDQiQYW4K2SmYgSBU/dFav70BO9/KotiYPIG9sArCeoY7W0vFhvpEMTpF2GB5SE/+ieNqJsQphmG+Z6n1X3Ajp92PhCVbZJPg2WHTOr1y+0T6hp0A47AbWSTLBEOaWbJLwvEoTdqTVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXfLNE3Z; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2445806e03cso19261715ad.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 19:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758248345; x=1758853145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdTdxoHinyoKrSxWgaUi0tEjRioTPC2OKqjLgprnFNs=;
        b=hXfLNE3ZRfHsEJRK0tfh/+ATyAxO1IhGxsYkMiu9CB4VTTmYUocQJIHNdn/+lYEbhI
         Y7KixiXM94W6YRoHYdSpRkd31TCTdItGQd2S6Zj0zuYkyKL55oEB7YSMKF13I/rCitL7
         tUDBfWv6uqkEB8yESyEYzpsjFvfccJYMN7hJ3xDWi4MUZ9TXuJ2ub+USMhU5qbmlY5BT
         PTuA1mq2O+5HFLfRGI9QvqE+IBhFISghvBoyWLzA3W4OBtlAsRNVAYDG9Ya0/vMmjYx6
         75OJ8e9jaguyjWeanRv+H+2Ewz7isKHn/Qoty+dpUkM0DNbUTeNpTti+WWNudusEHyGX
         5ElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758248345; x=1758853145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdTdxoHinyoKrSxWgaUi0tEjRioTPC2OKqjLgprnFNs=;
        b=Sxb99XRHKm/8a8/O7TaKV2zJckssIUm4Qxy5srHX67CrP2Z++HoE3ni0ZSPz6TCkc+
         ErhSzjtdFiHI02ZgDYe0/ImabkPhKuUi7JSlfhfhmn+GKGhswtqK7+1brVxwWkYUO1D/
         zCqKlgLp4OPOWaAy006eN67FjjngKrDsXWujjvLbQKA9z/KlFCJf7RvOJVmuiHXDc6Hu
         Y73wWXtF31pIh3GvG07lC90i5DVsf8ihZ29kaVssJWTuh0fKd3jLC92OcNncq5Dk8sBR
         swl442nXPk9qsvBPi+g0rRQxrsew06qNq8Kd5NH2Wkpy1YyFJ4ovWUy6Pb5s1kEa0Tbm
         4qNQ==
X-Gm-Message-State: AOJu0YxtgNa3TbZ6b1x1crAhiNSmPytLLn23lx6fhIjXhi8P0v47bCkM
	xHqA5tTnK6944HQhxOpRnQ5aD+htOj7+lqyzQZoKrXrW3kw2eiCTY7dsBdSutQ==
X-Gm-Gg: ASbGncsmLw5ObppAyNassJY7+jEC8ilTg2W4aRrl2R/J8QVW5BtNA+gCBI0CUlpMCbD
	3b8uxNueMY82PmaDj6lHNIL9S8y8WDls+BY6KErGzhPGgiC6UbheKeg9XHMm3sJsbIcZPAL2HGc
	JTWiHZpWBX+AAHxMt8JCWVo8JOxtvKLOV/0ECRmz0i4Wpm/j66a4hPMOfU+e6U8121wXXXUuWDc
	4nYza7MoEhqXenGdLlePxSnuTpAYuXwNbkPle7Lkkb3Y8IoUSDX//vzqpW95EsqXJF41r/EhuRj
	7tu2EarDrKmY/26o7DMFM/kVyxdUXDWflyiMky5TQiUbvssmkXRTCC9z3gJDXw8GVb0iFW2a+Um
	ylkxzavjnFHpOCmhk
X-Google-Smtp-Source: AGHT+IF2GooPp2UXVbf5g2dILnalV498vJQEQydtBSfdXxESXAtHr7hLsa1icDfBzLeGzMsQzEmFLg==
X-Received: by 2002:a17:902:ef48:b0:269:805c:943a with SMTP id d9443c01a7336-269ba402246mr27979335ad.2.1758248345263;
        Thu, 18 Sep 2025 19:19:05 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033a3e5sm39186235ad.126.2025.09.18.19.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 19:19:04 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 05/12] bpf: compute instructions postorder per subprogram
Date: Thu, 18 Sep 2025 19:18:38 -0700
Message-ID: <20250918-callchain-sensitive-liveness-v3-5-c3cd27bacc60@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
References: <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The next patch would require doing postorder traversal of individual
subprograms. Facilitate this by moving env->cfg.insn_postorder
computation from check_cfg() to a separate pass, as check_cfg()
descends into called subprograms (and it needs to, because of
merge_callee_effects() logic).

env->cfg.insn_postorder is used only by compute_live_registers(),
this function does not track cross subprogram dependencies,
thus the change does not affect it's operation.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  6 +++-
 kernel/bpf/verifier.c        | 68 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 93563564bde5947d08fad7b33f9e38b16942fa31..bd87e80f94231647183bb148045c200cc2104f31 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -665,6 +665,7 @@ struct bpf_subprog_info {
 	/* 'start' has to be the first field otherwise find_subprog() won't work */
 	u32 start; /* insn idx of function entry point */
 	u32 linfo_idx; /* The idx to the main_prog->aux->linfo */
+	u32 postorder_start; /* The idx to the env->cfg.insn_postorder */
 	u16 stack_depth; /* max. stack depth used by this function */
 	u16 stack_extra;
 	/* offsets in range [stack_depth .. fastcall_stack_off)
@@ -794,7 +795,10 @@ struct bpf_verifier_env {
 	struct {
 		int *insn_state;
 		int *insn_stack;
-		/* vector of instruction indexes sorted in post-order */
+		/*
+		 * vector of instruction indexes sorted in post-order, grouped by subprogram,
+		 * see bpf_subprog_info->postorder_start.
+		 */
 		int *insn_postorder;
 		int cur_stack;
 		/* current position in the insn_postorder vector */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a8a0d489a32db7fa43bc38066449332c63e5ac17..59d0dc4deb785dac45fbca3c9a750ea9b54f9818 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17863,7 +17863,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 static int check_cfg(struct bpf_verifier_env *env)
 {
 	int insn_cnt = env->prog->len;
-	int *insn_stack, *insn_state, *insn_postorder;
+	int *insn_stack, *insn_state;
 	int ex_insn_beg, i, ret = 0;
 
 	insn_state = env->cfg.insn_state = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
@@ -17876,14 +17876,6 @@ static int check_cfg(struct bpf_verifier_env *env)
 		return -ENOMEM;
 	}
 
-	insn_postorder = env->cfg.insn_postorder =
-		kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
-	if (!insn_postorder) {
-		kvfree(insn_state);
-		kvfree(insn_stack);
-		return -ENOMEM;
-	}
-
 	ex_insn_beg = env->exception_callback_subprog
 		      ? env->subprog_info[env->exception_callback_subprog].start
 		      : 0;
@@ -17901,7 +17893,6 @@ static int check_cfg(struct bpf_verifier_env *env)
 		case DONE_EXPLORING:
 			insn_state[t] = EXPLORED;
 			env->cfg.cur_stack--;
-			insn_postorder[env->cfg.cur_postorder++] = t;
 			break;
 		case KEEP_EXPLORING:
 			break;
@@ -17955,6 +17946,56 @@ static int check_cfg(struct bpf_verifier_env *env)
 	return ret;
 }
 
+/*
+ * For each subprogram 'i' fill array env->cfg.insn_subprogram sub-range
+ * [env->subprog_info[i].postorder_start, env->subprog_info[i+1].postorder_start)
+ * with indices of 'i' instructions in postorder.
+ */
+static int compute_postorder(struct bpf_verifier_env *env)
+{
+	u32 cur_postorder, i, top, stack_sz, s, succ_cnt, succ[2];
+	int *stack = NULL, *postorder = NULL, *state = NULL;
+
+	postorder = kvcalloc(env->prog->len, sizeof(int), GFP_KERNEL_ACCOUNT);
+	state = kvcalloc(env->prog->len, sizeof(int), GFP_KERNEL_ACCOUNT);
+	stack = kvcalloc(env->prog->len, sizeof(int), GFP_KERNEL_ACCOUNT);
+	if (!postorder || !state || !stack) {
+		kvfree(postorder);
+		kvfree(state);
+		kvfree(stack);
+		return -ENOMEM;
+	}
+	cur_postorder = 0;
+	for (i = 0; i < env->subprog_cnt; i++) {
+		env->subprog_info[i].postorder_start = cur_postorder;
+		stack[0] = env->subprog_info[i].start;
+		stack_sz = 1;
+		do {
+			top = stack[stack_sz - 1];
+			state[top] |= DISCOVERED;
+			if (state[top] & EXPLORED) {
+				postorder[cur_postorder++] = top;
+				stack_sz--;
+				continue;
+			}
+			succ_cnt = bpf_insn_successors(env->prog, top, succ);
+			for (s = 0; s < succ_cnt; ++s) {
+				if (!state[succ[s]]) {
+					stack[stack_sz++] = succ[s];
+					state[succ[s]] |= DISCOVERED;
+				}
+			}
+			state[top] |= EXPLORED;
+		} while (stack_sz);
+	}
+	env->subprog_info[i].postorder_start = cur_postorder;
+	env->cfg.insn_postorder = postorder;
+	env->cfg.cur_postorder = cur_postorder;
+	kvfree(stack);
+	kvfree(state);
+	return 0;
+}
+
 static int check_abnormal_return(struct bpf_verifier_env *env)
 {
 	int i;
@@ -24416,9 +24457,6 @@ static int compute_live_registers(struct bpf_verifier_env *env)
 
 out:
 	kvfree(state);
-	kvfree(env->cfg.insn_postorder);
-	env->cfg.insn_postorder = NULL;
-	env->cfg.cur_postorder = 0;
 	return err;
 }
 
@@ -24721,6 +24759,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = compute_postorder(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = check_attach_btf_id(env);
 	if (ret)
 		goto skip_full_check;

-- 
2.51.0

