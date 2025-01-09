Return-Path: <bpf+bounces-48441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7BCA0805B
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 20:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3AF4168B0D
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 19:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405741B21AA;
	Thu,  9 Jan 2025 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="caNHSfNj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624BA2594B4
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736449229; cv=none; b=NejCXSzJs2P+A1ypUdmPzEn0AWfvJ0yMXJKsU8tUrXpbWMEQi2CYAlb7JWLrvxt91WoYM00LaIzh0DIgYIPcNZGmDk5+ZsIOfvB2YQIjg58zckNYireQVUDeqxu2KCq64ImhR7DHQBYSsKxVeNooauNA3DiF6x4dyjzMjzxd7gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736449229; c=relaxed/simple;
	bh=tjVU332uZRfG8vAKMLqbonbyiM7LtLK4qww7cBewuFA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aoAsVs7YYsNfynmuKCnHfiCRnKYixlbKIsxrbH16+07VkaQcZJoWz+SZVHI+A1sPmMc4GRfHvud/SkwHOiD5UDnVUMByjaUFOdJRrSiXcZgKYXagbiAFB5k/I8FabZ1mxqi0xcf4d9h8COFVC+QKxthDYrLNE/YBqeM8bhLqq+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=caNHSfNj; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736449224; x=1736708424;
	bh=DCTYPCgqEf0zIGbb8jDKG6+MKeTzsnEbOXY0/RLSXkI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=caNHSfNjKlt3ZyNntOb+y8IOrAPUaAjylR/nF10wE1guIeIK9u0mpF1Y5xYb4h2oM
	 ajuKDR8RzZxs9GrxcUpyCu42uu6UkUoTQ+woc5kFX8FDdUvKycB6fKiMiDRk9c5Bp4
	 zaD/C7oeEy93sKEiPw3gTRjw3Fqa2Ygr/c0uhom2kBpF39mh9txY7aHpRYR+Mcy7xy
	 ljtF7oxAvxLLuMnAogw52fEx4ihyGmgrdwiuqg4SNMQ7orn2uoMHr05j1nR/oxuKby
	 aS+mTSQxPQPI1atBJjmgI+TJVRZdHUckKNJNBrbOrO/3yfdy8IGEAbEAWgI2Fb612E
	 siYR4f5JCgnqw==
Date: Thu, 09 Jan 2025 19:00:21 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, olsajiri@gmail.com
Subject: [PATCH dwarves v4 RESEND 05/10] btf_encoder: introduce elf_functions_list
Message-ID: <20250109185950.653110-6-ihor.solodrai@pm.me>
In-Reply-To: <20250109185950.653110-1-ihor.solodrai@pm.me>
References: <20250109185950.653110-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 00addda94406d2760b7fcb3dda326d64c5c954ef
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

In case of processing of multiple DWARF modules, multiple ELFs are
read. This requires maintaining and elf_functions table per ELF.

Replace btf_encoder.functions with btf_encoder.elf_functions_list,
that contains all necessary elf_functions tables.

The list is initialized when btf_encoder is created. When a new CU is
assigned to the encoder in btf_encoder__encode_cu, an elf_functions
table will be created if the CU is coming from an unknown Elf.

This patch is a variant of [1], following a discussion at [2].

[1] https://lore.kernel.org/bpf/20241213223641.564002-7-ihor.solodrai@pm.me=
/
[2] https://lore.kernel.org/bpf/C82bYTvJaV4bfT15o25EsBiUvFsj5eTlm17933Hvva7=
6CXjIcu3gvpaOCWPgeZ8g3cZ-RMa8Vp0y1o_QMR2LhPB-LEUYfZCGuCfR_HvkIP8=3D@pm.me/

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 138 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 115 insertions(+), 23 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 1c27700..f0715c5 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -102,6 +102,8 @@ struct elf_secinfo {
 };
=20
 struct elf_functions {
+=09struct list_head node; /* for elf_functions_list */
+=09Elf *elf; /* source ELF */
 =09struct elf_symtab *symtab;
 =09struct elf_function *entries;
 =09int cnt;
@@ -134,7 +136,11 @@ struct btf_encoder {
 =09size_t             seccnt;
 =09int                encode_vars;
 =09struct list_head   func_states;
-=09struct elf_functions functions;
+=09/* This is a list of elf_functions tables, one per ELF.
+=09 * Multiple ELF modules can be processed in one pahole run,
+=09 * so we have to store elf_functions tables per ELF.
+=09 */
+=09struct list_head elf_functions_list;
 };
=20
 struct btf_func {
@@ -148,6 +154,72 @@ struct btf_kfunc_set_range {
 =09uint64_t end;
 };
=20
+static inline void elf_functions__delete(struct elf_functions *funcs)
+{
+=09for (int i =3D 0; i < funcs->cnt; i++)
+=09=09free(funcs->entries[i].alias);
+=09free(funcs->entries);
+=09elf_symtab__delete(funcs->symtab);
+=09list_del(&funcs->node);
+=09free(funcs);
+}
+
+static int elf_functions__collect(struct elf_functions *functions);
+
+struct elf_functions *elf_functions__new(Elf *elf)
+{
+=09struct elf_functions *funcs;
+=09int err;
+
+=09funcs =3D calloc(1, sizeof(*funcs));
+=09if (!funcs) {
+=09=09err =3D -ENOMEM;
+=09=09goto out_delete;
+=09}
+
+=09funcs->symtab =3D elf_symtab__new(NULL, elf);
+=09if (!funcs->symtab) {
+=09=09err =3D -1;
+=09=09goto out_delete;
+=09}
+
+=09funcs->elf =3D elf;
+=09err =3D elf_functions__collect(funcs);
+=09if (err < 0)
+=09=09goto out_delete;
+
+=09return funcs;
+
+out_delete:
+=09elf_functions__delete(funcs);
+=09return NULL;
+}
+
+static inline void elf_functions_list__clear(struct list_head *elf_functio=
ns_list)
+{
+=09struct elf_functions *funcs;
+=09struct list_head *pos, *tmp;
+
+=09list_for_each_safe(pos, tmp, elf_functions_list) {
+=09=09funcs =3D list_entry(pos, struct elf_functions, node);
+=09=09elf_functions__delete(funcs);
+=09}
+}
+
+static struct elf_functions *elf_functions__find(const Elf *elf, const str=
uct list_head *elf_functions_list)
+{
+=09struct elf_functions *funcs;
+=09struct list_head *pos;
+
+=09list_for_each(pos, elf_functions_list) {
+=09=09funcs =3D list_entry(pos, struct elf_functions, node);
+=09=09if (funcs->elf =3D=3D elf)
+=09=09=09return funcs;
+=09}
+=09return NULL;
+}
+
+
 static LIST_HEAD(encoders);
 static pthread_mutex_t encoders__lock =3D PTHREAD_MUTEX_INITIALIZER;
=20
@@ -1253,9 +1325,6 @@ static void btf_encoder__delete_saved_funcs(struct bt=
f_encoder *encoder)
 =09=09free(pos->annots);
 =09=09free(pos);
 =09}
-
-=09for (int i =3D 0; i < encoder->functions.cnt; i++)
-=09=09free(encoder->functions.entries[i].alias);
 }
=20
 int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
@@ -1348,12 +1417,30 @@ static void elf_functions__collect_function(struct =
elf_functions *functions, GEl
 =09functions->cnt++;
 }
=20
+static struct elf_functions *btf_encoder__elf_functions(struct btf_encoder=
 *encoder)
+{
+=09struct elf_functions *funcs =3D NULL;
+
+=09if (!encoder->cu || !encoder->cu->elf)
+=09=09return NULL;
+
+=09funcs =3D elf_functions__find(encoder->cu->elf, &encoder->elf_functions=
_list);
+=09if (!funcs) {
+=09=09funcs =3D elf_functions__new(encoder->cu->elf);
+=09=09if (funcs)
+=09=09=09list_add(&funcs->node, &encoder->elf_functions_list);
+=09}
+
+=09return funcs;
+}
+
 static struct elf_function *btf_encoder__find_function(const struct btf_en=
coder *encoder,
 =09=09=09=09=09=09       const char *name, size_t prefixlen)
 {
+=09struct elf_functions *funcs =3D elf_functions__find(encoder->cu->elf, &=
encoder->elf_functions_list);
 =09struct elf_function key =3D { .name =3D name, .prefixlen =3D prefixlen =
};
=20
-=09return bsearch(&key, encoder->functions.entries, encoder->functions.cnt=
, sizeof(key), functions_cmp);
+=09return bsearch(&key, funcs->entries, funcs->cnt, sizeof(key), functions=
_cmp);
 }
=20
 static bool btf_name_char_ok(char c, bool first)
@@ -2108,6 +2195,8 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 #endif
 =09=09err =3D btf_encoder__write_elf(encoder, encoder->btf, BTF_ELF_SEC);
 =09}
+
+=09elf_functions_list__clear(&encoder->elf_functions_list);
 =09return err;
 }
=20
@@ -2363,8 +2452,10 @@ out:
 struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_f=
ilename, struct btf *base_btf, bool verbose, struct conf_load *conf_load)
 {
 =09struct btf_encoder *encoder =3D zalloc(sizeof(*encoder));
+=09struct elf_functions *funcs =3D NULL;
=20
 =09if (encoder) {
+=09=09encoder->cu =3D cu;
 =09=09encoder->raw_output =3D detached_filename !=3D NULL;
 =09=09encoder->source_filename =3D strdup(cu->filename);
 =09=09encoder->filename =3D strdup(encoder->raw_output ? detached_filename=
 : cu->filename);
@@ -2392,6 +2483,13 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, =
const char *detached_filenam
 =09=09if (conf_load->encode_btf_global_vars)
 =09=09=09encoder->encode_vars |=3D BTF_VAR_GLOBAL;
=20
+=09=09INIT_LIST_HEAD(&encoder->elf_functions_list);
+=09=09funcs =3D btf_encoder__elf_functions(encoder);
+=09=09if (!funcs)
+=09=09=09goto out_delete;
+
+=09=09encoder->symtab =3D funcs->symtab;
+
 =09=09GElf_Ehdr ehdr;
=20
 =09=09if (gelf_getehdr(cu->elf, &ehdr) =3D=3D NULL) {
@@ -2412,14 +2510,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, =
const char *detached_filenam
 =09=09=09goto out_delete;
 =09=09}
=20
-=09=09encoder->symtab =3D elf_symtab__new(NULL, cu->elf);
-=09=09if (!encoder->symtab) {
-=09=09=09if (encoder->verbose)
-=09=09=09=09printf("%s: '%s' doesn't have symtab.\n", __func__, cu->filena=
me);
-=09=09=09goto out;
-=09=09}
-=09=09encoder->functions.symtab =3D encoder->symtab;
-
 =09=09/* index the ELF sections for later lookup */
=20
 =09=09GElf_Shdr shdr;
@@ -2457,14 +2547,11 @@ struct btf_encoder *btf_encoder__new(struct cu *cu,=
 const char *detached_filenam
 =09=09if (!found_percpu && encoder->verbose)
 =09=09=09printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->file=
name, PERCPU_SECTION);
=20
-=09=09if (elf_functions__collect(&encoder->functions))
-=09=09=09goto out_delete;
-
 =09=09if (encoder->verbose)
 =09=09=09printf("File %s:\n", cu->filename);
 =09=09btf_encoders__add(encoder);
 =09}
-out:
+
 =09return encoder;
=20
 out_delete:
@@ -2487,11 +2574,8 @@ void btf_encoder__delete(struct btf_encoder *encoder=
)
 =09zfree(&encoder->source_filename);
 =09btf__free(encoder->btf);
 =09encoder->btf =3D NULL;
-=09elf_symtab__delete(encoder->symtab);
=20
-=09encoder->functions.cnt =3D 0;
-=09free(encoder->functions.entries);
-=09encoder->functions.entries =3D NULL;
+=09elf_functions_list__clear(&encoder->elf_functions_list);
=20
 =09btf_encoder__delete_saved_funcs(encoder);
=20
@@ -2502,12 +2586,20 @@ int btf_encoder__encode_cu(struct btf_encoder *enco=
der, struct cu *cu, struct co
 {
 =09struct llvm_annotation *annot;
 =09int btf_type_id, tag_type_id, skipped_types =3D 0;
+=09struct elf_functions *funcs;
 =09uint32_t core_id;
 =09struct function *fn;
 =09struct tag *pos;
 =09int err =3D 0;
=20
 =09encoder->cu =3D cu;
+=09funcs =3D btf_encoder__elf_functions(encoder);
+=09if (!funcs) {
+=09=09err =3D -1;
+=09=09goto out;
+=09}
+=09encoder->symtab =3D funcs->symtab;
+
 =09encoder->type_id_off =3D btf__type_cnt(encoder->btf) - 1;
=20
 =09if (!encoder->has_index_type) {
@@ -2591,7 +2683,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
r, struct cu *cu, struct co
 =09=09=09continue;
 =09=09if (!ftype__has_arg_names(&fn->proto))
 =09=09=09continue;
-=09=09if (encoder->functions.cnt) {
+=09=09if (funcs->cnt) {
 =09=09=09const char *name;
=20
 =09=09=09name =3D function__name(fn);
@@ -2600,7 +2692,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
r, struct cu *cu, struct co
=20
 =09=09=09/* prefer exact function name match... */
 =09=09=09func =3D btf_encoder__find_function(encoder, name, 0);
-=09=09=09if (!func && encoder->functions.suffix_cnt &&
+=09=09=09if (!func && funcs->suffix_cnt &&
 =09=09=09    conf_load->btf_gen_optimized) {
 =09=09=09=09/* falling back to name.isra.0 match if no exact
 =09=09=09=09 * match is found; only bother if we found any
--=20
2.47.1



