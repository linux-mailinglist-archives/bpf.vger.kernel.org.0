Return-Path: <bpf+bounces-45784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F639DB0B2
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039991665EA
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 01:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6E42E3EB;
	Thu, 28 Nov 2024 01:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ZZLifAn9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3705B20328
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 01:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757054; cv=none; b=CSKENetp2B1zeHZQTl1nK/vodGqhHMraY/xUvSBzpSZ4Dzaiv5hFEd0C2ihYO//obuRJ4SVTxqiZUtt24bmGtMnyXdhyecBPUWRySphJma5smYuCy/qtxAdiNfPhNZo2cAQb5jzD+/CDNcvECyTwdg6FoIGJwy8Wjb/JrRszK7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757054; c=relaxed/simple;
	bh=BnWwXROR2X2195O5Cz/zW3eOHyBTPxvpTZVyL8M+SK4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAywf4reyaA1s6szEma2B1DOXNHZzwLtlUiT7jQvMbvBoz7wgD0NYf3kypgEqY039bS1kRolFo8xvXKtKVxI76lyPpa6RrAq3FMZRbf0WBFOsiUuLGq5BPDa7Z+th32PoP7hxggsS+L/ZGQr7LjmtY0AGBmn33GjED+E64DmQbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ZZLifAn9; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732757049; x=1733016249;
	bh=zL986JE9ZKQsRcp97zfsphYsYM0KbMTdRoWVjWjNXKE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ZZLifAn9dmRQZnxA/VCdNzoahrVLIEu9Q4h3r/Qn8GyDRkhiRQdgZERR4c0rkAU3R
	 fkokbV2KyQOjTt6AgYXUqZG9BKjR7Sz1EfKnXckfEe6++5ps2xjy3i+Xk+4KX3UKFd
	 pGZZjYtJNWAzVqv0E3NA7s89SQXZszzfOmtR25nc9kC5VnNxvCfy56fHQpPXZix+ck
	 o7ilUAj6fH/Kgr70Lk5Zkxtr4JgfYMpk3rKHS/f+ssr0gdNFEerbbIzBwTmyTrhA0a
	 7kA2afO8z1PakTsVajv4Jy2XlTmCfG45ECP8B42H40O8WuIDq/I/fsV7JzB+xej8Ka
	 mMaz0Sb/f+tGw==
Date: Thu, 28 Nov 2024 01:24:05 +0000
To: dwarves@vger.kernel.org, acme@kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com
Subject: [RFC PATCH 5/9] btf_encoder: introduce elf_functions struct type
Message-ID: <20241128012341.4081072-6-ihor.solodrai@pm.me>
In-Reply-To: <20241128012341.4081072-1-ihor.solodrai@pm.me>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 5cd7877b1b7649a8fe84eb05156f5774e565f4ac
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Extract elf_functions struct type from btf_encoder.

Replace methods operating functions table in btf_encoder by methods
operating on elf_functions:
- btf_encoder__collect_function -> elf_functions__collect_function
- btf_encoder__collect_symbols -> elf_functions__collect

Now these functions do not depend on btf_encoder being passed to them
as a parameter.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 125 ++++++++++++++++++++++++++------------------------
 1 file changed, 66 insertions(+), 59 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 6114cc8..8331efe 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -102,6 +102,13 @@ struct elf_secinfo {
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
@@ -128,13 +135,7 @@ struct btf_encoder {
 =09size_t             seccnt;
 =09int                encode_vars;
 =09struct list_head   func_states;
-=09struct {
-=09=09struct elf_function *entries;
-=09=09int=09=09    allocated;
-=09=09int=09=09    cnt;
-=09=09int=09=09    suffix_cnt; /* number of .isra, .part etc */
-=09=09uint64_t=09    base_addr;
-=09} functions;
+=09struct elf_functions functions;
 };
=20
 struct btf_func {
@@ -1226,16 +1227,6 @@ static int functions_cmp(const void *_a, const void =
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
@@ -1339,47 +1330,34 @@ static int btf_encoder__add_saved_funcs(struct btf_=
encoder *encoder)
 =09return 0;
 }
=20
-static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf=
_Sym *sym)
+static int elf_functions__collect_function(struct elf_functions *functions=
, GElf_Sym *sym)
 {
-=09struct elf_function *new;
+=09struct elf_function *func;
 =09const char *name;
 =09uint64_t addr;
=20
 =09if (elf_sym__type(sym) !=3D STT_FUNC)
 =09=09return 0;
-=09name =3D elf_sym__name(sym, encoder->symtab);
+
+=09name =3D elf_sym__name(sym, functions->symtab);
 =09if (!name)
 =09=09return 0;
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
-
-=09memset(&encoder->functions.entries[encoder->functions.cnt], 0,
-=09       sizeof(*new));
-=09encoder->functions.entries[encoder->functions.cnt].name =3D name;
+=09func =3D &functions->entries[functions->cnt];
+=09func->name =3D name;
 =09/* convert to absoulte address for DWARF/ELF matching. */
 =09addr =3D elf_sym__value(sym);
-=09encoder->functions.entries[encoder->functions.cnt].addr =3D (uint32_t)a=
ddr;
+=09func->addr =3D (uint32_t)addr;
 =09if (strchr(name, '.')) {
 =09=09const char *suffix =3D strchr(name, '.');
-
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
+
+=09functions->cnt++;
+
 =09return 0;
 }
=20
@@ -2132,31 +2110,59 @@ int btf_encoder__encode(struct btf_encoder *encoder=
)
 =09return err;
 }
=20
-
-static int btf_encoder__collect_symbols(struct btf_encoder *encoder)
+static int elf_functions__collect(struct elf_functions *functions)
 {
-=09bool base_addr_set =3D false;
-=09uint32_t sym_sec_idx;
+=09uint32_t nr_symbols =3D elf_symtab__nr_symbols(functions->symtab);
+=09struct elf_function *tmp;
+=09Elf32_Word sym_sec_idx;
 =09uint32_t core_id;
 =09GElf_Sym sym;
+=09int err;
+
+=09/* We know that number of functions is less than number of symbols,
+=09 * so we can overallocate temporarily.
+=09 */
+=09functions->entries =3D calloc(nr_symbols, sizeof(struct elf_function));
+=09if (!functions->entries) {
+=09=09err =3D -ENOMEM;
+=09=09goto out_free;
+=09}
=20
-=09elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_se=
c_idx) {
-=09=09if (!base_addr_set && sym_sec_idx && sym_sec_idx < encoder->seccnt) =
{
-=09=09=09encoder->functions.base_addr =3D encoder->secinfo[sym_sec_idx].ad=
dr;
-=09=09=09base_addr_set =3D true;
+=09functions->cnt =3D 0;
+=09elf_symtab__for_each_symbol_index(functions->symtab, core_id, sym, sym_=
sec_idx) {
+=09=09if (elf_functions__collect_function(functions, &sym)) {
+=09=09=09err =3D -1;
+=09=09=09goto out_free;
 =09=09}
-=09=09if (btf_encoder__collect_function(encoder, &sym))
-=09=09=09return -1;
 =09}
=20
-=09if (encoder->functions.cnt) {
-=09=09qsort(encoder->functions.entries, encoder->functions.cnt, sizeof(enc=
oder->functions.entries[0]),
+=09if (functions->cnt) {
+=09=09qsort(functions->entries,
+=09=09      functions->cnt,
+=09=09      sizeof(functions->entries[0]),
 =09=09      functions_cmp);
-=09=09if (encoder->verbose)
-=09=09=09printf("Found %d functions!\n", encoder->functions.cnt);
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
@@ -2417,6 +2423,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
 =09=09=09=09printf("%s: '%s' doesn't have symtab.\n", __func__, cu->filena=
me);
 =09=09=09goto out;
 =09=09}
+=09=09encoder->functions.symtab =3D encoder->symtab;
=20
 =09=09/* index the ELF sections for later lookup */
=20
@@ -2455,7 +2462,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
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
@@ -2486,7 +2493,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 =09encoder->btf =3D NULL;
 =09elf_symtab__delete(encoder->symtab);
=20
-=09encoder->functions.allocated =3D encoder->functions.cnt =3D 0;
+=09encoder->functions.cnt =3D 0;
 =09free(encoder->functions.entries);
 =09encoder->functions.entries =3D NULL;
=20
--=20
2.47.0



