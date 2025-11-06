Return-Path: <bpf+bounces-73759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2C1C38B39
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 02:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1443434EBD4
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 01:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA8222370A;
	Thu,  6 Nov 2025 01:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rV6hIPUm"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318E221C9FD
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 01:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762392534; cv=none; b=KvY9z+AXR8a4EgMMb1cXvimyJXerPAaj3xjhu0gu4rx9L6vzPW4BRP3wDWgcIA9WugUQa9p5pn26W1RrKWy+q4bgoGYtrgmQ4xG6cPBk6UeaNgT03deBPfo9Myhayv6UhzgktePVDnZDiC+h9kbHgMzJ/oECijPtfDnNdSC0zRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762392534; c=relaxed/simple;
	bh=IrM5LdqyCtvEnqP1fZIxZ9MI63DVJOuCjs4hJC2K3dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mtgb/voqZdUPIL8GVUfqseKaoupdL3cBagUSYq1lFIZw8wb0H8K4y0GncZOdN6LggExwtxWwVJUE7Ci3JDDgyLHiN/aqpqlxO5O848ezfXBzs9Dz89GHK+w3DPVPX/0VhapB1uCENgFBFPiOpSpDjh7J1OFCaeQLJyD8wiF3iyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rV6hIPUm; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762392529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKgUhfcH5kRd/8ThxweNzfO2sK8KwmwUU8WAUzn5Jwg=;
	b=rV6hIPUm9sOAKcXJbOvRDTwGPPQ53ikegVAaLqgvw8vx57RHNvUiLDRnEZZLO0F946+tpt
	rE84+gEG8XBb6fs5Xrl6uOitQQBiL6ibulvuuUwGH0RMzrnKOqIkm9FDFqgO40/+oFQILQ
	KbG8NJU6nP/O+ErgGKPauiWoD5HBoh4=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	kernel-team@meta.com
Subject: [PATCH dwarves v4 1/3] btf_encoder: Remove encoder pointer from btf_encoder_func_state
Date: Wed,  5 Nov 2025 17:28:33 -0800
Message-ID: <20251106012835.260373-2-ihor.solodrai@linux.dev>
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

Since multithreading was moved to dwarf_loader [1], pahole maintains a
single global btf_encoder instance. However parts of btf_encoder.c
exist to manage mulitple encoders, which is not necessary anymore.

This patch removes encoder pointer from struct btf_encoder_func_state.
We create a state for every encountered instance of a function in
DWARF, and currently they carry around the encoder unnecessarily.

[1] https://lore.kernel.org/all/20250109185950.653110-9-ihor.solodrai@pm.me/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Tested-by: Eduard Zingerman <eddyz87@gmail.com>
---
 btf_encoder.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 03bc3c7..a6fdc58 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -79,7 +79,6 @@ struct btf_encoder_func_annot {
 
 /* state used to do later encoding of saved functions */
 struct btf_encoder_func_state {
-	struct btf_encoder *encoder;
 	struct elf_function *elf;
 	uint32_t type_id_off;
 	uint16_t nr_parms;
@@ -819,7 +818,7 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
 					   struct btf_encoder_func_state *state)
 {
 	const struct btf_type *t;
-	struct btf *btf;
+	struct btf *btf = encoder->btf;
 	struct parameter *param;
 	uint16_t nr_params, param_idx;
 	int32_t id, type_id;
@@ -834,12 +833,9 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
 
 	/* add btf_type for func_proto */
 	if (ftype) {
-		btf = encoder->btf;
 		nr_params = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
 		type_id = btf_encoder__tag_type(encoder, ftype->tag.type);
 	} else if (state) {
-		encoder = state->encoder;
-		btf = state->encoder->btf;
 		nr_params = state->nr_parms;
 		type_id = state->ret_type_id;
 	} else {
@@ -1123,13 +1119,12 @@ static bool types__match(struct btf_encoder *encoder,
 	return false;
 }
 
-static bool funcs__match(struct btf_encoder_func_state *s1,
+static bool funcs__match(struct btf_encoder *encoder,
+			 struct btf_encoder_func_state *s1,
 			 struct btf_encoder_func_state *s2)
 {
-	struct btf_encoder *encoder = s1->encoder;
 	struct elf_function *func = s1->elf;
-	struct btf *btf1 = s1->encoder->btf;
-	struct btf *btf2 = s2->encoder->btf;
+	struct btf *btf = encoder->btf;
 	uint8_t i;
 
 	if (s1->nr_parms != s2->nr_parms) {
@@ -1138,7 +1133,7 @@ static bool funcs__match(struct btf_encoder_func_state *s1,
 					   s1->nr_parms, s2->nr_parms);
 		return false;
 	}
-	if (!types__match(encoder, btf1, s1->ret_type_id, btf2, s2->ret_type_id)) {
+	if (!types__match(encoder, btf, s1->ret_type_id, btf, s2->ret_type_id)) {
 		btf_encoder__log_func_skip(encoder, func, "return type mismatch\n");
 		return false;
 	}
@@ -1146,11 +1141,11 @@ static bool funcs__match(struct btf_encoder_func_state *s1,
 		return true;
 
 	for (i = 0; i < s1->nr_parms; i++) {
-		if (!types__match(encoder, btf1, s1->parms[i].type_id,
-				  btf2, s2->parms[i].type_id)) {
+		if (!types__match(encoder, btf, s1->parms[i].type_id,
+				  btf, s2->parms[i].type_id)) {
 			if (encoder->verbose) {
-				const char *p1 = btf__name_by_offset(btf1, s1->parms[i].name_off);
-				const char *p2 = btf__name_by_offset(btf2, s2->parms[i].name_off);
+				const char *p1 = btf__name_by_offset(btf, s1->parms[i].name_off);
+				const char *p2 = btf__name_by_offset(btf, s2->parms[i].name_off);
 
 				btf_encoder__log_func_skip(encoder, func,
 							   "param type mismatch for param#%d %s %s %s\n",
@@ -1244,7 +1239,6 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 	if (!state)
 		return -ENOMEM;
 
-	state->encoder = encoder;
 	state->elf = func;
 	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
 	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
@@ -1410,7 +1404,9 @@ static int saved_functions_cmp(const void *_a, const void *_b)
 	return elf_function__name_cmp(a->elf, b->elf);
 }
 
-static int saved_functions_combine(struct btf_encoder_func_state *a, struct btf_encoder_func_state *b)
+static int saved_functions_combine(struct btf_encoder *encoder,
+				   struct btf_encoder_func_state *a,
+				   struct btf_encoder_func_state *b)
 {
 	uint8_t optimized, unexpected, inconsistent, uncertain_parm_loc;
 
@@ -1421,7 +1417,7 @@ static int saved_functions_combine(struct btf_encoder_func_state *a, struct btf_
 	unexpected = a->unexpected_reg | b->unexpected_reg;
 	inconsistent = a->inconsistent_proto | b->inconsistent_proto;
 	uncertain_parm_loc = a->uncertain_parm_loc | b->uncertain_parm_loc;
-	if (!unexpected && !inconsistent && !funcs__match(a, b))
+	if (!unexpected && !inconsistent && !funcs__match(encoder, a, b))
 		inconsistent = 1;
 	a->optimized_parms = b->optimized_parms = optimized;
 	a->unexpected_reg = b->unexpected_reg = unexpected;
@@ -1471,7 +1467,7 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 		 */
 		j = i + 1;
 
-		while (j < nr_saved_fns && saved_functions_combine(&saved_fns[i], &saved_fns[j]) == 0)
+		while (j < nr_saved_fns && saved_functions_combine(encoder, &saved_fns[i], &saved_fns[j]) == 0)
 			j++;
 
 		/* do not exclude functions with optimized-out parameters; they
@@ -1488,7 +1484,7 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 					0, 0);
 
 		if (add_to_btf) {
-			err = btf_encoder__add_func(state->encoder, state);
+			err = btf_encoder__add_func(encoder, state);
 			if (err < 0)
 				goto out;
 		}
-- 
2.51.1


