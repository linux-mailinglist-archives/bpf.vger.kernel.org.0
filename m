Return-Path: <bpf+bounces-45847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A786A9DBE30
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 01:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6880C28253C
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 00:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100D9BA4B;
	Fri, 29 Nov 2024 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQdnWioE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C701361
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 00:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732839401; cv=none; b=kS4eHx6bC9+EY7rFtdPvPQ4QF3U26uuc4FNbCfIYg8Le0yuycXbRuD4aOBtVEqXU8kQLIVbNFaBR7C700eyA/DQxy77elKyCtWleEyPDP9PW/+OHGnw/nknpZ/TPHQPCJMoaqfNP4/uPhSGUBemOJ4aLzPt3mt7UC6LUuxneiwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732839401; c=relaxed/simple;
	bh=b6A9Sq+dcJrIxm33umvU5X4PCID8c2ZwDQnYB3XCwCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBF84Ehfia/9OuggWgJWrGL9CsnwlnMVYErqmPWSoM6jMMp3ehWWfKAICHcCaQNv3ffk5qdxLmLHkzhgw2x7jwheO0LROIbbPkyhp9Sr8bEi2wAN0SDEGpBijoI+syYRPyyZOs1n9Nu8GJWe2TGu1kxPahakitxv55pvXrF2zsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQdnWioE; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-38248b810ffso1055233f8f.0
        for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 16:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732839397; x=1733444197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxSdUOZ9lp0kpOdMrRaurjM+bIrsLW2x1ddJhnZ8SQk=;
        b=cQdnWioEXLR6CJrGXR4osT0irKcAFOAHzO7UtoNz7YaUJIR91JAeOazG9vKcZd+/6M
         nVEY+UPur99vr41jwX3pnw6DuWJsUS7yWJuyj+VEw1vmSiMBVI4q9iIOhgbllpNFzGlh
         pEps5YQQliDOX2g4/oD0jGvEoEcHpqxO5akPERAtn32gZdnEULfqhBPE8PdH9G+nInk3
         cGoTbr+RvrRpR13EeF8sYXZvBAxdDYzAyJLxMj4rut3J60Gf5EV5chgNUfYcmxbtUnU9
         uqNirDppQbq3n5aUEZsjc9Oj6fAKCPXUrtm9FTenHgc2fPCrRDK21EbRrvNjX2bTouOW
         YwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732839397; x=1733444197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxSdUOZ9lp0kpOdMrRaurjM+bIrsLW2x1ddJhnZ8SQk=;
        b=asWWnyqU7r5ByD5LZCp+jB+E/aGMyzVsBJ/lBLm+howcWQJF0ERmkhY3AfBChgmFxG
         u0gqFO/RutTq25xlG8a0yulPfnJCqqYj3SZaTWRJXX3d/czDO2saa6qP/bE+i1ku70t9
         wfd/vn3MA2iZiD82YyH3BFGTZUrjzW3S0mEkCVm18dtfZQLKuGFRvSjtDF9QmqT4DGuE
         eZaC49pyFpgHmg+SjyAyFw6N8hxDbbLDXPu/ROkV/VaLy7Uok5nreiVEQRaNytiOKE43
         6p4Ckhgui9Cpv+6pTmcE6ZLYjFZ3Ug3aXqnbzrYOa7dewaoK2Aqcr/XKswaj20E63DE+
         Ijzg==
X-Gm-Message-State: AOJu0Yyb8um+JMsCMnHz3P8+JZVD/PFzhcWmD5r5rfGFH8r/lotCrkt5
	U8To0kYDbAjNABqoLAtDlhUdjVSZrRHC0YDVMT0TtYIok+CmRyQuGbMIZrcanPU=
X-Gm-Gg: ASbGnctmmZ/ih2C1Oiu2NJfJ7lNLhcC1mnuE7uR/umnY8wWm/yaT3XR1Ic/xOzm5eur
	AIrKOrU2yJSbfdjJPs55HxaLeXJfhpl6kFTVMBUVn+JWJtt7PDvhoeC3GArxbP0X4nYsP+WBLsU
	vu3DfTei5vk0qv3NaV/NPCRcgzrY5yx5TDuyy3fHUWaSB2r27l9QdFUDyw10rfALOVt8KX4H/QW
	svmBScdDRxn58l0Qb0XzDyNqR6lf1dk8JtyZS/s45EZRUCd7o8wO3x/tKq6gtdZkhu995P20lU3
X-Google-Smtp-Source: AGHT+IFzQTQYklAh5xIkxWyShc9QADtyp3xNqOrW1rvqD5b59hCDVXHXdkqBD8ZCtfviAW0sMgu7bw==
X-Received: by 2002:a5d:47cb:0:b0:382:22c6:7bcb with SMTP id ffacd0b85a97d-385c6eb4c32mr8759305f8f.3.1732839396847;
        Thu, 28 Nov 2024 16:16:36 -0800 (PST)
Received: from localhost (fwdproxy-cln-002.fbsv.net. [2a03:2880:31ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2e940sm2831526f8f.15.2024.11.28.16.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 16:16:35 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 2/7] bpf: Refactor {acquire,release}_reference_state
Date: Thu, 28 Nov 2024 16:16:27 -0800
Message-ID: <20241129001632.3828611-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241129001632.3828611-1-memxor@gmail.com>
References: <20241129001632.3828611-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9197; h=from:subject; bh=b6A9Sq+dcJrIxm33umvU5X4PCID8c2ZwDQnYB3XCwCw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnSQfboPyh8YjAr3a2JQ7ZYlRooDhv7s4X2NOjLkZV ZGauIEiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0kH2wAKCRBM4MiGSL8RygxKD/ 90lKxRZvHXJ3rrDr06inextpfJYhRjo1PetxdrT3eFYhwRB7VjteZY3/21aboQbcnH0atAUzdwg4Dn FKCCcs71jhFMKKWtcx9VTblb0Bk3fcUHv8bgNYQ/WDn1lwKwopn/xk+384CKt1cL+oiFRrc6t6e3sZ 5pfXfV5tD5rIThoYg1JpJwZtplUQagCcDnD9HUuKxx8cQzL2Rv3f31lWNownP7YXYlakJPGiOwCmMi cDS8VHRFujT42d6A252+Y2/suKWks1jMmGQRToc1awCNq9nrWgJhVbtfW17wLwtzB9jSwnJvcxQLq8 CLGFwyppEAQMr2fAltGTMF5eCVsU1hWX7xGhZxJAXs4w5UKrIc5eJi3VHHaJzR58HNm07+Xj6Wfzqp WqqrMq1LpcXRhR8RPqpjiC1f7hb4Djhl4raYCyh56MJXKjs26MUyn05cImRUGfrLjfYa20FRUp941b 0AMUxNeN9+ACVRhAaBVVI9TcFg4QfPljHMMl8Ly3dYhNLueeMCsQVGAsW20Y4jnDTHr78CGPGZHBz2 cAyc9h5ZJnUPF2MKCgQL8f/aJ1JXSfv2KCacidtf/1Jk3slTmR67Me1lnaEnVfBbpOZbBXIS4hfHFV nWh6fiIl7m8W7Fd63Z9BTDuigzn6/gVf+NqTad+BwL1Ye+/LV80sutY0Hqsg==
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
 kernel/bpf/verifier.c | 110 +++++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 50 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 019c56c782a2..91bcd84fabff 100644
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
@@ -9666,21 +9659,38 @@ static void mark_pkt_end(struct bpf_verifier_state *vstate, int regn, bool range
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
@@ -10774,7 +10784,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			struct bpf_func_state *state;
 			struct bpf_reg_state *reg;
 
-			err = release_reference_state(env->cur_state, ref_obj_id);
+			err = release_reference_nomark(env->cur_state, ref_obj_id);
 			if (!err) {
 				bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
 					if (reg->ref_obj_id == ref_obj_id) {
@@ -11107,7 +11117,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
 	} else if (is_acquire_function(func_id, meta.map_ptr)) {
-		int id = acquire_reference_state(env, insn_idx);
+		int id = acquire_reference(env, insn_idx);
 
 		if (id < 0)
 			return id;
@@ -13087,7 +13097,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
 		if (is_kfunc_acquire(&meta)) {
-			int id = acquire_reference_state(env, insn_idx);
+			int id = acquire_reference(env, insn_idx);
 
 			if (id < 0)
 				return id;
@@ -15387,7 +15397,7 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
 		 * No one could have freed the reference state before
 		 * doing the NULL check.
 		 */
-		WARN_ON_ONCE(release_reference_state(vstate, id));
+		WARN_ON_ONCE(release_reference_nomark(vstate, id));
 
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
 		mark_ptr_or_null_reg(state, reg, id, is_null);
-- 
2.43.5


