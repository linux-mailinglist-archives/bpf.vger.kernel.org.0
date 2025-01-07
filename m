Return-Path: <bpf+bounces-48160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E23A049EA
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 20:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363B33A204C
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 19:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDAA1F472F;
	Tue,  7 Jan 2025 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="INbbqOua"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD43F1F471C
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736276971; cv=none; b=nO+/gDI7UsBFi27mC8j3jPHc33i6VTnaNFLQMYXKWtYRGJNBPwOwiMR2ni+lAK/gZgOahnnLqkEAIt3Lh4y3HRCEEL2Dk9d7viAtw6q6qvXrUShwrAMKgE3nt4NnNjmgy700llWVfqsu3NFJr6WCiKJ3lEBvf4rlmb8TAeDTKVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736276971; c=relaxed/simple;
	bh=C46zV9NDFhHlLiu9SgGgypRvrNUR490I9O6XG9hqIho=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CiJsjH5UNQPi/gQLtYKJcfJI1xLoJulECMjXMqmBzFjJ61JuL5tdsL68J3S1c0Xsn/TdQyg+63oq4imeFUZqYFALIgcH3+LQmhf0J0r9SACHTclVeIQN1EgUyPHa1PgRr8uhbZpFeHYyDG8d7GkcqaCsdJqZC1+aRnpP5IMjsdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=INbbqOua; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736276967; x=1736536167;
	bh=N30LZya76BUReVoXzWhBm1uVU1iK80c4clCXBDnCfZc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=INbbqOuaPiPcDTjwzfFRkqmAqBWkhNjq38SumEjDMGyxVoiMIc3DeO65Eja4d1w6h
	 ktZT1Xh6QrAnbZe9gyvnwgawBC1LwFDS08M9yFp25s4GCQYE8D9eeZO0RdwHboyrgl
	 MrYku/fy51BE6KFkfsE+dxA+MSce3ZfVVlICahL+Q2wsMxAUEEXk1RlJTQtaOGlUa8
	 z4c37sp2b9TdBsheD7fmszP16017GesRbyupF+DnU3fbGGhK3SJVi+KW+axFoYItT2
	 mKRR/BLUrP9Yi68XdkkAFvm6mxYTqsYKsY7SfcBy10EMikHO6yVAAcWu5cAARS/ufw
	 CUyriP4hJ+TnQ==
Date: Tue, 07 Jan 2025 19:09:21 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, olsajiri@gmail.com
Subject: [PATCH dwarves v4 04/10] btf_encoder: introduce elf_functions struct type
Message-ID: <20250107190855.2312210-5-ihor.solodrai@pm.me>
In-Reply-To: <20250107190855.2312210-1-ihor.solodrai@pm.me>
References: <20250107190855.2312210-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: d3ffbb93f855276d2b969a14a0362dd3b79f2673
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Extract elf_functions struct type from btf_encoder.

Replace routines operating on functions table in btf_encoder by
routines operating on elf_functions:

- btf_encoder__collect_function -> elf_functions__collect_function
- btf_encoder__collect_symbols -> elf_functions__collect

Now these functions do not depend on btf_encoder being passed to them
as a parameter.

Link: https://lore.kernel.org/dwarves/3MqWfdjBO9srtpr8kjweJgCkdwYKV6JC_-SN2=
7S8Y9_J1SzssIgZs4Ptc5tEqpZ7w2vbSmTQ35J5CX35Yb4KMbw8wsTrB2IAf2SWU-k4Xi4=3D@p=
m.me/
Link: https://lore.kernel.org/dwarves/20241128012341.4081072-6-ihor.solodra=
i@pm.me/

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 118 ++++++++++++++++++++++++++------------------------
 1 file changed, 62 insertions(+), 56 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index b1e80ca..0df9296 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -101,6 +101,13 @@ struct elf_secinfo {
 =09struct gobuffer secinfo;
 };
=20
+struct elf_functions {
+=09struct elf_symtab *symtab;
+=09struct elf_function *entries;
+=09int cnt;
+=09int suffix_cnt; /* number of .isra, .part etc */
+};
+
 /*
  * cu: cu being processed.
  */
@@ -127,12 +134,7 @@ struct btf_encoder {
 =09size_t             seccnt;
 =09int                encode_vars;
 =09struct list_head   func_states;
-=09struct {
-=09=09struct elf_function *entries;
-=09=09int=09=09    allocated;
-=09=09int=09=09    cnt;
-=09=09int=09=09    suffix_cnt; /* number of .isra, .part etc */
-=09} functions;
+=09struct elf_functions functions;
 };
=20
 struct btf_func {
@@ -1210,16 +1212,6 @@ static int functions_cmp(const void *_a, const void =
*_b)
 #define max(x, y) ((x) < (y) ? (y) : (x))
 #endif
=20
-static void *reallocarray_grow(void *ptr, int *nmemb, size_t size)
-{
-=09int new_nmemb =3D max(1000, *nmemb * 3 / 2);
-=09void *new =3D realloc(ptr, new_nmemb * size);
-
-=09if (new)
-=09=09*nmemb =3D new_nmemb;
-=09return new;
-}
-
 static int saved_functions_cmp(const void *_a, const void *_b)
 {
 =09struct btf_encoder_func_state * const *a =3D _a;
@@ -1330,44 +1322,30 @@ out:
 =09return err;
 }
=20
-static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf=
_Sym *sym)
+static void elf_functions__collect_function(struct elf_functions *function=
s, GElf_Sym *sym)
 {
-=09struct elf_function *new;
+=09struct elf_function *func;
 =09const char *name;
=20
 =09if (elf_sym__type(sym) !=3D STT_FUNC)
-=09=09return 0;
-=09name =3D elf_sym__name(sym, encoder->symtab);
-=09if (!name)
-=09=09return 0;
+=09=09return;
=20
-=09if (encoder->functions.cnt =3D=3D encoder->functions.allocated) {
-=09=09new =3D reallocarray_grow(encoder->functions.entries,
-=09=09=09=09=09&encoder->functions.allocated,
-=09=09=09=09=09sizeof(*encoder->functions.entries));
-=09=09if (!new) {
-=09=09=09/*
-=09=09=09 * The cleanup - delete_functions is called
-=09=09=09 * in btf_encoder__encode_cu error path.
-=09=09=09 */
-=09=09=09return -1;
-=09=09}
-=09=09encoder->functions.entries =3D new;
-=09}
+=09name =3D elf_sym__name(sym, functions->symtab);
+=09if (!name)
+=09=09return;
=20
-=09memset(&encoder->functions.entries[encoder->functions.cnt], 0,
-=09       sizeof(*new));
-=09encoder->functions.entries[encoder->functions.cnt].name =3D name;
+=09func =3D &functions->entries[functions->cnt];
+=09func->name =3D name;
 =09if (strchr(name, '.')) {
 =09=09const char *suffix =3D strchr(name, '.');
=20
-=09=09encoder->functions.suffix_cnt++;
-=09=09encoder->functions.entries[encoder->functions.cnt].prefixlen =3D suf=
fix - name;
+=09=09functions->suffix_cnt++;
+=09=09func->prefixlen =3D suffix - name;
 =09} else {
-=09=09encoder->functions.entries[encoder->functions.cnt].prefixlen =3D str=
len(name);
+=09=09func->prefixlen =3D strlen(name);
 =09}
-=09encoder->functions.cnt++;
-=09return 0;
+
+=09functions->cnt++;
 }
=20
 static struct elf_function *btf_encoder__find_function(const struct btf_en=
coder *encoder,
@@ -2139,26 +2117,53 @@ int btf_encoder__encode(struct btf_encoder *encoder=
)
 =09return err;
 }
=20
-
-static int btf_encoder__collect_symbols(struct btf_encoder *encoder)
+static int elf_functions__collect(struct elf_functions *functions)
 {
-=09uint32_t sym_sec_idx;
+=09uint32_t nr_symbols =3D elf_symtab__nr_symbols(functions->symtab);
+=09struct elf_function *tmp;
+=09Elf32_Word sym_sec_idx;
 =09uint32_t core_id;
 =09GElf_Sym sym;
+=09int err =3D 0;
=20
-=09elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_se=
c_idx) {
-=09=09if (btf_encoder__collect_function(encoder, &sym))
-=09=09=09return -1;
+=09/* We know that number of functions is less than number of symbols,
+=09 * so we can overallocate temporarily.
+=09 */
+=09functions->entries =3D calloc(nr_symbols, sizeof(*functions->entries));
+=09if (!functions->entries) {
+=09=09err =3D -ENOMEM;
+=09=09goto out_free;
 =09}
=20
-=09if (encoder->functions.cnt) {
-=09=09qsort(encoder->functions.entries, encoder->functions.cnt, sizeof(enc=
oder->functions.entries[0]),
-=09=09      functions_cmp);
-=09=09if (encoder->verbose)
-=09=09=09printf("Found %d functions!\n", encoder->functions.cnt);
+=09functions->cnt =3D 0;
+=09elf_symtab__for_each_symbol_index(functions->symtab, core_id, sym, sym_=
sec_idx) {
+=09=09elf_functions__collect_function(functions, &sym);
+=09}
+
+=09if (functions->cnt) {
+=09=09qsort(functions->entries, functions->cnt, sizeof(*functions->entries=
), functions_cmp);
+=09} else {
+=09=09err =3D 0;
+=09=09goto out_free;
+=09}
+
+=09/* Reallocate to the exact size */
+=09tmp =3D realloc(functions->entries, functions->cnt * sizeof(struct elf_=
function));
+=09if (tmp) {
+=09=09functions->entries =3D tmp;
+=09} else {
+=09=09fprintf(stderr, "could not reallocate memory for elf_functions table=
\n");
+=09=09err =3D -ENOMEM;
+=09=09goto out_free;
 =09}
=20
 =09return 0;
+
+out_free:
+=09free(functions->entries);
+=09functions->entries =3D NULL;
+=09functions->cnt =3D 0;
+=09return err;
 }
=20
 static bool ftype__has_arg_names(const struct ftype *ftype)
@@ -2419,6 +2424,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
 =09=09=09=09printf("%s: '%s' doesn't have symtab.\n", __func__, cu->filena=
me);
 =09=09=09goto out;
 =09=09}
+=09=09encoder->functions.symtab =3D encoder->symtab;
=20
 =09=09/* index the ELF sections for later lookup */
=20
@@ -2457,7 +2463,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
 =09=09if (!found_percpu && encoder->verbose)
 =09=09=09printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->file=
name, PERCPU_SECTION);
=20
-=09=09if (btf_encoder__collect_symbols(encoder))
+=09=09if (elf_functions__collect(&encoder->functions))
 =09=09=09goto out_delete;
=20
 =09=09if (encoder->verbose)
@@ -2489,7 +2495,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 =09encoder->btf =3D NULL;
 =09elf_symtab__delete(encoder->symtab);
=20
-=09encoder->functions.allocated =3D encoder->functions.cnt =3D 0;
+=09encoder->functions.cnt =3D 0;
 =09free(encoder->functions.entries);
 =09encoder->functions.entries =3D NULL;
=20
--=20
2.47.1



