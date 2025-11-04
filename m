Return-Path: <bpf+bounces-73527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AC2C33654
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 00:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 893944EBCD3
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 23:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91221329C76;
	Tue,  4 Nov 2025 23:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DtbspDq9"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03106331A7C
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 23:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762299358; cv=none; b=pwpgYgsl8yEWvks23NBYqeUQ380ibEzW06eNcWg/DWVhhCTfVAHyDg9pdDEJ4hk8xKoNQXiEbEUD+YO8D/taHWZm57LLI1KkKsrefN4caYSdln28c/scxVhgNY1XQlN2JzuG6OrPKVniKnI6apOuBsAhUnPfk/lSfGG90Z3oU8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762299358; c=relaxed/simple;
	bh=/G8nF9yPA+CYlh9pqE6OwO7E74j0Rmg6Ud6wplQRJFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggVD4MmAzEBVdc1VXGtz5in5IDv5CvreAGVMAsi1JEZtH75L/wAiMuvG0WSwpYFMv/jpHFQDi6djb8tApJVf+JEK8Pvl3sFzOMs/kQa+K0sS+udDpgQ8HCoA8RmwnhL7OGXVfJpHW9M3pjbvYs/26QC1AcOtt3xEhKy7zoTzlQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DtbspDq9; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762299354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5luwn15y8VHsOgEmgOoVMrKWbBVqE4bRPwPnFEWSO0=;
	b=DtbspDq9NavPdsEtY6+WU6h3DCc/7C2XwVfB+dVnEEnFe3KR26DHp4fvUaTejmHz7/yrn8
	Jj7+P9NOV4lXKLVWmCLB8wNYlmrUOtJ/8gveTczMK05QyZXvsfGtcduklCY89LEHJDesj/
	TnF7NUYFSpOB3v0ZhUznmDrU7hiGB+o=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	kernel-team@meta.com
Subject: [PATCH dwarves v2 1/2] btf_encoder: refactor btf_encoder__add_func_proto
Date: Tue,  4 Nov 2025 15:35:31 -0800
Message-ID: <20251104233532.196287-2-ihor.solodrai@linux.dev>
In-Reply-To: <20251104233532.196287-1-ihor.solodrai@linux.dev>
References: <20251104233532.196287-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

btf_encoder__add_func_proto() essentially implements two independent
code paths depending on input arguments: one for struct ftype and the
other for struct btf_encoder_func_state.

Split btf_encoder__add_func_proto() into two variants:
  * btf_encoder__add_func_proto_for_ftype()
  * func_state__add_func_proto()

And factor out common btf_encoder__emit_func_proto() subroutine.

No functional changes.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 btf_encoder.c | 138 +++++++++++++++++++++++++++++---------------------
 1 file changed, 79 insertions(+), 59 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 03bc3c7..d4ab5ec 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -815,82 +815,102 @@ static inline bool is_kfunc_state(struct btf_encoder_func_state *state)
 	return state && state->elf && state->elf->kfunc;
 }
 
-static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype,
-					   struct btf_encoder_func_state *state)
+static int32_t btf_encoder__emit_func_proto(struct btf_encoder *encoder,
+					    uint32_t type_id,
+					    uint16_t nr_params)
 {
 	const struct btf_type *t;
-	struct btf *btf;
-	struct parameter *param;
+	uint32_t ret;
+
+	ret = btf__add_func_proto(encoder->btf, type_id);
+	if (ret > 0) {
+		t = btf__type_by_id(encoder->btf, ret);
+		btf_encoder__log_type(encoder, t, false, false,
+			"return=%u args=(%s", t->type, !nr_params ? "void)\n" : "");
+	} else {
+		btf__log_err(encoder->btf, BTF_KIND_FUNC_PROTO, NULL, true, ret,
+			     "return=%u vlen=%u Error emitting BTF type",
+			     type_id, nr_params);
+	}
+
+	return ret;
+}
+
+static int32_t btf_encoder__add_func_proto_for_ftype(struct btf_encoder *encoder,
+						     struct ftype *ftype)
+{
 	uint16_t nr_params, param_idx;
+	struct parameter *param;
 	int32_t id, type_id;
-	char tmp_name[KSYM_NAME_LEN];
 	const char *name;
 
-	assert(ftype != NULL || state != NULL);
-
-	if (is_kfunc_state(state) && encoder->tag_kfuncs && encoder->encode_attributes)
-		if (btf__add_bpf_arena_type_tags(encoder->btf, state) < 0)
-			return -1;
+	assert(ftype != NULL);
 
 	/* add btf_type for func_proto */
-	if (ftype) {
-		btf = encoder->btf;
-		nr_params = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
-		type_id = btf_encoder__tag_type(encoder, ftype->tag.type);
-	} else if (state) {
-		encoder = state->encoder;
-		btf = state->encoder->btf;
-		nr_params = state->nr_parms;
-		type_id = state->ret_type_id;
-	} else {
-		return 0;
-	}
+	nr_params = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
+	type_id = btf_encoder__tag_type(encoder, ftype->tag.type);
 
-	id = btf__add_func_proto(btf, type_id);
-	if (id > 0) {
-		t = btf__type_by_id(btf, id);
-		btf_encoder__log_type(encoder, t, false, false, "return=%u args=(%s", t->type, !nr_params ? "void)\n" : "");
-	} else {
-		btf__log_err(btf, BTF_KIND_FUNC_PROTO, NULL, true, id,
-			     "return=%u vlen=%u Error emitting BTF type",
-			     type_id, nr_params);
+	id = btf_encoder__emit_func_proto(encoder, type_id, nr_params);
+	if (id < 0)
 		return id;
-	}
 
 	/* add parameters */
 	param_idx = 0;
-	if (ftype) {
-		ftype__for_each_parameter(ftype, param) {
-			const char *name = parameter__name(param);
-
-			type_id = param->tag.type == 0 ? 0 : encoder->type_id_off + param->tag.type;
-			++param_idx;
-			if (btf_encoder__add_func_param(encoder, name, type_id,
-							param_idx == nr_params))
-				return -1;
-		}
 
+	ftype__for_each_parameter(ftype, param) {
+		name = parameter__name(param);
+		type_id = param->tag.type == 0 ? 0 : encoder->type_id_off + param->tag.type;
 		++param_idx;
-		if (ftype->unspec_parms)
-			if (btf_encoder__add_func_param(encoder, NULL, 0,
-							param_idx == nr_params))
-				return -1;
-	} else {
-		for (param_idx = 0; param_idx < nr_params; param_idx++) {
-			struct btf_encoder_func_parm *p = &state->parms[param_idx];
+		if (btf_encoder__add_func_param(encoder, name, type_id, param_idx == nr_params))
+			return -1;
+	}
 
-			name = btf__name_by_offset(btf, p->name_off);
+	++param_idx;
+	if (ftype->unspec_parms)
+		if (btf_encoder__add_func_param(encoder, NULL, 0, param_idx == nr_params))
+			return -1;
 
-			/* adding BTF data may result in a move of the
-			 * name string memory, so make a temporary copy.
-			 */
-			strncpy(tmp_name, name, sizeof(tmp_name) - 1);
+	return id;
+}
 
-			if (btf_encoder__add_func_param(encoder, tmp_name, p->type_id,
-							param_idx == nr_params))
-				return -1;
-		}
+static int32_t func_state__add_func_proto(struct btf_encoder_func_state *state)
+{
+	struct btf_encoder *encoder = state->encoder;
+	const struct btf *btf = encoder->btf;
+	struct btf_encoder_func_parm *p;
+	uint16_t nr_params, param_idx;
+	char tmp_name[KSYM_NAME_LEN];
+	int32_t id, type_id;
+	const char *name;
+	bool is_last;
+
+	/* Beware: btf__add_bpf_arena_type_tags may change some members of the state */
+	if (is_kfunc_state(state) && encoder->tag_kfuncs && encoder->encode_attributes)
+		if (btf__add_bpf_arena_type_tags(encoder->btf, state) < 0)
+			return -1;
+
+	type_id = state->ret_type_id;
+	nr_params = state->nr_parms;
+
+	id = btf_encoder__emit_func_proto(encoder, type_id, nr_params);
+	if (id < 0)
+		return id;
+
+	/* add parameters */
+	for (param_idx = 0; param_idx < nr_params; param_idx++) {
+		p = &state->parms[param_idx];
+		name = btf__name_by_offset(btf, p->name_off);
+		is_last = param_idx == nr_params;
+
+		/* adding BTF data may result in a move of the
+		 * name string memory, so make a temporary copy.
+		 */
+		strncpy(tmp_name, name, sizeof(tmp_name) - 1);
+
+		if (btf_encoder__add_func_param(encoder, tmp_name, p->type_id, is_last))
+			return -1;
 	}
+
 	return id;
 }
 
@@ -1349,7 +1369,7 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
 	uint16_t idx;
 	int err;
 
-	btf_fnproto_id = btf_encoder__add_func_proto(encoder, NULL, state);
+	btf_fnproto_id = func_state__add_func_proto(state);
 	name = func->name;
 	if (btf_fnproto_id >= 0)
 		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id,
@@ -1686,7 +1706,7 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
 	case DW_TAG_enumeration_type:
 		return btf_encoder__add_enum_type(encoder, tag, conf_load);
 	case DW_TAG_subroutine_type:
-		return btf_encoder__add_func_proto(encoder, tag__ftype(tag), NULL);
+		return btf_encoder__add_func_proto_for_ftype(encoder, tag__ftype(tag));
         case DW_TAG_unspecified_type:
 		/* Just don't encode this for now, converting anything with this type to void (0) instead.
 		 *
-- 
2.51.1


