Return-Path: <bpf+bounces-45731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AEB9DAC23
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 17:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8C5DB20A94
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 16:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5523B201003;
	Wed, 27 Nov 2024 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFF9GZK7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC817200BB3
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732726733; cv=none; b=PaB1QwiB++ciNTdyipZpcHPw87XsC+J2PMb12CbaHBbxRSZABy5it18BoboYyzlxV4qXGE+JnorW0euaj6Frsb0vdJS6Z/VTR7KajiDHx0+u01k5iECBY84CE9C4oB1UDk6l0tWV3DJuHm5NeSbVB10zvzy+6y460U640J0bIm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732726733; c=relaxed/simple;
	bh=+lbvwqryOE2W6P45sCY/CQfIp65/Ra0f06fAzDGT4+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I59XuMfogO3kk2eEQt1F98QKaIDzTHzqlbE2EMyAe4fqYbVyai1FAfHj4v16BsZRf3B7RfvRqjWDyTYlUn/XnAabFu/uOt+pvXjmYSqA2VH24N3Z1h9/IvQJ8YEua370dmDgtaBxeWgy4TdEKu4msuC18Z8MYAz/YsxQmAAWHOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFF9GZK7; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-434a736518eso20822995e9.1
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 08:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732726730; x=1733331530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyFj/w4NJo/EiVDGBkkt3HCkn23xq83hNOiKaFrtX/0=;
        b=KFF9GZK7jl0GkxtPfH+3x+Uqtm5CIyV5u/YQmpkksSHObIeKecUiUXmO9C5HvRg0+S
         G1/JbM2e2BzrYA3i+z/gj+cc0+b1k3QXBQm62TdZGR+ygEa0Ocami/1E/NEuBlCFe0uh
         y5/73clsobdFyzvoXXBmpiqt5blN6dWJ1w/3WALlp/un3aoYd1b4v7mdR2IK8IZYdOe6
         XYIArUhKrTbnLV+OSkTOgdOCTsWozam/wG2EvGY5mUKTUrXECQRQd0rcIU12IIFyJaeN
         Oq79/0GL5HGsdvXcQSoBwGJO70zw9JlIoM3KsqYAajgRC6wLfw+KZuXUAaQbpYen6h4r
         /2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732726730; x=1733331530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyFj/w4NJo/EiVDGBkkt3HCkn23xq83hNOiKaFrtX/0=;
        b=KhAELJk4La/072gJeEfJ7oWcKJNHLkTGNlcyA76nrSguvAGLRy4nEuEXxMkH8JqS0s
         Yyn04SEOWN/M2SHyT6VPgbaY60hmAhJZ/E14Icx2Dd5Z3wA4ymefkjpzcY1OmRfUwT/Q
         F/+jA7W11gyILcIxciRYNgVfd2tx+4a6o+jfrzPRfrgAJFWemp3qakJbOUa7B1HElVBn
         ph/X+oKUEwKVGq2BcZ88MhKDdC4uQoZR/hfeUpxmqAarSrId8lraUIbZXsbmk8mSWQft
         7e9cQ5uy8R7e95DoiECOocAaARbdUP732TTkF3D6zYU/mKuQoS43+uGl+BX4/+p3IhOh
         HoRw==
X-Gm-Message-State: AOJu0Yym9lx03Dk9BkdodZU2SU+gBimAjZ2uHtuS7S0ULPEZdmo5nNeI
	EFWFOUPRoaF0Fp4GMKxvcWNiP25TvknNOkCs8wiY/47PfmuFFy3Rj7l7GmooXUs=
X-Gm-Gg: ASbGnctqCAMZyiews2cywxxZhqkHgif3lgEyW9WVN81JAWK4diOnMO75BR4/ErGFBNr
	399988wNO06bSrbFYIFuVk+7qVCa+dWdq3d5l3mgEC0mk3stkgVtajlpS06DFEoOI/MguYGUpuP
	bUVVy/HO6bGTbZ9aYli+ksPiAt3LeIT/izm13SyJLwKVtYNpy0fGNLjeiGx0C9DNpHX2wCpNOA1
	pLWMhMntoWM55e3GAJ3lcOsylNPk98oIKQh5ho6S7zhfCGK6otUJ+0R3XsYH+Fmd/NjBJeBcOOZ
	4g==
X-Google-Smtp-Source: AGHT+IGhrBN8fv2MU8s/B+RnUjNs6GMfBayelt23e9waiuCiORbT8enTzq8teeIjCtjV2ZFTI10bBw==
X-Received: by 2002:a05:600c:5024:b0:434:a1d3:a321 with SMTP id 5b1f17b1804b1-434a9dbb663mr46068325e9.3.1732726729856;
        Wed, 27 Nov 2024 08:58:49 -0800 (PST)
Received: from localhost (fwdproxy-cln-112.fbsv.net. [2a03:2880:31ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825faf9e87sm16660206f8f.29.2024.11.27.08.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 08:58:49 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 2/7] bpf: Refactor {acquire,release}_reference_state
Date: Wed, 27 Nov 2024 08:58:41 -0800
Message-ID: <20241127165846.2001009-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127165846.2001009-1-memxor@gmail.com>
References: <20241127165846.2001009-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9386; h=from:subject; bh=+lbvwqryOE2W6P45sCY/CQfIp65/Ra0f06fAzDGT4+E=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR0+5L/DlFkU+TVBd+Gdd2AGUfKzuJOe+YbJRWprV S/dy0lGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0dPuQAKCRBM4MiGSL8Ryi+hD/ 9ibSGbxPa/MI3zQv0BqofUWJvz5iLq0csQuDSTItRnFmGV/M8x51RxUebbgBWCOEDZhGx2Ctew3Ai0 Iv0bO+8sxLggkGNP11Rk6rzlHRxDTN/zwOCa8oBS5jQyRRJIEUtp+WouksVyq5oUNkKvfrWpLUp+U9 Lv2Ft3WFruVGQP15CEzIkxh5gbcNgsoq7nGEIeSuRx2hpkGHk7qtBQXfFexBjZJKw0c+mLTRT7x6+c T9q1UdjBSEjLTp5DbubtStraf7/F1Hs231GQrbyqczcUm/dRojuJTZR6quM9ksH5Vhshz16+W7Ypqr OQa0P4GkIjYN52JPPyMZep9Q38JGiT+zKn7LW1JU6gbGqOKg+Zm+N775IRDVvPUwqRqi/ZafFdc2L/ 05pqzgI0DBLJn5nXMUO1P//5F86ifalQ5gAfbmTdCxsgGigsM6pEsTeRnVh7meHPiXlWUYi+aY8E4H tGZbPf06p7MW9S1mR2CL29X3/79ESrJGVn64UVl2PtVOjoMQ+M0r2xQuEP98mUdYkKHb3q1ZL+2zpG zidCw/NkmfbLECpG/KPU9vmZQy0bfOk083ROwnMd52KGC0MMkVR34j5EgzBIZbM2CMGyPn1iAy+VnF hNQs1rykV14Ly1YOU+2bLcgfjEnOzfwWl9vuthxWF6zLLiFnrhIwuVN0YvFA==
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


