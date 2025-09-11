Return-Path: <bpf+bounces-68069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5069B52575
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 03:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B703A5B34
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 01:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14361F4CBB;
	Thu, 11 Sep 2025 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/eOREJZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68551DF25C
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 01:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757552698; cv=none; b=HdM55CCcnM4MeWPAOGX1ezYob6DXPZFuOmMT/RNBGHMTMaNDU+o6GOEQmDn+dqe69fdIs3YE+3yeRQDdmq3LDZcT0dwOLKtD8PilBHOulkT4oHJ0HK7LY029LTFzRNY1M8XoPQYCu3gJ2fDyRRpZFtOWIdSvPvyeXP04RXHz8Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757552698; c=relaxed/simple;
	bh=AJhqYyBaIfXKwEMAkKfkA03K/VdxIi/2ISdYG7GJKVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtBRINJyirGLq0bO1AVL9LvCs536rZ6R2bR2nvzAErNOM2dyE3Fd9iBjkltVUREG62Ac6RgSEbe60omMlr3v86ySg+vdFMzKqSuK+7zpwDvir2u0l0CsYCv8LGfbJD2zV4eGOEXQ93bC108KYJKVm9yCDCCuzBnG+eybTAGRviM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/eOREJZ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32da35469f7so132419a91.1
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 18:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757552696; x=1758157496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNh/jLayqOGL4xTE2R92JEeExIrxCgxjfbL5tKeVDys=;
        b=P/eOREJZ/y59wHrtdI05NXUNLNtRdaVM0nQQ7UwuG84HxJPNvRI9CbeKRjU51t7tKG
         Rh39O9uWv/MnpN4pN5WUf+VXeX/R1aPfCnWZftHkUYkVFav5QPZNVH3qeWx0ZH1KfUDt
         /U1QH0rRYY1mDPhbpjX63/6KoDy4/sO3sN2rCuWC5JW+Uh0YS1FbzWW4nUKzUuyfLR1C
         d8B2lv+2TsHLZx22fn+ubj1tHr2/yDwC9PHeeQ3ns4SiURTd3VOyGzbjFNOVYLnurYUx
         5pG43IbY8Uh5ersAmyrIEIAAsaSpVR4p/scrj76oi98tMhGBRzMnPUBI7ReXzECJCAq1
         QQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757552696; x=1758157496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNh/jLayqOGL4xTE2R92JEeExIrxCgxjfbL5tKeVDys=;
        b=B1zVGfGrUUtwjVzZWT2Pmw5GkExv9yRvXRfgq1j4pgWmXHkoBDe7fgX6PU3emQUn8B
         d6QFMWTUKaaoEcrHGvkt9SP03T+sk3x2QogGVnNsNHCXEABHw00VPdL9uBwABD7eEPX4
         kJ+r9ZjluXZUJh8ILsT6jdwFjRYzDavcKYha1qD+8KuhfQENzTeTbZq0P0xe45eyHzGQ
         eBzMe5YyzDVN757JMSnf/DOo7KRkw8l2YsYp3hOGyMgZUPi8VROT2HeYwrVlNeXHT7c9
         5jpJ3vaKAhEDLZWyMeY6WtG8sW7f7XWtWQWKLgCORTxlUE76kroTDQEDFGlTvJ55otZp
         7TrQ==
X-Gm-Message-State: AOJu0Yxesc7k8HbHHvvSzl0CE+n6lvf50LBOHctKZh19Fg/ZVY5793Ff
	RE/q1nG8CBe20gpbQpINlNaihEjpXLLZs08sv4ImEd2zqbv2IGqbs7T3cqVEeg==
X-Gm-Gg: ASbGncvaVInkpieGee9GzgnRvfswi02Ei+R9HYs5u8hsB9Tv51DhQ0acdFaTbvGGtmL
	J4/P8LDIMZkyNl5CQmh/etFavkcLW998jxDbNOwMi0NtQB3BZLyiQUsHwrxIwJL+JJ6l/2EL9Zm
	rh56vIQZFHiESoEEfL6TbBtNqteiqNID4FVX92W1HUx5D5oY7GKw5AuhaGfzUt2XGilTf+uRnZk
	s2xDKywi4LfK4Fr9nu3jS28KmTElPWWpQ9xMsPPiC605iT7rvJTiKR++yTEk41jpLbt53p4zewD
	P5qzHdw6AmTZlmZA4U0kvVqS2QyI5OKVm0o+PatCgfbBuSZeYO4Vf4GVYkWKIdVA/gZEtbkbBm0
	dfb/F52APhKCUHexo92ljeHZ1u2V+ATEgeg==
X-Google-Smtp-Source: AGHT+IF2oGnEIEucMIc8GQyZFqNe8E4LxbbTCrCFd+E4kq16wTWbc/O9xBT7IctOizX/aXzrX0pl3Q==
X-Received: by 2002:a17:90b:3ccd:b0:327:a638:d21 with SMTP id 98e67ed59e1d1-32d43e2cda6mr24710490a91.0.1757552695947;
        Wed, 10 Sep 2025 18:04:55 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd61eaa27sm545511a91.1.2025.09.10.18.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:04:55 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 05/10] bpf: compute instructions postorder per subprogram
Date: Wed, 10 Sep 2025 18:04:30 -0700
Message-ID: <20250911010437.2779173-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911010437.2779173-1-eddyz87@gmail.com>
References: <20250911010437.2779173-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
 kernel/bpf/verifier.c        | 67 +++++++++++++++++++++++++++++-------
 2 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 93563564bde5..bd87e80f9423 100644
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
index 5658e1e1d5c5..bdcc20d2fab6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17834,7 +17834,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 static int check_cfg(struct bpf_verifier_env *env)
 {
 	int insn_cnt = env->prog->len;
-	int *insn_stack, *insn_state, *insn_postorder;
+	int *insn_stack, *insn_state;
 	int ex_insn_beg, i, ret = 0;
 
 	insn_state = env->cfg.insn_state = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
@@ -17847,14 +17847,6 @@ static int check_cfg(struct bpf_verifier_env *env)
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
@@ -17872,7 +17864,6 @@ static int check_cfg(struct bpf_verifier_env *env)
 		case DONE_EXPLORING:
 			insn_state[t] = EXPLORED;
 			env->cfg.cur_stack--;
-			insn_postorder[env->cfg.cur_postorder++] = t;
 			break;
 		case KEEP_EXPLORING:
 			break;
@@ -17926,6 +17917,55 @@ static int check_cfg(struct bpf_verifier_env *env)
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
@@ -24387,9 +24427,6 @@ static int compute_live_registers(struct bpf_verifier_env *env)
 
 out:
 	kvfree(state);
-	kvfree(env->cfg.insn_postorder);
-	env->cfg.insn_postorder = NULL;
-	env->cfg.cur_postorder = 0;
 	return err;
 }
 
@@ -24692,6 +24729,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
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
2.47.3


