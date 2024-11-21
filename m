Return-Path: <bpf+bounces-45313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB169D4523
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 01:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E531F21FF9
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 00:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4920A535DC;
	Thu, 21 Nov 2024 00:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDPyG4H6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F5645979
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 00:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732150416; cv=none; b=bSppZvu3CjUnxqLJfsbO1t9uFijnih0gKwnEoe4VQBTNIbe/a84CXGRB7j5GhTwpPyYGwvLYEFfZBOaKTo8jCsLN7jUHL9nrHr6+JFC744Iw8HTY8FGiMuPDvLctCRFMnJUhVjN8MejtCdUw2HffGjkY7PXKRGeJ9ydl6t1c5MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732150416; c=relaxed/simple;
	bh=fCDcAN+4zc4C3MttQjgY7FqxujvS/RrgChgtcrDkD6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3BEcpZG+x50G+1+3cybenIwg+l5ejYHaudoePhHuqs4EW2z3H8gfU5ab/6V3qs2ztbN7SuT9jhIQtA6r5SLztvvABuYYNMyZ43nDZZwDpEPdF1QxijVnlkzdpp96LWj+R2Y3PPf9K36om/mDog1wk/OKsc/2ajuzmHgEU/s2HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDPyG4H6; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso2371955e9.3
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 16:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732150412; x=1732755212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVL6vU9VsC7sSPIJgIB2KdqVwc84j5czVKw3PnYJPD8=;
        b=aDPyG4H6h/XEkXJ75sR5lVzCmRBLG64dC344rkLI+QNeWSakKTMsXj4UUnsztTvFWm
         0s91aKPzMH/ZvjGru9MgxVQMeuAJK6dkBIQsKT7QPNJAoDmX4H++t63aNL8+X4p4Tck8
         nMsxeEVlM33KE0BiD8Lr4f3uWeqNZBjBfxAhMcLEz3726yhI1fMrmPwyAQ+Oku6KiYRj
         W+iTRC7z2mJRtiaSTzZGdYDgnS2kawqaO6XDSevN9IDA4nYPduRrcTTiBzRQB23QIswG
         v6H7xqEM13kf1OGh3vPqDyQXfjGyFKs00D5FGAWyyuWSFMH3ZA/tnlZSElUVVqj3203l
         ulbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732150412; x=1732755212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVL6vU9VsC7sSPIJgIB2KdqVwc84j5czVKw3PnYJPD8=;
        b=n8OOfTIkKrhITfWbsDYnBxPheaRMvbreADLtmFHvpeJf7gIElIA9RyyPgyngJ/eoG8
         o44gixwYM/iad+ytrfdRkMCa14ZZ2XBEwKAep0QszWQx7WiDDc9t9e1mYU4Gkztd1XTs
         xTOFX7UAkcLGCs7/k0H7ozA1qUCL7/nHVVdSh5mwwe/hu0qEkQbfiJKjfmCobCVZGDMC
         3MFZw+PG0HK17cWWZR3B5BMsEbjTBjyQn0kGOicLuelUIgRuqmyAhAnRv9THltdv3nn5
         6zegy1S5s2YjiTrg1Y1MqXfOx+CRx1G1M8wgHs5g+a49c55ZZwIx+wZc9z8X7KmupWE+
         U0KQ==
X-Gm-Message-State: AOJu0YxUwQAAlydIJsCjyn4ajOA3W/F6H/+FtzIVWsl/YSvN+LmVd4/A
	r1H+XjlX3AlP2JX9qYN3GRG/Ftf1FZPxTCvp9FZds6CoeNslD0wjeg7rvo5lnZE=
X-Google-Smtp-Source: AGHT+IHAf0I6b2kri9VLZPn6Ve2fLQgtMxj3PmhcFtoE4bFJl5cQk2Gmz94zK8IC7XqIHxuLZWzaJg==
X-Received: by 2002:a05:600c:3493:b0:431:6060:8b16 with SMTP id 5b1f17b1804b1-4334f02c6f9mr46265175e9.30.1732150412119;
        Wed, 20 Nov 2024 16:53:32 -0800 (PST)
Received: from localhost (fwdproxy-cln-113.fbsv.net. [2a03:2880:31ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b463ad45sm37046915e9.39.2024.11.20.16.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 16:53:31 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v1 1/7] bpf: Refactor and rename resource management
Date: Wed, 20 Nov 2024 16:53:23 -0800
Message-ID: <20241121005329.408873-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241121005329.408873-1-memxor@gmail.com>
References: <20241121005329.408873-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16148; h=from:subject; bh=fCDcAN+4zc4C3MttQjgY7FqxujvS/RrgChgtcrDkD6w=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnPoQ2VfFjcLJ8qO84XhzNOTivvsBZ0yK/qKwrvEWt 1wXiZKWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZz6ENgAKCRBM4MiGSL8RykCdD/ 49I5u+85eVDTv0UASoHydBrkpPt426++jwF+uEaLypywsh0Wah7d2hAc/NyentGlBZ78DGgQfJcqbq 2rHl2oK+Cmeo7pKBpX3T9aO09IDWxyjOq8FjNWyCnxiiHe06XIgz2xBzmrcf8uif/IZxdIPrn35quo UGwRwV7HjSekZrCwm0BKMykSJiFlA4MmNvU55O7WhjYYtFCyMwtjrJXrO4OdaVRNYEXI/0HHEqya1b ypUCS+OrcmR334zTt5yqLMopvIn2hulU2mJo9iCR6WAOCYFVuIfNwYIvhUcGSFaG9lJSDAQWVnTj+O 8vrml9YrbTPw/8JuHR1B2rhF7hbwjn7hHVr15T1a0RbNr/XBKyzuTGmCj9SNKEQXpPu5Oc/On+ICxk UpORQtPlGfY2tlIfR6AifdR2+45qebydhPwlSsQ1w+padpGMAlDBjsxcBn4tOwfDSzOn50bLNWapkL 5uHbZE/ULihR4KQizQB/KOHflHyqZAtb00WPjzrs91WBVNn2c3jOtIDpnKl5UdMkFocw+rCSMb+Phb H4uL78mcH74IjnkiKMgO8y4x/T7qWwCRkZe3dysWq8DE1blAG71cwo5tWC1PXd+dbBFtF4UQqVibpZ mKr4jlIe+1v8SQY+pVzIiTgXFIUgM5iyKajf1dXGwsxI2BH5r95axrrQLxsQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

With the commit f6b9a69a9e56 ("bpf: Refactor active lock management"),
we have begun using the acquired_refs array to also store active lock
metadata, as a way to consolidate and manage all kernel resources that
the program may acquire.

This is beginning to cause some confusion and duplication in existing
code, where the terms references now both mean lock reference state and
the references for acquired kernel object pointers. To clarify and
improve the current state of affairs, as well as reduce code duplication,
make the following changes:

Rename bpf_reference_state to bpf_resource_state, and begin using
resource as the umbrella term. This terminology matches what we use in
check_resource_leak. Next, "reference" now only means RES_TYPE_PTR, and
the usage and meaning is updated accordingly.

Next, factor out common code paths for managing addition and removal of
resource state in acquire_resource_state and erase_resource_state, and
then implement type specific resource handling on top of these common
functions. Overall, this patch improves upon the confusion and minimizes
code duplication, as we prepare to introduce new resource types in
subsequent patches.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  24 +++--
 kernel/bpf/log.c             |  10 +-
 kernel/bpf/verifier.c        | 173 +++++++++++++++++++----------------
 3 files changed, 108 insertions(+), 99 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f4290c179bee..e5123b6804eb 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -249,20 +249,18 @@ struct bpf_stack_state {
 	u8 slot_type[BPF_REG_SIZE];
 };
 
-struct bpf_reference_state {
-	/* Each reference object has a type. Ensure REF_TYPE_PTR is zero to
-	 * default to pointer reference on zero initialization of a state.
-	 */
-	enum ref_state_type {
-		REF_TYPE_PTR = 0,
-		REF_TYPE_LOCK,
+struct bpf_resource_state {
+	enum res_state_type {
+		RES_TYPE_INV = -1,
+		RES_TYPE_PTR = 0,
+		RES_TYPE_LOCK,
 	} type;
-	/* Track each reference created with a unique id, even if the same
-	 * instruction creates the reference multiple times (eg, via CALL).
+	/* Track each resource created with a unique id, even if the same
+	 * instruction creates the resource multiple times (eg, via CALL).
 	 */
 	int id;
-	/* Instruction where the allocation of this reference occurred. This
-	 * is used purely to inform the user of a reference leak.
+	/* Instruction where the allocation of this resource occurred. This
+	 * is used purely to inform the user of a resource leak.
 	 */
 	int insn_idx;
 	/* Use to keep track of the source object of a lock, to ensure
@@ -315,9 +313,9 @@ struct bpf_func_state {
 	u32 callback_depth;
 
 	/* The following fields should be last. See copy_func_state() */
-	int acquired_refs;
+	int acquired_res;
 	int active_locks;
-	struct bpf_reference_state *refs;
+	struct bpf_resource_state *res;
 	/* The state of the stack. Each element of the array describes BPF_REG_SIZE
 	 * (i.e. 8) bytes worth of stack memory.
 	 * stack[0] represents bytes [*(r10-8)..*(r10-1)]
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 4a858fdb6476..0ad6f0737c57 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -843,11 +843,11 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_func_st
 			break;
 		}
 	}
-	if (state->acquired_refs && state->refs[0].id) {
-		verbose(env, " refs=%d", state->refs[0].id);
-		for (i = 1; i < state->acquired_refs; i++)
-			if (state->refs[i].id)
-				verbose(env, ",%d", state->refs[i].id);
+	if (state->acquired_res && state->res[0].id) {
+		verbose(env, " refs=%d", state->res[0].id);
+		for (i = 1; i < state->acquired_res; i++)
+			if (state->res[i].id)
+				verbose(env, ",%d", state->res[i].id);
 	}
 	if (state->in_callback_fn)
 		verbose(env, " cb");
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c4ebb326785..c106720d0c62 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1279,15 +1279,15 @@ static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
 	return arr ? arr : ZERO_SIZE_PTR;
 }
 
-static int copy_reference_state(struct bpf_func_state *dst, const struct bpf_func_state *src)
+static int copy_resource_state(struct bpf_func_state *dst, const struct bpf_func_state *src)
 {
-	dst->refs = copy_array(dst->refs, src->refs, src->acquired_refs,
-			       sizeof(struct bpf_reference_state), GFP_KERNEL);
-	if (!dst->refs)
+	dst->res = copy_array(dst->res, src->res, src->acquired_res,
+			      sizeof(struct bpf_resource_state), GFP_KERNEL);
+	if (!dst->res)
 		return -ENOMEM;
 
+	dst->acquired_res = src->acquired_res;
 	dst->active_locks = src->active_locks;
-	dst->acquired_refs = src->acquired_refs;
 	return 0;
 }
 
@@ -1304,14 +1304,14 @@ static int copy_stack_state(struct bpf_func_state *dst, const struct bpf_func_st
 	return 0;
 }
 
-static int resize_reference_state(struct bpf_func_state *state, size_t n)
+static int resize_resource_state(struct bpf_func_state *state, size_t n)
 {
-	state->refs = realloc_array(state->refs, state->acquired_refs, n,
-				    sizeof(struct bpf_reference_state));
-	if (!state->refs)
+	state->res = realloc_array(state->res, state->acquired_res, n,
+				   sizeof(struct bpf_resource_state));
+	if (!state->res)
 		return -ENOMEM;
 
-	state->acquired_refs = n;
+	state->acquired_res = n;
 	return 0;
 }
 
@@ -1342,6 +1342,25 @@ static int grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state
 	return 0;
 }
 
+static struct bpf_resource_state *acquire_resource_state(struct bpf_verifier_env *env, int insn_idx, int *id)
+{
+	struct bpf_func_state *state = cur_func(env);
+	int new_ofs = state->acquired_res;
+	struct bpf_resource_state *s;
+	int err;
+
+	err = resize_resource_state(state, state->acquired_res + 1);
+	if (err)
+		return NULL;
+	s = &state->res[new_ofs];
+	s->type = RES_TYPE_INV;
+	if (id)
+		*id = s->id = ++env->id_gen;
+	s->insn_idx = insn_idx;
+
+	return s;
+}
+
 /* Acquire a pointer id from the env and update the state->refs to include
  * this new pointer reference.
  * On success, returns a valid pointer id to associate with the register
@@ -1349,55 +1368,52 @@ static int grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state
  */
 static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
 {
-	struct bpf_func_state *state = cur_func(env);
-	int new_ofs = state->acquired_refs;
-	int id, err;
-
-	err = resize_reference_state(state, state->acquired_refs + 1);
-	if (err)
-		return err;
-	id = ++env->id_gen;
-	state->refs[new_ofs].type = REF_TYPE_PTR;
-	state->refs[new_ofs].id = id;
-	state->refs[new_ofs].insn_idx = insn_idx;
+	struct bpf_resource_state *s;
+	int id;
 
+	s = acquire_resource_state(env, insn_idx, &id);
+	if (!s)
+		return -ENOMEM;
+	s->type = RES_TYPE_PTR;
 	return id;
 }
 
-static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum ref_state_type type,
+static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum res_state_type type,
 			      int id, void *ptr)
 {
 	struct bpf_func_state *state = cur_func(env);
-	int new_ofs = state->acquired_refs;
-	int err;
+	struct bpf_resource_state *s;
 
-	err = resize_reference_state(state, state->acquired_refs + 1);
-	if (err)
-		return err;
-	state->refs[new_ofs].type = type;
-	state->refs[new_ofs].id = id;
-	state->refs[new_ofs].insn_idx = insn_idx;
-	state->refs[new_ofs].ptr = ptr;
+	s = acquire_resource_state(env, insn_idx, NULL);
+	if (!s)
+		return -ENOMEM;
+	s->type = type;
+	s->id = id;
+	s->ptr = ptr;
 
 	state->active_locks++;
 	return 0;
 }
 
-/* release function corresponding to acquire_reference_state(). Idempotent. */
+static void erase_resource_state(struct bpf_func_state *state, int res_idx)
+{
+	int last_idx = state->acquired_res - 1;
+
+	if (last_idx && res_idx != last_idx)
+		memcpy(&state->res[res_idx], &state->res[last_idx], sizeof(*state->res));
+	memset(&state->res[last_idx], 0, sizeof(*state->res));
+	state->acquired_res--;
+}
+
 static int release_reference_state(struct bpf_func_state *state, int ptr_id)
 {
-	int i, last_idx;
+	int i;
 
-	last_idx = state->acquired_refs - 1;
-	for (i = 0; i < state->acquired_refs; i++) {
-		if (state->refs[i].type != REF_TYPE_PTR)
+	for (i = 0; i < state->acquired_res; i++) {
+		if (state->res[i].type != RES_TYPE_PTR)
 			continue;
-		if (state->refs[i].id == ptr_id) {
-			if (last_idx && i != last_idx)
-				memcpy(&state->refs[i], &state->refs[last_idx],
-				       sizeof(*state->refs));
-			memset(&state->refs[last_idx], 0, sizeof(*state->refs));
-			state->acquired_refs--;
+		if (state->res[i].id == ptr_id) {
+			erase_resource_state(state, i);
 			return 0;
 		}
 	}
@@ -1406,18 +1422,13 @@ static int release_reference_state(struct bpf_func_state *state, int ptr_id)
 
 static int release_lock_state(struct bpf_func_state *state, int type, int id, void *ptr)
 {
-	int i, last_idx;
+	int i;
 
-	last_idx = state->acquired_refs - 1;
-	for (i = 0; i < state->acquired_refs; i++) {
-		if (state->refs[i].type != type)
+	for (i = 0; i < state->acquired_res; i++) {
+		if (state->res[i].type != type)
 			continue;
-		if (state->refs[i].id == id && state->refs[i].ptr == ptr) {
-			if (last_idx && i != last_idx)
-				memcpy(&state->refs[i], &state->refs[last_idx],
-				       sizeof(*state->refs));
-			memset(&state->refs[last_idx], 0, sizeof(*state->refs));
-			state->acquired_refs--;
+		if (state->res[i].id == id && state->res[i].ptr == ptr) {
+			erase_resource_state(state, i);
 			state->active_locks--;
 			return 0;
 		}
@@ -1425,16 +1436,16 @@ static int release_lock_state(struct bpf_func_state *state, int type, int id, vo
 	return -EINVAL;
 }
 
-static struct bpf_reference_state *find_lock_state(struct bpf_verifier_env *env, enum ref_state_type type,
+static struct bpf_resource_state *find_lock_state(struct bpf_verifier_env *env, enum res_state_type type,
 						   int id, void *ptr)
 {
 	struct bpf_func_state *state = cur_func(env);
 	int i;
 
-	for (i = 0; i < state->acquired_refs; i++) {
-		struct bpf_reference_state *s = &state->refs[i];
+	for (i = 0; i < state->acquired_res; i++) {
+		struct bpf_resource_state *s = &state->res[i];
 
-		if (s->type == REF_TYPE_PTR || s->type != type)
+		if (s->type == RES_TYPE_PTR || s->type != type)
 			continue;
 
 		if (s->id == id && s->ptr == ptr)
@@ -1447,7 +1458,7 @@ static void free_func_state(struct bpf_func_state *state)
 {
 	if (!state)
 		return;
-	kfree(state->refs);
+	kfree(state->res);
 	kfree(state->stack);
 	kfree(state);
 }
@@ -1473,8 +1484,8 @@ static int copy_func_state(struct bpf_func_state *dst,
 {
 	int err;
 
-	memcpy(dst, src, offsetof(struct bpf_func_state, acquired_refs));
-	err = copy_reference_state(dst, src);
+	memcpy(dst, src, offsetof(struct bpf_func_state, acquired_res));
+	err = copy_resource_state(dst, src);
 	if (err)
 		return err;
 	return copy_stack_state(dst, src);
@@ -7907,7 +7918,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 				"Locking two bpf_spin_locks are not allowed\n");
 			return -EINVAL;
 		}
-		err = acquire_lock_state(env, env->insn_idx, REF_TYPE_LOCK, reg->id, ptr);
+		err = acquire_lock_state(env, env->insn_idx, RES_TYPE_LOCK, reg->id, ptr);
 		if (err < 0) {
 			verbose(env, "Failed to acquire lock state\n");
 			return err;
@@ -7925,7 +7936,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 			return -EINVAL;
 		}
 
-		if (release_lock_state(cur_func(env), REF_TYPE_LOCK, reg->id, ptr)) {
+		if (release_lock_state(cur_func(env), RES_TYPE_LOCK, reg->id, ptr)) {
 			verbose(env, "bpf_spin_unlock of different lock\n");
 			return -EINVAL;
 		}
@@ -9758,7 +9769,7 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 			state->curframe + 1 /* frameno within this callchain */,
 			subprog /* subprog number within this prog */);
 	/* Transfer references to the callee */
-	err = copy_reference_state(callee, caller);
+	err = copy_resource_state(callee, caller);
 	err = err ?: set_callee_state_cb(env, caller, callee, callsite);
 	if (err)
 		goto err_out;
@@ -10334,7 +10345,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	}
 
 	/* Transfer references to the caller */
-	err = copy_reference_state(caller, callee);
+	err = copy_resource_state(caller, callee);
 	if (err)
 		return err;
 
@@ -10509,11 +10520,11 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
 	if (!exception_exit && state->frameno)
 		return 0;
 
-	for (i = 0; i < state->acquired_refs; i++) {
-		if (state->refs[i].type != REF_TYPE_PTR)
+	for (i = 0; i < state->acquired_res; i++) {
+		if (state->res[i].type != RES_TYPE_PTR)
 			continue;
 		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
-			state->refs[i].id, state->refs[i].insn_idx);
+			state->res[i].id, state->res[i].insn_idx);
 		refs_lingering = true;
 	}
 	return refs_lingering ? -EINVAL : 0;
@@ -11777,8 +11788,8 @@ static int ref_convert_owning_non_owning(struct bpf_verifier_env *env, u32 ref_o
 		return -EFAULT;
 	}
 
-	for (i = 0; i < state->acquired_refs; i++) {
-		if (state->refs[i].id != ref_obj_id)
+	for (i = 0; i < state->acquired_res; i++) {
+		if (state->res[i].id != ref_obj_id)
 			continue;
 
 		/* Clear ref_obj_id here so release_reference doesn't clobber
@@ -11843,7 +11854,7 @@ static int ref_convert_owning_non_owning(struct bpf_verifier_env *env, u32 ref_o
  */
 static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
-	struct bpf_reference_state *s;
+	struct bpf_resource_state *s;
 	void *ptr;
 	u32 id;
 
@@ -11862,7 +11873,7 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
 
 	if (!cur_func(env)->active_locks)
 		return -EINVAL;
-	s = find_lock_state(env, REF_TYPE_LOCK, id, ptr);
+	s = find_lock_state(env, RES_TYPE_LOCK, id, ptr);
 	if (!s) {
 		verbose(env, "held lock and object are not in the same allocation\n");
 		return -EINVAL;
@@ -17750,27 +17761,27 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 	return true;
 }
 
-static bool refsafe(struct bpf_func_state *old, struct bpf_func_state *cur,
+static bool ressafe(struct bpf_func_state *old, struct bpf_func_state *cur,
 		    struct bpf_idmap *idmap)
 {
 	int i;
 
-	if (old->acquired_refs != cur->acquired_refs)
+	if (old->acquired_res != cur->acquired_res)
 		return false;
 
-	for (i = 0; i < old->acquired_refs; i++) {
-		if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap) ||
-		    old->refs[i].type != cur->refs[i].type)
+	for (i = 0; i < old->acquired_res; i++) {
+		if (!check_ids(old->res[i].id, cur->res[i].id, idmap) ||
+		    old->res[i].type != cur->res[i].type)
 			return false;
-		switch (old->refs[i].type) {
-		case REF_TYPE_PTR:
+		switch (old->res[i].type) {
+		case RES_TYPE_PTR:
 			break;
-		case REF_TYPE_LOCK:
-			if (old->refs[i].ptr != cur->refs[i].ptr)
+		case RES_TYPE_LOCK:
+			if (old->res[i].ptr != cur->res[i].ptr)
 				return false;
 			break;
 		default:
-			WARN_ONCE(1, "Unhandled enum type for reference state: %d\n", old->refs[i].type);
+			WARN_ONCE(1, "Unhandled enum type for resource state: %d\n", old->res[i].type);
 			return false;
 		}
 	}
@@ -17820,7 +17831,7 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
 		return false;
 
-	if (!refsafe(old, cur, &env->idmap_scratch))
+	if (!ressafe(old, cur, &env->idmap_scratch))
 		return false;
 
 	return true;
-- 
2.43.5


