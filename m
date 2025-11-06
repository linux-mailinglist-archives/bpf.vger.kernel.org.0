Return-Path: <bpf+bounces-73761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9FFC38B3C
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 02:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D1DE34E826
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 01:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93F82222D2;
	Thu,  6 Nov 2025 01:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZsihvxJR"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4128225A39
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 01:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762392537; cv=none; b=JCKNCCsQhanmwTvaOAjxmai9Q8Qw/I+zop9MbtdSmYXZKo7lk0zGck/l0LIJW3rdlvN2UyQVYBfRcR+zR4kbWYDN7aKmBRZC0W5Zs+vZbEFKy8En92Qs/eaXo10dsYKRSwiuQ9mAq77W1mVtzYvSG9qqeyu4Bki2dDsER6uV47M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762392537; c=relaxed/simple;
	bh=cBYfu+lEp1uTxD7e7OzDYqbb3DH7WRxuriznZvgABS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0xnJmgbdHW2xzlC9NaaKtgbQ8BgBe78lHyogs5NpYmVugnuxkdYpJm9INdSI12JWoIdWyK3j7HNu3OJyfil+V870J3Vu7cwKHaThRkFZt1VQCF7TlyQU4YO+8XNVbiSggRAuhYbsuIBMWYC+8tBTGnNax5TUgibd5FZ67iiaPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZsihvxJR; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762392534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=brfkkiFIUjzBv5glmIbWyU8Lsk9WqNmYBwzLqwenkuI=;
	b=ZsihvxJRvhni3XM/XCa38QoMeuupf6g2r9P21G9BTbig6H2oDDeq6vmgdT+0sdpbOLaZay
	Ahj5B7/TVjPlJbDKHtnLTQwdSQIAJkiYQXfP+V/+7B0wAjJI5Mw6RPxn6MvDfb9EYRP+0f
	6PRtP0AN1aSXEfjMiVn/VhpsMEpiBIE=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	kernel-team@meta.com
Subject: [PATCH dwarves v4 3/3] btf_encoder: Factor out BPF kfunc emission
Date: Wed,  5 Nov 2025 17:28:35 -0800
Message-ID: <20251106012835.260373-4-ihor.solodrai@linux.dev>
In-Reply-To: <20251106012835.260373-1-ihor.solodrai@linux.dev>
References: <20251106012835.260373-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Generating BTF for BPF kernel functions requires special
handling. Consolidate this behavior into btf_encoder__add_bpf_kfunc(),
which uses simplified btf_encoder_add_func().

No functional changes.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Tested-by: Eduard Zingerman <eddyz87@gmail.com>
---
 btf_encoder.c | 51 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index bdda7d0..b37ee7f 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -773,6 +773,7 @@ static int btf__tag_bpf_arena_arg(struct btf *btf, struct btf_encoder_func_state
 	return id;
 }
 
+/* Modifies state->ret_type_id and state->parms[i].type_id for flagged kfuncs */
 static int btf__add_bpf_arena_type_tags(struct btf *btf, struct btf_encoder_func_state *state)
 {
 	uint32_t flags = state->elf->kfunc_flags;
@@ -883,11 +884,6 @@ static int32_t btf_encoder__add_func_proto_for_state(struct btf_encoder *encoder
 	const char *name;
 	bool is_last;
 
-	/* Beware: btf__add_bpf_arena_type_tags may change some members of the state */
-	if (is_kfunc_state(state) && encoder->tag_kfuncs && encoder->encode_attributes)
-		if (btf__add_bpf_arena_type_tags(encoder->btf, state) < 0)
-			return -1;
-
 	type_id = state->ret_type_id;
 	nr_params = state->nr_parms;
 
@@ -1357,14 +1353,13 @@ static int btf__tag_kfunc(struct btf *btf, struct elf_function *kfunc, __u32 btf
 static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
 				     struct btf_encoder_func_state *state)
 {
-	struct elf_function *func = state->elf;
 	int btf_fnproto_id, btf_fn_id, tag_type_id = 0;
+	struct elf_function *func = state->elf;
+	char tmp_value[KSYM_NAME_LEN];
 	int16_t component_idx = -1;
-	const char *name;
 	const char *value;
-	char tmp_value[KSYM_NAME_LEN];
+	const char *name;
 	uint16_t idx;
-	int err;
 
 	btf_fnproto_id = btf_encoder__add_func_proto_for_state(encoder, state);
 	name = func->name;
@@ -1377,15 +1372,6 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
 		return -1;
 	}
 
-	if (func->kfunc && encoder->tag_kfuncs && !encoder->skip_encoding_decl_tag) {
-		err = btf__tag_kfunc(encoder->btf, func, btf_fn_id);
-		if (err < 0)
-			return err;
-	}
-
-	if (state->nr_annots == 0)
-		return 0;
-
 	for (idx = 0; idx < state->nr_annots; idx++) {
 		struct btf_encoder_func_annot *a = &state->annots[idx];
 
@@ -1408,6 +1394,30 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
 		return -1;
 	}
 
+	return btf_fn_id;
+}
+
+static int btf_encoder__add_bpf_kfunc(struct btf_encoder *encoder,
+				      struct btf_encoder_func_state *state)
+{
+	int btf_fn_id, err;
+
+	if (encoder->tag_kfuncs && encoder->encode_attributes) {
+		err = btf__add_bpf_arena_type_tags(encoder->btf, state);
+		if (err < 0)
+			return err;
+	}
+
+	btf_fn_id = btf_encoder__add_func(encoder, state);
+	if (btf_fn_id < 0)
+		return -1;
+
+	if (encoder->tag_kfuncs && !encoder->skip_encoding_decl_tag) {
+		err = btf__tag_kfunc(encoder->btf, state->elf, btf_fn_id);
+		if (err < 0)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -1507,7 +1517,10 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 					0, 0);
 
 		if (add_to_btf) {
-			err = btf_encoder__add_func(encoder, state);
+			if (is_kfunc_state(state))
+				err = btf_encoder__add_bpf_kfunc(encoder, state);
+			else
+				err = btf_encoder__add_func(encoder, state);
 			if (err < 0)
 				goto out;
 		}
-- 
2.51.1


