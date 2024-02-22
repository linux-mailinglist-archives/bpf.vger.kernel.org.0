Return-Path: <bpf+bounces-22476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA66885EE4B
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 01:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F464282464
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 00:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4394111AA;
	Thu, 22 Feb 2024 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FinmgIEP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8373EDC
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708563029; cv=none; b=FfTSECetnvAmNMdIuIAPlba9dnetK7eSt8EWt+2AEwLk0EiPL7fMAbTMqgvaMGk6JEn51p9OZrLJSxSawb8HOQQ9dFQtSz2pNuK2HnKr/qOie+pDTYCK5rwaNRsP8x0SGUDfDdYKNKz1r49WnvX7qcZZPm35B1cbGqcUSJYguBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708563029; c=relaxed/simple;
	bh=o6u4p5eTufpYWAPtnC/zgute2JW1fp8Y8IMCCiCUuHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJp7i5qAj7r/suqWwMDCLR0ecXLa1pA5eYkmLIj+VyaZlgK7a4rDxUPA7rIm3fAcGCPjJDGJAshNVy8goGSACi0JNKx66jExldSp7TFdZ0noU/SmnlXPXQoIIzFGJTxp9Qi4/mG9RepHsslepY0czJlhWq5USY7SZUtCHysGUrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FinmgIEP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4127700a384so8598585e9.3
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 16:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708563026; x=1709167826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIUgpSFLHenqnUbM2o3R3OjL2OAwPt1xNlwPnfi1f84=;
        b=FinmgIEP9gBa3RKjiHfV0K6iGklNNaDF0vFKCx9KEuwP7WrOyOQiQ87bAokr46dZI3
         TAQFKPb6TN3qWm/37B0q2AaMdj5UQspEesLR5xgpHJ4mZ/Qbwt67EbDc1Qf/oSkcY4jm
         Z0mfpcUX/X5n64KS5OKKOZYLjkDTa//ac3yjkDknQitBN6iSR9RE+Txs9xoh5N5GJu6b
         2IIZOXMbqKSUfaAVGgsF2I/L9DrYQUId3/x3H25cvwqVOB8fMI2uv/w9nHuchcLHkVqI
         jaCCFuIBYYMl5kjt8gZCg3p4b7xGyEjSSkYbNizo6zYcLBNJLD4d8HKJYXPCnUXjueHu
         ufhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708563026; x=1709167826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIUgpSFLHenqnUbM2o3R3OjL2OAwPt1xNlwPnfi1f84=;
        b=odHK0ua7lxO5NADbDqg0Ksc1jI18bTog0RMW9xyTNVoqqfk29+4BtYHXH47+MJuAqQ
         Wckh4UfzPc7GHsKrhNNzUCQxugp9Cm1xHbiCc3Y/l8gUKKjN4V/7ZVeJVPSX+pSoEHi3
         ulvoO5dnsqBMxLOwnTX6G0WeA7ZwCqU4cCRtulyBJkpVAJR4FN0BYyI4Dd6KmRrCqbdX
         SDAJaD4Olb0x2xUokscCZok3UDWD+j5doJpjUGbso34jJjU4az2nA5UIJk10pVktl/hT
         1MMOFltrYh/whEZKncirPcHNXBtUOJjWub/SxCGQuoZGud2ZXqL5lvlIkqG0J4t2HfJ7
         no4A==
X-Gm-Message-State: AOJu0Yxn8EMnXGJeVE4Wy+dBZom9oXHgqbYQ/Rc2PP49Tj2SyDEs6qZi
	0oEl0bbqQw0/3wCBoJ4/ch7S/xGW84ceCG6zRqT+2esZhjkBezgp/nJDAOCb
X-Google-Smtp-Source: AGHT+IFZN9fYAa646oeG9hWGS18TEPVnXuiTPdkmZI12hXQ5q7YP3XvJtdFpI9WrgcAxSUgG9eSypg==
X-Received: by 2002:a05:600c:34d5:b0:412:85ff:ec0d with SMTP id d21-20020a05600c34d500b0041285ffec0dmr40608wmq.7.1708563025451;
        Wed, 21 Feb 2024 16:50:25 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i17-20020a05600c355100b0041279ac13adsm2031992wmq.36.2024.02.21.16.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 16:50:24 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	sunhao.th@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/4] bpf: replace env->cur_hist_ent with a getter function
Date: Thu, 22 Feb 2024 02:50:02 +0200
Message-ID: <20240222005005.31784-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222005005.31784-1-eddyz87@gmail.com>
References: <20240222005005.31784-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let push_jmp_history() peek current jump history entry basing on the
passed bpf_verifier_state. This replaces a "global" variable in
bpf_verifier_env allowing to use push_jmp_history() for states other
than env->cur_state.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  1 -
 kernel/bpf/verifier.c        | 34 ++++++++++++++++------------------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 84365e6dd85d..cbfb235984c8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -705,7 +705,6 @@ struct bpf_verifier_env {
 		int cur_stack;
 	} cfg;
 	struct backtrack_state bt;
-	struct bpf_jmp_history_entry *cur_hist_ent;
 	u32 pass_cnt; /* number of times do_check() was called */
 	u32 subprog_cnt;
 	/* number of instructions analyzed by the verifier */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 011d54a1dc53..759ef089b33c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3304,24 +3304,34 @@ static bool is_jmp_point(struct bpf_verifier_env *env, int insn_idx)
 	return env->insn_aux_data[insn_idx].jmp_point;
 }
 
+static struct bpf_jmp_history_entry *get_jmp_hist_entry(struct bpf_verifier_state *st,
+							u32 hist_end, int insn_idx)
+{
+	if (hist_end > 0 && st->jmp_history[hist_end - 1].idx == insn_idx)
+		return &st->jmp_history[hist_end - 1];
+	return NULL;
+}
+
 /* for any branch, call, exit record the history of jmps in the given state */
 static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
 			    int insn_flags)
 {
+	struct bpf_jmp_history_entry *p, *cur_hist_ent;
 	u32 cnt = cur->jmp_history_cnt;
-	struct bpf_jmp_history_entry *p;
 	size_t alloc_size;
 
+	cur_hist_ent = get_jmp_hist_entry(cur, cnt, env->insn_idx);
+
 	/* combine instruction flags if we already recorded this instruction */
-	if (env->cur_hist_ent) {
+	if (cur_hist_ent) {
 		/* atomic instructions push insn_flags twice, for READ and
 		 * WRITE sides, but they should agree on stack slot
 		 */
-		WARN_ONCE((env->cur_hist_ent->flags & insn_flags) &&
-			  (env->cur_hist_ent->flags & insn_flags) != insn_flags,
+		WARN_ONCE((cur_hist_ent->flags & insn_flags) &&
+			  (cur_hist_ent->flags & insn_flags) != insn_flags,
 			  "verifier insn history bug: insn_idx %d cur flags %x new flags %x\n",
-			  env->insn_idx, env->cur_hist_ent->flags, insn_flags);
-		env->cur_hist_ent->flags |= insn_flags;
+			  env->insn_idx, cur_hist_ent->flags, insn_flags);
+		cur_hist_ent->flags |= insn_flags;
 		return 0;
 	}
 
@@ -3337,19 +3347,10 @@ static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_st
 	p->prev_idx = env->prev_insn_idx;
 	p->flags = insn_flags;
 	cur->jmp_history_cnt = cnt;
-	env->cur_hist_ent = p;
 
 	return 0;
 }
 
-static struct bpf_jmp_history_entry *get_jmp_hist_entry(struct bpf_verifier_state *st,
-						        u32 hist_end, int insn_idx)
-{
-	if (hist_end > 0 && st->jmp_history[hist_end - 1].idx == insn_idx)
-		return &st->jmp_history[hist_end - 1];
-	return NULL;
-}
-
 /* Backtrack one insn at a time. If idx is not at the top of recorded
  * history then previous instruction came from straight line execution.
  * Return -ENOENT if we exhausted all instructions within given state.
@@ -17437,9 +17438,6 @@ static int do_check(struct bpf_verifier_env *env)
 		u8 class;
 		int err;
 
-		/* reset current history entry on each new instruction */
-		env->cur_hist_ent = NULL;
-
 		env->prev_insn_idx = prev_insn_idx;
 		if (env->insn_idx >= insn_cnt) {
 			verbose(env, "invalid insn idx %d insn_cnt %d\n",
-- 
2.43.0


