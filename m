Return-Path: <bpf+bounces-46048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AE29E31C4
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 04:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73DB028470C
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 03:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBA7137923;
	Wed,  4 Dec 2024 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASAQLwGk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371C93A1B5
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 03:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281451; cv=none; b=Qd+QD87DWFU9OiIAfs7oL6EjzpzT8647jw2FiNYxXWdKRvWcq3ILMRJCJkSDj5UACGCRw/xQ8P+FSyQW9NTbAUozZ9HyITa8et6PnC9nfPNd/YkVm4C7iNX0S0mrKM4W7Tvok+U9hBegphH8rWQ3QT9m1vCwgY4mKblv5FQ85GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281451; c=relaxed/simple;
	bh=iEVu8kmSZyLeJeiEoglbCCB6IHu0xSeC3JqgT9TdIHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0WjYbgXNoI514Lwvr4dm/rLu3mWjI3gTEqNtukCpnUiJJlfj3VBQtj9j0DRVCx/05oWDVf9nRUiZGoW1ApK3AXG/cYUkt5yxW8KsN3Cfb+Qgks14z6r0vuDeljRh+D9xWJfRRBBkGIV90ybIE1jB5dSnx8lGllV9u+yZBf6LgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASAQLwGk; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso4271050f8f.1
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 19:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733281447; x=1733886247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60lXYy4/0XzCplNgdhpSsswOi6BXdkBKKPAUudO2oJo=;
        b=ASAQLwGk3nOlhFFCPbULwdl4urbaU4KJSts+cp9BDlwalWpBKRPQ/Ulu2kV6tA9kok
         0ZXCWXHyXZDx5NCrg2DCT0Pjyl2RMugC073BXvkP8/0cIuAqHvjzq7l1lrXAaIHp88nW
         xDckwT+Nd0izSy0sbIDPisoPSR75tUVUj17bGkO7UmpsllKfxaqoyI25oaB6/u6vMwZL
         HOo1GBFQpyns+DLxaBZ264xGduz4EcrzYT7dFw77FBMLD9oldcBewH/IliuH2/z8oSYR
         GBzw4fNIk+tCnvsqupgwWCCchZkIxa/QiOuFxGfVxDD6TnTasWc00YbDG049r/7XcpjK
         sJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733281447; x=1733886247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60lXYy4/0XzCplNgdhpSsswOi6BXdkBKKPAUudO2oJo=;
        b=Ai183GknSxPrsd+XFDLCAWi1V2WQ4kX+r4UqfCCRLNX5AJp3u6W+qTatk5kGYbTJwl
         JaUGhATmSB5V1md0BHbQmnkxFqP6Ma9s6x0X2BPIpUOWcUjqk6cN+CV9oqB71V5CSCA2
         pP6S+U6GlO9vpclnlOlCaJdKxh5GhaKKLSBromw3T+CrSsTRHKnaBsrJ3b7oNL5Klx/E
         51NHgywbv4zUr7REYOSyjhD2V5yDen0/bGgz1BBj9a1B9SFmH3dm9QUcfZm0Cy8pANT9
         StnZsNh0L7peROqmKDY0AlECDYYkN/YjkeDhSXXO8U8Lb07hV/cP9G0MgPnvGEIXry47
         Zsvg==
X-Gm-Message-State: AOJu0YxyEzqA+uRjD78sT93ous9d71yx8CDqsxcTz/riPXeOBr3phKqS
	tLAOTJ07/jnPwhtYSebLGJq+GV8qxv2vDlS9FjW6mUI4Vb5Q1pxBLm1Va/nsZGA=
X-Gm-Gg: ASbGncvCQXwKePdt6rd3loP5jE4i2Gf0ghRqL5CozzRaWBWq/tDagF5foAH+n9ylBkY
	sjxPsjQheVO+7EazmXUrUHE/Wk2sW14Rh6RczIs4aS917OV9cB+XyiYP9uySxDvs6Ti/nN0MD9A
	9yr5alxeZP6Pq/0jnSuPJxxyiHts1pbZte0Ml3/OF2aeTNE342hgXApRXZHOhzGs5qEcPdujYz2
	mBokJ1zfp3j7Yd2zE/kEuqc73Mf1tVlv5dbLIeem8CR7zubziSJAbqJ5itpRhPWpjIqWG32L+eH
	sQ==
X-Google-Smtp-Source: AGHT+IGkPQaFSC6hCMqunTGlUIxiaH5OqVdboDmSXHYgnq3/MwmaDdmg3xy6hUqNsgFjoWJ4yVLgWg==
X-Received: by 2002:a5d:47a7:0:b0:382:4aa9:b620 with SMTP id ffacd0b85a97d-385fd3c6843mr3961208f8f.5.1733281446879;
        Tue, 03 Dec 2024 19:04:06 -0800 (PST)
Received: from localhost (fwdproxy-cln-033.fbsv.net. [2a03:2880:31ff:21::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385eaf1d099sm9878459f8f.61.2024.12.03.19.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 19:04:06 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 1/7] bpf: Consolidate locks and reference state in verifier state
Date: Tue,  3 Dec 2024 19:03:54 -0800
Message-ID: <20241204030400.208005-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204030400.208005-1-memxor@gmail.com>
References: <20241204030400.208005-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=24904; h=from:subject; bh=iEVu8kmSZyLeJeiEoglbCCB6IHu0xSeC3JqgT9TdIHw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnT8Q/LMwEt3JDzkWeqNT/RZVGqAqb5jy4Yn42Cxgh RnEl0FuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0/EPwAKCRBM4MiGSL8RygG6D/ 0V6vgaTsSN95rwrxdyAA+ZvlnKyvWoY9qDGio95tSFgUVqW3x3d9DOmMkhEshs5JC634gfGjqsmNpL mIIXSsxZmfNQqDHEHb7NX1goCt7qqmxgnAzPXWeaQjZRrt0nvOTpcGrFg8qiPFuE9VaBw54WD4YAib qOURxQRQTOgjl4fJYC4krSmBILWvOqS0LAidcI8wAdAfER/6tkDs2seJcOd2w1p2IdqnUHcq9VqmB/ XTN1UO1Kqawy2KZdH/CmAsXETcCUmkuGQLjaKhb2nLkF/hhdiYOMEwMSacUh9pErPfPVfnBMwwI843 71bNX6lum5k0vUt+W6fHWqlBajdMQWyL3Zb8GnMYMREUs5DzLwdJMPzKPbYhm4Y018HlS9eB2sfEcN OZNYS5J6buXfb68FJFp59Ah6f2bqQqigFxaNQIMkN60XA7Ow0O0aoLnHphjj5tU+xz5RtKzSIZNZju veBG3Tgqt6kEUu+U/m8nLWxpfKD6njCdWAYrqh5rhjfdKvFmsPDlpQqRYIMKeqx6apLmfJ72X0Z8Oh GMKQxP/WLsktkHPzvD6LtoBYVQeMP//yV16sxD9rTDpUcZt827UkW2e0Aig62uWp22GkQcjEfV6rht I+ilJM286qVG4wXiuqu6Sk/veRJeuAqgk+5TgXBGsE5YMUyfKKkt5q9RPw2A==
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

Since we switch print_verifier_state and friends to print using vstate,
we now need to explicitly pass in the verifier state from the caller
along with the bpf_func_state, so modify the prototype and callers to do
so. To ensure func state matches the verifier state when we're printing
data, take in frame number instead of bpf_func_state pointer instead and
avoid inconsistencies induced by the caller.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  19 +++--
 kernel/bpf/log.c             |  20 ++---
 kernel/bpf/verifier.c        | 140 +++++++++++++++++------------------
 3 files changed, 88 insertions(+), 91 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f4290c179bee..03e351c43fa8 100644
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
@@ -370,6 +367,8 @@ struct bpf_verifier_state {
 	/* call stack tracking */
 	struct bpf_func_state *frame[MAX_CALL_FRAMES];
 	struct bpf_verifier_state *parent;
+	/* Acquired reference states */
+	struct bpf_reference_state *refs;
 	/*
 	 * 'branches' field is the number of branches left to explore:
 	 * 0 - all possible paths from this state reached bpf_exit or
@@ -419,9 +418,12 @@ struct bpf_verifier_state {
 	u32 insn_idx;
 	u32 curframe;
 
-	bool speculative;
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
@@ -979,8 +981,9 @@ const char *dynptr_type_str(enum bpf_dynptr_type type);
 const char *iter_type_str(const struct btf *btf, u32 btf_id);
 const char *iter_state_str(enum bpf_iter_state state);
 
-void print_verifier_state(struct bpf_verifier_env *env,
-			  const struct bpf_func_state *state, bool print_all);
-void print_insn_state(struct bpf_verifier_env *env, const struct bpf_func_state *state);
+void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifier_state *vstate,
+			  u32 frameno, bool print_all);
+void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_state *vstate,
+		      u32 frameno);
 
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 4a858fdb6476..2d28ce926053 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -753,9 +753,10 @@ static void print_reg_state(struct bpf_verifier_env *env,
 	verbose(env, ")");
 }
 
-void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_func_state *state,
-			  bool print_all)
+void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifier_state *vstate,
+			  u32 frameno, bool print_all)
 {
+	const struct bpf_func_state *state = vstate->frame[frameno];
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
@@ -864,7 +865,8 @@ static inline u32 vlog_alignment(u32 pos)
 			BPF_LOG_MIN_ALIGNMENT) - pos - 1;
 }
 
-void print_insn_state(struct bpf_verifier_env *env, const struct bpf_func_state *state)
+void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_state *vstate,
+		      u32 frameno)
 {
 	if (env->prev_log_pos && env->prev_log_pos == env->log.end_pos) {
 		/* remove new line character */
@@ -873,5 +875,5 @@ void print_insn_state(struct bpf_verifier_env *env, const struct bpf_func_state
 	} else {
 		verbose(env, "%d:", env->insn_idx);
 	}
-	print_verifier_state(env, state, false);
+	print_verifier_state(env, vstate, frameno, false);
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c4ebb326785..019c56c782a2 100644
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
@@ -4499,7 +4496,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
 					       bt_frame_stack_mask(bt, fr));
 				verbose(env, "stack=%s: ", env->tmp_str_buf);
-				print_verifier_state(env, func, true);
+				print_verifier_state(env, st, fr, true);
 			}
 		}
 
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
@@ -10039,9 +10034,9 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (env->log.level & BPF_LOG_LEVEL) {
 		verbose(env, "caller:\n");
-		print_verifier_state(env, caller, true);
+		print_verifier_state(env, state, caller->frameno, true);
 		verbose(env, "callee:\n");
-		print_verifier_state(env, state->frame[state->curframe], true);
+		print_verifier_state(env, state, state->curframe, true);
 	}
 
 	return 0;
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
@@ -10350,9 +10340,9 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 
 	if (env->log.level & BPF_LOG_LEVEL) {
 		verbose(env, "returning from callee:\n");
-		print_verifier_state(env, callee, true);
+		print_verifier_state(env, state, callee->frameno, true);
 		verbose(env, "to caller at %d:\n", *insn_idx);
-		print_verifier_state(env, caller, true);
+		print_verifier_state(env, state, caller->frameno, true);
 	}
 	/* clear everything in the callee. In case of exceptional exits using
 	 * bpf_throw, this will be done by copy_verifier_state for extra frames. */
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
@@ -14495,12 +14484,12 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 
 	/* Got here implies adding two SCALAR_VALUEs */
 	if (WARN_ON_ONCE(ptr_reg)) {
-		print_verifier_state(env, state, true);
+		print_verifier_state(env, vstate, vstate->curframe, true);
 		verbose(env, "verifier internal error: unexpected ptr_reg\n");
 		return -EINVAL;
 	}
 	if (WARN_ON(!src_reg)) {
-		print_verifier_state(env, state, true);
+		print_verifier_state(env, vstate, vstate->curframe, true);
 		verbose(env, "verifier internal error: no src_reg\n");
 		return -EINVAL;
 	}
@@ -15398,7 +15387,7 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
 		 * No one could have freed the reference state before
 		 * doing the NULL check.
 		 */
-		WARN_ON_ONCE(release_reference_state(state, id));
+		WARN_ON_ONCE(release_reference_state(vstate, id));
 
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
 		mark_ptr_or_null_reg(state, reg, id, is_null);
@@ -15708,7 +15697,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 					       *insn_idx))
 			return -EFAULT;
 		if (env->log.level & BPF_LOG_LEVEL)
-			print_insn_state(env, this_branch->frame[this_branch->curframe]);
+			print_insn_state(env, this_branch, this_branch->curframe);
 		*insn_idx += insn->off;
 		return 0;
 	} else if (pred == 0) {
@@ -15722,7 +15711,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 					       *insn_idx))
 			return -EFAULT;
 		if (env->log.level & BPF_LOG_LEVEL)
-			print_insn_state(env, this_branch->frame[this_branch->curframe]);
+			print_insn_state(env, this_branch, this_branch->curframe);
 		return 0;
 	}
 
@@ -15839,7 +15828,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 	if (env->log.level & BPF_LOG_LEVEL)
-		print_insn_state(env, this_branch->frame[this_branch->curframe]);
+		print_insn_state(env, this_branch, this_branch->curframe);
 	return 0;
 }
 
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
@@ -18249,9 +18241,9 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				verbose_linfo(env, insn_idx, "; ");
 				verbose(env, "infinite loop detected at insn %d\n", insn_idx);
 				verbose(env, "cur state:");
-				print_verifier_state(env, cur->frame[cur->curframe], true);
+				print_verifier_state(env, cur, cur->curframe, true);
 				verbose(env, "old state:");
-				print_verifier_state(env, sl->state.frame[cur->curframe], true);
+				print_verifier_state(env, &sl->state, cur->curframe, true);
 				return -EINVAL;
 			}
 			/* if the verifier is processing a loop, avoid adding new state
@@ -18607,7 +18599,7 @@ static int do_check(struct bpf_verifier_env *env)
 				env->prev_insn_idx, env->insn_idx,
 				env->cur_state->speculative ?
 				" (speculative execution)" : "");
-			print_verifier_state(env, state->frame[state->curframe], true);
+			print_verifier_state(env, state, state->curframe, true);
 			do_print_state = false;
 		}
 
@@ -18619,7 +18611,7 @@ static int do_check(struct bpf_verifier_env *env)
 			};
 
 			if (verifier_state_scratched(env))
-				print_insn_state(env, state->frame[state->curframe]);
+				print_insn_state(env, state, state->curframe);
 
 			verbose_linfo(env, env->insn_idx, "; ");
 			env->prev_log_pos = env->log.end_pos;
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


