Return-Path: <bpf+bounces-44441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9889C2FD7
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 23:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5361C20C58
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 22:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC80A1A286D;
	Sat,  9 Nov 2024 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVqKBujb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1721A0AF7
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 22:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731192770; cv=none; b=JXIEuVeP4iCUyrH7EmykzVl8KbfrZzZNRb6Eh1dR/a+os3XUSEZuZPcaFyitigZcYXJKYEg/APsB4uRkJeAIJwoPDmlkiWxVv4MyBYDZ3FmbyWK9AkSaVcOlRgJhaGnwZXUQswufXon/mYAPzusWtTqWKEZJZCydVom/YT4AfSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731192770; c=relaxed/simple;
	bh=1L0j81axCpw/t/meBKHEpSaZvIALDOdm/DMdwxxSwJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VU7mJaD+qUJYrjwRMFULKtdwkR1mcavGjNsN61pVbKGMbw/mHmJLUTVOtV+q2YhUd+gEHfIcWVmcM53vGctnPfy6mmpX80dQu0DDFcFCMGXbobuFSogDgcCCvXm4S7tcr4AqU4H1Rrxv3vRdxwujUYgP50dqn2OAHXn2TZPGPpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVqKBujb; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so2264156f8f.3
        for <bpf@vger.kernel.org>; Sat, 09 Nov 2024 14:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731192766; x=1731797566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPEhNKfVPNlOODIl/9V5tdXI+E5KE1pFRtY1J/An5tM=;
        b=PVqKBujb79rr5sCBAA7RS6TRfWgJP7QUiAP8CBVE9jd8q+8infPCIKHFS675BsGzOQ
         MnfDrALUA4ZSXjAeOYbezxTqgO45LIJG/CKrmSdvSZWyDHTAPLYS94FvPYw/12ICp3Bo
         qpARb0dUhlxjLwtKMvO0CZ+tl6aLHKa6gKGocFzglZ7yJTLmN/Hn9NGtIlzWyZn7tpjL
         WcXMvmt4l/bdU/C77D/RM9CTpjlido1VPeRDZ00uEj0T4CMXifDvl4NRGPGbps+0vPZw
         G2oDjK35mRTlHsu9BlxARyQc6PwdCza+ZTh03VgzVaQ2mu32FETo63+5gUSRT53g0pAJ
         obMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731192766; x=1731797566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPEhNKfVPNlOODIl/9V5tdXI+E5KE1pFRtY1J/An5tM=;
        b=vyYFfnW/N/TJt5wxjau6jj6rIl9s+wKY+2del1vP7NAHyAVzmSy4w+edFERR7oIYTD
         Ce+mxM08qtA2i+yZ4CFFE11+D2ck6l93adNV2jv+KSOOcw5LvfVNG9tUzCsggny9YxW2
         8aiD/Z7uRTC5BJhnktwWluw5HpHcR+dVKhtY9F+gXF/li4opL/CSftUrFCOWuSV4npHl
         iv1RD6po0QtxCoKYje1Zu14W50HxiCg/8IVK46AewZCxJRR3HpUWumeSMsBC5BP95gbF
         r/fHzs8uf3jzrh304FmEvRUIBJ0oNWfLg/oTs1xojKILMb88P5DjK+ShMoBuyKgVKKHH
         FNRQ==
X-Gm-Message-State: AOJu0YzAsAF2QC4gOP31ys65YE5YCGvnlHGakWhNB0afZaMfo1K/zWdI
	oXq635AnVKPWpOC0zQqo3l/0COkOYynT0qpPQa6T8fQmDGHb0+7tWf/6zPPm4Zo=
X-Google-Smtp-Source: AGHT+IGzxS6Mg5s4bKRca8XmZXvSW0603ZSsUkq8dxOml8jeuOtM7t7Gqxlyy3SxphkM9gJDkEnJjQ==
X-Received: by 2002:a05:6000:2a82:b0:381:f595:fd0a with SMTP id ffacd0b85a97d-381f595fd36mr3839770f8f.16.1731192765759;
        Sat, 09 Nov 2024 14:52:45 -0800 (PST)
Received: from localhost (fwdproxy-cln-035.fbsv.net. [2a03:2880:31ff:23::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed970e23sm8780802f8f.18.2024.11.09.14.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 14:52:45 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 1/2] bpf: Refactor active lock management
Date: Sat,  9 Nov 2024 14:52:42 -0800
Message-ID: <20241109225243.2306756-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241109225243.2306756-1-memxor@gmail.com>
References: <20241109225243.2306756-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15061; h=from:subject; bh=1L0j81axCpw/t/meBKHEpSaZvIALDOdm/DMdwxxSwJI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnL+eapvfyDN/tPk8DnkRWJxpZ7cIunPxIZT7HCsSJ n0W57PmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZy/nmgAKCRBM4MiGSL8RypT5D/ 98xqPJYwz9iNWH4o6bYPVnpP16JaOovWfRVgXn14TLrnSNmXUYflLypWgL5Y2AjW3FF9P+qwjzMqCk sEkS9qaNh2RXoq1U4dZ343mLuHnMQbzPC3bnQHkEk31+ccRHrNkBage4nWzY3jq81DX1sKuM9z8rSL fKM9dYcO6tFvalhvrGCbIsXKO8kDWENSvPr0LsfZutZm1S5DwHYbfVuBaRcNPNZBQ+GYPbn6wDYfpS pEpKawTv2A2R0BoTSPUNKgACV2Ac9JGkSgkZF/M/CA/w3lhl3e5m53wN3GZ1ZORWvPAcNZ90D95jjU LPhMNdESrX0dwi2M75NFFQToPdwwEUHaxwO9rFKCag77UIm/ovE3hduoM+unthY3aCW/RlaNHnoguu ucmpq3o+exAd6VHz6jrJyvCaaREP/ZlpQ+gkQnuAAaw6KCl5nTgxQSWRtiFJdlPWnF2QoUtJfVjo33 tYwBtjJlXwLa6IbWz/At4ojevGkrCbdSlk4CPf9/3roLs3CojwyRLRgO+EZ0xDZ/SwGl0skZFIT5hj mUpyBrU3qK9XE8J1evTwkaDVFuhWCEIGGJ1KW9taEXkd83dt+B76hGyKD/m1gi9uoO/txtfssPCqSm Q/5T8gNxrDYXVauip93z+YtRYQ3F9fGuLAZ7JgYFvKI6uczoyeaT1RityMyw==
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
 include/linux/bpf_verifier.h |  53 ++++++-------
 kernel/bpf/verifier.c        | 149 ++++++++++++++++++++++++++---------
 2 files changed, 135 insertions(+), 67 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4513372c5bc8..d84beed92ae4 100644
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
@@ -332,6 +329,7 @@ struct bpf_func_state {
 
 	/* The following fields should be last. See copy_func_state() */
 	int acquired_refs;
+	int active_locks;
 	struct bpf_reference_state *refs;
 	/* The state of the stack. Each element of the array describes BPF_REG_SIZE
 	 * (i.e. 8) bytes worth of stack memory.
@@ -434,7 +432,6 @@ struct bpf_verifier_state {
 	u32 insn_idx;
 	u32 curframe;
 
-	struct bpf_active_lock active_lock;
 	bool speculative;
 	bool active_rcu_lock;
 	u32 active_preempt_lock;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 132fc172961f..e3f06a4410d8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1284,6 +1284,7 @@ static int copy_reference_state(struct bpf_func_state *dst, const struct bpf_fun
 	if (!dst->refs)
 		return -ENOMEM;
 
+	dst->active_locks = src->active_locks;
 	dst->acquired_refs = src->acquired_refs;
 	return 0;
 }
@@ -1354,6 +1355,7 @@ static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
 	if (err)
 		return err;
 	id = ++env->id_gen;
+	state->refs[new_ofs].type = REF_TYPE_PTR;
 	state->refs[new_ofs].id = id;
 	state->refs[new_ofs].insn_idx = insn_idx;
 	state->refs[new_ofs].callback_ref = state->in_callback_fn ? state->frameno : 0;
@@ -1361,6 +1363,24 @@ static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
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
@@ -1368,6 +1388,8 @@ static int release_reference_state(struct bpf_func_state *state, int ptr_id)
 
 	last_idx = state->acquired_refs - 1;
 	for (i = 0; i < state->acquired_refs; i++) {
+		if (state->refs[i].type != REF_TYPE_PTR)
+			continue;
 		if (state->refs[i].id == ptr_id) {
 			/* Cannot release caller references in callbacks */
 			if (state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
@@ -1383,6 +1405,44 @@ static int release_reference_state(struct bpf_func_state *state, int ptr_id)
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
@@ -1453,8 +1513,6 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
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
+	       cur_func(env)->active_locks ||
 	       !in_sleepable(env);
 }
 
@@ -7724,19 +7782,20 @@ static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg
  * Since only one bpf_spin_lock is allowed the checks are simpler than
  * reg_is_refcounted() logic. The verifier needs to remember only
  * one spin_lock instead of array of acquired_refs.
- * cur_state->active_lock remembers which map value element or allocated
+ * cur_func(env)->active_locks remembers which map value element or allocated
  * object got locked and clears it after bpf_spin_unlock.
  */
 static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 			     bool is_lock)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
-	struct bpf_verifier_state *cur = env->cur_state;
 	bool is_const = tnum_is_const(reg->var_off);
+	struct bpf_func_state *cur = cur_func(env);
 	u64 val = reg->var_off.value;
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
+		if (cur->active_locks) {
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
+		cur->active_locks++;
 	} else {
 		void *ptr;
 
@@ -7786,20 +7856,18 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 		else
 			ptr = btf;
 
-		if (!cur->active_lock.ptr) {
+		if (!cur->active_locks) {
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
+		cur->active_locks--;
 	}
 	return 0;
 }
@@ -9861,7 +9929,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		const char *sub_name = subprog_name(env, subprog);
 
 		/* Only global subprogs cannot be called with a lock held. */
-		if (env->cur_state->active_lock.ptr) {
+		if (cur_func(env)->active_locks) {
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
+	if (check_lock && cur_func(env)->active_locks) {
 		verbose(env, "%s cannot be used inside bpf_spin_lock-ed region\n", prefix);
 		return -EINVAL;
 	}
@@ -11620,10 +11690,9 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 
 static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
-	struct bpf_verifier_state *state = env->cur_state;
 	struct btf_record *rec = reg_btf_record(reg);
 
-	if (!state->active_lock.ptr) {
+	if (!cur_func(env)->active_locks) {
 		verbose(env, "verifier internal error: ref_set_non_owning w/o active lock\n");
 		return -EFAULT;
 	}
@@ -11720,6 +11789,7 @@ static int ref_convert_owning_non_owning(struct bpf_verifier_env *env, u32 ref_o
  */
 static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
+	struct bpf_reference_state *s;
 	void *ptr;
 	u32 id;
 
@@ -11736,10 +11806,10 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
 	}
 	id = reg->id;
 
-	if (!env->cur_state->active_lock.ptr)
+	if (!cur_func(env)->active_locks)
 		return -EINVAL;
-	if (env->cur_state->active_lock.ptr != ptr ||
-	    env->cur_state->active_lock.id != id) {
+	s = find_lock_state(env, REF_TYPE_LOCK, id, ptr);
+	if (!s) {
 		verbose(env, "held lock and object are not in the same allocation\n");
 		return -EINVAL;
 	}
@@ -17635,8 +17705,22 @@ static bool refsafe(struct bpf_func_state *old, struct bpf_func_state *cur,
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
+		case REF_TYPE_LOCK:
+			if (old->refs[i].ptr != cur->refs[i].ptr)
+				return false;
+			break;
+		default:
+			WARN_ONCE(1, "Unhandled enum type for reference state: %d\n", old->refs[i].type);
+			return false;
+		}
 	}
 
 	return true;
@@ -17714,19 +17798,6 @@ static bool states_equal(struct bpf_verifier_env *env,
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
-		return false;
-
 	if (old->active_rcu_lock != cur->active_rcu_lock)
 		return false;
 
@@ -18625,7 +18696,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_lock.ptr) {
+				if (cur_func(env)->active_locks) {
 					if ((insn->src_reg == BPF_REG_0 && insn->imm != BPF_FUNC_spin_unlock) ||
 					    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
 					     (insn->off != 0 || !is_bpf_graph_api_kfunc(insn->imm)))) {
-- 
2.43.5


