Return-Path: <bpf+bounces-43850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E132F9BA81A
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 21:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E5A1C20A61
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 20:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AC218BC1D;
	Sun,  3 Nov 2024 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M72+2aZa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B275B83CD3
	for <bpf@vger.kernel.org>; Sun,  3 Nov 2024 20:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730667541; cv=none; b=AZVqbk24PZqlD1j6VUwQObYcWU6Sou9LRowATc42U627hw9tkYhBC0MaaMth03pkO7lWUF84rVaf07MR41cAJ2dvu04OOJQnAk02yxd656BnS2S6fkQE2f8PZG1ga5Yl91viPa1b062o3jhbm55tpMUgw1Y6eCx5ptGpi0MsvE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730667541; c=relaxed/simple;
	bh=7F+gzA3AeRiu/ukay9k1zSJc8KQaXfQd6oCj0bomz1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uYHnhiW/0ecFD0jcHPVwaaR7Y4/qceMZyDTojeRr/E3RhM272OpKqFYw+nOkDgSwvzoELcjR44+8G/b73xe6LXABZH4bRKMidmmyInt2vZS95kKdJTTuoKmOE+WRU+DKNJqCZ3rDuoKMg2z4xyQAEytFB+JEp4N/Bh8hZRG9T9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M72+2aZa; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so1973101f8f.1
        for <bpf@vger.kernel.org>; Sun, 03 Nov 2024 12:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730667538; x=1731272338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qOwMJ7lN7WjabzIzycf2bTxUJaBdVj2T6iArZaxOK0s=;
        b=M72+2aZaAOZ2LIx8cXoni3aaujKdfXn4he8S6j8DVk8KgsjAMBCiwAPxFeI2tBfLe1
         eDGK2VBm1L/fm0CJlqWCyQDSbduLnNepuDB6SkN8RW1EFmFkadLzzTkbQrJibwI3FiP4
         dv7kr2zazGbd+9eZoWMi88BthZxXi5Ltu8Vx3UAra/k2rRerFexmp7ynP9zWIH2ht30f
         DIA6LA9IsnuVnBEl68vT+XrB8SncAELOMBU+rra5PufjN79iNjjdkppLx27+tp69+qiZ
         k/v6hJsQMd5A4I7WjGiQCMIz7sEsHrS00YGgwKiYdcEIT67z1jChaOrQpIN2qBbC8g3J
         hJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730667538; x=1731272338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOwMJ7lN7WjabzIzycf2bTxUJaBdVj2T6iArZaxOK0s=;
        b=O5VJpQcFOIzsM3Wlx2Su8NyfJLrl99gOArIis6ZFFfVdp7N1EQo8Jh1pyFKPR5d4eY
         7Vgm69unQUJrkvjZFMN6zEw6MP/xR7gTAmuSR8z3aL5viXi6IeT6BCn+7TNPKZdJs/2w
         GMnq+fuLrj42M/du33PsSQ9hZhOeGP4QcRBVJSK28RrXmpBIAu3iv6mWnucAhpK778nr
         68PEOLrY8aaXXlgDLW8vmMkyRo9H3RmxDj/IV1+J1Icc/wKk4Fk2MMfUmepdsk/hWkq8
         vBAqJgzOBJaZQh3OCmRalToCGbO08XG0BhRWARrMyhhGQWixDgoUmxAD+vP8+m+5ReUy
         Pepw==
X-Gm-Message-State: AOJu0YxAKQK6QlDHhneCpQM2gbHXzd5gfe1fvaGdVpJZRuA5recMs/o/
	c7M58jwWDB+zwai7o0ECek45FnVT5nZrBOTcI254jx/FYwkZr+ig7NjdxepMV/Yl7w==
X-Google-Smtp-Source: AGHT+IHPh68GS02QhtobD5IZE1sX5wI9DgQThc0ayozQSPEPJ0oVd9rcULrMOTgCoseOC/lR9+PERA==
X-Received: by 2002:a5d:64ad:0:b0:37d:38a1:6470 with SMTP id ffacd0b85a97d-381c7aa47d6mr7271619f8f.46.1730667537422;
        Sun, 03 Nov 2024 12:58:57 -0800 (PST)
Received: from localhost (fwdproxy-cln-015.fbsv.net. [2a03:2880:31ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e8549sm166323415e9.10.2024.11.03.12.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 12:58:56 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v1] bpf: Refactor active lock management
Date: Sun,  3 Nov 2024 12:58:56 -0800
Message-ID: <20241103205856.345580-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13439; h=from:subject; bh=g6A4bF8TO/boW2wndc0JCTB7erKwxXvtvmRd6htK7zo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnJ+OgSEIL/0v8dhLq34HuvHbnfgJI+3h9heoTkwZo 8lNqXm+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZyfjoAAKCRBM4MiGSL8RyuuMD/ 9/EMfqr3Fh+FqnA4xowQqYMiUW3h8jWyYyJteuR0DXgflr3rlspDl7VOLnfLPTADeHwk5v5OyoGEdQ yb8WiIoY3/D4Zr3WzME4llDScoRnDRR+n3mkW7YDJzSO7UK3IEW6pTtwKl50bbcariehP0/qbz2ZgT 6NRI9yHtmVjs2H+3qy4XasYaDM0gEgQ7psDDZa8M6tIcxNrY9e3mp+Ga4rXNzGpokOdWw7zAyEFAm5 P6JGZEpkvynEJbiXSxhRQyq4Pe16U2/i3AznLMvmSOGE/prTeQ8Sa7djoyU8gtD77/a2Ggu1y0GWEb N35qKKJKSYJVryi8PZXaC4qhbNnPbcVqqkYcaock8tr1lrBSsaM2bAdT91+M72Rpm4actA0t1qKIyw 3kJaP1LeZbcFfgQLOkZySUf4ANOT2/ikcZemmQTKF9zxOIj5JcPYyc7H3XFJ40q7H45fNAVG+eKg3U n7hdvLvIqaqHeEQ7gFGBj+IZcTIqfGOWOcRmlA2/NVjaiim8cl5jnQbc7vE+QFzEAAUyITqk6RR9Bh tmDwf3bq2RQgcpk9Hive+q1+dlYdYDwFcH07RJO0PNBJnN1KFAC81+GXXmj+Y2R4/T7+L3iV7M00aO h449UfYKqzHBv/A+6irdFmSgDrbBu/93Y0wN8hUfs6aOOtj0e9wAloipcVqw==
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
 include/linux/bpf_verifier.h |  34 ++++++---
 kernel/bpf/verifier.c        | 139 +++++++++++++++++++++++++----------
 2 files changed, 122 insertions(+), 51 deletions(-)

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
index 797cf3ed32e0..0e3f2f124983 100644
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
@@ -11554,7 +11622,7 @@ static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state
 	struct bpf_verifier_state *state = env->cur_state;
 	struct btf_record *rec = reg_btf_record(reg);

-	if (!state->active_lock.ptr) {
+	if (!state->active_lock) {
 		verbose(env, "verifier internal error: ref_set_non_owning w/o active lock\n");
 		return -EFAULT;
 	}
@@ -11651,6 +11719,7 @@ static int ref_convert_owning_non_owning(struct bpf_verifier_env *env, u32 ref_o
  */
 static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
+	struct bpf_reference_state *s;
 	void *ptr;
 	u32 id;

@@ -11667,10 +11736,10 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
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
@@ -15786,17 +15855,17 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	 * gen_ld_abs() may terminate the program at runtime, leading to
 	 * reference leak.
 	 */
+	if (env->cur_state->active_lock) {
+		verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_spin_lock-ed region\n");
+		return -EINVAL;
+	}
+
 	err = check_reference_leak(env, false);
 	if (err) {
 		verbose(env, "BPF_LD_[ABS|IND] cannot be mixed with socket references\n");
 		return err;
 	}

-	if (env->cur_state->active_lock.ptr) {
-		verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_spin_lock-ed region\n");
-		return -EINVAL;
-	}
-
 	if (env->cur_state->active_rcu_lock) {
 		verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_rcu_read_lock-ed region\n");
 		return -EINVAL;
@@ -17552,7 +17621,9 @@ static bool refsafe(struct bpf_func_state *old, struct bpf_func_state *cur,
 		return false;

 	for (i = 0; i < old->acquired_refs; i++) {
-		if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap))
+		if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap) ||
+		    old->refs[i].type != cur->refs[i].type ||
+		    old->refs[i].ptr != cur->refs[i].ptr)
 			return false;
 	}

@@ -17631,17 +17702,7 @@ static bool states_equal(struct bpf_verifier_env *env,
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
@@ -18542,7 +18603,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}

-				if (env->cur_state->active_lock.ptr) {
+				if (env->cur_state->active_lock) {
 					if ((insn->src_reg == BPF_REG_0 && insn->imm != BPF_FUNC_spin_unlock) ||
 					    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
 					     (insn->off != 0 || !is_bpf_graph_api_kfunc(insn->imm)))) {
@@ -18591,7 +18652,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 process_bpf_exit_full:
-				if (env->cur_state->active_lock.ptr && !env->cur_state->curframe) {
+				if (env->cur_state->active_lock && !env->cur_state->curframe) {
 					verbose(env, "bpf_spin_unlock is missing\n");
 					return -EINVAL;
 				}
--
2.43.5


