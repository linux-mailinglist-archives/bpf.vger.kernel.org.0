Return-Path: <bpf+bounces-45786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E789DB0B4
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2FE1665DF
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 01:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BF224B34;
	Thu, 28 Nov 2024 01:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="pDxsZ6Hh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7621EEE0
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 01:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757059; cv=none; b=L4z3c8yzf+6YwKM+jk3fdPr2V84INpbyz6KS59SSG7XSb0QMxH7qsBYqDisq8ZBdG5Fy08qcbPo/XMvcvTTUTRKTF3m8pVQufvFJb/vqbGfKyNW9NsJSc4s4uuvuxo99ysdM5vcotwDaPwavmLC2V4NXDRFGr/jpTgVyw/JkQlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757059; c=relaxed/simple;
	bh=AcekpYPUz6WXe/HocDja5CWE/JskoSENnlv96FjlCI8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4pdIeaODKtzv+emmIfra33gxseJ8BK/u45nj6lwrFGrUoysIz+mGpDrCwXxQGhLUhtzlhdVOiP7zkmiWB9s+G8RiusP43TRA2FsgnQoc8c/OLXIhpgm4jjbsyXfWMG6PAaxwTgw14HUxYThhYyzDMdjQqeSp2Qp1zWWi6aWUPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=pDxsZ6Hh; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732757055; x=1733016255;
	bh=jaw2NQ06s5/YdtWm4Ky06nvWSpFOKNi8xjlLNi0SoWQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=pDxsZ6HhShjjyrvnDDrVdPbAVQwzyc4viDDIXIRNjvArcSVbAXOUI4gB5qjitPB5S
	 K/Cp/zA5GRLdhpSnadtAx2U+wp1CSC0k7uwNpsldMJV7EZRet6N2bS8wTELbhYLK8l
	 jYlteXtFGyFbRalOW38SIxjl/cLeB5aJoYPGl3557hgOzbi332AFBORdinPk0prOrA
	 gbdVNcpyrwEo0SwN8ULp8YLp4qUbnW3cNNBneeT2sc96gmyWP/OOZ5JpFLLKvdP21p
	 c9HZLv1Wx6De3asb42lHHvs8EI+EAQl5mB3F0WslMWqTdi++3qIKOPnCdnv9IyKmeL
	 9z12sRISRUxmw==
Date: Thu, 28 Nov 2024 01:24:13 +0000
To: dwarves@vger.kernel.org, acme@kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com
Subject: [RFC PATCH 7/9] btf_encoder: switch to shared elf_functions table
Message-ID: <20241128012341.4081072-8-ihor.solodrai@pm.me>
In-Reply-To: <20241128012341.4081072-1-ihor.solodrai@pm.me>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 5fa30f01a4e43a861beb08b6870c293b5e23b016
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Do not collect functions from ELF for each new btf_encoder, and
instead set a pointer to a shared elf_functions table, built
beforehand by btf_encoder__pre_cus__load_module().

Do not call btf_encoder__add_saved_funcs() on every
btf_encoder__add_encoder(). Instead, for non-reproducible
multi-threaded case do that in pahole_threads_collect(), and for
single-threaded or reproducible_build do that right before
btf_encoder__encode().

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 42 +++++++++++++++++++-----------------------
 btf_encoder.h |  1 +
 pahole.c      |  9 ++++++++-
 3 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 8b1db5b..778481d 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -137,7 +137,7 @@ struct btf_encoder {
 =09size_t             seccnt;
 =09int                encode_vars;
 =09struct list_head   func_states;
-=09struct elf_functions functions;
+=09struct elf_functions *functions;
 };
=20
 struct btf_func {
@@ -159,6 +159,19 @@ struct btf_kfunc_set_range {
  */
 static LIST_HEAD(elf_functions_list);
=20
+static struct elf_functions *elf_functions__get(Elf *elf)
+{
+=09struct list_head *pos;
+
+=09list_for_each(pos, &elf_functions_list) {
+=09=09struct elf_functions *funcs =3D list_entry(pos, struct elf_functions=
, node);
+
+=09=09if (funcs->elf =3D=3D elf)
+=09=09=09return funcs;
+=09}
+=09return NULL;
+}
+
 static inline void elf_functions__delete(struct elf_functions *funcs)
 {
 =09free(funcs->entries);
@@ -215,8 +228,6 @@ out_delete:
 static LIST_HEAD(encoders);
 static pthread_mutex_t encoders__lock =3D PTHREAD_MUTEX_INITIALIZER;
=20
-static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder);
-
 /* mutex only needed for add/delete, as this can happen in multiple encodi=
ng
  * threads.  Traversal of the list is currently confined to thread collect=
ion.
  */
@@ -869,8 +880,6 @@ int32_t btf_encoder__add_encoder(struct btf_encoder *en=
coder, struct btf_encoder
 =09if (encoder =3D=3D other)
 =09=09return 0;
=20
-=09btf_encoder__add_saved_funcs(other);
-
 =09for (shndx =3D 1; shndx < other->seccnt; shndx++) {
 =09=09struct gobuffer *var_secinfo_buf =3D &other->secinfo[shndx].secinfo;
 =09=09size_t sz =3D gobuffer__size(var_secinfo_buf);
@@ -1333,7 +1342,7 @@ static void btf_encoder__delete_saved_funcs(struct bt=
f_encoder *encoder)
 =09}
 }
=20
-static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
+int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
 {
 =09struct btf_encoder_func_state **saved_fns, *s;
 =09struct btf_encoder *e =3D NULL;
@@ -1430,7 +1439,7 @@ static struct elf_function *btf_encoder__find_functio=
n(const struct btf_encoder
 {
 =09struct elf_function key =3D { .name =3D name, .prefixlen =3D prefixlen,=
 .addr =3D addr };
=20
-=09return bsearch(&key, encoder->functions.entries, encoder->functions.cnt=
, sizeof(key), functions_cmp);
+=09return bsearch(&key, encoder->functions->entries, encoder->functions->c=
nt, sizeof(key), functions_cmp);
 }
=20
 static bool btf_name_char_ok(char c, bool first)
@@ -2118,9 +2127,6 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 =09int err;
 =09size_t shndx;
=20
-=09/* for single-threaded case, saved funcs are added here */
-=09btf_encoder__add_saved_funcs(encoder);
-
 =09for (shndx =3D 1; shndx < encoder->seccnt; shndx++)
 =09=09if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
 =09=09=09btf_encoder__add_datasec(encoder, shndx);
@@ -2488,8 +2494,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
 =09=09=09=09printf("%s: '%s' doesn't have symtab.\n", __func__, cu->filena=
me);
 =09=09=09goto out;
 =09=09}
-=09=09encoder->functions.symtab =3D encoder->symtab;
-=09=09encoder->functions.elf =3D cu->elf;
+=09=09encoder->functions =3D elf_functions__get(cu->elf);
=20
 =09=09/* index the ELF sections for later lookup */
=20
@@ -2528,9 +2533,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
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
@@ -2559,12 +2561,6 @@ void btf_encoder__delete(struct btf_encoder *encoder=
)
 =09encoder->btf =3D NULL;
 =09elf_symtab__delete(encoder->symtab);
=20
-=09encoder->functions.cnt =3D 0;
-=09free(encoder->functions.entries);
-=09encoder->functions.entries =3D NULL;
-
-=09btf_encoder__delete_saved_funcs(encoder);
-
 =09free(encoder);
 }
=20
@@ -2661,7 +2657,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
r, struct cu *cu, struct co
 =09=09=09continue;
 =09=09if (!ftype__has_arg_names(&fn->proto))
 =09=09=09continue;
-=09=09if (encoder->functions.cnt) {
+=09=09if (encoder->functions->cnt) {
 =09=09=09const char *name;
 =09=09=09uint64_t addr;
=20
@@ -2673,7 +2669,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
r, struct cu *cu, struct co
=20
 =09=09=09/* prefer exact function name match... */
 =09=09=09func =3D btf_encoder__find_function(encoder, name, 0, addr);
-=09=09=09if (!func && encoder->functions.suffix_cnt &&
+=09=09=09if (!func && encoder->functions->suffix_cnt &&
 =09=09=09    conf_load->btf_gen_optimized) {
 =09=09=09=09/* falling back to name.isra.0 match if no exact
 =09=09=09=09 * match is found; only bother if we found any
diff --git a/btf_encoder.h b/btf_encoder.h
index 7debd67..29f652a 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -33,6 +33,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, s=
truct cu *cu, struct co
 struct btf *btf_encoder__btf(struct btf_encoder *encoder);
=20
 int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encod=
er *other);
+int btf_encoder__add_saved_funcs(struct btf_encoder *base_encoder);
=20
 int btf_encoder__pre_load_module(Dwfl_Module *mod, Elf *elf);
=20
diff --git a/pahole.c b/pahole.c
index 1f8cf4b..b5aea56 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3185,12 +3185,16 @@ static int pahole_threads_collect(struct conf_load =
*conf, int nr_threads, void *
 =09if (error)
 =09=09goto out;
=20
+=09err =3D btf_encoder__add_saved_funcs(btf_encoder);
+=09if (err < 0)
+=09=09goto out;
+
 =09for (i =3D 0; i < nr_threads; i++) {
 =09=09/*
 =09=09 * Merge content of the btf instances of worker threads to the btf
 =09=09 * instance of the primary btf_encoder.
                 */
-=09=09if (!threads[i]->btf)
+=09=09if (!threads[i]->encoder || !threads[i]->btf)
 =09=09=09continue;
 =09=09err =3D btf_encoder__add_encoder(btf_encoder, threads[i]->encoder);
 =09=09if (err < 0)
@@ -3845,6 +3849,9 @@ try_sole_arg_as_class_names:
 =09=09=09exit(1);
 =09=09}
=20
+=09=09if (conf_load.nr_jobs <=3D 1 || conf_load.reproducible_build)
+=09=09=09btf_encoder__add_saved_funcs(btf_encoder);
+
 =09=09err =3D btf_encoder__encode(btf_encoder);
 =09=09if (err) {
 =09=09=09fputs("Failed to encode BTF\n", stderr);
--=20
2.47.0



