Return-Path: <bpf+bounces-64924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C59BAB1880C
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 22:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6E43AC8C2
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 20:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758A2212B18;
	Fri,  1 Aug 2025 20:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fKsvwv4A"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24BF184524
	for <bpf@vger.kernel.org>; Fri,  1 Aug 2025 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754079619; cv=none; b=P9NVr2Do3YhZSIQxgXNjnFSMx1WSxY4LVKGKRH1APuq5xOfwDh3nEUZZZrT7Or+emqiIw54Dw6FGQh8AGlsDyqubg82+xeIiPhaRS9wFSj+TuomHTjRSPE1oH5/KjHyFIrPI4//vUYD8bVWwEglkTrZ3FYpFakk02OSXQBFB6Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754079619; c=relaxed/simple;
	bh=bViP1A2V60EgFgEOw/XBI1oSsKsS6W1XNHw+oHcIJCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KaBPMpY+l1zD1u2R4SAQS9ATH6JNMRpGeVrCmHsD4q09RFYNLPiwXISZ7RTnEA8OEAh8kUVp+hE+gOBSUyomDLXbU2CpW5EgBB6J/51/61KGMSKerXPIydbI+LlqF0Tld1ZrZf61gImkjBeOu2dQb1pozrzTajIrxoxULLfcIxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fKsvwv4A; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754079614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WYlq9LZHP2ErlSK10jVViGjjrREz0ikScoWRCgy4N2o=;
	b=fKsvwv4AxV7/RisUD2tNEa68Hnzl04LdKZe4dlR+6M7lCoXqHpxhWEyHsHMANwCtO4zKOp
	/uwNNpB8ARsXrVojpOL5LdzZk0xICoJQT8HxMALvqFuhz0k5ONsuXcYaBShU3aWZXJoGRZ
	kMQaAHaBemy6D73Vpy2P4c/j4bvOdCw=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Cc: alan.maguire@oracle.com,
	domenico.andreoli@linux.com,
	acme@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	kernel-team@meta.com
Subject: [PATCH dwarves v3] btf_encoder: group all function ELF syms by function name
Date: Fri,  1 Aug 2025 13:20:09 -0700
Message-ID: <20250801202009.3942492-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

btf_encoder collects function ELF symbols into a table, which is later
used for processing DWARF data and determining whether a function can
be added to BTF.

So far the ELF symbol name was used as a key for search in this table,
and a search by prefix match was attempted in cases when ELF symbol
name has a compiler-generated suffix.

This implementation has bugs [1][2], causing some functions to be
inappropriately excluded from (or included into) BTF.

Rework the implementation of the ELF functions table. Use a name of a
function without any suffix - a symbol name before the first
occurrence of '.' - as a key. This way btf_encoder__find_function()
always returns a valid elf_function object (or NULL).

Collect an array of symbol name + address pairs from GElf_Sym for each
elf_function when building the elf_functions table.

Take into account that some symbols associated with a function name
are not relevant, and do not collect them into elf_functions table:
  * ".cold" suffix indicates a piece of hot/cold split
  * ".part" suffix indicates a piece of partial inline

When inspecting symbol name we have to search for any occurrence of
the target suffix, as opposed to testing the entire suffix, or the end
of a string. This is because suffixes may be combined by the compiler,
for example producing ".isra0.cold", and the conclusion will be
incorrect.

Introduce ambiguous_addr flag to the elf_function. It is set when the
functions are deduped in elf_functions__collect() examining the array
of ELF symbols in elf_function__has_ambiguous_address(). It tests
whether there is only one unique address for this function name.

In btf_encoder__add_saved_funcs() check ambiguous_addr flag when
deciding whether a function should be included in BTF.

Successful CI run: https://github.com/acmel/dwarves/actions/runs/16683734552

[1] https://lore.kernel.org/bpf/2f8c792e-9675-4385-b1cb-10266c72bd45@linux.dev/
[2] https://lore.kernel.org/dwarves/6b4fda90fbf8f6aeeb2732bbfb6e81ba5669e2f3@linux.dev/

v2->v3:
  * Move ambiguous_addr flag from btf_encoder_func_state to
    elf_function. We don't have to process DWARF to know the value of
    ambiguous_addr, so elf_function is more appropriate.
  * Don't even add symbols with non_fn suffixes into elf_functions
    table. This saves us space and string comparisons. (Alan)
  * Increase elf_function->sym_cnt size from u8 to u16, and other
    nits. (Jiri)

v2: https://github.com/acmel/dwarves/pull/68/commits/f23968d964eb50359715257962a6f9e07c8cf793
v2 (discussion): https://lore.kernel.org/dwarves/aIjG4q6oirhi4pN1@krava/
v1: https://lore.kernel.org/dwarves/98f41eaf6dd364745013650d58c5f254a592221c@linux.dev/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 btf_encoder.c | 247 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 161 insertions(+), 86 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 0bc2334..1803e86 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -92,11 +92,17 @@ struct btf_encoder_func_state {
 	struct btf_encoder_func_annot *annots;
 };
 
+struct elf_function_sym {
+	const char *name;
+	uint64_t addr;
+};
+
 struct elf_function {
-	const char	*name;
-	char		*alias;
-	size_t		prefixlen;
-	bool		kfunc;
+	char		*name;
+	struct elf_function_sym *syms;
+	uint16_t 	sym_cnt;
+	uint16_t 	ambiguous_addr:1;
+	uint16_t	kfunc:1;
 	uint32_t	kfunc_flags;
 };
 
@@ -115,7 +121,6 @@ struct elf_functions {
 	struct elf_symtab *symtab;
 	struct elf_function *entries;
 	int cnt;
-	int suffix_cnt; /* number of .isra, .part etc */
 };
 
 /*
@@ -161,10 +166,18 @@ struct btf_kfunc_set_range {
 	uint64_t end;
 };
 
+static inline void elf_function__clear(struct elf_function *func) {
+	free(func->name);
+	if (func->sym_cnt)
+		free(func->syms);
+	memset(func, 0, sizeof(*func));
+}
+
 static inline void elf_functions__delete(struct elf_functions *funcs)
 {
-	for (int i = 0; i < funcs->cnt; i++)
-		free(funcs->entries[i].alias);
+	for (int i = 0; i < funcs->cnt; i++) {
+		elf_function__clear(&funcs->entries[i]);
+	}
 	free(funcs->entries);
 	elf_symtab__delete(funcs->symtab);
 	list_del(&funcs->node);
@@ -981,8 +994,7 @@ static void btf_encoder__log_func_skip(struct btf_encoder *encoder, struct elf_f
 
 	if (!encoder->verbose)
 		return;
-	printf("%s (%s): skipping BTF encoding of function due to ",
-	       func->alias ?: func->name, func->name);
+	printf("%s : skipping BTF encoding of function due to ", func->name);
 	va_start(ap, fmt);
 	vprintf(fmt, ap);
 	va_end(ap);
@@ -1176,6 +1188,47 @@ static struct btf_encoder_func_state *btf_encoder__alloc_func_state(struct btf_e
 	return state;
 }
 
+/* some "." suffixes do not correspond to real functions;
+ * - .part for partial inline
+ * - .cold for rarely-used codepath extracted for better code locality
+ */
+static inline bool is_non_fn_suffix(const char *suffix) {
+	static const char *skip[] = {
+		".cold",
+		".part"
+	};
+	int i;
+
+	if (!suffix)
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(skip); i++) {
+		if (strstr(suffix, skip[i]))
+			return true;
+	}
+
+	return false;
+}
+
+static bool elf_function__has_ambiguous_address(struct elf_function *func) {
+	struct elf_function_sym *sym;
+	uint64_t addr;
+
+	if (func->sym_cnt <= 1)
+		return false;
+
+	addr = 0;
+	for (int i = 0; i < func->sym_cnt; i++) {
+		sym = &func->syms[i];
+		if (addr && addr != sym->addr)
+			return true;
+		else
+			addr = sym->addr;
+	}
+
+	return false;
+}
+
 static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)
 {
 	struct btf_encoder_func_state *state = btf_encoder__alloc_func_state(encoder);
@@ -1294,7 +1347,7 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
 	int err;
 
 	btf_fnproto_id = btf_encoder__add_func_proto(encoder, NULL, state);
-	name = func->alias ?: func->name;
+	name = func->name;
 	if (btf_fnproto_id >= 0)
 		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id,
 						      name, false);
@@ -1338,40 +1391,29 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
 	return 0;
 }
 
-static int functions_cmp(const void *_a, const void *_b)
+static int elf_function__name_cmp(const void *_a, const void *_b)
 {
 	const struct elf_function *a = _a;
 	const struct elf_function *b = _b;
 
-	/* if search key allows prefix match, verify target has matching
-	 * prefix len and prefix matches.
-	 */
-	if (a->prefixlen && a->prefixlen == b->prefixlen)
-		return strncmp(a->name, b->name, b->prefixlen);
 	return strcmp(a->name, b->name);
 }
 
-#ifndef max
-#define max(x, y) ((x) < (y) ? (y) : (x))
-#endif
-
 static int saved_functions_cmp(const void *_a, const void *_b)
 {
 	const struct btf_encoder_func_state *a = _a;
 	const struct btf_encoder_func_state *b = _b;
 
-	return functions_cmp(a->elf, b->elf);
+	return elf_function__name_cmp(a->elf, b->elf);
 }
 
 static int saved_functions_combine(struct btf_encoder_func_state *a, struct btf_encoder_func_state *b)
 {
 	uint8_t optimized, unexpected, inconsistent;
-	int ret;
 
-	ret = strncmp(a->elf->name, b->elf->name,
-		      max(a->elf->prefixlen, b->elf->prefixlen));
-	if (ret != 0)
-		return ret;
+	if (a->elf != b->elf)
+		return 1;
+
 	optimized = a->optimized_parms | b->optimized_parms;
 	unexpected = a->unexpected_reg | b->unexpected_reg;
 	inconsistent = a->inconsistent_proto | b->inconsistent_proto;
@@ -1432,7 +1474,7 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 		 * just do not _use_ them.  Only exclude functions with
 		 * unexpected register use or multiple inconsistent prototypes.
 		 */
-		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto;
+		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto && !state->elf->ambiguous_addr;
 
 		if (add_to_btf) {
 			err = btf_encoder__add_func(state->encoder, state);
@@ -1447,32 +1489,6 @@ out:
 	return err;
 }
 
-static void elf_functions__collect_function(struct elf_functions *functions, GElf_Sym *sym)
-{
-	struct elf_function *func;
-	const char *name;
-
-	if (elf_sym__type(sym) != STT_FUNC)
-		return;
-
-	name = elf_sym__name(sym, functions->symtab);
-	if (!name)
-		return;
-
-	func = &functions->entries[functions->cnt];
-	func->name = name;
-	if (strchr(name, '.')) {
-		const char *suffix = strchr(name, '.');
-
-		functions->suffix_cnt++;
-		func->prefixlen = suffix - name;
-	} else {
-		func->prefixlen = strlen(name);
-	}
-
-	functions->cnt++;
-}
-
 static struct elf_functions *btf_encoder__elf_functions(struct btf_encoder *encoder)
 {
 	struct elf_functions *funcs = NULL;
@@ -1490,13 +1506,12 @@ static struct elf_functions *btf_encoder__elf_functions(struct btf_encoder *enco
 	return funcs;
 }
 
-static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder,
-						       const char *name, size_t prefixlen)
+static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder, const char *name)
 {
 	struct elf_functions *funcs = elf_functions__find(encoder->cu->elf, &encoder->elf_functions_list);
-	struct elf_function key = { .name = name, .prefixlen = prefixlen };
+	struct elf_function key = { .name = (char*)name };
 
-	return bsearch(&key, funcs->entries, funcs->cnt, sizeof(key), functions_cmp);
+	return bsearch(&key, funcs->entries, funcs->cnt, sizeof(key), elf_function__name_cmp);
 }
 
 static bool btf_name_char_ok(char c, bool first)
@@ -2060,7 +2075,7 @@ static int btf_encoder__collect_kfuncs(struct btf_encoder *encoder)
 			continue;
 		}
 
-		elf_fn = btf_encoder__find_function(encoder, func, 0);
+		elf_fn = btf_encoder__find_function(encoder, func);
 		if (elf_fn) {
 			elf_fn->kfunc = true;
 			elf_fn->kfunc_flags = pair->flags;
@@ -2135,14 +2150,34 @@ int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf)
 	return err;
 }
 
+static inline int elf_function__push_sym(struct elf_function *func, struct elf_function_sym *sym) {
+	struct elf_function_sym *tmp;
+
+	if (func->sym_cnt)
+		tmp = realloc(func->syms, (func->sym_cnt + 1) * sizeof(func->syms[0]));
+	else
+		tmp = calloc(sizeof(func->syms[0]), 1);
+
+	if (!tmp)
+		return -ENOMEM;
+
+	func->syms = tmp;
+	func->syms[func->sym_cnt] = *sym;
+	func->sym_cnt++;
+
+	return 0;
+}
+
 static int elf_functions__collect(struct elf_functions *functions)
 {
 	uint32_t nr_symbols = elf_symtab__nr_symbols(functions->symtab);
-	struct elf_function *tmp;
+	struct elf_function_sym func_sym;
+	struct elf_function *func, *tmp;
+	const char *sym_name, *suffix;
 	Elf32_Word sym_sec_idx;
+	int err = 0, i, j;
 	uint32_t core_id;
 	GElf_Sym sym;
-	int err = 0;
 
 	/* We know that number of functions is less than number of symbols,
 	 * so we can overallocate temporarily.
@@ -2153,18 +2188,77 @@ static int elf_functions__collect(struct elf_functions *functions)
 		goto out_free;
 	}
 
+	/* First, collect an elf_function for each GElf_Sym
+	 * Where func->name is without a suffix
+	 */
 	functions->cnt = 0;
 	elf_symtab__for_each_symbol_index(functions->symtab, core_id, sym, sym_sec_idx) {
-		elf_functions__collect_function(functions, &sym);
+
+		if (elf_sym__type(&sym) != STT_FUNC)
+			continue;
+
+		sym_name = elf_sym__name(&sym, functions->symtab);
+		if (!sym_name)
+			continue;
+
+		suffix = strchr(sym_name, '.');
+		if (is_non_fn_suffix(sym_name))
+			continue;
+
+		func = &functions->entries[functions->cnt];
+		if (suffix)
+			func->name = strndup(sym_name, suffix - sym_name);
+		else
+			func->name = strdup(sym_name);
+
+		if (!func->name) {
+			err = -ENOMEM;
+			goto out_free;
+		}
+
+		func_sym.name = sym_name;
+		func_sym.addr = sym.st_value;
+
+		err = elf_function__push_sym(func, &func_sym);
+		if (err)
+			goto out_free;
+
+		functions->cnt++;
 	}
 
+	/* At this point functions->entries is an unordered array of elf_function
+	 * each having a name (without a suffix) and a single elf_function_sym (maybe with suffix)
+	 * Now let's sort this table by name.
+	 */
 	if (functions->cnt) {
-		qsort(functions->entries, functions->cnt, sizeof(*functions->entries), functions_cmp);
+		qsort(functions->entries, functions->cnt, sizeof(*functions->entries), elf_function__name_cmp);
 	} else {
 		err = 0;
 		goto out_free;
 	}
 
+	/* Finally dedup by name, transforming { name -> syms[1] } entries into { name -> syms[n] } */
+	i = 0;
+	j = 1;
+	for (j = 1; j < functions->cnt; j++) {
+		struct elf_function *a = &functions->entries[i];
+		struct elf_function *b = &functions->entries[j];
+
+		if (!strcmp(a->name, b->name)) {
+			elf_function__push_sym(a, &b->syms[0]);
+			elf_function__clear(b);
+		} else {
+			// at this point all syms for `a` have been collected
+			// check for ambiguous addresses before moving on
+			a->ambiguous_addr = elf_function__has_ambiguous_address(a);
+			i++;
+			if (i != j)
+				functions->entries[i] = functions->entries[j];
+		}
+	}
+
+	functions->cnt = i + 1;
+
 	/* Reallocate to the exact size */
 	tmp = realloc(functions->entries, functions->cnt * sizeof(struct elf_function));
 	if (tmp) {
@@ -2661,30 +2755,11 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 			if (!name)
 				continue;
 
-			/* prefer exact function name match... */
-			func = btf_encoder__find_function(encoder, name, 0);
-			if (!func && funcs->suffix_cnt &&
-			    conf_load->btf_gen_optimized) {
-				/* falling back to name.isra.0 match if no exact
-				 * match is found; only bother if we found any
-				 * .suffix function names.  The function
-				 * will be saved and added once we ensure
-				 * it does not have optimized-out parameters
-				 * in any cu.
-				 */
-				func = btf_encoder__find_function(encoder, name,
-								  strlen(name));
-				if (func) {
-					if (encoder->verbose)
-						printf("matched function '%s' with '%s'%s\n",
-						       name, func->name,
-						       fn->proto.optimized_parms ?
-						       ", has optimized-out parameters" :
-						       fn->proto.unexpected_reg ? ", has unexpected register use by params" :
-						       "");
-					if (!func->alias)
-						func->alias = strdup(name);
-				}
+			func = btf_encoder__find_function(encoder, name);
+			if (!func) {
+				if (encoder->verbose)
+					printf("could not find function '%s' in the ELF functions table\n", name);
+				continue;
 			}
 		} else {
 			if (!fn->external)
-- 
2.49.0


