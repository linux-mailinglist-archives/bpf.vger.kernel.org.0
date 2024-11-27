Return-Path: <bpf+bounces-45763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 004B39DAEFA
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 22:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62569162590
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 21:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BFC20010A;
	Wed, 27 Nov 2024 21:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ht5rSZFo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D3E2036ED
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 21:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732743344; cv=none; b=T8mv16T6Twowwo7TaH74pGAO67ZvrhCNthbrjpu6Ul7EPmZ7H7uBAznQK2ihb+s2DXPVloecZxsEnP7ojF39Yx9xgZjHX+MJfy9364vs7izd92Iefx/4SrXj5d9wXUjtJ621SLcL4FgiBMyytsB+fb4YKdbNXhvkUKk8F7FcEqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732743344; c=relaxed/simple;
	bh=haXHBIw+IAeTSlGBb0DWF0SoN+arpIfSKJ65ihAMstA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDS6KQCE9EakcaLGWbbw7C6qZolN8NB45vf7CXR7dW1DrLSeMui7gp/+pJevYf4EW2INtXygEsVWJ7PQd6e8uaUWl+4kA72ux3nuzWONL7TG2HBwF8zD9KY4M8G7tC6b3lMSSl7KRSLLfumgMJL+MA/JcB5pwTIH4j6oOo7hR08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ht5rSZFo; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-434ab114753so1121845e9.0
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 13:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732743340; x=1733348140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GeYHbLohCgWUukG+5zybVEDFJ+Pso3FMFyO/WP56Ps=;
        b=ht5rSZFoG6XK4trOJe1Z4dY0REri6LLg/rfIFpZzleHtWbASO2P3wdRXak4fctFr3A
         ESiosp+Jmr2BQQ03h4irpt3SW076gNWTk/xOnx2SSHkve2vqxKO5Zs1PPQ5nXUJTvTP+
         DkSOcPMBvT6jbB/UThSFsqlDFZb4oS/b8AyYLUscwa+yO3VEjiYzs2OxwzcBqR1Hf+Ko
         96rqmUg9wXZRHl5TG0Qi0ZZgrzk0G5xy0za5PalvYFg2W+vBoaGtpnJUl2BuqoYXCcne
         CG30MN1FYsbw9tWUzASQK64W1faEQrjfj1oYCdU2UT/Ef1MF/JYH8z0CKH+5lvrS9XSq
         PUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732743340; x=1733348140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GeYHbLohCgWUukG+5zybVEDFJ+Pso3FMFyO/WP56Ps=;
        b=I8YFqmarvyym780UqRnq2yYn2D7WU5czckZjYhNAlN3vvCHZxlX6eV073VQf2q0Bp9
         rDfNqpxo9VPscP1bo2M1DxlHhEEFKv7vqP2Vpo+8cqDPzU8cz00MWq1v087ve7YnMGmm
         NypW1enDa6JZlMJ6ow3o0DCI2wxDOKB3bf1rkVLgcR4Q6dw4lQ/qImt7AZZ4ROcnzzPP
         ev27d5x1IyQKVZO/RAKACeAiD/vKIon/3sf60CDKpV9cfuyihhNQj7uoLzOCKakM2iY4
         iC0W6+TLezqHXeNqwImtggeAwhYh9NBu/PxKJ4ItDWTQ9rxkgh6EMDjit5Uf3C1sxXbP
         vwrg==
X-Gm-Message-State: AOJu0YyR4OJc5dI1cR5WPFYxANmU88P2nSYYt3wnhUMtKdTduSsASZp4
	oO465ZwwxmNFqW7y9Q2nVxQd7KNnkI7QC6wwCalEe34txzJJ4v/Q+489t77bLTY=
X-Gm-Gg: ASbGncsaLWB0dHB1Zs0H+rLHquFSJEifuiwdI58siCoEW+l7gf39TaCZnl7+xHG+e+f
	rWjdqy1J8wwsonAGvvb1NjiOUTZURDuG5mUg1tqMi8OThL20a3DjWoLi4bYJ1Xl7UMtsTZa/Wr8
	wnnx7GS60s3Wj1pgCMQaxuFcBVCLVWIe//5fTni1zysUrFQk9athoPjw2y6y/UurME9Fn+W0rfP
	mQig81rT1lGuQw5ZAJES4faVEeu0xvaVz8eVHOYn5nq7tcAMJ7GPu3ZOWpy1ft9hM9dYS8rifZ+
	EQ==
X-Google-Smtp-Source: AGHT+IHi06BxKwRvZbAOlxkuze0LNCz5rpJO2Jz/Gv35cJtL5bPQA472pzoMMelrigMrQ3T3Me3Wkg==
X-Received: by 2002:a05:600c:4f49:b0:431:52a3:d9d9 with SMTP id 5b1f17b1804b1-434a9d4fa7dmr46582995e9.0.1732743338592;
        Wed, 27 Nov 2024 13:35:38 -0800 (PST)
Received: from localhost (fwdproxy-cln-029.fbsv.net. [2a03:2880:31ff:1d::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74f1f6sm33580475e9.8.2024.11.27.13.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 13:35:37 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 1/7] bpf: Consolidate locks and reference state in verifier state
Date: Wed, 27 Nov 2024 13:35:29 -0800
Message-ID: <20241127213535.3657472-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127213535.3657472-1-memxor@gmail.com>
References: <20241127213535.3657472-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18177; h=from:subject; bh=haXHBIw+IAeTSlGBb0DWF0SoN+arpIfSKJ65ihAMstA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR46tfgemBNPfsR0Yb6UDrTC83hnQitfVQ5N6J088 gT1qzUuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0eOrQAKCRBM4MiGSL8RypXXEA CumKI6upqYhOMsZ3ljSjKyeGTMkMquQw2o+rtm2M7ZEDQwlgucMfNI2AuwsYEbZHkD/vAy4aXXTnoF K4b5DK03QxJ69GK/tFOcYnAjliTiT7Pw2YmippD/I/wO6bwGja39E6ZN9KyDoYWZm2LuaU1cybxC2q pSAVuABUG6IsjS3/rrTf7W0jiVvqx3rGXhbyVKdnnfXD5r4UMqQ1mOrfKxJEeXPsx2UX+yEmKvOQog ywUBVxg0W3qjEAUDkyA5Hm0X31izXlxiv+DfP5OyG3+NE1uJjqH07b5f+Km3OVECPPLBypjrJ0esDM PitJ6WUHq5FnJuacaZpvQmi7m2mg2k6Gh1gajXih6+8wp7UhCjEcGIEazytraPknt2EZ+/AAETTfEa bdNK/i+cfx4+fZmjuCcvLIKt/lo5ymVvPcSAgmvGeaIk+ngoKAOFQh8oUfl8NRm6cMnTZmL1B4eLlT OkNh37SQ+7w6aiuGDs+t9l+PMIAvnJIWdOsmjZHPx01zm/uj0rhifhMK2g96J5QweWIaf0d7Y90Jvr ceWM1Zlchj2oBmwC5K6aomo0H/FjzWOHLjiSUvVWgSifFxfD2lopQ50S/CJV5AhuVyEOS1V6lU/5EL SKRGVaYut4s0csLH8gIxXfqbAjUmEQrPlMuIHKkPaGf1mVged4znPnjAJzkw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Currently, state for RCU read locks and preemption is in
bpf_verifier_state, while locks and pointer reference state remains in
bpf_func_state. There is no particular reason to keep the latter in
bpf_func_state. Additionally, it is copied into a new frame's state and
copied back to the caller frame's state everytime the verifier processes
a pseudo call instruction. This is a bit wasteful, given this state is
global for a given verification state / path.

Move all resource and reference related state in bpf_verifier_state
structure in this patch, in preparation for introducing new reference
state types in the future.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  11 ++--
 kernel/bpf/log.c             |  11 ++--
 kernel/bpf/verifier.c        | 112 ++++++++++++++++-------------------
 3 files changed, 64 insertions(+), 70 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f4290c179bee..af64b5415df8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -315,9 +315,6 @@ struct bpf_func_state {
 	u32 callback_depth;
 
 	/* The following fields should be last. See copy_func_state() */
-	int acquired_refs;
-	int active_locks;
-	struct bpf_reference_state *refs;
 	/* The state of the stack. Each element of the array describes BPF_REG_SIZE
 	 * (i.e. 8) bytes worth of stack memory.
 	 * stack[0] represents bytes [*(r10-8)..*(r10-1)]
@@ -419,9 +416,13 @@ struct bpf_verifier_state {
 	u32 insn_idx;
 	u32 curframe;
 
-	bool speculative;
+	struct bpf_reference_state *refs;
+	u32 acquired_refs;
+	u32 active_locks;
+	u32 active_preempt_locks;
 	bool active_rcu_lock;
-	u32 active_preempt_lock;
+
+	bool speculative;
 	/* If this state was ever pointed-to by other state's loop_entry field
 	 * this flag would be set to true. Used to avoid freeing such states
 	 * while they are still in use.
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 4a858fdb6476..8b52e5b7504c 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -756,6 +756,7 @@ static void print_reg_state(struct bpf_verifier_env *env,
 void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_func_state *state,
 			  bool print_all)
 {
+	struct bpf_verifier_state *vstate = env->cur_state;
 	const struct bpf_reg_state *reg;
 	int i;
 
@@ -843,11 +844,11 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_func_st
 			break;
 		}
 	}
-	if (state->acquired_refs && state->refs[0].id) {
-		verbose(env, " refs=%d", state->refs[0].id);
-		for (i = 1; i < state->acquired_refs; i++)
-			if (state->refs[i].id)
-				verbose(env, ",%d", state->refs[i].id);
+	if (vstate->acquired_refs && vstate->refs[0].id) {
+		verbose(env, " refs=%d", vstate->refs[0].id);
+		for (i = 1; i < vstate->acquired_refs; i++)
+			if (vstate->refs[i].id)
+				verbose(env, ",%d", vstate->refs[i].id);
 	}
 	if (state->in_callback_fn)
 		verbose(env, " cb");
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c4ebb326785..f8313e95eb8e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1279,15 +1279,17 @@ static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
 	return arr ? arr : ZERO_SIZE_PTR;
 }
 
-static int copy_reference_state(struct bpf_func_state *dst, const struct bpf_func_state *src)
+static int copy_reference_state(struct bpf_verifier_state *dst, const struct bpf_verifier_state *src)
 {
 	dst->refs = copy_array(dst->refs, src->refs, src->acquired_refs,
 			       sizeof(struct bpf_reference_state), GFP_KERNEL);
 	if (!dst->refs)
 		return -ENOMEM;
 
-	dst->active_locks = src->active_locks;
 	dst->acquired_refs = src->acquired_refs;
+	dst->active_locks = src->active_locks;
+	dst->active_preempt_locks = src->active_preempt_locks;
+	dst->active_rcu_lock = src->active_rcu_lock;
 	return 0;
 }
 
@@ -1304,7 +1306,7 @@ static int copy_stack_state(struct bpf_func_state *dst, const struct bpf_func_st
 	return 0;
 }
 
-static int resize_reference_state(struct bpf_func_state *state, size_t n)
+static int resize_reference_state(struct bpf_verifier_state *state, size_t n)
 {
 	state->refs = realloc_array(state->refs, state->acquired_refs, n,
 				    sizeof(struct bpf_reference_state));
@@ -1349,7 +1351,7 @@ static int grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state
  */
 static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
 {
-	struct bpf_func_state *state = cur_func(env);
+	struct bpf_verifier_state *state = env->cur_state;
 	int new_ofs = state->acquired_refs;
 	int id, err;
 
@@ -1367,7 +1369,7 @@ static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
 static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum ref_state_type type,
 			      int id, void *ptr)
 {
-	struct bpf_func_state *state = cur_func(env);
+	struct bpf_verifier_state *state = env->cur_state;
 	int new_ofs = state->acquired_refs;
 	int err;
 
@@ -1384,7 +1386,7 @@ static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum r
 }
 
 /* release function corresponding to acquire_reference_state(). Idempotent. */
-static int release_reference_state(struct bpf_func_state *state, int ptr_id)
+static int release_reference_state(struct bpf_verifier_state *state, int ptr_id)
 {
 	int i, last_idx;
 
@@ -1404,7 +1406,7 @@ static int release_reference_state(struct bpf_func_state *state, int ptr_id)
 	return -EINVAL;
 }
 
-static int release_lock_state(struct bpf_func_state *state, int type, int id, void *ptr)
+static int release_lock_state(struct bpf_verifier_state *state, int type, int id, void *ptr)
 {
 	int i, last_idx;
 
@@ -1425,10 +1427,9 @@ static int release_lock_state(struct bpf_func_state *state, int type, int id, vo
 	return -EINVAL;
 }
 
-static struct bpf_reference_state *find_lock_state(struct bpf_verifier_env *env, enum ref_state_type type,
+static struct bpf_reference_state *find_lock_state(struct bpf_verifier_state *state, enum ref_state_type type,
 						   int id, void *ptr)
 {
-	struct bpf_func_state *state = cur_func(env);
 	int i;
 
 	for (i = 0; i < state->acquired_refs; i++) {
@@ -1447,7 +1448,6 @@ static void free_func_state(struct bpf_func_state *state)
 {
 	if (!state)
 		return;
-	kfree(state->refs);
 	kfree(state->stack);
 	kfree(state);
 }
@@ -1461,6 +1461,7 @@ static void free_verifier_state(struct bpf_verifier_state *state,
 		free_func_state(state->frame[i]);
 		state->frame[i] = NULL;
 	}
+	kfree(state->refs);
 	if (free_self)
 		kfree(state);
 }
@@ -1471,12 +1472,7 @@ static void free_verifier_state(struct bpf_verifier_state *state,
 static int copy_func_state(struct bpf_func_state *dst,
 			   const struct bpf_func_state *src)
 {
-	int err;
-
-	memcpy(dst, src, offsetof(struct bpf_func_state, acquired_refs));
-	err = copy_reference_state(dst, src);
-	if (err)
-		return err;
+	memcpy(dst, src, offsetof(struct bpf_func_state, stack));
 	return copy_stack_state(dst, src);
 }
 
@@ -1493,9 +1489,10 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 		free_func_state(dst_state->frame[i]);
 		dst_state->frame[i] = NULL;
 	}
+	err = copy_reference_state(dst_state, src);
+	if (err)
+		return err;
 	dst_state->speculative = src->speculative;
-	dst_state->active_rcu_lock = src->active_rcu_lock;
-	dst_state->active_preempt_lock = src->active_preempt_lock;
 	dst_state->in_sleepable = src->in_sleepable;
 	dst_state->curframe = src->curframe;
 	dst_state->branches = src->branches;
@@ -5496,7 +5493,7 @@ static bool in_sleepable(struct bpf_verifier_env *env)
 static bool in_rcu_cs(struct bpf_verifier_env *env)
 {
 	return env->cur_state->active_rcu_lock ||
-	       cur_func(env)->active_locks ||
+	       env->cur_state->active_locks ||
 	       !in_sleepable(env);
 }
 
@@ -7850,15 +7847,15 @@ static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg
  * Since only one bpf_spin_lock is allowed the checks are simpler than
  * reg_is_refcounted() logic. The verifier needs to remember only
  * one spin_lock instead of array of acquired_refs.
- * cur_func(env)->active_locks remembers which map value element or allocated
+ * env->cur_state->active_locks remembers which map value element or allocated
  * object got locked and clears it after bpf_spin_unlock.
  */
 static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 			     bool is_lock)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_verifier_state *cur = env->cur_state;
 	bool is_const = tnum_is_const(reg->var_off);
-	struct bpf_func_state *cur = cur_func(env);
 	u64 val = reg->var_off.value;
 	struct bpf_map *map = NULL;
 	struct btf *btf = NULL;
@@ -7925,7 +7922,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 			return -EINVAL;
 		}
 
-		if (release_lock_state(cur_func(env), REF_TYPE_LOCK, reg->id, ptr)) {
+		if (release_lock_state(env->cur_state, REF_TYPE_LOCK, reg->id, ptr)) {
 			verbose(env, "bpf_spin_unlock of different lock\n");
 			return -EINVAL;
 		}
@@ -9679,7 +9676,7 @@ static int release_reference(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg;
 	int err;
 
-	err = release_reference_state(cur_func(env), ref_obj_id);
+	err = release_reference_state(env->cur_state, ref_obj_id);
 	if (err)
 		return err;
 
@@ -9757,9 +9754,7 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 			callsite,
 			state->curframe + 1 /* frameno within this callchain */,
 			subprog /* subprog number within this prog */);
-	/* Transfer references to the callee */
-	err = copy_reference_state(callee, caller);
-	err = err ?: set_callee_state_cb(env, caller, callee, callsite);
+	err = set_callee_state_cb(env, caller, callee, callsite);
 	if (err)
 		goto err_out;
 
@@ -9992,14 +9987,14 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		const char *sub_name = subprog_name(env, subprog);
 
 		/* Only global subprogs cannot be called with a lock held. */
-		if (cur_func(env)->active_locks) {
+		if (env->cur_state->active_locks) {
 			verbose(env, "global function calls are not allowed while holding a lock,\n"
 				     "use static function instead\n");
 			return -EINVAL;
 		}
 
 		/* Only global subprogs cannot be called with preemption disabled. */
-		if (env->cur_state->active_preempt_lock) {
+		if (env->cur_state->active_preempt_locks) {
 			verbose(env, "global function calls are not allowed with preemption disabled,\n"
 				     "use static function instead\n");
 			return -EINVAL;
@@ -10333,11 +10328,6 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 		caller->regs[BPF_REG_0] = *r0;
 	}
 
-	/* Transfer references to the caller */
-	err = copy_reference_state(caller, callee);
-	if (err)
-		return err;
-
 	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to callsite,
 	 * there function call logic would reschedule callback visit. If iteration
 	 * converges is_state_visited() would prune that visit eventually.
@@ -10502,11 +10492,11 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 
 static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exit)
 {
-	struct bpf_func_state *state = cur_func(env);
+	struct bpf_verifier_state *state = env->cur_state;
 	bool refs_lingering = false;
 	int i;
 
-	if (!exception_exit && state->frameno)
+	if (!exception_exit && cur_func(env)->frameno)
 		return 0;
 
 	for (i = 0; i < state->acquired_refs; i++) {
@@ -10523,7 +10513,7 @@ static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit
 {
 	int err;
 
-	if (check_lock && cur_func(env)->active_locks) {
+	if (check_lock && env->cur_state->active_locks) {
 		verbose(env, "%s cannot be used inside bpf_spin_lock-ed region\n", prefix);
 		return -EINVAL;
 	}
@@ -10539,7 +10529,7 @@ static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit
 		return -EINVAL;
 	}
 
-	if (check_lock && env->cur_state->active_preempt_lock) {
+	if (check_lock && env->cur_state->active_preempt_locks) {
 		verbose(env, "%s cannot be used inside bpf_preempt_disable-ed region\n", prefix);
 		return -EINVAL;
 	}
@@ -10727,7 +10717,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
 	}
 
-	if (env->cur_state->active_preempt_lock) {
+	if (env->cur_state->active_preempt_locks) {
 		if (fn->might_sleep) {
 			verbose(env, "sleepable helper %s#%d in non-preemptible region\n",
 				func_id_name(func_id), func_id);
@@ -10784,7 +10774,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			struct bpf_func_state *state;
 			struct bpf_reg_state *reg;
 
-			err = release_reference_state(cur_func(env), ref_obj_id);
+			err = release_reference_state(env->cur_state, ref_obj_id);
 			if (!err) {
 				bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
 					if (reg->ref_obj_id == ref_obj_id) {
@@ -11746,7 +11736,7 @@ static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state
 {
 	struct btf_record *rec = reg_btf_record(reg);
 
-	if (!cur_func(env)->active_locks) {
+	if (!env->cur_state->active_locks) {
 		verbose(env, "verifier internal error: ref_set_non_owning w/o active lock\n");
 		return -EFAULT;
 	}
@@ -11765,12 +11755,11 @@ static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state
 
 static int ref_convert_owning_non_owning(struct bpf_verifier_env *env, u32 ref_obj_id)
 {
-	struct bpf_func_state *state, *unused;
+	struct bpf_verifier_state *state = env->cur_state;
+	struct bpf_func_state *unused;
 	struct bpf_reg_state *reg;
 	int i;
 
-	state = cur_func(env);
-
 	if (!ref_obj_id) {
 		verbose(env, "verifier internal error: ref_obj_id is zero for "
 			     "owning -> non-owning conversion\n");
@@ -11860,9 +11849,9 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
 	}
 	id = reg->id;
 
-	if (!cur_func(env)->active_locks)
+	if (!env->cur_state->active_locks)
 		return -EINVAL;
-	s = find_lock_state(env, REF_TYPE_LOCK, id, ptr);
+	s = find_lock_state(env->cur_state, REF_TYPE_LOCK, id, ptr);
 	if (!s) {
 		verbose(env, "held lock and object are not in the same allocation\n");
 		return -EINVAL;
@@ -12789,17 +12778,17 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EINVAL;
 	}
 
-	if (env->cur_state->active_preempt_lock) {
+	if (env->cur_state->active_preempt_locks) {
 		if (preempt_disable) {
-			env->cur_state->active_preempt_lock++;
+			env->cur_state->active_preempt_locks++;
 		} else if (preempt_enable) {
-			env->cur_state->active_preempt_lock--;
+			env->cur_state->active_preempt_locks--;
 		} else if (sleepable) {
 			verbose(env, "kernel func %s is sleepable within non-preemptible region\n", func_name);
 			return -EACCES;
 		}
 	} else if (preempt_disable) {
-		env->cur_state->active_preempt_lock++;
+		env->cur_state->active_preempt_locks++;
 	} else if (preempt_enable) {
 		verbose(env, "unmatched attempt to enable preemption (kernel function %s)\n", func_name);
 		return -EINVAL;
@@ -15398,7 +15387,7 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
 		 * No one could have freed the reference state before
 		 * doing the NULL check.
 		 */
-		WARN_ON_ONCE(release_reference_state(state, id));
+		WARN_ON_ONCE(release_reference_state(vstate, id));
 
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
 		mark_ptr_or_null_reg(state, reg, id, is_null);
@@ -17750,7 +17739,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 	return true;
 }
 
-static bool refsafe(struct bpf_func_state *old, struct bpf_func_state *cur,
+static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *cur,
 		    struct bpf_idmap *idmap)
 {
 	int i;
@@ -17758,6 +17747,15 @@ static bool refsafe(struct bpf_func_state *old, struct bpf_func_state *cur,
 	if (old->acquired_refs != cur->acquired_refs)
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
 	for (i = 0; i < old->acquired_refs; i++) {
 		if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap) ||
 		    old->refs[i].type != cur->refs[i].type)
@@ -17820,9 +17818,6 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
 		return false;
 
-	if (!refsafe(old, cur, &env->idmap_scratch))
-		return false;
-
 	return true;
 }
 
@@ -17850,13 +17845,10 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->speculative && !cur->speculative)
 		return false;
 
-	if (old->active_rcu_lock != cur->active_rcu_lock)
-		return false;
-
-	if (old->active_preempt_lock != cur->active_preempt_lock)
+	if (old->in_sleepable != cur->in_sleepable)
 		return false;
 
-	if (old->in_sleepable != cur->in_sleepable)
+	if (!refsafe(old, cur, &env->idmap_scratch))
 		return false;
 
 	/* for states to be equal callsites have to be the same
@@ -18751,7 +18743,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (cur_func(env)->active_locks) {
+				if (env->cur_state->active_locks) {
 					if ((insn->src_reg == BPF_REG_0 && insn->imm != BPF_FUNC_spin_unlock) ||
 					    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
 					     (insn->off != 0 || !is_bpf_graph_api_kfunc(insn->imm)))) {
-- 
2.43.5


