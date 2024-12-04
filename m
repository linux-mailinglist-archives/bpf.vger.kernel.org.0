Return-Path: <bpf+bounces-46049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E479E31C6
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 04:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF85CB27DE0
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 03:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6247613B2B8;
	Wed,  4 Dec 2024 03:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBP26YEj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ABEFC1D
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 03:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281452; cv=none; b=PNR+Rr4LLSkvCwYhDSMzcaC8Q8y4JnrEj3A4/JgWo4TFC19yZF88pjU2joabCgKlkACRiF2BS1PVhN4Cc0Zl6vFzkFtoVQPTNiqhLz3N5jK/BKFR0PDvsDkvBMcG9Y3qCZsI7XsyrfS3mubmKCr/WnhEZkY0REVUajeou5D2dcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281452; c=relaxed/simple;
	bh=Td+xWtw0EqpnHOZIlUSYLza42yyOn1XyIk0b8BdVOjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIgTm/7ynw+SwLYKJhimVRRTStaE4Ih4AEz+uZwGU6owbGIRE4e30ayjRQcQ7RFmxzzMo/5aJ0sxYUxhNmGuUWsf9ENBe2w35+8dL0oT1mUnrQYqH13YLZwcURbO+n/Zd65JpYSWMW+Q0e3xeFK54lVie/uJXe9f5n7LdjzMq30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBP26YEj; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-434a8640763so51998885e9.1
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 19:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733281448; x=1733886248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmAgR3K9Kvxtkhz9iXzav1JygOw2MAm1MEcN2NhYj6o=;
        b=MBP26YEjbuE2jza9TR56ENA9bmYI4Vy9yTUZ5laEsqoTHxRJW9YPMcvjS+w18MlZ7+
         ArClhA4yaWmCue3Cjd23SflqdaKa5apuNcdHu/7++26UNFYjn/1aOFETagUM4uCzlB86
         ef5J0zszYv4pgQI1u7DYSTD2U4e3DDUhLiylQmjcaQheA6QlayRQl2qb3J5M1v45+U+9
         VTelNRGOUVBfPok8ukftP0NmZigRYL2MBcCWHHyVs5q0nTJhhocnByAH0jXg4UDaEIEb
         /y+X7umNhQTB4FJmzUIBwLW3hzRCNkyyhGGkdR1IkeUjDZs46sexhYZo6bf1XkmNkyC5
         If/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733281448; x=1733886248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmAgR3K9Kvxtkhz9iXzav1JygOw2MAm1MEcN2NhYj6o=;
        b=XHjsjSqV+DbYp82R42HkDXbLlKg7mDoyBPkvtNNOWFKyMIv23j98yMjeeTZPFZ75V2
         yQxJLMc/+0p2eoVUA22vrnTBQWFf2TroRCfCxMdxFKIoyJvqYN/swgeACvg5BGDOYWNC
         C0Hnv3NCMw9yD3cKZaL0KzTaFbVCh+ZQkSgx2Kc4ws28vvsQEg8fw92DVhXDhXYnXoXO
         tsDO6ziPA0qV6UJ5vNwuzYgWmHKP7Se+1r2/MB4FxL20Yw57NFeM9u4fYQdUcueq1PVk
         dDuFN+R1Mgqo2naXI+OldwVZ9C/oyotdf3zvII6+lS25eMf0FTv+4n9ULHL+qYQs14pC
         Al9w==
X-Gm-Message-State: AOJu0YwZKh0KwQqbe1uniNlU3amT1EE8lla8YxGU+r/h7vcaQExDeKuB
	vHHZeupiWKNAW7OUMxvWmU/ati3WoCDHW0Eq8M7AbahT9tfxCi5zYleStg2iYK0=
X-Gm-Gg: ASbGncsnoeDWEgnqvQ8M9rwKVOfNXiecY1VPQaBkvb0Yi69iok1Dt9Uk0OtQINgYqhe
	OZ7/xNq1zeMc9+fM2zhbKLg9CXO+Bt/Xv2qsLUWO/InTx9SvyrzUjDPOOyQwhL0dCkLLNKfiHBp
	PqTW14GttsO9yR5lASc40aigYnxihEOu/Q61quzc1CrNWyUyQem3J1IvhOXjAU9DxKbiqNFAjDt
	o8eSvqRbv6utTqQGhw84+iXfBTZ4rIyAKvg6fzgdIlHjT9CiejO6/s/it8M8UUNOt2lBIqIj4zp
	Vw==
X-Google-Smtp-Source: AGHT+IEbtZehN5gG4itlT7TxO9S42EO6F3vUNW35CYihh//w3+a8CsC9Do/rINh8D9kVqJILVDPJ0g==
X-Received: by 2002:a05:600c:35c9:b0:434:a5b6:273c with SMTP id 5b1f17b1804b1-434d09b1464mr40192245e9.2.1733281448182;
        Tue, 03 Dec 2024 19:04:08 -0800 (PST)
Received: from localhost (fwdproxy-cln-029.fbsv.net. [2a03:2880:31ff:1d::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5272427sm7755535e9.4.2024.12.03.19.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 19:04:07 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 2/7] bpf: Refactor {acquire,release}_reference_state
Date: Tue,  3 Dec 2024 19:03:55 -0800
Message-ID: <20241204030400.208005-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204030400.208005-1-memxor@gmail.com>
References: <20241204030400.208005-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9185; h=from:subject; bh=Td+xWtw0EqpnHOZIlUSYLza42yyOn1XyIk0b8BdVOjw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnT8Q/lymyMOWlJgPlrSSCqqZD2eAvjF2VlRaUjFH3 eclBV/CJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0/EPwAKCRBM4MiGSL8RyugwD/ 9lcoTdr9yA7c/knvnmeiHzfMURlGf/90L1fFYmAmlxuylkIgGC7zmxX4clcQ5X8OxhQD26CYK04ABr 4mBF7C50Q2CkVR0CeJpHOpPht2Q3O8IsAqsD6zUjmaLkZFD5VCgrSyRBR7cg7/bSOzINeAjl9GaOl7 +UHOBkJVmwWZj/E5H/HTKjqMoriqPduwmMNWtk0GPi/7pSnl+qmrtKw4ifUIte66oOjcaZR9VJ8WXE MVSDL+s5qgHNtZ1KSbim+i9emg90/ZL2eJ4C46RqwpbeBpG9OUcLEGnF8gEqDG2ceM4+M+ZlQV9OKt W01rnnMsYIKm76kEdXKuzIJncvXwOSpNdQMazZlQQ6TYju3eKF0bR/oN0rD8hAgf2VikxEuo3+NGum UjugtjPNOTMYW0ZgrlviRRA+Wg4yA7shLh3ZGDlNbWHSMk+mRTg+s9dsYjy/0+f8V0rH2puYohYs5G dmzNZH+qinpVT/40HDRPyaCIlMGTmON7e2zECUhcPFYIf6SZN7LhgDqYOh29DrugSnneJbHi3qIq4J vLMCwBVCmGmXDcpwM7+EvTG7HvjPvaIeksAob+21nR2H1aljjoKaCa/iSKUCnClVvOqPDPtzSlBvlP eySz9EDA6mro3hOtbO7A8iOOHd5hGECFKnMl2L6VclnwDrc1oj8O+hwBey3g==
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 109 +++++++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 50 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 019c56c782a2..41b3dc1ce450 100644
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
 
@@ -1349,77 +1350,68 @@ static int grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state
  * On success, returns a valid pointer id to associate with the register
  * On failure, returns a negative errno.
  */
-static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
+static struct bpf_reference_state *acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
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
 	state->refs[new_ofs].insn_idx = insn_idx;
 
-	return id;
+	return &state->refs[new_ofs];
+}
+
+static int acquire_reference(struct bpf_verifier_env *env, int insn_idx)
+{
+	struct bpf_reference_state *s;
+
+	s = acquire_reference_state(env, insn_idx);
+	if (!s)
+		return -ENOMEM;
+	s->type = REF_TYPE_PTR;
+	s->id = ++env->id_gen;
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
+	s = acquire_reference_state(env, insn_idx);
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
@@ -9666,21 +9658,38 @@ static void mark_pkt_end(struct bpf_verifier_state *vstate, int regn, bool range
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
@@ -10774,7 +10783,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			struct bpf_func_state *state;
 			struct bpf_reg_state *reg;
 
-			err = release_reference_state(env->cur_state, ref_obj_id);
+			err = release_reference_nomark(env->cur_state, ref_obj_id);
 			if (!err) {
 				bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
 					if (reg->ref_obj_id == ref_obj_id) {
@@ -11107,7 +11116,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
 	} else if (is_acquire_function(func_id, meta.map_ptr)) {
-		int id = acquire_reference_state(env, insn_idx);
+		int id = acquire_reference(env, insn_idx);
 
 		if (id < 0)
 			return id;
@@ -13087,7 +13096,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
 		if (is_kfunc_acquire(&meta)) {
-			int id = acquire_reference_state(env, insn_idx);
+			int id = acquire_reference(env, insn_idx);
 
 			if (id < 0)
 				return id;
@@ -15387,7 +15396,7 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
 		 * No one could have freed the reference state before
 		 * doing the NULL check.
 		 */
-		WARN_ON_ONCE(release_reference_state(vstate, id));
+		WARN_ON_ONCE(release_reference_nomark(vstate, id));
 
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
 		mark_ptr_or_null_reg(state, reg, id, is_null);
-- 
2.43.5


