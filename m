Return-Path: <bpf+bounces-43894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FD69BB8BF
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 16:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67891F2246C
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 15:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FF21B6CF9;
	Mon,  4 Nov 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXs1DpeK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CD04A08
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733443; cv=none; b=ZM5NcFEfcvQYWgCjq1ofaUXV1Vi/9WyGVPK4I5IKiOFbEixaAAoT7B+37QzIr4nvp18bLHKeCFvmnjhXK8xRVaXlYNSh3YOdlZcHkupl8x3rMTB5b1V953xbfF0YK/jPppQyCmbhmsF4MG+JD3hxjp+aj9ogmrhH3S+M6oPfN2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733443; c=relaxed/simple;
	bh=3Ja+gj53WfO5u9uqpYF1Mbp8hfuII1mpRXIBL30nrgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQMtAWMO5AsBWU6dOwtH2rsnkSCHKAJ7VvUq6w6HOph2Ysx+XDYzuWbBOrmn6lGyI4M9hydf6G9LDcH1H60LsbDPiWbIO1IW1MWaqKjXJrKa3yB+aWRSYQb227Rei4psIl1QCWlddBrjJWZQYkZNl8QIHThb4Y7+9c3M7qjDkOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXs1DpeK; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-53c779ef19cso5015208e87.3
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 07:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730733439; x=1731338239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EP+8q+R7bsEXZGT0auEvqXVsYGzbNSLB1iJR1+KWvYg=;
        b=IXs1DpeKjrJ+NqfKLTo5hmfEe2IJF0GcyvDP8J4yD6DZfWYndqdmhBRUtjxx9KhdG2
         BgrnbqKdR88NvNwu0FyRpnnvHRVwo13uL/zJBDi5huQg+jXlG94dIiItRk2pyXFWXQMP
         W0PY8wMi9es+tHVNYIPH85JDa0jqqHBZC1caZE0E1ott7L8qpkr/6rsKeKIldCYpIORo
         lyn/iNim7SvrPbOtbot7Y2Or+aJHBOy4SakhysSWZq3kJXmk8jW9wPywqwttRznBF/ZL
         saT1vZhtBpwCpbnK3Og64jMH+JKGCMVKk8KKfX/gH3B6F4rwvVXs3gH8TpbK/Jur9xAR
         ywWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730733439; x=1731338239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EP+8q+R7bsEXZGT0auEvqXVsYGzbNSLB1iJR1+KWvYg=;
        b=rLCT3EHNPBIfPaWb8oypwNnQTIvwM7J3pPoBhHroXwYvVnI2tEza5s0ul59I0uOE2y
         L+0JvcBaM0SajZOv9b0I4+8DvmDuL8H/WyybSjkNj7jGbZUmgT1C5TbUF5aQMIK6e2/t
         OeRtRlhindLs6Q5wrb9Bxho+KFPhZGb1Ynqb8Jh5Rk6Few1RNN5bRULlvndJUEVOBcQm
         tpTe47YrSUzdW2wEq+wMc8tWPpMCBM32+RDQSXjYP+BYYnIEuOziQ776dt4mBiMIb03M
         19kXCllFDeSoQJB8Xw69qSnc5mt+corhlb5AlVgIwVR0mYgIjMhv8CwdohW0ISM2rIKF
         NPuQ==
X-Gm-Message-State: AOJu0YzFh/RN4/s2ISIh5W2xgYzLAGlZb8yzLrV0Ayg9GnlyKPddk9UF
	gOyQHd0IXiUPdCJ32RCgfllIm7SRMp1358bBf8UoxhvB3RJpCRZu3+qU7KxNQULi3g==
X-Google-Smtp-Source: AGHT+IFV0MJrb0ivSHzcQmAvb1Jeci88qtc8NmPHNXg/q5w07aA4ws1hRRWpFUr/FB04gPR5Ew6Qqg==
X-Received: by 2002:a05:6512:3b91:b0:539:fa3d:a73 with SMTP id 2adb3069b0e04-53c79e91292mr6822143e87.39.1730733438241;
        Mon, 04 Nov 2024 07:17:18 -0800 (PST)
Received: from localhost (fwdproxy-cln-021.fbsv.net. [2a03:2880:31ff:15::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6852efsm156128995e9.30.2024.11.04.07.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 07:17:17 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3] bpf: Refactor active lock management
Date: Mon,  4 Nov 2024 07:17:16 -0800
Message-ID: <20241104151716.2079893-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12817; h=from:subject; bh=mr5Vq8Tjv5M8EhHdPfnjL4D2wbf5A5+piE6Ce4Nj6pg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnKOS9hNWTPkcBQOAlHcnLLlN9dozoiCP+8wwgtVRd TvrjN6qJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZyjkvQAKCRBM4MiGSL8Ryh4FD/ 9vewVGyMS6E9fm4S4b7eSrflqR7FYLTDA7uG+piWFCqqAOsH8ey8Medx5UkJIEdNA+tLjoxkkRUW7U IKrZwuD+vrSRYDI9eoXyc1lpNkz87skvH4EOMx5I1+oDIyFqPtTvPJIZH2LBiCIN/K6U+y6nV4grd4 1LiCoRoQ/DyjEW8Vw2ijy29vtJdIEZ83TMPLPBIFnTvLyU+NYRSbB2E7BeEf6qk7d+9j25cRo7Lout N+koDaS6AdSmQYK3b6LasKWVwlq+s6smUXy4tyANHDmJAOv0MX1KHLNwQtDh3rECIVxFbMKhgAS1YH iNEGygIwt8t25Ue1za9xNKcXAyPdHImews4RnOhczAFGBDMaCsO10htJfuHsVnhggjD4l7CBvITj3w za8Blw1pkAUsoV3GK7dXBUVs6t+MB0sT3G8iQiEZjfu+U/VkZZsSI5VTu5uJ1ZCCig1mjmfFlct5Cq lYfFQmOXvF9eOevVz+cYw3lB4SWSiFzuG254PBrdJMSv//EvJl33vHyBYTRQaZXfvrYnpN2YkuJs/U vEI/K2cNvaR5JF56DELwjieJ19mbR8h9XWi4oshHjLw8/tY4jF2BF0JaRqFX0ksdUO8aCuTd+IL1dT FKdFpU61EPjI8LN8zBT2wAvIDE1GLuXps/+JgrK3dSFKuL1SZyV3qROduzag==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

When bpf_spin_lock was introduced originally, there was deliberation on
whether to use an array of lock IDs, but since bpf_spin_lock is limited
to holding a single lock at any given time, we've been using a single ID
to identify the held lock.

In preparation for introducing spin locks that can be taken multiple
times, introduce support for acquiring multiple lock IDs. For this
purpose, reuse the acquired_refs array and store both lock and pointer
references. We tag the entry with REF_TYPE_PTR or REF_TYPE_BPF_LOCK to
disambiguate and find the relevant entry. The ptr field is used to track
the map_ptr or btf (for bpf_obj_new allocations) to ensure locks can be
matched with protected fields within the same "allocation", i.e.
bpf_obj_new object or map value.

The struct active_lock is changed to a boolean as the state is part of
the acquired_refs array, and we only need active_lock as a cheap way
of detecting lock presence.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
Changelog:
v2 -> v3
v2: https://lore.kernel.org/bpf/20241103212252.547071-1-memxor@gmail.com

 * Rebase on bpf-next to resolve merge conflict

v1 -> v2
v1: https://lore.kernel.org/bpf/20241103205856.345580-1-memxor@gmail.com

 * Fix refsafe state comparison to check callback_ref and ptr separately.
---
 include/linux/bpf_verifier.h |  34 ++++++---
 kernel/bpf/verifier.c        | 138 ++++++++++++++++++++++++++---------
 2 files changed, 126 insertions(+), 46 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4513372c5bc8..1e7e1803d78b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -266,6 +266,10 @@ struct bpf_stack_state {
 };

 struct bpf_reference_state {
+	/* Each reference object has a type. Ensure REF_TYPE_PTR is zero to
+	 * default to pointer reference on zero initialization of a state.
+	 */
+	enum { REF_TYPE_PTR = 0, REF_TYPE_BPF_LOCK } type;
 	/* Track each reference created with a unique id, even if the same
 	 * instruction creates the reference multiple times (eg, via CALL).
 	 */
@@ -274,17 +278,23 @@ struct bpf_reference_state {
 	 * is used purely to inform the user of a reference leak.
 	 */
 	int insn_idx;
-	/* There can be a case like:
-	 * main (frame 0)
-	 *  cb (frame 1)
-	 *   func (frame 3)
-	 *    cb (frame 4)
-	 * Hence for frame 4, if callback_ref just stored boolean, it would be
-	 * impossible to distinguish nested callback refs. Hence store the
-	 * frameno and compare that to callback_ref in check_reference_leak when
-	 * exiting a callback function.
-	 */
-	int callback_ref;
+	union {
+		/* There can be a case like:
+		 * main (frame 0)
+		 *  cb (frame 1)
+		 *   func (frame 3)
+		 *    cb (frame 4)
+		 * Hence for frame 4, if callback_ref just stored boolean, it would be
+		 * impossible to distinguish nested callback refs. Hence store the
+		 * frameno and compare that to callback_ref in check_reference_leak when
+		 * exiting a callback function.
+		 */
+		int callback_ref;
+		/* Use to keep track of the source object of a lock, to ensure
+		 * it matches on unlock.
+		 */
+		void *ptr;
+	};
 };

 struct bpf_retval_range {
@@ -434,7 +444,7 @@ struct bpf_verifier_state {
 	u32 insn_idx;
 	u32 curframe;

-	struct bpf_active_lock active_lock;
+	bool active_lock;
 	bool speculative;
 	bool active_rcu_lock;
 	u32 active_preempt_lock;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ba800c7611e3..ea8ad320e6cc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1335,6 +1335,7 @@ static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
 	if (err)
 		return err;
 	id = ++env->id_gen;
+	state->refs[new_ofs].type = REF_TYPE_PTR;
 	state->refs[new_ofs].id = id;
 	state->refs[new_ofs].insn_idx = insn_idx;
 	state->refs[new_ofs].callback_ref = state->in_callback_fn ? state->frameno : 0;
@@ -1342,6 +1343,23 @@ static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
 	return id;
 }

+static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, int type, int id, void *ptr)
+{
+	struct bpf_func_state *state = cur_func(env);
+	int new_ofs = state->acquired_refs;
+	int err;
+
+	err = resize_reference_state(state, state->acquired_refs + 1);
+	if (err)
+		return err;
+	state->refs[new_ofs].type = type;
+	state->refs[new_ofs].id = id;
+	state->refs[new_ofs].insn_idx = insn_idx;
+	state->refs[new_ofs].ptr = ptr;
+
+	return 0;
+}
+
 /* release function corresponding to acquire_reference_state(). Idempotent. */
 static int release_reference_state(struct bpf_func_state *state, int ptr_id)
 {
@@ -1349,6 +1367,8 @@ static int release_reference_state(struct bpf_func_state *state, int ptr_id)

 	last_idx = state->acquired_refs - 1;
 	for (i = 0; i < state->acquired_refs; i++) {
+		if (state->refs[i].type != REF_TYPE_PTR)
+			continue;
 		if (state->refs[i].id == ptr_id) {
 			/* Cannot release caller references in callbacks */
 			if (state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
@@ -1364,6 +1384,43 @@ static int release_reference_state(struct bpf_func_state *state, int ptr_id)
 	return -EINVAL;
 }

+static int release_lock_state(struct bpf_func_state *state, int type, int id, void *ptr)
+{
+	int i, last_idx;
+
+	last_idx = state->acquired_refs - 1;
+	for (i = 0; i < state->acquired_refs; i++) {
+		if (state->refs[i].type != type)
+			continue;
+		if (state->refs[i].id == id && state->refs[i].ptr == ptr) {
+			if (last_idx && i != last_idx)
+				memcpy(&state->refs[i], &state->refs[last_idx],
+				       sizeof(*state->refs));
+			memset(&state->refs[last_idx], 0, sizeof(*state->refs));
+			state->acquired_refs--;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+static struct bpf_reference_state *find_lock_state(struct bpf_verifier_env *env, int id, void *ptr)
+{
+	struct bpf_func_state *state = cur_func(env);
+	int i;
+
+	for (i = 0; i < state->acquired_refs; i++) {
+		struct bpf_reference_state *s = &state->refs[i];
+
+		if (s->type == REF_TYPE_PTR)
+			continue;
+
+		if (s->id == id && s->ptr == ptr)
+			return s;
+	}
+	return NULL;
+}
+
 static void free_func_state(struct bpf_func_state *state)
 {
 	if (!state)
@@ -1430,12 +1487,11 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 		dst_state->frame[i] = NULL;
 	}
 	dst_state->speculative = src->speculative;
+	dst_state->active_lock = src->active_lock;
 	dst_state->active_rcu_lock = src->active_rcu_lock;
 	dst_state->active_preempt_lock = src->active_preempt_lock;
 	dst_state->in_sleepable = src->in_sleepable;
 	dst_state->curframe = src->curframe;
-	dst_state->active_lock.ptr = src->active_lock.ptr;
-	dst_state->active_lock.id = src->active_lock.id;
 	dst_state->branches = src->branches;
 	dst_state->parent = src->parent;
 	dst_state->first_insn_idx = src->first_insn_idx;
@@ -5423,7 +5479,7 @@ static bool in_sleepable(struct bpf_verifier_env *env)
 static bool in_rcu_cs(struct bpf_verifier_env *env)
 {
 	return env->cur_state->active_rcu_lock ||
-	       env->cur_state->active_lock.ptr ||
+	       env->cur_state->active_lock ||
 	       !in_sleepable(env);
 }

@@ -7698,6 +7754,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 	struct bpf_map *map = NULL;
 	struct btf *btf = NULL;
 	struct btf_record *rec;
+	int err;

 	if (!is_const) {
 		verbose(env,
@@ -7729,16 +7786,27 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 		return -EINVAL;
 	}
 	if (is_lock) {
-		if (cur->active_lock.ptr) {
+		void *ptr;
+
+		if (map)
+			ptr = map;
+		else
+			ptr = btf;
+
+		if (cur->active_lock) {
 			verbose(env,
 				"Locking two bpf_spin_locks are not allowed\n");
 			return -EINVAL;
 		}
-		if (map)
-			cur->active_lock.ptr = map;
-		else
-			cur->active_lock.ptr = btf;
-		cur->active_lock.id = reg->id;
+		err = acquire_lock_state(env, env->insn_idx, REF_TYPE_BPF_LOCK, reg->id, ptr);
+		if (err < 0) {
+			verbose(env, "Failed to acquire lock state\n");
+			return err;
+		}
+		/* It is not safe to allow multiple bpf_spin_lock calls, so
+		 * disallow them until this lock has been unlocked.
+		 */
+		cur->active_lock = true;
 	} else {
 		void *ptr;

@@ -7747,20 +7815,18 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 		else
 			ptr = btf;

-		if (!cur->active_lock.ptr) {
+		if (!cur->active_lock) {
 			verbose(env, "bpf_spin_unlock without taking a lock\n");
 			return -EINVAL;
 		}
-		if (cur->active_lock.ptr != ptr ||
-		    cur->active_lock.id != reg->id) {
+
+		if (release_lock_state(cur_func(env), REF_TYPE_BPF_LOCK, reg->id, ptr)) {
 			verbose(env, "bpf_spin_unlock of different lock\n");
 			return -EINVAL;
 		}

 		invalidate_non_owning_refs(env);
-
-		cur->active_lock.ptr = NULL;
-		cur->active_lock.id = 0;
+		cur->active_lock = false;
 	}
 	return 0;
 }
@@ -9818,7 +9884,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		const char *sub_name = subprog_name(env, subprog);

 		/* Only global subprogs cannot be called with a lock held. */
-		if (env->cur_state->active_lock.ptr) {
+		if (env->cur_state->active_lock) {
 			verbose(env, "global function calls are not allowed while holding a lock,\n"
 				     "use static function instead\n");
 			return -EINVAL;
@@ -10343,6 +10409,8 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
 		return 0;

 	for (i = 0; i < state->acquired_refs; i++) {
+		if (state->refs[i].type != REF_TYPE_PTR)
+			continue;
 		if (!exception_exit && state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
 			continue;
 		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
@@ -10356,7 +10424,7 @@ static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit
 {
 	int err;

-	if (check_lock && env->cur_state->active_lock.ptr) {
+	if (check_lock && env->cur_state->active_lock) {
 		verbose(env, "%s cannot be used inside bpf_spin_lock-ed region\n", prefix);
 		return -EINVAL;
 	}
@@ -11580,7 +11648,7 @@ static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state
 	struct bpf_verifier_state *state = env->cur_state;
 	struct btf_record *rec = reg_btf_record(reg);

-	if (!state->active_lock.ptr) {
+	if (!state->active_lock) {
 		verbose(env, "verifier internal error: ref_set_non_owning w/o active lock\n");
 		return -EFAULT;
 	}
@@ -11677,6 +11745,7 @@ static int ref_convert_owning_non_owning(struct bpf_verifier_env *env, u32 ref_o
  */
 static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
+	struct bpf_reference_state *s;
 	void *ptr;
 	u32 id;

@@ -11693,10 +11762,10 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
 	}
 	id = reg->id;

-	if (!env->cur_state->active_lock.ptr)
+	if (!env->cur_state->active_lock)
 		return -EINVAL;
-	if (env->cur_state->active_lock.ptr != ptr ||
-	    env->cur_state->active_lock.id != id) {
+	s = find_lock_state(env, id, ptr);
+	if (!s) {
 		verbose(env, "held lock and object are not in the same allocation\n");
 		return -EINVAL;
 	}
@@ -17561,8 +17630,19 @@ static bool refsafe(struct bpf_func_state *old, struct bpf_func_state *cur,
 		return false;

 	for (i = 0; i < old->acquired_refs; i++) {
-		if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap))
+		if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap) ||
+		    old->refs[i].type != cur->refs[i].type)
 			return false;
+		switch (old->refs[i].type) {
+		case REF_TYPE_PTR:
+			if (old->refs[i].callback_ref != cur->refs[i].callback_ref)
+				return false;
+			break;
+		default:
+			if (old->refs[i].ptr != cur->refs[i].ptr)
+				return false;
+			break;
+		}
 	}

 	return true;
@@ -17640,17 +17720,7 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->speculative && !cur->speculative)
 		return false;

-	if (old->active_lock.ptr != cur->active_lock.ptr)
-		return false;
-
-	/* Old and cur active_lock's have to be either both present
-	 * or both absent.
-	 */
-	if (!!old->active_lock.id != !!cur->active_lock.id)
-		return false;
-
-	if (old->active_lock.id &&
-	    !check_ids(old->active_lock.id, cur->active_lock.id, &env->idmap_scratch))
+	if (old->active_lock != cur->active_lock)
 		return false;

 	if (old->active_rcu_lock != cur->active_rcu_lock)
@@ -18551,7 +18621,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}

-				if (env->cur_state->active_lock.ptr) {
+				if (env->cur_state->active_lock) {
 					if ((insn->src_reg == BPF_REG_0 && insn->imm != BPF_FUNC_spin_unlock) ||
 					    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
 					     (insn->off != 0 || !is_bpf_graph_api_kfunc(insn->imm)))) {
--
2.43.5


