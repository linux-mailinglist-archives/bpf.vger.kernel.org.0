Return-Path: <bpf+bounces-45315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB8B9D4525
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 01:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95901F2230A
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 00:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBB87080D;
	Thu, 21 Nov 2024 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLFhSCRl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036BE2F2A
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 00:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732150418; cv=none; b=UvfHwfbyl9GyQru62bduzpNRXbyKgXKLk1DRSiKieCSJWa2w4+cbsva1ibUaVPovfc1l+zORRvNr0ptHaCKd46IRZuqTtnUfSsTe4xm2sjH49E1GwBl71wrjW8Zrbf9dHmtkF7UreTVQtuK7QlQc/K4pjNC4WJb/0CPQ62OBKrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732150418; c=relaxed/simple;
	bh=b8tjPt3MWtFkErilVsIILgSbweRdo8W0KiAwJECfgkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8SiVmXeREQw0R1NT6oxH1dGAzwFju4vPfZmRaJ+/oAzvo5iXPEnTPKPCQd6Q6dMOF0O6o4iIBWajUbax/5wQIpieGQc+EIWKW12U8iMMCtypsdocT3NJR1S+/mljkjPbJg3z5O3o/ORi6R1szqnsVMCNULiccwDogdmUsXbasI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLFhSCRl; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-38241435528so189324f8f.2
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 16:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732150415; x=1732755215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ez7TQzJKD8KdtjksJYcqlg5pJuJ8gA74Da2TBHhaJl0=;
        b=OLFhSCRlxwxF5lYnjhvqTA3ZJsfteiHIdiRnN+P9+2ks77nXPVD8W4zgYizhtvTVrB
         PtB6O5IfjTnlQv8vFZ0jmOcQtEQ4m6QdQ6kBVp14PX3crb4VK5euGn9Tf4lPaq3H+JGA
         DuDMm6UET4KlNJeD84ocRTWorfMa8/q8xybVyVj1Bwki+9H2S3Epmol29kMfATWtTJ/d
         TtUFpfuqe4YAkl3v5M8zJ0p288Ogo3Q9wxm1TboQkXoBo1UyRdaTUyl9qNcIKAIimj0/
         sHFs966hAhYOMUZcge9G9wWu2O/I5x3thTJeHRma+jz5ArkK4bw1N54ayIt0wznf1mQo
         NscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732150415; x=1732755215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ez7TQzJKD8KdtjksJYcqlg5pJuJ8gA74Da2TBHhaJl0=;
        b=pEUQEzymr8Kn3uUjYeQKqdymCc0AZyMfjtS0cHqPZEQdkhnBwC580STvZxEpM4bk4G
         zvihS1XLk7lPHFFw41kMj7WmBHEEsh1vIdB1X1anbAEiPCi2Jr6jcMcbh6Mf0Y7dyozb
         C+KfTkzguhFvGuxWyxltSKAdnRy+Rm8/SpHYA2r2qZzYwr0AjSUIxOA5fOJSJmzWmbI0
         PBb+p1xe1FBiA2quXAymSggI6ezQeCs6PlOUtJRqM0YNjqMsp8hd65ivlbDruGTWZ+Xo
         S6pTTrbAKvbmc2C6iJbVDRhHOjQVtqmJMTeD7agCHXrpVlTcj+TPzD2FTK/xGnUdQohO
         VYmA==
X-Gm-Message-State: AOJu0YySvOi4xWScfXnzPC6WmYcbNeq0zoaZtwZbLed3dfjvq5WrVfrY
	TJYoHsjDCmF39kKPrOFXDX5G8rRRD9OJUkQzR/JKYhRSV3Ur57TXMhwCJhIb6Jk=
X-Google-Smtp-Source: AGHT+IHFo8pCfMUwj622xpFctQfjLnkXqVCakjUUDgyYOgtvrl4F9UmrEztmxpUynyKMDVA/xX930g==
X-Received: by 2002:a5d:6da7:0:b0:382:512b:baff with SMTP id ffacd0b85a97d-38254b266a6mr4027408f8f.59.1732150414976;
        Wed, 20 Nov 2024 16:53:34 -0800 (PST)
Received: from localhost (fwdproxy-cln-024.fbsv.net. [2a03:2880:31ff:18::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825494ca3fsm3406758f8f.111.2024.11.20.16.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 16:53:34 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v1 3/7] bpf: Consolidate RCU and preempt locks in bpf_func_state
Date: Wed, 20 Nov 2024 16:53:25 -0800
Message-ID: <20241121005329.408873-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241121005329.408873-1-memxor@gmail.com>
References: <20241121005329.408873-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7478; h=from:subject; bh=b8tjPt3MWtFkErilVsIILgSbweRdo8W0KiAwJECfgkE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnPoQ2WCvqobNq0K4IgIMwfEKPSiBDqlPbysEkxcwX jsFLfnmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZz6ENgAKCRBM4MiGSL8Ryr+XD/ wI/iE60rLeQ358ckPmwfCGbGhaOLwAIOdypd3uE3PKlAjNi3DxZH2AUxyPCooD9c4LOmvYsM6r5dTd 9J5nkectM/94Y9aqcy0wVcyAgF6pVz0/C88/oJ7bAekgX7BWwK0CJbXy3bj6wF2vMtkvPgZC3u1I7w 9resjo/5Dz7/cFazt4wkJp8sNl5K1Y5HDKvGb4X8FfwehKbR05bgK6UVQi+y0EC+VpOaPUmnIWi2fa EmwSCsI0f9DznfNUea0iyH0yjiegzpl3Wep6iVCdEMrGPjfjDdAy0almUOMjPgPXipWzMLu/33gytO e581RS03nAXSmBSGIF2noTqrJLSL5RTP3iPTm/tS3yXYBM81JQKffZsFZr5tbBCXdRsHMZy94sY7J9 8nOCjt/Xh57GnGJiuqW9nP+gNXdCglzfo7EMdlAJwaHLmL46uq8me1xdSZm4/7vNRpv7357PQwNBLI 8u1OA9O+UKtRTsnLW0oFwzoDwYwyFNAndDA/2u9/aZQwFq+/CrhQ2dQbEDBp0OiDI5WGkG7uZu1u+W u+6aDZ1O1wXH/fx2LsX26Sd0wNaNlgiCA9XsOvpNUVjxN8jlwrv1C+mGoET0Qynz2BSd1aySpoKdAr mLOdSZuVONxnE8mx36UFflwz5eSw5sS58qJFEeX2FjRjuSUQhrH1meNZoe7w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

To ensure consistency in resource handling, move RCU and preemption
state counters to bpf_func_state, and convert all users to access them
through cur_func(env).

For the sake of consistency, also compare active_locks in ressafe as a
quick way to eliminate iteration and entry matching if the number of
locks are not the same.

OTOH, the comparison of active_preempt_locks and active_rcu_lock is
needed for correctness, as state exploration cannot be avoided if these
counters do not match, and not comparing them will lead to problems
since they lack an actual entry in the acquired_res array.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  4 ++--
 kernel/bpf/verifier.c        | 46 ++++++++++++++++++++----------------
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e5123b6804eb..fa09538a35bc 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -315,6 +315,8 @@ struct bpf_func_state {
 	/* The following fields should be last. See copy_func_state() */
 	int acquired_res;
 	int active_locks;
+	int active_preempt_locks;
+	bool active_rcu_lock;
 	struct bpf_resource_state *res;
 	/* The state of the stack. Each element of the array describes BPF_REG_SIZE
 	 * (i.e. 8) bytes worth of stack memory.
@@ -418,8 +420,6 @@ struct bpf_verifier_state {
 	u32 curframe;
 
 	bool speculative;
-	bool active_rcu_lock;
-	u32 active_preempt_lock;
 	/* If this state was ever pointed-to by other state's loop_entry field
 	 * this flag would be set to true. Used to avoid freeing such states
 	 * while they are still in use.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0ff436c06c13..25c44b68f16a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1287,7 +1287,10 @@ static int copy_resource_state(struct bpf_func_state *dst, const struct bpf_func
 		return -ENOMEM;
 
 	dst->acquired_res = src->acquired_res;
+
 	dst->active_locks = src->active_locks;
+	dst->active_preempt_locks = src->active_preempt_locks;
+	dst->active_rcu_lock = src->active_rcu_lock;
 	return 0;
 }
 
@@ -1504,8 +1507,6 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 		dst_state->frame[i] = NULL;
 	}
 	dst_state->speculative = src->speculative;
-	dst_state->active_rcu_lock = src->active_rcu_lock;
-	dst_state->active_preempt_lock = src->active_preempt_lock;
 	dst_state->in_sleepable = src->in_sleepable;
 	dst_state->curframe = src->curframe;
 	dst_state->branches = src->branches;
@@ -5505,7 +5506,7 @@ static bool in_sleepable(struct bpf_verifier_env *env)
  */
 static bool in_rcu_cs(struct bpf_verifier_env *env)
 {
-	return env->cur_state->active_rcu_lock ||
+	return cur_func(env)->active_rcu_lock ||
 	       cur_func(env)->active_locks ||
 	       !in_sleepable(env);
 }
@@ -10009,7 +10010,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 
 		/* Only global subprogs cannot be called with preemption disabled. */
-		if (env->cur_state->active_preempt_lock) {
+		if (cur_func(env)->active_preempt_locks) {
 			verbose(env, "global function calls are not allowed with preemption disabled,\n"
 				     "use static function instead\n");
 			return -EINVAL;
@@ -10544,12 +10545,12 @@ static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit
 		return err;
 	}
 
-	if (check_lock && env->cur_state->active_rcu_lock) {
+	if (check_lock && cur_func(env)->active_rcu_lock) {
 		verbose(env, "%s cannot be used inside bpf_rcu_read_lock-ed region\n", prefix);
 		return -EINVAL;
 	}
 
-	if (check_lock && env->cur_state->active_preempt_lock) {
+	if (check_lock && cur_func(env)->active_preempt_locks) {
 		verbose(env, "%s cannot be used inside bpf_preempt_disable-ed region\n", prefix);
 		return -EINVAL;
 	}
@@ -10726,7 +10727,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return err;
 	}
 
-	if (env->cur_state->active_rcu_lock) {
+	if (cur_func(env)->active_rcu_lock) {
 		if (fn->might_sleep) {
 			verbose(env, "sleepable helper %s#%d in rcu_read_lock region\n",
 				func_id_name(func_id), func_id);
@@ -10737,7 +10738,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
 	}
 
-	if (env->cur_state->active_preempt_lock) {
+	if (cur_func(env)->active_preempt_locks) {
 		if (fn->might_sleep) {
 			verbose(env, "sleepable helper %s#%d in non-preemptible region\n",
 				func_id_name(func_id), func_id);
@@ -12767,7 +12768,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	preempt_disable = is_kfunc_bpf_preempt_disable(&meta);
 	preempt_enable = is_kfunc_bpf_preempt_enable(&meta);
 
-	if (env->cur_state->active_rcu_lock) {
+	if (cur_func(env)->active_rcu_lock) {
 		struct bpf_func_state *state;
 		struct bpf_reg_state *reg;
 		u32 clear_mask = (1 << STACK_SPILL) | (1 << STACK_ITER);
@@ -12787,29 +12788,29 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 					reg->type |= PTR_UNTRUSTED;
 				}
 			}));
-			env->cur_state->active_rcu_lock = false;
+			cur_func(env)->active_rcu_lock = false;
 		} else if (sleepable) {
 			verbose(env, "kernel func %s is sleepable within rcu_read_lock region\n", func_name);
 			return -EACCES;
 		}
 	} else if (rcu_lock) {
-		env->cur_state->active_rcu_lock = true;
+		cur_func(env)->active_rcu_lock = true;
 	} else if (rcu_unlock) {
 		verbose(env, "unmatched rcu read unlock (kernel function %s)\n", func_name);
 		return -EINVAL;
 	}
 
-	if (env->cur_state->active_preempt_lock) {
+	if (cur_func(env)->active_preempt_locks) {
 		if (preempt_disable) {
-			env->cur_state->active_preempt_lock++;
+			cur_func(env)->active_preempt_locks++;
 		} else if (preempt_enable) {
-			env->cur_state->active_preempt_lock--;
+			cur_func(env)->active_preempt_locks--;
 		} else if (sleepable) {
 			verbose(env, "kernel func %s is sleepable within non-preemptible region\n", func_name);
 			return -EACCES;
 		}
 	} else if (preempt_disable) {
-		env->cur_state->active_preempt_lock++;
+		cur_func(env)->active_preempt_locks++;
 	} else if (preempt_enable) {
 		verbose(env, "unmatched attempt to enable preemption (kernel function %s)\n", func_name);
 		return -EINVAL;
@@ -17768,6 +17769,15 @@ static bool ressafe(struct bpf_func_state *old, struct bpf_func_state *cur,
 	if (old->acquired_res != cur->acquired_res)
 		return false;
 
+	if (old->active_locks != cur->active_locks)
+		return false;
+
+	if (old->active_preempt_locks != cur->active_preempt_locks)
+		return false;
+
+	if (old->active_rcu_lock != cur->active_rcu_lock)
+		return false;
+
 	for (i = 0; i < old->acquired_res; i++) {
 		if (!check_ids(old->res[i].id, cur->res[i].id, idmap) ||
 		    old->res[i].type != cur->res[i].type)
@@ -17860,12 +17870,6 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->speculative && !cur->speculative)
 		return false;
 
-	if (old->active_rcu_lock != cur->active_rcu_lock)
-		return false;
-
-	if (old->active_preempt_lock != cur->active_preempt_lock)
-		return false;
-
 	if (old->in_sleepable != cur->in_sleepable)
 		return false;
 
-- 
2.43.5


