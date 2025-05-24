Return-Path: <bpf+bounces-58896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E40AC3108
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 21:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA9B189B602
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 19:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA151EFF89;
	Sat, 24 May 2025 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3zzdLQi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6E71EDA12
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748114393; cv=none; b=Pd/f1ZnF1/1fodFgsBVO7Qyc9FzKi0rG4CwjDo61HjF6/i8ksPr+KBDivdu59yVSgfRKjx8c9ECLk/89dAG0t3khHZkOV8twcvWjGNQflUHhk9JpVNJ9EHggDDvZJjkgAsbYe6WNbwULwPHejjGpp39uE3+w3wlG9DRyz9OyOzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748114393; c=relaxed/simple;
	bh=cHBfm33AbywZzO04/Vreq5zjxzLXfs3/Z/0xi2cD4y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewxnaV+BsWYHQPaJmJHPOzznwI3zMdv7jdl7Dh2jmpIVWvsfl8XITbw3IixLWYZmW8+zV1e6jxrWWPKxXDzed53bdZr/x21W2WTAiwi6FW7Ej7Imp4Hn5RWaZdVXUJJek3FFW0WVZ/oXabIV5wh9Jr0iAFgRbPYe+XYe8Vsysy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3zzdLQi; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-745fe311741so789095b3a.0
        for <bpf@vger.kernel.org>; Sat, 24 May 2025 12:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748114391; x=1748719191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kafkhRJz+6Po6bSkTGP2ykuetfHZGXTJZCeudM0Y4Yc=;
        b=c3zzdLQilhXEnGKNI94B0k8MRWMyy19DFn6Vcm7sjWpx9EnKaADMzgxrCjzBTxQTS7
         8GmQ1CTg7qqlf3m/t+q/emGERXCQsz7sjup8bXqH136kvdaGsQABYpINV+F2kdr1Em94
         7Qb40zz7kaTUx9DVUVUHii3LO1Yx60lg94HXcltdICjR8ct3RN9lQsXI0gnxvZWhU73E
         IUzxVd7JEsp/08a7IsSVIKlhSmhV/SgZRzHCYFs5TmwSmj6KPNvNH/1GMHvpXI3gqqNv
         04Vc2umQWYZg4AwHykmjkEex+AtrrO7HJajnmKL9TBQAAm5JztBB6FNUyDOx861gUOH1
         b8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748114391; x=1748719191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kafkhRJz+6Po6bSkTGP2ykuetfHZGXTJZCeudM0Y4Yc=;
        b=TqmKXR2QDpEscC0ORr5hwFOdcbKaZCviurXpqXP48pYzmjiHhidzBXFvqWKZkpuXeu
         PGWK1+v4pcM1q89o4la5VC4SC6dl+EqHRHwZoQv/Q6JoioNX2YXq6ySbChOFPo1N6HA5
         WPsudw/5paKv5hJ42dORJN5h2YnX6iqGPQhAg8WUM0LnSiwjftt4MgJABQxawF6CBlvK
         +EdHnc40LjpFxeT7IE/AGaCBIBoAPupZmvZ2BVHl+CrQvWPrFx6Cu/lvMhBYop21amnH
         MZvSsA9L7rBfRqsqGAX+UmXcc4El918kCVCZ+hFCD4vLiSIavFofFMmVNrlQFg2i6s5F
         4k5Q==
X-Gm-Message-State: AOJu0YyeonZzb5viFcPxFesFnQNW9b0MR34+uDthWQjc9aNf2yWZM3x7
	KVYnf5gu6oWtAI9V3nHPXuTYHTBXE/U8EkEyie0wUmerLa0kKEsJiYxM33SGKweA
X-Gm-Gg: ASbGnct6iifMovxeRI1qZEjEZ3A9QnV5CYT94sbwZuA6nWG1sqnm4mnNS+SW5SJsYfv
	0kCisvAAQv5txxEKOsLoZvK6g6qzSs8/lybJU59yzLn5AKZ1w1yrAJJxBcHHVm/dnZyHOVEhPdC
	M7JDcRuD0zvXCZ+OAtg+95L5bJkGMFnDylgQKovPFRLO27z/900JXuN8RR0eejCH6THTkEwpsaw
	4vhIMwKEPTQFZSnN+5JHmpOh+wc6qNHeH+fRRt8Scf6guAUA3bTPe/5ywejGX/kwQVJrnCD5FLi
	BXDZ7Huw9O4yhoMwYcK47wn97QotjX78Vk/WI2Q8MJYdCzs=
X-Google-Smtp-Source: AGHT+IGKTn5Fas7Q+Losh1XLAYW6A4WZjxaZhwemL45BMFa5GiGyEk6fT6Jm24XIc2BJX0a+ymXPrQ==
X-Received: by 2002:a05:6a00:4b55:b0:740:a52f:9652 with SMTP id d2e1a72fcca58-745fdf34c71mr5567238b3a.6.1748114391403;
        Sat, 24 May 2025 12:19:51 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a986b38bsm14558298b3a.129.2025.05.24.12.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 12:19:50 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 04/11] bpf: starting_state parameter for __mark_chain_precision()
Date: Sat, 24 May 2025 12:19:25 -0700
Message-ID: <20250524191932.389444-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250524191932.389444-1-eddyz87@gmail.com>
References: <20250524191932.389444-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow `mark_chain_precision()` to run from an arbitrary starting state
by replacing direct references to `env->cur_state` with a parameter.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 13bbe63dab00..fa0f6bce1e2a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4662,12 +4662,13 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
  * mark_all_scalars_imprecise() to hopefully get more permissive and generic
  * finalized states which help in short circuiting more future states.
  */
-static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
+static int __mark_chain_precision(struct bpf_verifier_env *env,
+				  struct bpf_verifier_state *starting_state, int regno)
 {
+	struct bpf_verifier_state *st = starting_state;
 	struct backtrack_state *bt = &env->bt;
-	struct bpf_verifier_state *st = env->cur_state;
 	int first_idx = st->first_insn_idx;
-	int last_idx = env->insn_idx;
+	int last_idx = starting_state->insn_idx;
 	int subseq_idx = -1;
 	struct bpf_func_state *func;
 	struct bpf_reg_state *reg;
@@ -4678,7 +4679,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 		return 0;
 
 	/* set frame number from which we are starting to backtrack */
-	bt_init(bt, env->cur_state->curframe);
+	bt_init(bt, starting_state->curframe);
 
 	/* Do sanity checks against current state of register and/or stack
 	 * slot, but don't set precise flag in current state, as precision
@@ -4742,7 +4743,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				err = backtrack_insn(env, i, subseq_idx, hist, bt);
 			}
 			if (err == -ENOTSUPP) {
-				mark_all_scalars_precise(env, env->cur_state);
+				mark_all_scalars_precise(env, starting_state);
 				bt_reset(bt);
 				return 0;
 			} else if (err) {
@@ -4830,7 +4831,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 	 * fallback to marking all precise
 	 */
 	if (!bt_empty(bt)) {
-		mark_all_scalars_precise(env, env->cur_state);
+		mark_all_scalars_precise(env, starting_state);
 		bt_reset(bt);
 	}
 
@@ -4839,15 +4840,16 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 
 int mark_chain_precision(struct bpf_verifier_env *env, int regno)
 {
-	return __mark_chain_precision(env, regno);
+	return __mark_chain_precision(env, env->cur_state, regno);
 }
 
 /* mark_chain_precision_batch() assumes that env->bt is set in the caller to
  * desired reg and stack masks across all relevant frames
  */
-static int mark_chain_precision_batch(struct bpf_verifier_env *env)
+static int mark_chain_precision_batch(struct bpf_verifier_env *env,
+				      struct bpf_verifier_state *starting_state)
 {
-	return __mark_chain_precision(env, -1);
+	return __mark_chain_precision(env, starting_state, -1);
 }
 
 static bool is_spillable_regtype(enum bpf_reg_type type)
@@ -9500,7 +9502,7 @@ static int get_constant_map_key(struct bpf_verifier_env *env,
 	 * to prevent pruning on it.
 	 */
 	bt_set_frame_slot(&env->bt, key->frameno, spi);
-	err = mark_chain_precision_batch(env);
+	err = mark_chain_precision_batch(env, env->cur_state);
 	if (err < 0)
 		return err;
 
@@ -18914,7 +18916,7 @@ static int propagate_precision(struct bpf_verifier_env *env,
 			verbose(env, "\n");
 	}
 
-	err = mark_chain_precision_batch(env);
+	err = mark_chain_precision_batch(env, env->cur_state);
 	if (err < 0)
 		return err;
 
-- 
2.48.1


