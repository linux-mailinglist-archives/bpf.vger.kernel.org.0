Return-Path: <bpf+bounces-64121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9880FB0E6C9
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 00:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42DC567FB8
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 22:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10569288C87;
	Tue, 22 Jul 2025 22:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K4gLLnE4"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D5F28505C
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 22:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753225147; cv=none; b=EJP+0t+6qvSZLi4jktdu9EkvF5cEGMNSC90WPeooGBhPZzSFZ2oAqEO60d/KqY0YGJJanWEKl/LFa+KE1BvI/X2ft3MbOxkb3cYpQbunhm+Ja58jEP2G0Gwhifqx+ZBpdjpjZ3Xrodimq4Z6p4GJrdfa7k1BtuxE22xjPRNlHJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753225147; c=relaxed/simple;
	bh=+F57QFgQ4diO3pL1qh7aQs42IyVEPWXh8zDKGONSd70=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=WAS9C7mu8RjzZs2+FTurl8gkTzZFkLgm3j3r1xjYaXnnxb5ru0aGmqrlnJXgPem8nXJH4NMTpIGPGnFBCiHYw4Pm5cqsQEuURFgAbwTJ+/9404Kpe/uBHKfmEXUtB18oIXEcRjzJVIijiZsd18KA1bR/xg3m3OPiaSzLiZeOCcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K4gLLnE4; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753225142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBVsN61l9UlY5mxE5nC0NZI/urFEIg4W41scyF+JN0A=;
	b=K4gLLnE4nsG5YzB8AmomHhsleTE/W+2jhNVq2+LgeK7elH6si2lZqrM6w9KPKp3t73gMkR
	6BCUyftSRvN4zdh77Pkh0GAdBwtyd+PLsaWqGGYgav8uL94lMbi7VFtJDpkNrcqihJiliC
	LmB4OnS5/wKamzz/ZXMqqoA8Ws/x8qc=
Date: Tue, 22 Jul 2025 22:58:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <98f41eaf6dd364745013650d58c5f254a592221c@linux.dev>
TLS-Required: No
Subject: Re: [RFC dwarves] btf_encoder: Remove duplicates from functions
 entries
To: "Alan Maguire" <alan.maguire@oracle.com>, "Jiri Olsa"
 <olsajiri@gmail.com>
Cc: "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Menglong Dong"
 <menglong8.dong@gmail.com>, dwarves@vger.kernel.org, bpf@vger.kernel.org,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andriin@fb.com>, "Yonghong Song" <yhs@fb.com>, "Song Liu"
 <songliubraving@fb.com>, "Eduard Zingerman" <eddyz87@gmail.com>
In-Reply-To: <e88caa24-6bfa-457c-8e88-d00ed775ebd1@oracle.com>
References: <20250717152512.488022-1-jolsa@kernel.org>
 <e4fece83-8267-4929-b1aa-65a9e2882dd8@oracle.com>
 <aH5OW0rtSuMn1st1@krava>
 <6b4fda90fbf8f6aeeb2732bbfb6e81ba5669e2f3@linux.dev>
 <e88caa24-6bfa-457c-8e88-d00ed775ebd1@oracle.com>
X-Migadu-Flow: FLOW_OUT

On 7/22/25 3:45 AM, Alan Maguire wrote:
> On 22/07/2025 00:27, Ihor Solodrai wrote:
>> On 7/21/25 7:27 AM, Jiri Olsa wrote:
>>> On Mon, Jul 21, 2025 at 12:41:00PM +0100, Alan Maguire wrote:
>>>> On 17/07/2025 16:25, Jiri Olsa wrote:
>>
>> [...]
>>
>> The current implementation is just buggy in this regard.
>>
>=20
>=20There are a few separable issues here I think.

You're right. I think in my mind all the issues we are discussing here
boil down to a single fundamental problem: one (function) name maps to
many things. But then there are a lot of details about what those
things are, how to find them, represent them etc.

>=20
>=20First as you say, certain suffixes should not be eligible as matches =
at
> all - .cold is one, and .part is another (partial inlining). As such
> they should be filtered and removed as potential matches.
>=20
>=20Second we need to fix the function sort/search logic.

Ok, here is my stab at it. See a patch draft below.

Using ELF symbol name as the key in elf_functions table is bug-prone,
given that we lookup a name loaded from DWARF (without suffixes).

So instead of having a table of ELF sym names directly and attempting
to search there, I tried a table of unsuffixed names (assuming that
any prefix before first '.' is a proper name, which is an assumption
already present in pahole).

To not lose the information from the ELF symbols, we simply collect it
at the time that table is built, basically constructing a mapping:

    function name -> [array of elf sym info]

Then we can inspect this array when a decision about inclusion into
BTF has to made. In the patch I check for .cold and multiple
addresses.

There is little difference in resulting BTF, but the bug I reported
gets fixed with the change, as well as ambigous address problem.

Please let me know if the approach makes sense.


From 1088367c1facb8b2e6700df17aa5b6e306578334 Mon Sep 17 00:00:00 2001
From: Ihor Solodrai <isolodrai@meta.com>
Date: Tue, 22 Jul 2025 15:16:36 -0700
Subject: [PATCH] btf_encoder: group all function ELF syms by function nam=
e

btf_encoder collects function ELF symbols into a table, which is later
used for processing DWARF data and determining whether a function can
be added to BTF.

So far, the ELF symbol name was used as a key for search in this
table, and a search by prefix match was attempted in cases when ELF
symbol name has a compiler-generated suffix.

This implementation has bugs, causing some functions to be
inappropriately excluded from (or included into) BTF.

Rework the implementation of the ELF functions table: use a proper
name of a function (without any suffix) as a key, and collect each
relevant ELF symbol information for later examination. This way we can
guarantee that btf_encoder__find_function() always returns correct
elf_function object (or NULL).

Collect an array of symbol name + address pairs from GElf_Sym for each
elf_function. Then, in saved_functions_combine() use this information
when deciding whether a function should be included in BTF.

In particular, exclude functions with ambiguous address, taking into
account that .cold symbols can be ignored.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 btf_encoder.c | 248 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 162 insertions(+), 86 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 0bc2334..fcc30aa 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -87,16 +87,22 @@ struct btf_encoder_func_state {
 	uint8_t optimized_parms:1;
 	uint8_t unexpected_reg:1;
 	uint8_t inconsistent_proto:1;
+	uint8_t ambiguous_addr:1;
 	int ret_type_id;
 	struct btf_encoder_func_parm *parms;
 	struct btf_encoder_func_annot *annots;
 };
=20
+struct=20elf_function_sym {
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
+	uint8_t 	sym_cnt;
+	uint8_t		kfunc:1;
 	uint32_t	kfunc_flags;
 };
=20
@@=20-161,10 +167,18 @@ struct btf_kfunc_set_range {
 	uint64_t end;
 };
=20
+static=20inline void elf_function__free_content(struct elf_function *fun=
c) {
+	free(func->name);
+	if (func->sym_cnt)
+		free(func->syms);
+	memset(func, 0, sizeof(*func));
+}
+
 static inline void elf_functions__delete(struct elf_functions *funcs)
 {
-	for (int i =3D 0; i < funcs->cnt; i++)
-		free(funcs->entries[i].alias);
+	for (int i =3D 0; i < funcs->cnt; i++) {
+		elf_function__free_content(&funcs->entries[i]);
+	}
 	free(funcs->entries);
 	elf_symtab__delete(funcs->symtab);
 	list_del(&funcs->node);
@@ -981,8 +995,7 @@ static void btf_encoder__log_func_skip(struct btf_enc=
oder *encoder, struct elf_f
=20
=20	if (!encoder->verbose)
 		return;
-	printf("%s (%s): skipping BTF encoding of function due to ",
-	       func->alias ?: func->name, func->name);
+	printf("%s: skipping BTF encoding of function due to ", func->name);
 	va_start(ap, fmt);
 	vprintf(fmt, ap);
 	va_end(ap);
@@ -1176,6 +1189,33 @@ static struct btf_encoder_func_state *btf_encoder_=
_alloc_func_state(struct btf_e
 	return state;
 }
=20
+static=20inline bool str_has_suffix(const char *str, const char *suffix)=
 {
+	int prefixlen =3D strlen(str) - strlen(suffix);
+
+	if (prefixlen < 0)
+		return false;
+
+	return !strcmp(str + prefixlen, suffix);
+}
+
+static bool elf_function__has_ambiguous_address(struct elf_function *fun=
c) {
+	if (func->sym_cnt <=3D 1)
+		return false;
+
+	uint64_t addr =3D 0;
+	for (int i =3D 0; i < func->sym_cnt; i++) {
+		struct elf_function_sym *sym =3D &func->syms[i];
+		if (!str_has_suffix(sym->name, ".cold")) {
+			if (addr && addr !=3D sym->addr)
+				return true;
+			else
+			 	addr =3D sym->addr;
+		}
+	}
+
+	return false;
+}
+
 static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struc=
t function *fn, struct elf_function *func)
 {
 	struct btf_encoder_func_state *state =3D btf_encoder__alloc_func_state(=
encoder);
@@ -1191,6 +1231,9 @@ static int32_t btf_encoder__save_func(struct btf_en=
coder *encoder, struct functi
=20
=20	state->encoder =3D encoder;
 	state->elf =3D func;
+
+	state->ambiguous_addr =3D elf_function__has_ambiguous_address(func);
+
 	state->nr_parms =3D ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
 	state->ret_type_id =3D ftype->tag.type =3D=3D 0 ? 0 : encoder->type_id_=
off + ftype->tag.type;
 	if (state->nr_parms > 0) {
@@ -1294,7 +1337,7 @@ static int32_t btf_encoder__add_func(struct btf_enc=
oder *encoder,
 	int err;
=20
=20	btf_fnproto_id =3D btf_encoder__add_func_proto(encoder, NULL, state);
-	name =3D func->alias ?: func->name;
+	name =3D func->name;
 	if (btf_fnproto_id >=3D 0)
 		btf_fn_id =3D btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fn=
proto_id,
 						      name, false);
@@ -1338,48 +1381,39 @@ static int32_t btf_encoder__add_func(struct btf_e=
ncoder *encoder,
 	return 0;
 }
=20
-static=20int functions_cmp(const void *_a, const void *_b)
+static int elf_function__name_cmp(const void *_a, const void *_b)
 {
 	const struct elf_function *a =3D _a;
 	const struct elf_function *b =3D _b;
=20
-=09/* if search key allows prefix match, verify target has matching
-	 * prefix len and prefix matches.
-	 */
-	if (a->prefixlen && a->prefixlen =3D=3D b->prefixlen)
-		return strncmp(a->name, b->name, b->prefixlen);
 	return strcmp(a->name, b->name);
 }
=20
-#ifndef=20max
-#define max(x, y) ((x) < (y) ? (y) : (x))
-#endif
-
 static int saved_functions_cmp(const void *_a, const void *_b)
 {
 	const struct btf_encoder_func_state *a =3D _a;
 	const struct btf_encoder_func_state *b =3D _b;
=20
-=09return functions_cmp(a->elf, b->elf);
+	return elf_function__name_cmp(a->elf, b->elf);
 }
=20
=20static int saved_functions_combine(struct btf_encoder_func_state *a, s=
truct btf_encoder_func_state *b)
 {
-	uint8_t optimized, unexpected, inconsistent;
-	int ret;
+	uint8_t optimized, unexpected, inconsistent, ambiguous_addr;
+
+	if (a->elf !=3D b->elf)
+		return 1;
=20
-=09ret =3D strncmp(a->elf->name, b->elf->name,
-		      max(a->elf->prefixlen, b->elf->prefixlen));
-	if (ret !=3D 0)
-		return ret;
 	optimized =3D=20a->optimized_parms | b->optimized_parms;
 	unexpected =3D a->unexpected_reg | b->unexpected_reg;
 	inconsistent =3D a->inconsistent_proto | b->inconsistent_proto;
-	if (!unexpected && !inconsistent && !funcs__match(a, b))
+	ambiguous_addr =3D a->ambiguous_addr | b->ambiguous_addr;
+	if (!unexpected && !inconsistent && !ambiguous_addr && !funcs__match(a,=
 b))
 		inconsistent =3D 1;
 	a->optimized_parms =3D b->optimized_parms =3D optimized;
 	a->unexpected_reg =3D b->unexpected_reg =3D unexpected;
 	a->inconsistent_proto =3D b->inconsistent_proto =3D inconsistent;
+	a->ambiguous_addr =3D b->ambiguous_addr =3D ambiguous_addr;
=20
=20	return 0;
 }
@@ -1447,32 +1481,6 @@ out:
 	return err;
 }
=20
-static=20void elf_functions__collect_function(struct elf_functions *func=
tions, GElf_Sym *sym)
-{
-	struct elf_function *func;
-	const char *name;
-
-	if (elf_sym__type(sym) !=3D STT_FUNC)
-		return;
-
-	name =3D elf_sym__name(sym, functions->symtab);
-	if (!name)
-		return;
-
-	func =3D &functions->entries[functions->cnt];
-	func->name =3D name;
-	if (strchr(name, '.')) {
-		const char *suffix =3D strchr(name, '.');
-
-		functions->suffix_cnt++;
-		func->prefixlen =3D suffix - name;
-	} else {
-		func->prefixlen =3D strlen(name);
-	}
-
-	functions->cnt++;
-}
-
 static struct elf_functions *btf_encoder__elf_functions(struct btf_encod=
er *encoder)
 {
 	struct elf_functions *funcs =3D NULL;
@@ -1490,13 +1498,12 @@ static struct elf_functions *btf_encoder__elf_fun=
ctions(struct btf_encoder *enco
 	return funcs;
 }
=20
-static=20struct elf_function *btf_encoder__find_function(const struct bt=
f_encoder *encoder,
-						       const char *name, size_t prefixlen)
+static struct elf_function *btf_encoder__find_function(const struct btf_=
encoder *encoder, const char *name)
 {
 	struct elf_functions *funcs =3D elf_functions__find(encoder->cu->elf, &=
encoder->elf_functions_list);
-	struct elf_function key =3D { .name =3D name, .prefixlen =3D prefixlen =
};
+	struct elf_function key =3D { .name =3D (char*)name };
=20
-=09return bsearch(&key, funcs->entries, funcs->cnt, sizeof(key), functio=
ns_cmp);
+	return bsearch(&key, funcs->entries, funcs->cnt, sizeof(key), elf_funct=
ion__name_cmp);
 }
=20
=20static bool btf_name_char_ok(char c, bool first)
@@ -2060,7 +2067,7 @@ static int btf_encoder__collect_kfuncs(struct btf_e=
ncoder *encoder)
 			continue;
 		}
=20
-=09	elf_fn =3D btf_encoder__find_function(encoder, func, 0);
+		elf_fn =3D btf_encoder__find_function(encoder, func);
 		if (elf_fn) {
 			elf_fn->kfunc =3D true;
 			elf_fn->kfunc_flags =3D pair->flags;
@@ -2135,14 +2142,45 @@ int btf_encoder__encode(struct btf_encoder *encod=
er, struct conf_load *conf)
 	return err;
 }
=20
+static=20inline int elf_function__push_sym(struct elf_function *func, st=
ruct elf_function_sym *sym) {
+	struct elf_function_sym *tmp;
+
+	if (func->sym_cnt)
+		tmp =3D realloc(func->syms, (func->sym_cnt + 1) * sizeof(func->syms[0]=
));
+	else
+		tmp =3D calloc(sizeof(func->syms[0]), 1);
+
+	if (!tmp)
+		return -ENOMEM;
+
+	func->syms =3D tmp;
+	func->syms[func->sym_cnt] =3D *sym;
+	func->sym_cnt++;
+
+	return 0;
+}
+
+static void print_func_table(struct elf_functions *functions) {
+	for (int i =3D 0; i < functions->cnt; i++) {
+		struct elf_function *func =3D &functions->entries[i];
+		printf("%s -> [", func->name);
+		for (int j =3D 0; j < func->sym_cnt; j++) {
+			printf("{ %s %lx } ", func->syms[j].name, func->syms[j].addr);
+		}
+		printf("]\n");
+	}
+}
+
 static int elf_functions__collect(struct elf_functions *functions)
 {
 	uint32_t nr_symbols =3D elf_symtab__nr_symbols(functions->symtab);
-	struct elf_function *tmp;
+	struct elf_function *func, *tmp;
 	Elf32_Word sym_sec_idx;
+	const char *sym_name;
 	uint32_t core_id;
+	struct elf_function_sym func_sym;
 	GElf_Sym sym;
-	int err =3D 0;
+	int err =3D 0, i, j;
=20
=20	/* We know that number of functions is less than number of symbols,
 	 * so we can overallocate temporarily.
@@ -2153,18 +2191,75 @@ static int elf_functions__collect(struct elf_func=
tions *functions)
 		goto out_free;
 	}
=20
+=09/* First, collect an elf_function for each GElf_Sym
+	 * Where func->name is without a suffix
+	 */
 	functions->cnt =3D 0;
 	elf_symtab__for_each_symbol_index(functions->symtab, core_id, sym, sym_=
sec_idx) {
-		elf_functions__collect_function(functions, &sym);
+
+		if (elf_sym__type(&sym) !=3D STT_FUNC)
+			continue;
+
+		sym_name =3D elf_sym__name(&sym, functions->symtab);
+		if (!sym_name)
+			continue;
+
+		func =3D &functions->entries[functions->cnt];
+
+		const char *suffix =3D strchr(sym_name, '.');
+		if (suffix) {
+			functions->suffix_cnt++;
+			func->name =3D strndup(sym_name, suffix - sym_name);
+		} else {
+			func->name =3D strdup(sym_name);
+		}
+		if (!func->name) {
+			err =3D -ENOMEM;
+			goto out_free;
+		}
+
+		func_sym.name =3D sym_name;
+		func_sym.addr =3D sym.st_value;
+
+		err =3D elf_function__push_sym(func, &func_sym);
+		if (err)
+			goto out_free;
+
+		functions->cnt++;
 	}
=20
+=09/* At this point functions->entries is an unordered array of elf_func=
tion
+	 * each having a name (without a suffix) and a single elf_function_sym =
(maybe with suffix)
+	 * Now let's sort this table by name.
+	 */
 	if (functions->cnt) {
-		qsort(functions->entries, functions->cnt, sizeof(*functions->entries),=
 functions_cmp);
+		qsort(functions->entries, functions->cnt, sizeof(*functions->entries),=
 elf_function__name_cmp);
 	} else {
 		err =3D 0;
 		goto out_free;
 	}
=20
+=09/* Finally dedup by name, transforming { name -> syms[1] } entries in=
to { name -> syms[n] } */
+	i =3D 0;
+	j =3D 1;
+	for (j =3D 1; j < functions->cnt; j++) {
+		struct elf_function *a =3D &functions->entries[i];
+		struct elf_function *b =3D &functions->entries[j];
+
+		if (!strcmp(a->name, b->name)) {
+			elf_function__push_sym(a, &b->syms[0]);
+			elf_function__free_content(b);
+		} else {
+			i++;
+			if (i !=3D j)
+				functions->entries[i] =3D functions->entries[j];
+		}
+	}
+
+	functions->cnt =3D i + 1;
+
+	print_func_table(functions);
+
 	/* Reallocate to the exact size */
 	tmp =3D realloc(functions->entries, functions->cnt * sizeof(struct elf_=
function));
 	if (tmp) {
@@ -2661,30 +2756,11 @@ int btf_encoder__encode_cu(struct btf_encoder *en=
coder, struct cu *cu, struct co
 			if (!name)
 				continue;
=20
-=09		/* prefer exact function name match... */
-			func =3D btf_encoder__find_function(encoder, name, 0);
-			if (!func && funcs->suffix_cnt &&
-			    conf_load->btf_gen_optimized) {
-				/* falling back to name.isra.0 match if no exact
-				 * match is found; only bother if we found any
-				 * .suffix function names.  The function
-				 * will be saved and added once we ensure
-				 * it does not have optimized-out parameters
-				 * in any cu.
-				 */
-				func =3D btf_encoder__find_function(encoder, name,
-								  strlen(name));
-				if (func) {
-					if (encoder->verbose)
-						printf("matched function '%s' with '%s'%s\n",
-						       name, func->name,
-						       fn->proto.optimized_parms ?
-						       ", has optimized-out parameters" :
-						       fn->proto.unexpected_reg ? ", has unexpected register use b=
y params" :
-						       "");
-					if (!func->alias)
-						func->alias =3D strdup(name);
-				}
+			func =3D btf_encoder__find_function(encoder, name);
+			if (!func) {
+				if (encoder->verbose)
+					printf("could not find function '%s' in the ELF functions table\n",=
 name);
+				continue;
 			}
 		} else {
 			if (!fn->external)
--=20
2.50.1


>=20
> Third we need to decide how to deal with cases where the function does
> not correspond to an mcount boundary. It'd be interesting to see if the
> filtering helps here, but part of the problem is also that we don't
> currently have a mechanism to help guide the match between function nam=
e
> and function site that is done when the fentry attach is carried out.
> Yonghong and I talked about it in [1].
>=20
>=20Addresses seem like the natural means to help guide that, so a
> DATASEC-like set of addresses would help this matching. I had a WIP
> version of this but it wasn't working fully yet. I'll revive it and see
> if I can get it out as an RFC. Needs to take into account the work bein=
g
> done on inlines too [1].
>=20
>=20In terms of the tracer's actual intent, multi-site functions are ofte=
n
> "static inline" functions in a .h file that don't actually get inlined;
> the user intent would be often to trace all instances, but it seems to
> me we need to provide a means to support both this or to trace a
> specific instance. How the latter is best represented from the tracer
> side I'm not sure; raw addresses would be one way I suppose. Absent an
> explicit request from the tracer I'm not sure what heuristics make most
> sense; currently we just pick the first instance I suspect, and might
> need to continue to do so for backwards compatibility.
>=20
>=20
>> I am not aware of long term plans for addressing this, though it looks
>> like this was discussed before. I'd appreciate if you share any
>> relevant threads.
>>
>=20
>=20Yonghong and I discussed this a bit in [1], and the inline thread in =
[2]
> has some more details.

Thank you for sharing. I guess I was wrong when I said I'm not aware
of the plans, because I am a little bit familiar with the work on BTF
representation of inlined funcs.

As far as I understand, partly because of the current limitations of
BTF, the best pahole/btf_encoder can do with optimized functions right
now is determine whether a function was not modified too much across
instances (optimized_parms, unexpected_reg etc.), and if yes then
exclude it from BTF.

Anything smarter requires extending BTF.

>=20
>=20[1]
> https://lpc.events/event/18/contributions/1945/attachments/1508/3179/Ke=
rnel%20func%20tracing%20in%20the%20face%20of%20compiler%20optimization.pd=
f
> [2]
> https://lore.kernel.org/bpf/20250416-btf_inline-v1-0-e4bd2f8adae5@meta.=
com/
>=20
>>=20Thanks.
>>
>> [...]

