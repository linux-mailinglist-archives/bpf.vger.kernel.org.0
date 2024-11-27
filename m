Return-Path: <bpf+bounces-45719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B2A9DAAD7
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 16:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE9A1679AF
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 15:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07091FF7DE;
	Wed, 27 Nov 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDTrb32r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C621FCFD7
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732721594; cv=none; b=NLWYnuTVmmYfT+udMCk/+BPD1DLAQf05MrQy4NxwKzE1eM3Nx6RT6xpwKmhax4YmvzNlWrXjrhBWV92st7fGP5G1kdx57wamjldp/M+4bn6Ci+msPbvXBR07abnBfyESjueQZ6h4Axikx5nO+AvU3p8wJ3vAHaax0BD5SXN3K6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732721594; c=relaxed/simple;
	bh=+lbvwqryOE2W6P45sCY/CQfIp65/Ra0f06fAzDGT4+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZNdKI7a3C/mtn/oSytxPCtj+aCeMrgqQa26fJ/JDEOzyVwzFbtViZVYGT8qA1qQvo9mC0XNjZ7PMMJRz8zKOC5D8Tv/R0apyrEXU6aeobSCxVUpCy6bwstFLWbwcDLICGCSzM1oCu03nniIxp3WssjLuk01OM3WUBTSCAlnS0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDTrb32r; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-434a2f3bae4so23603645e9.3
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 07:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732721590; x=1733326390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyFj/w4NJo/EiVDGBkkt3HCkn23xq83hNOiKaFrtX/0=;
        b=MDTrb32rcuOCPAL7ZU2Ww9KxLI0Dh+QpwSBy3CVj6+8YVuUO8Q1KndUDHhV4M2X8+M
         c08sBqenWBc9wz4kkCxB/M+Hiat8X6oEcPpA0suQ9/rWUulAY88rwTKMc/5tWfbexOyK
         uxmj7Sz/+8tLYAhLr+4i5Z1z2H7ezFAsVheut9RosJgZXxMRQqncOPABQvVRW3B+o+wY
         FDEjPfYaiBg22vQDtJwPdz1S+/Yqosapjd+Fe/3m9k3m65Eh5AghvnQBI56B/u7XN+ka
         TmiHVh8jsBSDOEbtWBAtxem0Tk65iVKKe3YENud6HeH1rSAOYHTUgkQk/07N7XFft6BA
         +qWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732721590; x=1733326390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyFj/w4NJo/EiVDGBkkt3HCkn23xq83hNOiKaFrtX/0=;
        b=hQL4I4liUitwjdW1Zbx0MMCnhyBNqi/s8FEw3HWC5LsewuNonhs5JosSvtc7WbQ+gK
         3madNY6po3xqeSNEZr8Lppik8+PeBj/nmSF01/uXvcnCuuORTpbgHwcSdcGj/L5U4Pz7
         iSmHRa8jAT8sJBh9i181xijFo/xKJpqKX5sFRvFKGbt8bfowIWb2/HoDxyKIJUht99/t
         pKVFnFUXPGGOC+CcuOAmeKLwMZlL8czCPNADXMYJxkJTXchlXu9A7QyjS8P/zIYesYZT
         ze6arBzccwlIZC1D20c1wTPbf95MkYBRTeAVlb9qo88Ho06Sc1pLWuFkVGFu1CKhuJE9
         d0VQ==
X-Gm-Message-State: AOJu0Yy3rFekjXuAmYApj9+zXEHfp0bgQ3LOC/VkxH3HzF7P0q3EEhQ+
	n5CpOTWktT4cOAkcGxpikX3OtqHOvyeNml0CFx2sfEg5U+LGYY25P1PWm8vjl7c=
X-Gm-Gg: ASbGncv2haoALOKr+R9T8hEERymXsf76OrwOX4gZch927HAJcq5aVp8Z7sivQygxOrU
	X55w0IpcKcVolS5EE1Fl50fwwp6q+ncqegtRtQrTgUXbcdiOUy3E79OiWQbM867S3evvn1w6/CD
	BUF6swX/Ew1J7xwpgK3pt2kgTTC6pZO7XWPwvPSuwnWO/FkuGP2Tr+Ym/BVoavWErSBZtdGSluF
	5oB0M475plcXVTf7nKSAGpVCkH5lt1uxSZgbLQi7d5BpYNDTk6BSww/GeS4yz67JxxE9+VMxhoE
	zg==
X-Google-Smtp-Source: AGHT+IFAeTG66B1aAJoJXFiQOD6JVJ/xUhuK+A3149yFfgzZ0weBIzJwbPGOJJbcBhZa0wO7djUhBw==
X-Received: by 2002:a05:600c:4f09:b0:434:a802:43d with SMTP id 5b1f17b1804b1-434a9df0376mr31386635e9.27.1732721590354;
        Wed, 27 Nov 2024 07:33:10 -0800 (PST)
Received: from localhost (fwdproxy-cln-039.fbsv.net. [2a03:2880:31ff:27::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa76a981sm24047645e9.16.2024.11.27.07.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:33:09 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 2/7] bpf: Refactor {acquire,release}_reference_state
Date: Wed, 27 Nov 2024 07:33:01 -0800
Message-ID: <20241127153306.1484562-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127153306.1484562-1-memxor@gmail.com>
References: <20241127153306.1484562-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9386; h=from:subject; bh=+lbvwqryOE2W6P45sCY/CQfIp65/Ra0f06fAzDGT4+E=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnRztdL/DlFkU+TVBd+Gdd2AGUfKzuJOe+YbJRWprV S/dy0lGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0c7XQAKCRBM4MiGSL8Rypb6D/ 9EkOTx4v8z/Th2ZppRV/h5hJQWEWZzI4vzT8uadBQmwwGApFxyMgI4+/MRB2SZP7L+0wtolgGLDI6x /hdLy25/OgO/+mIMsvOsHnqxlUAa07RmJRF7F6REGvnC7yCgM+SMyRfXQrQ0Ja9AatIJNgIPHu8o9w uFjZ6BRoCJS9Y9X9l28W7Phnr++f2bMDPBvDPfxE2SffMNlTfA31sqRaX8K1+ReE4fWr+tDquf7J7q 56ZWUnvVpVLp/3AIIGRTNoI1tPMiKZIRKWisPIJQ9JTEitdfwQBEFoX22i8L4MKTNtFztOmLU7pHyd oi1nzbolcpqNJYf+qdWtpHGolMhCCUGEVOuJdKofadcOy7xFhAAjRd1e0SEaVXLiObgSjkN0rnpN6G xykdpvj4R9WIACGmMxHxoJy7PScjSutXf/Hg6uItGRX0cBcDJfPx9e6Zf5wTl9cEhVVPHMByuR8Xs7 7hQcm34daqUfI/IEp7G0cdQvDrUBUzjT94IkLqKRg4ucF5416loo0EjLysagigMYc7poKPkZEMoTsX AQJ4pdBawAEkuC5bz7hAUI7x8r8aA1W+AFRxmpW8Dh/Cl7xTn796rj2hCBUs7Msr4MFXYuoZdQWYa2 Dse042vRq0LdlaHHHFmDgVPGKuTOXKtxz1/myCpgcMFXWmOaWxky5NQM/FOg==
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


