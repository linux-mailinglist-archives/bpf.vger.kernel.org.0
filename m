Return-Path: <bpf+bounces-73690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B785C3767C
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 19:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F6A64E63EC
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 18:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0F5314B74;
	Wed,  5 Nov 2025 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DiSRq+E5"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F0F31194A
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369191; cv=none; b=qyeMdN8PGdZIB+KsilnS/65QqMlqm2ikBfvSJyaiV/7CCVTta5CYQgH2e4vBbodQkUN2mcdh2lBufxPSM4KntAWB8JaJiwLz+vV1T6YGSVq1npO20vMRzYP8ZLdk7vmYbqeH9OeIuP9zjtiWnzVr+48JPHwwhn4QBxJWV5N/kGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369191; c=relaxed/simple;
	bh=vE7yCp5u7/pXsk4QWKiWAG9vYcvQVTWUkDRRhndHmPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMfeOkzfY/j47KX6GRJKJfi6tixr/HZ0xoxaHcynJTjGA1Ie34YUNRUTOXnk6+JCH8+X4iXyz6GUB1GHBIUXwqM6l/13ODXoZ75YgddOjM3cG/JkMwWn0eyHq+sqMpqZ5GRwUGlEeRJY5c4Hx+X60e7bWHZUlbI18FJv69INahc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DiSRq+E5; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762369187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4l0oBguW7yDf6P5dXvwYQMG9LMIsi28SVhUwuJJEQ54=;
	b=DiSRq+E5iiIMSiB+8IDV969MZ7zDYUi/8P1h4ktZb2zn7LUzO/kxuv2g9UL8WJFRO15H6W
	rlNTHKzOfljIEkw7a1qWeg2p2QMNSgeMv+YB0Y7sSarTPEOA4bUhhXPSSbO+a7CfbCNhN4
	xJs6YKFpBzglZEWhioQTX3VpoY+LFa8=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	kernel-team@meta.com
Subject: [PATCH dwarves v3 2/3] btf_encoder: Refactor btf_encoder__add_func_proto
Date: Wed,  5 Nov 2025 10:59:25 -0800
Message-ID: <20251105185926.296539-3-ihor.solodrai@linux.dev>
In-Reply-To: <20251105185926.296539-1-ihor.solodrai@linux.dev>
References: <20251105185926.296539-1-ihor.solodrai@linux.dev>
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
  * btf_encoder__add_func_proto_for_state()

And factor out common btf_encoder__emit_func_proto() subroutine.

No functional changes.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 btf_encoder.c | 135 +++++++++++++++++++++++++++++---------------------
 1 file changed, 79 insertions(+), 56 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index a6fdc58..bdda7d0 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -814,79 +814,102 @@ static inline bool is_kfunc_state(struct btf_encoder_func_state *state)
 	return state && state->elf && state->elf->kfunc;
 }
 
-static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype,
-					   struct btf_encoder_func_state *state)
+static int32_t btf_encoder__emit_func_proto(struct btf_encoder *encoder,
+					    uint32_t type_id,
+					    uint16_t nr_params)
 {
 	const struct btf_type *t;
-	struct btf *btf = encoder->btf;
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
-		nr_params = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
-		type_id = btf_encoder__tag_type(encoder, ftype->tag.type);
-	} else if (state) {
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
+static int32_t btf_encoder__add_func_proto_for_state(struct btf_encoder *encoder,
+						     struct btf_encoder_func_state *state)
+{
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
 
@@ -1343,7 +1366,7 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
 	uint16_t idx;
 	int err;
 
-	btf_fnproto_id = btf_encoder__add_func_proto(encoder, NULL, state);
+	btf_fnproto_id = btf_encoder__add_func_proto_for_state(encoder, state);
 	name = func->name;
 	if (btf_fnproto_id >= 0)
 		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id,
@@ -1682,7 +1705,7 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
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


