Return-Path: <bpf+bounces-68843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CFDB86833
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 20:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACEB916DC3D
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE60B2D63FF;
	Thu, 18 Sep 2025 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnWMDIi/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B082D5427
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221291; cv=none; b=OsFpUNozyUw/dqDf6AXFaYK4YbRuf+eNjKaDdHt4vmne9kDgqRPSxsuCeA5T1iFMx+uP4eAd0ChAJwKFu3jRdhsc/VyAjfanzAS+VKSiaFz8uQ/LWHoFMexUIV1avPREwOaZYSch8H+MzlaJr5NgAHcRiMGg5aXzHl1AHhhe2ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221291; c=relaxed/simple;
	bh=LIVYDXvH/fJCdySeel0K+8ODJMk7upWvD69RWKpWlRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1m+Otewq78cyAt00J9Vcy3FaJVc214TR951MDlzWykKEn9qGQEzT8Yoy7s7mdNgsIsj649qAAlLe2wr45YxnnUKfDoAzJP50lsaoK27OL/uWAfL2HEt1Kygt7Yul54jYKAIuqHOQVEX3Med1F7gB2Sutvy2pFLmwrU/TamN/i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnWMDIi/; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b54abd46747so1360471a12.0
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 11:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758221289; x=1758826089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4TlO1P7yZKBU5aBDx15CGqGdN1t+4zij99D3Tqy2mU=;
        b=HnWMDIi/yIbcYPfrYIzXAdRYE28ZiO1SVrD4vmETRg46OMp5nCGGa5sjwRgt528DaF
         MvC+RRAZcokhagfJPWZZzYWW+fuhpeDmMktD/oL1bJ8aucsa3FWBX3RCwfqoLla9xsa2
         XCSKyRk3oPh09Z4Nd9ARpFfA20bsTN4we0WGrlOnnWvrlbFEe9pA3EpsJQS6C/meSY3K
         GKeMTJlbSdP9VXnwHk7q8EsLzX25Z5x7DOtmD5h59CeCh85MGB7NGgJ7O0Cg/PiVO9VM
         edCvDWBIiXgh/m8iJcL1gKMVN4CKF0mxpwOVJCFsTBwcBazV8MI5dNCf65BqD8HErqIq
         u2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758221289; x=1758826089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4TlO1P7yZKBU5aBDx15CGqGdN1t+4zij99D3Tqy2mU=;
        b=h53CFMzN5ApPcB3waXMRNJv5qg8zNJARYdns2kw0MmGA/QGRAhj9DrLkrlYpjH6Rm4
         1d+2P5MbpMBl9xKqDZOtYnihleNxoM4N+r76MhpyFyot6/n+2x5dJn063eo7d6BRtzPC
         jQwZ/8MnNetv6PeFS6tIKXo/skiRC2VEP0xOY9COL+6qyxqxUyiMZK7tfWh4uWJn+nbR
         C3ld7ssGQsJ9XAkDu9nITgBtcmXk75d6MG4DMM1c+859X6oO81D7wtnZoQD3jQaEXbfZ
         WQRn2QIaNfz+9/WKYkIOxU8n0sKBpHTH7l8BYqFbCUE+9nSacCDl52eWavxiX4w2e0C5
         C5gg==
X-Gm-Message-State: AOJu0YwIV1Wz3WIUzpLLSwlke8lacq2plICF9VhDF01wevEJ4Eg64VTz
	qm/3ehAYfOc8Uv5B5g5YsNqLI7G05+JHuecrXjVSbeOH1+DUtpdnyUdbThqwAeF0
X-Gm-Gg: ASbGnctIJchg8JgyaTH+Uc8SPxru7HDfKRUgtLiZREXrGKaYg2jUUJ/UQng9DkuSTYT
	LrLCC5Y0Mp0QYc3nRCnLuIJwQIPtb17Z/tq00SnC6jKnknKXv3klym0g5jn9dJUbuNWlbaxLXfI
	5R5Lm/GjKJ7LcFj+Up5onONjDvgMFR8hD//YrRGgrY+k/c7mc2dW+oXd0bmJfqnXgDx3N+kqkqx
	zHZXxU+CfYGFUhw30NBLjipxclpAL5688G0h4Ea0iwmWneEFoTFaxKOE3N/Fngp06TVniQzwlrW
	h2TaZDtn8X95uQjxbVff+giCnkNGSvMKOkubED73MrwH1Iz/juzDzenNiJa0oQuvlV2hTO8lbam
	qOWx3zfOgKb4Fv1vTv+49fQ5Vd5c76rx3gec=
X-Google-Smtp-Source: AGHT+IGZkwySCzGzZoypBATqTpjuHPIDkAjg5kSJi2PYkYG5qsVwe+IVpPAnYoBkCCO4o1eycr/QgQ==
X-Received: by 2002:a17:903:f86:b0:267:16ec:390 with SMTP id d9443c01a7336-269ba447e48mr9932305ad.17.1758221288821;
        Thu, 18 Sep 2025 11:48:08 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm32361505ad.90.2025.09.18.11.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 11:48:08 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 05/12] bpf: compute instructions postorder per subprogram
Date: Thu, 18 Sep 2025 11:47:34 -0700
Message-ID: <20250918-callchain-sensitive-liveness-v2-5-214ed2653eee@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918-callchain-sensitive-liveness-v2-0-214ed2653eee@gmail.com>
References: <20250918-callchain-sensitive-liveness-v2-0-214ed2653eee@gmail.com>
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
index d516c1d721ba500c9ab5dcf36a24a693003bb794..12ba281472dc0e014a700659ec802db20f7d71a6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17838,7 +17838,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 static int check_cfg(struct bpf_verifier_env *env)
 {
 	int insn_cnt = env->prog->len;
-	int *insn_stack, *insn_state, *insn_postorder;
+	int *insn_stack, *insn_state;
 	int ex_insn_beg, i, ret = 0;
 
 	insn_state = env->cfg.insn_state = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
@@ -17851,14 +17851,6 @@ static int check_cfg(struct bpf_verifier_env *env)
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
@@ -17876,7 +17868,6 @@ static int check_cfg(struct bpf_verifier_env *env)
 		case DONE_EXPLORING:
 			insn_state[t] = EXPLORED;
 			env->cfg.cur_stack--;
-			insn_postorder[env->cfg.cur_postorder++] = t;
 			break;
 		case KEEP_EXPLORING:
 			break;
@@ -17930,6 +17921,56 @@ static int check_cfg(struct bpf_verifier_env *env)
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
@@ -24391,9 +24432,6 @@ static int compute_live_registers(struct bpf_verifier_env *env)
 
 out:
 	kvfree(state);
-	kvfree(env->cfg.insn_postorder);
-	env->cfg.insn_postorder = NULL;
-	env->cfg.cur_postorder = 0;
 	return err;
 }
 
@@ -24696,6 +24734,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
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

