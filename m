Return-Path: <bpf+bounces-44420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 560C59C2B0F
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 08:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B10282D44
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 07:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B94A141987;
	Sat,  9 Nov 2024 07:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIq+HPB8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACB554652
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 07:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731138232; cv=none; b=FzherkPMwuzc5DLXdMTo+h7eRl5h12/7YPKLd+GL4TZY7u5MlOeJ1yJdoFM1P41EDQyQKp7m6wDmb9tld3akMG+eTUG62q7kY/wHygA2YHzKtxaxXS3V9M/DyuxwufeP16aFFG9c3Ljfp8MUqWGEXw7vqWF94Q0Pjq5v0pR6CFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731138232; c=relaxed/simple;
	bh=6EGPeoV7duzSplYuLDh/of7elmwMPn1JyBYbVb7V8ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KBO29173fleICF0E0lAGJbEaONZfGVRNElCkukOovy3pj4O+x1SQVyiVyTVokALYKVhq7Is4BJ2XYQnHnKDydfbOyp3Y8TgZv/FeX55QwvvC9lPFvPhgpn7IcO6p56M29sVv6+V4Y0h3gdIAFRp9Sk298dPtwVdLYU9nxEi1bYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIq+HPB8; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so23866305e9.2
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2024 23:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731138228; x=1731743028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KkA4LHB+ccxDjkmki0exm0Gw7JFuXQTERA/l6T0taK0=;
        b=QIq+HPB8GPoxtZApz5e48AGPx5ebmMBP/B0qw6HU0p3TQd5tmOUN2c1eMtOMLcJjE2
         UkrVY7iIXvN8niOzuy5aRnY6H9/aqXn1H2e6eC9uv5/mZffsyi/+bvmZsD8z3tfHj7SB
         fhc8ePKlqiY5Q0e+GlhMumAiAxml3BE8DUDzfiMMlcsb11/bubo0coKGveJ/3kBKsewN
         Q/YN04+tOuT0maTYvTq9HQlgpqG+uSqLckUIKvrc80YyBKA9Ny0t3Uu8phpQtgS+v0JB
         DujVCDi/oS9jJbdLmrUoNJWFzinq/Uo1zUJAXEHWDXlgM1Ii8Bvgage2OsydBxXyadzZ
         jiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731138228; x=1731743028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KkA4LHB+ccxDjkmki0exm0Gw7JFuXQTERA/l6T0taK0=;
        b=Uzg4iqlk0HOU1VHZMwru6jqsxxae9Gojcd3xFrl5+xHuEZQ1dd+m55LR/VZLSWTY6o
         pTUF/m7P7vFbsaDv7IDNp962c1Jk56h/D5XtRJAIPNOPojxe8zQ3Enpy13E/Rim2wGUk
         MlKSSpt+puTRa4npEQGL/LZbJV8k3KCjowkO0yn5dDSP+J1bqBihU5zylD6i1N+490jB
         BWNwa5rQOj2m2SLusyiiGPp70IpI597DvU/nUCcRE+kEhIRfqDKQPLIfi+I3J9pKMfJp
         4VVeT6cMZs5b08XXLYP0+ZxPvcDM1BSDZgnsKeqCYe+dVcEPBiakwzzNVYO4/lM4y2J9
         k7TA==
X-Gm-Message-State: AOJu0YwATR9qm+MXzn4/G14rvFViBfDUCbL60d4ikW8nINamifhVJ29R
	5IRIw8GFzoQ876TiqV1cYj++IZIHE/eaoPIDkHIerCe9LFDv4Nb7710Emihq51I=
X-Google-Smtp-Source: AGHT+IHIhhoqTEQWPCK/Sk0Chso0xK72iwuMVdYVYQeBl2y9gaguxnAGxFmjN50C4WNZDxuMQplHkQ==
X-Received: by 2002:a05:600c:4fcc:b0:431:5044:e388 with SMTP id 5b1f17b1804b1-432b75166femr48610785e9.22.1731138228278;
        Fri, 08 Nov 2024 23:43:48 -0800 (PST)
Received: from localhost (fwdproxy-cln-032.fbsv.net. [2a03:2880:31ff:20::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5e3dsm131236035e9.9.2024.11.08.23.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 23:43:47 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4] bpf: Refactor active lock management
Date: Fri,  8 Nov 2024 23:43:47 -0800
Message-ID: <20241109074347.1434011-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13846; h=from:subject; bh=E27kuIJlQ+HSCVW0yWxye6Cjnnv5OdhV+AHOUMQW2Dw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnLxGpRt17nXqiVna6Oc+wIo8kDuDBeTchLpmUy1R/ NUBjPAWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZy8RqQAKCRBM4MiGSL8Ryk/zD/ sEH7m8Za7aWQFKF6mBw7yyHFQLTGWPNUbqaTLC7lzunsMADYTx/V50XJUupzJWJ4bsQ1nBdO0fBOf7 bRtNhVWmknXFnzzq5pvT+7vojgmG6w8biLT81mYvXC6/wcz/RMNY1STj3aIhOIrek3eoGMS1m5HVF7 xFw4oitdRw0XfsMR9ELscIzZAYXzljR0+rplaPudQ9uc+ZpAaO4BNDcwWITLxTaLDFioRTT1/vm4HB dVQZS4lXZog+LoNKTMd5brto5m45msaFnqdfEvEFMBOiVvq/f0rHZ5XdmifNDaApD6j31Mp93RcNry jUwiUgwwAwTfgVzUAwtSqeyXpY+YKPWHS7XyaZ/UEm8N3WZTYWbiks5YfNFlKeRk8nZDwdE5kznXSx Ff5VVcOarkyU5vMAJjQQ9HwqE+nx9V83Gk9PD0ALUaeXWvqXk7yopMQcPEh0SYktPISWfniqy6YFsk Lk4ibAIWLxsH3jQFFVAZGd2m0/x6w6xI1EMWKRQU0pDxWr6+epXQmKAVMy45KlV5npOZPohRRkWf2b LJJ3DFjVm1krMuSnPD9XBeEOdKAEchvkvGzfY4+rbbg+CPwZcedYdDMBCImEHTiYS2uufwtFad83Ar rbGfHXS0wTfeiGhvSzcMSKa7ZkkaNr9PlvTz7XPRPBICV0ux/0xaeP4h8O5g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

When bpf_spin_lock was introduced originally, there was deliberation on
whether to use an array of lock IDs, but since bpf_spin_lock is limited
to holding a single lock at any given time, we've been using a single ID
to identify the held lock.

In preparation for introducing spin locks that can be taken multiple
times, introduce support for acquiring multiple lock IDs. For this
purpose, reuse the acquired_refs array and store both lock and pointer
references. We tag the entry with REF_TYPE_PTR or REF_TYPE_LOCK to
disambiguate and find the relevant entry. The ptr field is used to track
the map_ptr or btf (for bpf_obj_new allocations) to ensure locks can be
matched with protected fields within the same "allocation", i.e.
bpf_obj_new object or map value.

The struct active_lock is changed to an int as the state is part of the
acquired_refs array, and we only need active_lock as a cheap way of
detecting lock presence.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
Changelog:
v3 -> v4
v3: https://lore.kernel.org/bpf/20241104151716.2079893-1-memxor@gmail.com

 * Address comments from Alexei
   * Drop struct bpf_active_lock definition
   * Name enum type, expand definition to multiple lines
   * s/REF_TYPE_BPF_LOCK/REF_TYPE_LOCK/g
   * Change active_lock type to int
   * Fix type of 'type' in acquire_lock_state
   * Filter by taking type explicitly in find_lock_state
   * WARN for default case in refsafe switch statement

v2 -> v3
v2: https://lore.kernel.org/bpf/20241103212252.547071-1-memxor@gmail.com

  * Rebase on bpf-next to resolve merge conflict

v1 -> v2
v1: https://lore.kernel.org/bpf/20241103205856.345580-1-memxor@gmail.com

  * Fix refsafe state comparison to check callback_ref and ptr separately.
---
 include/linux/bpf_verifier.h |  53 ++++++-------
 kernel/bpf/verifier.c        | 143 ++++++++++++++++++++++++++---------
 2 files changed, 134 insertions(+), 62 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4513372c5bc8..b248850396ac 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -48,22 +48,6 @@ enum bpf_reg_liveness {
 	REG_LIVE_DONE = 0x8, /* liveness won't be updating this register anymore */
 };

-/* For every reg representing a map value or allocated object pointer,
- * we consider the tuple of (ptr, id) for them to be unique in verifier
- * context and conside them to not alias each other for the purposes of
- * tracking lock state.
- */
-struct bpf_active_lock {
-	/* This can either be reg->map_ptr or reg->btf. If ptr is NULL,
-	 * there's no active lock held, and other fields have no
-	 * meaning. If non-NULL, it indicates that a lock is held and
-	 * id member has the reg->id of the register which can be >= 0.
-	 */
-	void *ptr;
-	/* This will be reg->id */
-	u32 id;
-};
-
 #define ITER_PREFIX "bpf_iter_"

 enum bpf_iter_state {
@@ -266,6 +250,13 @@ struct bpf_stack_state {
 };

 struct bpf_reference_state {
+	/* Each reference object has a type. Ensure REF_TYPE_PTR is zero to
+	 * default to pointer reference on zero initialization of a state.
+	 */
+	enum ref_state_type {
+		REF_TYPE_PTR = 0,
+		REF_TYPE_LOCK,
+	} type;
 	/* Track each reference created with a unique id, even if the same
 	 * instruction creates the reference multiple times (eg, via CALL).
 	 */
@@ -274,17 +265,23 @@ struct bpf_reference_state {
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
@@ -434,7 +431,7 @@ struct bpf_verifier_state {
 	u32 insn_idx;
 	u32 curframe;

-	struct bpf_active_lock active_lock;
+	int active_lock;
 	bool speculative;
 	bool active_rcu_lock;
 	u32 active_preempt_lock;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 132fc172961f..e04be1241a2c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1354,6 +1354,7 @@ static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
 	if (err)
 		return err;
 	id = ++env->id_gen;
+	state->refs[new_ofs].type = REF_TYPE_PTR;
 	state->refs[new_ofs].id = id;
 	state->refs[new_ofs].insn_idx = insn_idx;
 	state->refs[new_ofs].callback_ref = state->in_callback_fn ? state->frameno : 0;
@@ -1361,6 +1362,24 @@ static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
 	return id;
 }

+static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum ref_state_type type,
+			      int id, void *ptr)
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
@@ -1368,6 +1387,8 @@ static int release_reference_state(struct bpf_func_state *state, int ptr_id)

 	last_idx = state->acquired_refs - 1;
 	for (i = 0; i < state->acquired_refs; i++) {
+		if (state->refs[i].type != REF_TYPE_PTR)
+			continue;
 		if (state->refs[i].id == ptr_id) {
 			/* Cannot release caller references in callbacks */
 			if (state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
@@ -1383,6 +1404,44 @@ static int release_reference_state(struct bpf_func_state *state, int ptr_id)
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
+static struct bpf_reference_state *find_lock_state(struct bpf_verifier_env *env, enum ref_state_type type,
+						   int id, void *ptr)
+{
+	struct bpf_func_state *state = cur_func(env);
+	int i;
+
+	for (i = 0; i < state->acquired_refs; i++) {
+		struct bpf_reference_state *s = &state->refs[i];
+
+		if (s->type == REF_TYPE_PTR || s->type != type)
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
@@ -1449,12 +1508,11 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
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
@@ -5442,7 +5500,7 @@ static bool in_sleepable(struct bpf_verifier_env *env)
 static bool in_rcu_cs(struct bpf_verifier_env *env)
 {
 	return env->cur_state->active_rcu_lock ||
-	       env->cur_state->active_lock.ptr ||
+	       env->cur_state->active_lock ||
 	       !in_sleepable(env);
 }

@@ -7737,6 +7795,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 	struct bpf_map *map = NULL;
 	struct btf *btf = NULL;
 	struct btf_record *rec;
+	int err;

 	if (!is_const) {
 		verbose(env,
@@ -7768,16 +7827,27 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
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
+		err = acquire_lock_state(env, env->insn_idx, REF_TYPE_LOCK, reg->id, ptr);
+		if (err < 0) {
+			verbose(env, "Failed to acquire lock state\n");
+			return err;
+		}
+		/* It is not safe to allow multiple bpf_spin_lock calls, so
+		 * disallow them until this lock has been unlocked.
+		 */
+		cur->active_lock++;
 	} else {
 		void *ptr;

@@ -7786,20 +7856,18 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
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
+		if (release_lock_state(cur_func(env), REF_TYPE_LOCK, reg->id, ptr)) {
 			verbose(env, "bpf_spin_unlock of different lock\n");
 			return -EINVAL;
 		}

 		invalidate_non_owning_refs(env);
-
-		cur->active_lock.ptr = NULL;
-		cur->active_lock.id = 0;
+		cur->active_lock--;
 	}
 	return 0;
 }
@@ -9861,7 +9929,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		const char *sub_name = subprog_name(env, subprog);

 		/* Only global subprogs cannot be called with a lock held. */
-		if (env->cur_state->active_lock.ptr) {
+		if (env->cur_state->active_lock) {
 			verbose(env, "global function calls are not allowed while holding a lock,\n"
 				     "use static function instead\n");
 			return -EINVAL;
@@ -10386,6 +10454,8 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
 		return 0;

 	for (i = 0; i < state->acquired_refs; i++) {
+		if (state->refs[i].type != REF_TYPE_PTR)
+			continue;
 		if (!exception_exit && state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
 			continue;
 		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
@@ -10399,7 +10469,7 @@ static int check_resource_leak(struct bpf_verifier_env *env, bool exception_exit
 {
 	int err;

-	if (check_lock && env->cur_state->active_lock.ptr) {
+	if (check_lock && env->cur_state->active_lock) {
 		verbose(env, "%s cannot be used inside bpf_spin_lock-ed region\n", prefix);
 		return -EINVAL;
 	}
@@ -11623,7 +11693,7 @@ static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state
 	struct bpf_verifier_state *state = env->cur_state;
 	struct btf_record *rec = reg_btf_record(reg);

-	if (!state->active_lock.ptr) {
+	if (!state->active_lock) {
 		verbose(env, "verifier internal error: ref_set_non_owning w/o active lock\n");
 		return -EFAULT;
 	}
@@ -11720,6 +11790,7 @@ static int ref_convert_owning_non_owning(struct bpf_verifier_env *env, u32 ref_o
  */
 static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
+	struct bpf_reference_state *s;
 	void *ptr;
 	u32 id;

@@ -11736,10 +11807,10 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
 	}
 	id = reg->id;

-	if (!env->cur_state->active_lock.ptr)
+	if (!env->cur_state->active_lock)
 		return -EINVAL;
-	if (env->cur_state->active_lock.ptr != ptr ||
-	    env->cur_state->active_lock.id != id) {
+	s = find_lock_state(env, REF_TYPE_LOCK, id, ptr);
+	if (!s) {
 		verbose(env, "held lock and object are not in the same allocation\n");
 		return -EINVAL;
 	}
@@ -17635,8 +17706,22 @@ static bool refsafe(struct bpf_func_state *old, struct bpf_func_state *cur,
 		return false;

 	for (i = 0; i < old->acquired_refs; i++) {
-		if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap))
+		if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap) ||
+		    old->refs[i].type != cur->refs[i].type)
+			return false;
+		switch (old->refs[i].type) {
+		case REF_TYPE_PTR:
+			if (old->refs[i].callback_ref != cur->refs[i].callback_ref)
+				return false;
+			break;
+		case REF_TYPE_LOCK:
+			if (old->refs[i].ptr != cur->refs[i].ptr)
+				return false;
+			break;
+		default:
+			WARN_ONCE(1, "Unhandled enum type for reference state: %d\n", old->refs[i].type);
 			return false;
+		}
 	}

 	return true;
@@ -17714,17 +17799,7 @@ static bool states_equal(struct bpf_verifier_env *env,
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
@@ -18625,7 +18700,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}

-				if (env->cur_state->active_lock.ptr) {
+				if (env->cur_state->active_lock) {
 					if ((insn->src_reg == BPF_REG_0 && insn->imm != BPF_FUNC_spin_unlock) ||
 					    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
 					     (insn->off != 0 || !is_bpf_graph_api_kfunc(insn->imm)))) {
--
2.43.5


