Return-Path: <bpf+bounces-69031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E32B8BB22
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 02:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9601BC7648
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 00:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913611F03D9;
	Sat, 20 Sep 2025 00:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="reoM2Zkp"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE19158874
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 00:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758328634; cv=none; b=tXW6kcnvzKYDGPCYH9N4nsU+raNeyfMIYFuxKWXHql9PfwbPj2kAUYUtcQBSmUQe9Z1dZRREUGc7gltlQH0vZLNjAMw9gGl6cFyCvwIzeOC6UuW6T52+kU2HC+GNAnhvlOsktGDkd8IjdvMSoZmCLL14JAXRRZyB8qDy13nEfX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758328634; c=relaxed/simple;
	bh=0yMDbuIsGUXthav4lIyn8nPgT29QmoUcxjHv1W7CFLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QwP/BnRobMiheBHijkOl3TDxXKklP6LV6ryxOr2hKXFfz1h/lqw1DtYhitTKXumCrc/cpP+c9ghHj+ubkWpb5JQsk/zCYUj3bCT4ustdQAnImqkRyi+cEdhD6SV0cvD1iDccHNS5QaGq6mKF3eV18l7cAFdofq92l0F18ptqhHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=reoM2Zkp; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758328627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TuuAUp2asbMdTEB250MLnsL6dRm8mzfGpieRU/IkzsQ=;
	b=reoM2ZkpKH2Uekfi/Yh/ugjaWo7gkAiMrKTLucG2vIcUktpuokg0M46cWpLmm69ALs4gjf
	LpBCxCskTKxzwwoE33eI6SG7dGG6UOcYNm7LMUgcTYKaOCgVofj/6YnUWmqxdCEG80mfgX
	6geQGcc6rCnadJeSu6dgBpf21vG7k/Y=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: alan.maguire@oracle.com,
	dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org,
	acme@kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	olsajiri@gmail.com,
	kernel-team@meta.com
Subject: [PATCH dwarves v1] btf_encoder: move ambiguous_addr flag to elf_function
Date: Fri, 19 Sep 2025 17:36:56 -0700
Message-ID: <20250920003656.3592976-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Having an "ambiguous address" in the context of BTF encoding is an
attribute of an ELF function, and not any specific DWARF instance of
it. Thus it is redundant to maintain this flag in every
btf_encoder_func_state, and merging them in btf_encoder__save_func().

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 btf_encoder.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 710a122..03bc3c7 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -97,14 +97,14 @@ struct btf_encoder_func_state {
 struct elf_function_sym {
 	const char *name;
 	uint64_t addr;
-	uint8_t non_fn:1;
 };
 
 struct elf_function {
 	char		*name;
 	struct elf_function_sym *syms;
 	uint16_t	sym_cnt;
-	uint8_t		kfunc:1;
+	uint16_t 	ambiguous_addr:1;
+	uint16_t	kfunc:1;
 	uint32_t	kfunc_flags;
 };
 
@@ -168,7 +168,7 @@ struct btf_kfunc_set_range {
 	uint64_t end;
 };
 
-static inline void elf_function__free_content(struct elf_function *func)
+static inline void elf_function__clear(struct elf_function *func)
 {
 	free(func->name);
 	if (func->sym_cnt)
@@ -179,7 +179,7 @@ static inline void elf_function__free_content(struct elf_function *func)
 static inline void elf_functions__delete(struct elf_functions *funcs)
 {
 	for (int i = 0; i < funcs->cnt; i++)
-		elf_function__free_content(&funcs->entries[i]);
+		elf_function__clear(&funcs->entries[i]);
 	free(funcs->entries);
 	elf_symtab__delete(funcs->symtab);
 	free(funcs);
@@ -1214,21 +1214,20 @@ static bool str_contains_non_fn_suffix(const char *str) {
 static bool elf_function__has_ambiguous_address(struct elf_function *func)
 {
 	struct elf_function_sym *sym;
-	uint64_t addr = 0;
-	int i;
+	uint64_t addr;
 
 	if (func->sym_cnt <= 1)
 		return false;
 
-	for (i = 0; i < func->sym_cnt; i++) {
+	addr = 0;
+	for (int i = 0; i < func->sym_cnt; i++) {
 		sym = &func->syms[i];
-		if (!sym->non_fn) {
-			if (addr && addr != sym->addr)
-				return true;
-			else
-				addr = sym->addr;
-		}
+		if (addr && addr != sym->addr)
+			return true;
+		else
+			addr = sym->addr;
 	}
+
 	return false;
 }
 
@@ -1247,7 +1246,6 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 
 	state->encoder = encoder;
 	state->elf = func;
-	state->ambiguous_addr = elf_function__has_ambiguous_address(func);
 	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
 	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
 	if (state->nr_parms > 0) {
@@ -1414,7 +1412,7 @@ static int saved_functions_cmp(const void *_a, const void *_b)
 
 static int saved_functions_combine(struct btf_encoder_func_state *a, struct btf_encoder_func_state *b)
 {
-	uint8_t optimized, unexpected, inconsistent, uncertain_parm_loc, ambiguous_addr;
+	uint8_t optimized, unexpected, inconsistent, uncertain_parm_loc;
 
 	if (a->elf != b->elf)
 		return 1;
@@ -1423,14 +1421,12 @@ static int saved_functions_combine(struct btf_encoder_func_state *a, struct btf_
 	unexpected = a->unexpected_reg | b->unexpected_reg;
 	inconsistent = a->inconsistent_proto | b->inconsistent_proto;
 	uncertain_parm_loc = a->uncertain_parm_loc | b->uncertain_parm_loc;
-	ambiguous_addr = a->ambiguous_addr | b->ambiguous_addr;
-	if (!unexpected && !inconsistent && !ambiguous_addr && !funcs__match(a, b))
+	if (!unexpected && !inconsistent && !funcs__match(a, b))
 		inconsistent = 1;
 	a->optimized_parms = b->optimized_parms = optimized;
 	a->unexpected_reg = b->unexpected_reg = unexpected;
 	a->inconsistent_proto = b->inconsistent_proto = inconsistent;
 	a->uncertain_parm_loc = b->uncertain_parm_loc = uncertain_parm_loc;
-	a->ambiguous_addr = b->ambiguous_addr = ambiguous_addr;
 
 	return 0;
 }
@@ -1484,7 +1480,7 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 		 * unexpected register use, multiple inconsistent prototypes or
 		 * uncertain parameters location
 		 */
-		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto && !state->uncertain_parm_loc && !state->ambiguous_addr;
+		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto && !state->uncertain_parm_loc && !state->elf->ambiguous_addr;
 
 		if (state->uncertain_parm_loc)
 			btf_encoder__log_func_skip(encoder, saved_fns[i].elf,
@@ -2216,9 +2212,11 @@ static int elf_functions__collect(struct elf_functions *functions)
 		if (!sym_name)
 			continue;
 
-		func = &functions->entries[functions->cnt];
-
 		suffix = strchr(sym_name, '.');
+		if (str_contains_non_fn_suffix(sym_name))
+			continue;
+
+		func = &functions->entries[functions->cnt];
 		if (suffix)
 			func->name = strndup(sym_name, suffix - sym_name);
 		else
@@ -2231,7 +2229,7 @@ static int elf_functions__collect(struct elf_functions *functions)
 
 		func_sym.name = sym_name;
 		func_sym.addr = sym.st_value;
-		func_sym.non_fn = str_contains_non_fn_suffix(sym_name);
+
 		err = elf_function__push_sym(func, &func_sym);
 		if (err)
 			goto out_free;
@@ -2259,8 +2257,11 @@ static int elf_functions__collect(struct elf_functions *functions)
 
 		if (!strcmp(a->name, b->name)) {
 			elf_function__push_sym(a, &b->syms[0]);
-			elf_function__free_content(b);
+			elf_function__clear(b);
 		} else {
+			// at this point all syms for `a` have been collected
+			// check for ambiguous addresses before moving on
+			a->ambiguous_addr = elf_function__has_ambiguous_address(a);
 			i++;
 			if (i != j)
 				functions->entries[i] = functions->entries[j];
-- 
2.49.0


