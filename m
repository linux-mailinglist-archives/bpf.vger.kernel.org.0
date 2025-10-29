Return-Path: <bpf+bounces-72864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7E8C1CE60
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 20:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0AA1895EE0
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EA9363B80;
	Wed, 29 Oct 2025 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iE2Kj4mM"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768ED35BDBC
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764591; cv=none; b=mgUdCr2cJjgJd3W5sE/a2xDuyxtS3r2tffUwet0isVOmjHFqfNsDHCODooDdqgTxOMKsttwtS7Nb6LvYs3dmidXO25afOdpRU8Vnp0KoyD4zmrkhSiEh48kkUebczqFOBVjo6OGK6/uAR1/B2Vf9+BwBkRrgekCBpMmHZEwQT20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764591; c=relaxed/simple;
	bh=zzwON/j4Xv/MXrZ4Eo/Xv47MBKtDT6bczuLNgMPVeOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2TPrdaZfqkjKajJqNHwkp4S+rfYSQQJGWM6OehgfGlbM6ja6JdKcKXImYfMs1fMVywXC7UxT5Es3G56Bp/xW+A9CXtrzulyqx9UMapM335350LsuInLrG+jJPxT4eicIZhnHuS/+modxAxEFTfApAJzV0qS7lYcRTPe9IFobmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iE2Kj4mM; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761764585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YnzovBFmA/VWLGpZNn2oBLcchRJjbnZlXv2wnSeL+g=;
	b=iE2Kj4mM2uvxX2gYcwHfrXGSQ7dwvZkziXP/gQj26UVaKoYBVOCAZtkH2ECYy+6A3U+l0B
	suUb8Ep9XLB/JAXv792gfBwjJ4xuQ232BVbmL6Fx0LCUuMKW4q/WCJ4Ls5nGA2oiQV/GWE
	jicZy1E7j8Fn1WQRKWsdmiAAfxNPAAk=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org
Cc: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	tj@kernel.org,
	kernel-team@meta.com
Subject: [PATCH dwarves v1 1/3] btf_encoder: refactor btf_encoder__add_func_proto
Date: Wed, 29 Oct 2025 12:02:47 -0700
Message-ID: <20251029190249.3323752-2-ihor.solodrai@linux.dev>
In-Reply-To: <20251029190249.3323752-1-ihor.solodrai@linux.dev>
References: <20251029190249.3323752-1-ihor.solodrai@linux.dev>
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
index 03bc3c7..0416824 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -815,82 +815,105 @@ static inline bool is_kfunc_state(struct btf_encoder_func_state *state)
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
+	const char *name;
+
+	assert(ftype != NULL);
+
+	/* add btf_type for func_proto */
+	nr_params = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
+	type_id = btf_encoder__tag_type(encoder, ftype->tag.type);
+
+	id = btf_encoder__emit_func_proto(encoder, type_id, nr_params);
+	if (id < 0)
+		return id;
+
+	/* add parameters */
+	param_idx = 0;
+
+	ftype__for_each_parameter(ftype, param) {
+		name = parameter__name(param);
+		type_id = param->tag.type == 0 ? 0 : encoder->type_id_off + param->tag.type;
+		++param_idx;
+		if (btf_encoder__add_func_param(encoder, name, type_id, param_idx == nr_params))
+			return -1;
+	}
+
+	++param_idx;
+	if (ftype->unspec_parms)
+		if (btf_encoder__add_func_param(encoder, NULL, 0, param_idx == nr_params))
+			return -1;
+
+	return id;
+}
+
+static int32_t btf_encoder__add_func_proto_for_state(struct btf_encoder *encoder, struct btf_encoder_func_state *state)
+{
+	uint16_t nr_params, param_idx;
 	char tmp_name[KSYM_NAME_LEN];
+	int32_t id, type_id;
 	const char *name;
+	struct btf *btf;
 
-	assert(ftype != NULL || state != NULL);
+	assert(state != NULL);
 
 	if (is_kfunc_state(state) && encoder->tag_kfuncs && encoder->encode_attributes)
 		if (btf__add_bpf_arena_type_tags(encoder->btf, state) < 0)
 			return -1;
 
-	/* add btf_type for func_proto */
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
+	encoder = state->encoder;
+	btf = state->encoder->btf;
+	nr_params = state->nr_parms;
+	type_id = state->ret_type_id;
 
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
 
-		++param_idx;
-		if (ftype->unspec_parms)
-			if (btf_encoder__add_func_param(encoder, NULL, 0,
-							param_idx == nr_params))
-				return -1;
-	} else {
-		for (param_idx = 0; param_idx < nr_params; param_idx++) {
-			struct btf_encoder_func_parm *p = &state->parms[param_idx];
+	for (param_idx = 0; param_idx < nr_params; param_idx++) {
+		struct btf_encoder_func_parm *p = &state->parms[param_idx];
 
-			name = btf__name_by_offset(btf, p->name_off);
+		name = btf__name_by_offset(btf, p->name_off);
 
-			/* adding BTF data may result in a move of the
-			 * name string memory, so make a temporary copy.
-			 */
-			strncpy(tmp_name, name, sizeof(tmp_name) - 1);
+		/* adding BTF data may result in a move of the
+		 * name string memory, so make a temporary copy.
+		 */
+		strncpy(tmp_name, name, sizeof(tmp_name) - 1);
 
-			if (btf_encoder__add_func_param(encoder, tmp_name, p->type_id,
-							param_idx == nr_params))
-				return -1;
-		}
+		if (btf_encoder__add_func_param(encoder, tmp_name, p->type_id,
+						param_idx == nr_params))
+			return -1;
 	}
+
 	return id;
 }
 
@@ -1349,7 +1372,7 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
 	uint16_t idx;
 	int err;
 
-	btf_fnproto_id = btf_encoder__add_func_proto(encoder, NULL, state);
+	btf_fnproto_id = btf_encoder__add_func_proto_for_state(encoder, state);
 	name = func->name;
 	if (btf_fnproto_id >= 0)
 		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id,
@@ -1686,7 +1709,7 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
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


