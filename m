Return-Path: <bpf+bounces-69620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E81B9C401
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 23:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA899327176
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 21:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D275B27EFEF;
	Wed, 24 Sep 2025 21:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N9scieSY"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB73524E016
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758748582; cv=none; b=sToh3sMQdslPMTNu4lzvhTqzQ3Yz4Kh0hPU84Kkz0FQYGZMP8MDAEQdC4hglUG/uAxCORf5WUfTwE4ElpzRjegPIz3UxuLwQcEN04RpfpNfcuvKFRAaXZqh8RnkGMYvhuKO8ULcRuwZz9bnPwzBfwBiJzK6DDY57kjNhBEfF9vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758748582; c=relaxed/simple;
	bh=ToDsIYy8Kd/zKh/7CB6pD6L+5decK+6DEYuVgEuQWJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5hQbF70BjweEhhYDcWeeirr703NaSsyZJfTPEXjC4x/0n80bm0unaqa6/VjDjnonoYGvovj1vfG9XRK9w1fscm03LF1xzU37Pu+HalpTuVwMXuABQV8A09yEp1vmio4TxzLpGXsEUbkWGF86XxmJFZoioGmbPO2O9D3FrzWgt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N9scieSY; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758748578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RUZ3ZR5IbmquEVEJ9UQOaAf7Ghc5kTOy6peC/nD6pz8=;
	b=N9scieSYTn/h/azgwLQ5Wlc8PBtVmbB8yNO4paZoEmVggj2Jdmx9KgMPM3TC3Am9OIHnd9
	s8Jhgks6ZJMAGv1nxsXJS45S0AXEIiUTqsuxpVIgeG8hSuarg+l4d8b7ZzhAWGmQc2ST95
	oPlEPD89oO+0BtSbSP+1LCli9/OnKxk=
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
Subject: [PATCH dwarves v1 2/2] btf_encoder: implement KF_IMPLICIT_PROG_AUX_ARG kfunc flag handling
Date: Wed, 24 Sep 2025 14:15:12 -0700
Message-ID: <20250924211512.1287298-3-ihor.solodrai@linux.dev>
In-Reply-To: <20250924211512.1287298-1-ihor.solodrai@linux.dev>
References: <20250924211512.1287298-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When a kfunc is marked with KF_IMPLICIT_PROG_AUX_ARG, do not emit the
last parameter of this function to BTF.

Validate that the ommitted parameter has a type of `struct
bpf_prog_aux *`, otherwise report an error and fail BTF encoding.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 btf_encoder.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 4906943..eb669f9 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -48,6 +48,7 @@
 #define KF_ARENA_RET  (1 << 13)
 #define KF_ARENA_ARG1 (1 << 14)
 #define KF_ARENA_ARG2 (1 << 15)
+#define KF_IMPLICIT_PROG_AUX_ARG (1 << 16)
 
 struct btf_id_and_flag {
 	uint32_t id;
@@ -868,6 +869,41 @@ static int32_t btf_encoder__add_func_proto_for_ftype(struct btf_encoder *encoder
 	return id;
 }
 
+static const struct btf_type *btf__unqualified_type_by_id(const struct btf *btf, int32_t type_id)
+{
+	const struct btf_type *t = btf__type_by_id(btf, type_id);
+	while (btf_is_const(t) || btf_is_volatile(t) || btf_is_restrict(t)) {
+		t = btf__type_by_id(btf, t->type);
+	}
+	return t;
+}
+
+static int validate_kfunc_with_implicit_prog_aux_arg(struct btf_encoder_func_state *state)
+{
+	/* The last argument must be a pointer to 'struct bpf_prog_aux' */
+	const struct btf_encoder_func_parm *p = &state->parms[state->nr_parms - 1];
+	const struct btf *btf = state->encoder->btf;
+	const struct btf_type *t = btf__unqualified_type_by_id(btf, p->type_id);
+	if (!btf_is_ptr(t))
+		goto out_err;
+
+	const uint32_t struct_type_id = t->type;
+	t = btf__unqualified_type_by_id(btf, struct_type_id);
+	if (!btf_is_struct(t))
+		goto out_err;
+
+	const char *name = btf__name_by_offset(btf, t->name_off);
+	if (strcmp(name, "bpf_prog_aux") != 0)
+		goto out_err;
+
+	return 0;
+out_err:
+	btf__log_err(btf, BTF_KIND_FUNC_PROTO, state->elf->name, true, 0,
+		"return=%u Error emitting BTF func proto for kfunc with implicit bpf_prog_aux: the last parameter is not 'struct bpf_prog_aux*'",
+		p->type_id);
+	return -1;
+}
+
 static int32_t btf_encoder__add_func_proto_for_state(struct btf_encoder *encoder, struct btf_encoder_func_state *state)
 {
 	uint16_t nr_params, param_idx;
@@ -887,6 +923,12 @@ static int32_t btf_encoder__add_func_proto_for_state(struct btf_encoder *encoder
 	nr_params = state->nr_parms;
 	type_id = state->ret_type_id;
 
+	if (is_kfunc_state(state) && KF_IMPLICIT_PROG_AUX_ARG & state->elf->kfunc_flags) {
+		if (validate_kfunc_with_implicit_prog_aux_arg(state))
+			return -1;
+		nr_params--;
+	}
+
 	id = btf_encoder__emit_func_proto(encoder, type_id, nr_params);
 	if (id < 0)
 		return id;
-- 
2.51.0


