Return-Path: <bpf+bounces-45762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B04769DAEF9
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 22:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0E62818D8
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 21:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE71C2036F5;
	Wed, 27 Nov 2024 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYov/jZ6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE7D14EC60
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 21:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732743344; cv=none; b=Sk+q5lRW1/U4YmngnT9vyN3cAZtqEezUFNjqNqzjxrgg5jnBVrMuQm8GAUFD6u/V/mn0d1qVQ4tQcG31FpYvCi2hwZ+ckgLBR3bbh3BiNQcVZM52VfatO4VaJXu2G2O8i8m9YuJGGfbealy40X1uWwNST8R8WOHtGMdj0RL8fuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732743344; c=relaxed/simple;
	bh=+lbvwqryOE2W6P45sCY/CQfIp65/Ra0f06fAzDGT4+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trTd4hQUZV5zacUmv/7ORfecRtCDE/SYfpd+Sc4K6IzHpu37jISC5TJY0SLeTbe8RXLI836ApvchRZftX3QPiZ2rGmsdz6KnTShGDrKeWrgJ4hvjpa5KKQ7L9jFc4Xit3iJKZQdxkey6CdTS/vZWewhEcueo9BV0LtarQV1My8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYov/jZ6; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-382378f359dso142111f8f.1
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 13:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732743340; x=1733348140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyFj/w4NJo/EiVDGBkkt3HCkn23xq83hNOiKaFrtX/0=;
        b=fYov/jZ6i4ZBKfxjABiqDsjdfTBwUpXju5vIR3tJ/vYKxF/UDyZMFo+Cop7vbbeR6m
         gigqoM86Vy/AXJWDOWrBYwzlq30TAytdDlcjUSJr9NuV6GlyCPdUK1xNAebn6Q6rgenO
         2+Tqlo1bvtp/IS8fIE8pulVSgkZf+b0Njd1VuOjj/7AlL5mfxZmdAs0+JvDTJ0TfSRac
         zyv+NURkbdigGGaGAWfABz9PsonZA94d3L9L/O3DjQY+hGkLBAZlTEVDFt/FhlHRiIKS
         A+DY+tmiey37p3kAP3YdTcSINKoDzxCNvDg43UAOCgqSP4KdXZfEpRN0NHljr+Au9Cgq
         t+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732743340; x=1733348140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyFj/w4NJo/EiVDGBkkt3HCkn23xq83hNOiKaFrtX/0=;
        b=qH3q/rVfjruLdX3cOq86rXhvsEF3k7JkWf0K4KL4SNdxhI3Sxp5F/5JXkX7FK4p0EA
         aS07ktQodZodF9d2+BuSa49QEs0gH7qt9E2rqafhA9CyLwukypp47hFebeVCddC5kDM5
         yMNQC/O8rRK3S137R+WNdjNzv8a5AW7hmJzXPwX7UpMd6/tNJxp8lLnAgdS9rtxoEsQD
         IrKry98WK32zWrHhKxTO1XfFy4aOhq0aFOY7mZd2r1JcjxTrhaJ4AJijiVihivs8zrCF
         EbtocACgAri+cnR59WVQNjAt4lK/1+eGSNTLBGCAQMEmhoATnPcaVsB/ZPVn9WJ5hdC7
         mykg==
X-Gm-Message-State: AOJu0YyXXpJZ3BkhEykP/ogci9Rf/XXYmTYjoz+XmZNmZcUOL9Pu8sCg
	aC+acFX0iLuEX/tnLd7cRKSvjr3ECH4cZ9OziKOEHqPekW8qBw3YT/JgGHA1QVA=
X-Gm-Gg: ASbGncuDWO5B/26Lxy1XQRwgFyR/0wqJzdoRi+sXNF3952vd+cE2iqDeUKR/hzMyCUD
	x6Ene1i8S2WTfjRLq3FR0UnPz+G4uVlLpBOBfE0AvEDHMcFDsQOd1tSn8Rp3zO7rm27cjP3/L8n
	l9Y3EceV48MOLWmV9EVvHjStT1x23i2BaOMdyCu3yKdmP1VOAGu8/I42Ibzm21UuacBbVG5/rX0
	/FgzAjx4CDxiMuZV/EToZTWbYq02L3xjbLuWk++AZ8U6q7YF/ICmaYKcZWoPpb3rkN8tp+ggONo
	pg==
X-Google-Smtp-Source: AGHT+IGdvO4bgXCS1d5nHFwZ2A7gvg4lTSbjm87AYmYr49MckcNVbyC4O74iaTLgr8SH//hF0+1GUA==
X-Received: by 2002:adf:e191:0:b0:382:4b5c:4199 with SMTP id ffacd0b85a97d-385c6eb725dmr4103642f8f.23.1732743339867;
        Wed, 27 Nov 2024 13:35:39 -0800 (PST)
Received: from localhost (fwdproxy-cln-116.fbsv.net. [2a03:2880:31ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb2685csm17691635f8f.46.2024.11.27.13.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 13:35:39 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 2/7] bpf: Refactor {acquire,release}_reference_state
Date: Wed, 27 Nov 2024 13:35:30 -0800
Message-ID: <20241127213535.3657472-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127213535.3657472-1-memxor@gmail.com>
References: <20241127213535.3657472-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9386; h=from:subject; bh=+lbvwqryOE2W6P45sCY/CQfIp65/Ra0f06fAzDGT4+E=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR46tL/DlFkU+TVBd+Gdd2AGUfKzuJOe+YbJRWprV S/dy0lGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0eOrQAKCRBM4MiGSL8RyhpvD/ 9QK5ujTqCCZG0KbkoG5nrhi225UMlT/MG14AmDpn4lUHeIgLidz/wtbLHR3vGEgCzRoDEgmRCUx2va rLJwZ+7nP3TY8faWZBgxLXQjhx0veqsiLdnbDmRRbR6BP1wxrNykMQ9rnE6DciRSdKdFhCFNR8+I0S 6Z0VmJtR2wXU4AJVV/k/HHfVYbeNs/q0TsDcZ3ekXouGBwlgmyJJQeylAxDqUO5O0dF7h6q3M1fl/N 8Y/KxGT2bIxgMffZ+Q0xwyAyocnicqVncsrDbUpciISFRDJTbQDeucmf/0sScFBEmhEHoSnFQSK/GT 57JRCA8bi8ETjw09jYjnwpk6HmyOzFJDdoz31cqOqqFyHqW0ofMTYOIUrGPzfr59lK5LJfA4uBM571 Khp7RnOthA3LOZkgS+jImL5T+GalvGg6CNBZ7mNc4HiJVuilIn3grWTZBEz/Mdg1ZQwG7cvdIH4Nbp hNoEwd/7kZluzt5IP6v3cAwuFbhvi7n1oQbz+y2nojqjbFnHLfZTLBfD+7VjmqsZUxXRUYoBuX42St qyAJyZF5AH2u14McPeG8NLguUH6EybvmcgBTEjgq+Zhg8nD47cW9MZk8s1wn99eJHdw2ZZ5tCgEYGV TYWfFXoTjuldjpOh0R9yxC7DKSNdnW5KAiLX64aIuLxow2X6h6x+UD0kuJvg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

In preparation for introducing support for more reference types which
have to add and remove reference state, refactor the
acquire_reference_state and release_reference_state functions to share
common logic.

The acquire_reference_state function simply handles growing the acquired
refs and returning the pointer to the new uninitialized element, which
can be filled in by the caller.

The release_reference_state function simply erases a reference state
entry in the acquired_refs array and shrinks it. The callers are
responsible for finding the suitable element by matching on various
fields of the reference state and requesting deletion through this
function. It is not supposed to be called directly.

Existing callers of release_reference_state were using it to find and
remove state for a given ref_obj_id without scrubbing the associated
registers in the verifier state. Introduce release_reference_nomark to
provide this functionality and convert callers. We now use this new
release_reference_nomark function within release_reference as well.
It needs to operate on a verifier state instead of taking verifier env
as mark_ptr_or_null_regs requires operating on verifier state of the
two branches of a NULL condition check, therefore env->cur_state cannot
be used directly.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 113 +++++++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 50 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f8313e95eb8e..474cca3e8f66 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -196,7 +196,8 @@ struct bpf_verifier_stack_elem {
 
 #define BPF_PRIV_STACK_MIN_SIZE		64
 
-static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx);
+static int acquire_reference(struct bpf_verifier_env *env, int insn_idx);
+static int release_reference_nomark(struct bpf_verifier_state *state, int ref_obj_id);
 static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
 static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
@@ -771,7 +772,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		if (clone_ref_obj_id)
 			id = clone_ref_obj_id;
 		else
-			id = acquire_reference_state(env, insn_idx);
+			id = acquire_reference(env, insn_idx);
 
 		if (id < 0)
 			return id;
@@ -1033,7 +1034,7 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 	if (spi < 0)
 		return spi;
 
-	id = acquire_reference_state(env, insn_idx);
+	id = acquire_reference(env, insn_idx);
 	if (id < 0)
 		return id;
 
@@ -1349,77 +1350,69 @@ static int grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state
  * On success, returns a valid pointer id to associate with the register
  * On failure, returns a negative errno.
  */
-static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
+static struct bpf_reference_state *acquire_reference_state(struct bpf_verifier_env *env, int insn_idx, bool gen_id)
 {
 	struct bpf_verifier_state *state = env->cur_state;
 	int new_ofs = state->acquired_refs;
-	int id, err;
+	int err;
 
 	err = resize_reference_state(state, state->acquired_refs + 1);
 	if (err)
-		return err;
-	id = ++env->id_gen;
-	state->refs[new_ofs].type = REF_TYPE_PTR;
-	state->refs[new_ofs].id = id;
+		return NULL;
+	if (gen_id)
+		state->refs[new_ofs].id = ++env->id_gen;
 	state->refs[new_ofs].insn_idx = insn_idx;
 
-	return id;
+	return &state->refs[new_ofs];
+}
+
+static int acquire_reference(struct bpf_verifier_env *env, int insn_idx)
+{
+	struct bpf_reference_state *s;
+
+	s = acquire_reference_state(env, insn_idx, true);
+	if (!s)
+		return -ENOMEM;
+	s->type = REF_TYPE_PTR;
+	return s->id;
 }
 
 static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum ref_state_type type,
 			      int id, void *ptr)
 {
 	struct bpf_verifier_state *state = env->cur_state;
-	int new_ofs = state->acquired_refs;
-	int err;
+	struct bpf_reference_state *s;
 
-	err = resize_reference_state(state, state->acquired_refs + 1);
-	if (err)
-		return err;
-	state->refs[new_ofs].type = type;
-	state->refs[new_ofs].id = id;
-	state->refs[new_ofs].insn_idx = insn_idx;
-	state->refs[new_ofs].ptr = ptr;
+	s = acquire_reference_state(env, insn_idx, false);
+	s->type = type;
+	s->id = id;
+	s->ptr = ptr;
 
 	state->active_locks++;
 	return 0;
 }
 
-/* release function corresponding to acquire_reference_state(). Idempotent. */
-static int release_reference_state(struct bpf_verifier_state *state, int ptr_id)
+static void release_reference_state(struct bpf_verifier_state *state, int idx)
 {
-	int i, last_idx;
+	int last_idx;
 
 	last_idx = state->acquired_refs - 1;
-	for (i = 0; i < state->acquired_refs; i++) {
-		if (state->refs[i].type != REF_TYPE_PTR)
-			continue;
-		if (state->refs[i].id == ptr_id) {
-			if (last_idx && i != last_idx)
-				memcpy(&state->refs[i], &state->refs[last_idx],
-				       sizeof(*state->refs));
-			memset(&state->refs[last_idx], 0, sizeof(*state->refs));
-			state->acquired_refs--;
-			return 0;
-		}
-	}
-	return -EINVAL;
+	if (last_idx && idx != last_idx)
+		memcpy(&state->refs[idx], &state->refs[last_idx], sizeof(*state->refs));
+	memset(&state->refs[last_idx], 0, sizeof(*state->refs));
+	state->acquired_refs--;
+	return;
 }
 
 static int release_lock_state(struct bpf_verifier_state *state, int type, int id, void *ptr)
 {
-	int i, last_idx;
+	int i;
 
-	last_idx = state->acquired_refs - 1;
 	for (i = 0; i < state->acquired_refs; i++) {
 		if (state->refs[i].type != type)
 			continue;
 		if (state->refs[i].id == id && state->refs[i].ptr == ptr) {
-			if (last_idx && i != last_idx)
-				memcpy(&state->refs[i], &state->refs[last_idx],
-				       sizeof(*state->refs));
-			memset(&state->refs[last_idx], 0, sizeof(*state->refs));
-			state->acquired_refs--;
+			release_reference_state(state, i);
 			state->active_locks--;
 			return 0;
 		}
@@ -9666,21 +9659,41 @@ static void mark_pkt_end(struct bpf_verifier_state *vstate, int regn, bool range
 		reg->range = AT_PKT_END;
 }
 
+static int release_reference_nomark(struct bpf_verifier_state *state, int ref_obj_id)
+{
+	int i;
+
+	for (i = 0; i < state->acquired_refs; i++) {
+		if (state->refs[i].type != REF_TYPE_PTR)
+			continue;
+		if (state->refs[i].id == ref_obj_id) {
+			release_reference_state(state, i);
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
 /* The pointer with the specified id has released its reference to kernel
  * resources. Identify all copies of the same pointer and clear the reference.
+ *
+ * This is the release function corresponding to acquire_reference(). Idempotent.
+ * The 'mark' boolean is used to optionally skip scrubbing registers matching
+ * the ref_obj_id, in case they need to be switched to some other type instead
+ * of havoc scalar value.
  */
-static int release_reference(struct bpf_verifier_env *env,
-			     int ref_obj_id)
+static int release_reference(struct bpf_verifier_env *env, int ref_obj_id)
 {
+	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
 	int err;
 
-	err = release_reference_state(env->cur_state, ref_obj_id);
+	err = release_reference_nomark(vstate, ref_obj_id);
 	if (err)
 		return err;
 
-	bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
+	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
 		if (reg->ref_obj_id == ref_obj_id)
 			mark_reg_invalid(env, reg);
 	}));
@@ -10774,7 +10787,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			struct bpf_func_state *state;
 			struct bpf_reg_state *reg;
 
-			err = release_reference_state(env->cur_state, ref_obj_id);
+			err = release_reference_nomark(env->cur_state, ref_obj_id);
 			if (!err) {
 				bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
 					if (reg->ref_obj_id == ref_obj_id) {
@@ -11107,7 +11120,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
 	} else if (is_acquire_function(func_id, meta.map_ptr)) {
-		int id = acquire_reference_state(env, insn_idx);
+		int id = acquire_reference(env, insn_idx);
 
 		if (id < 0)
 			return id;
@@ -13087,7 +13100,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
 		if (is_kfunc_acquire(&meta)) {
-			int id = acquire_reference_state(env, insn_idx);
+			int id = acquire_reference(env, insn_idx);
 
 			if (id < 0)
 				return id;
@@ -15387,7 +15400,7 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
 		 * No one could have freed the reference state before
 		 * doing the NULL check.
 		 */
-		WARN_ON_ONCE(release_reference_state(vstate, id));
+		WARN_ON_ONCE(release_reference_nomark(vstate, id));
 
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
 		mark_ptr_or_null_reg(state, reg, id, is_null);
-- 
2.43.5


