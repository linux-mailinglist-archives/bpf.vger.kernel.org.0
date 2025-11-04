Return-Path: <bpf+bounces-73528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD60C3364E
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 00:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D25C42824A
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 23:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC669346FC2;
	Tue,  4 Nov 2025 23:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FPCmQ1DV"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8864832E741;
	Tue,  4 Nov 2025 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762299361; cv=none; b=KjVDLB7S7RQbqvbgh1coagigwEWWe2WH17uv0b/l5D9SbGE9Bh1kmtWLeP7EXNVN1omwGZHS/kt+TBNWUtoUY+JOcMAgpZrhreykI50ej6bvpVXwDuIbbKRJ3/4nVnvp3NBb1r3tz0wXsEhhXiVdIbw0XRZtXD+qABmVxVqXPpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762299361; c=relaxed/simple;
	bh=nVCZv7BDaADVPM+NUS7ZNu0z7wImAda6AlRFZGx41zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckvxJhY1JyjRO/Q0hTiJeWznsOaIycT3oLpOUOg25IGIAV2FXRFqVAqGnwtbRy+0JqqCe5L3UPiDl7TNJ2g3WqkfdPeFbBqdV4QFhqpyJFze3KmrmLcJy/4KiU/OY9xGYoLAdDJoNYaK49PUrLfISANoGYORDrlSicAygtbKpYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FPCmQ1DV; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762299357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qHztu5pNrbiBILt1YDLFsBjjPbkd4otCCvwHABdiiEo=;
	b=FPCmQ1DVC5vOHiJHUjfb7VK8ypqqYlP2I8GoFnxqR1Jn67A6hGXyzMe1AEEw4tQaDEHMLJ
	+z33te9+Rr31+b4UQJT/8rK+yToiZdrzrdkVpnzM1AfBgyfHZSFKaV6iBGqQ06b2pDIrLz
	NpNNc/lQVZli5umNlxKdhUTNyh1K+Bk=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	kernel-team@meta.com
Subject: [PATCH dwarves v2 2/2] btf_encoder: factor out btf_encoder__add_bpf_kfunc()
Date: Tue,  4 Nov 2025 15:35:32 -0800
Message-ID: <20251104233532.196287-3-ihor.solodrai@linux.dev>
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

Emitting BTF for BPF kernel functions requires special
handling. Consolidate this behavior into btf_encoder__add_bpf_kfunc()
function, which uses simplified btf_encoder_add_func()

No functional changes.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 btf_encoder.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index d4ab5ec..7accaa0 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -774,6 +774,7 @@ static int btf__tag_bpf_arena_arg(struct btf *btf, struct btf_encoder_func_state
 	return id;
 }
 
+/* Modifies state->ret_type_id and state->parms[i].type_id for flagged kfuncs */
 static int btf__add_bpf_arena_type_tags(struct btf *btf, struct btf_encoder_func_state *state)
 {
 	uint32_t flags = state->elf->kfunc_flags;
@@ -884,11 +885,6 @@ static int32_t func_state__add_func_proto(struct btf_encoder_func_state *state)
 	const char *name;
 	bool is_last;
 
-	/* Beware: btf__add_bpf_arena_type_tags may change some members of the state */
-	if (is_kfunc_state(state) && encoder->tag_kfuncs && encoder->encode_attributes)
-		if (btf__add_bpf_arena_type_tags(encoder->btf, state) < 0)
-			return -1;
-
 	type_id = state->ret_type_id;
 	nr_params = state->nr_parms;
 
@@ -1367,7 +1363,6 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
 	const char *value;
 	char tmp_value[KSYM_NAME_LEN];
 	uint16_t idx;
-	int err;
 
 	btf_fnproto_id = func_state__add_func_proto(state);
 	name = func->name;
@@ -1380,15 +1375,6 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
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
 
@@ -1411,6 +1397,28 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
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
+	if (encoder->tag_kfuncs && encoder->encode_attributes)
+		if (btf__add_bpf_arena_type_tags(encoder->btf, state) < 0)
+			return -1;
+
+	btf_fn_id = btf_encoder__add_func(encoder, state);
+	if (btf_fn_id < 0)
+		return -1;
+
+	if (encoder->tag_kfuncs && !encoder->skip_encoding_decl_tag) {
+		err = btf__tag_kfunc(encoder->btf, state->elf, btf_fn_id);
+		if (err < 0)
+			return -1;
+	}
+
 	return 0;
 }
 
@@ -1508,7 +1516,10 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 					0, 0);
 
 		if (add_to_btf) {
-			err = btf_encoder__add_func(state->encoder, state);
+			if (is_kfunc_state(state))
+				err = btf_encoder__add_bpf_kfunc(state->encoder, state);
+			else
+				err = btf_encoder__add_func(state->encoder, state);
 			if (err < 0)
 				goto out;
 		}
-- 
2.51.1


