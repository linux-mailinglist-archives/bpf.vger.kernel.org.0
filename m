Return-Path: <bpf+bounces-48446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28718A08063
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 20:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB31188A7DF
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 19:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7081F9439;
	Thu,  9 Jan 2025 19:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="qAgv0GVW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E71B4133
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 19:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736449261; cv=none; b=OSMJkd7XlA6fcyMerohfRQ8pmDRzXytxeLHlrpQsDmq7ChHhe+fHjMGsSdGdfOm1KodXoiKuxjkDDEfVEu64P2aRAt8qiTv8leX4bV9j0Vl3HPOLb1KT0RoSYdSYOw0xw5BsPfoP49nNPgY44p7X7ynMuKBkqiPNM2nFQM3KxX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736449261; c=relaxed/simple;
	bh=nWRBvXIZLUG/0nIGRYJF9tUFh/pcE2I31qSTDymXz8o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z57+SCEIY5cND40AFNpSjKQU5Jt4QwiCBjo/56dHISEIOB/wuRRmoujwY4N0ACYrtIP0UC2ADpljwzMBDmD0b99CHfbiHgVmUZmGXlrpq2zwFnNqKXLDBM4GRJcX4Yb6SaOKoyzdKJNgpH+p9xynsJKWla3J+OE538M7BwJ7kzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=qAgv0GVW; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736449257; x=1736708457;
	bh=23TypOfuJ4mIy7H6YtvpcaGiYoIB9NhyhrjCz2YicjA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=qAgv0GVW3VUTEQWpt6gCjQJqUq8aL7elAApeyiGPQgTFDY+RXKLULOTFadMJ15m1f
	 mxVyaNRqOwkjdlC7QgJy8ovrdCpMyht2/sf5dXkyRmsBqBpk/nCf4ULIQlpbKhLAor
	 Ux0o0OgVIf9rHPhTBtSFXus6Cnk/f95JOHAT/8QoHu5SAn/Gw4RMaHXnyNIXFHaVf3
	 BviASX32VLpF3FmoMgtDnoBNMLiTDDI8a/xWrsouKInq5TOb/6ARw1BS7RgHRrmgxQ
	 5idrMMoLuFMfokM034WDjTxbQ3dyXREHGY0swotMDHuBX97RVJx9lusFEqL7kECcZ4
	 uvIfC6wlYKCnw==
Date: Thu, 09 Jan 2025 19:00:54 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, olsajiri@gmail.com
Subject: [PATCH dwarves v4 RESEND 10/10] btf_encoder: switch func_states from a list to an array
Message-ID: <20250109185950.653110-11-ihor.solodrai@pm.me>
In-Reply-To: <20250109185950.653110-1-ihor.solodrai@pm.me>
References: <20250109185950.653110-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 199c3894c60d4be22ce735d63b1bc3eda9dd18c4
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

With only a single encoder, it's now easier to acummulate function
states into an array, and then sort it before merging the states and
adding the functions to BTF.

Previously a list (per encoder) was collected, and because the sorting
is required, the lists had to be converted into a temporary array in a
separate step.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 95 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 57 insertions(+), 38 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index da99fbb..78efd70 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -72,7 +72,6 @@ struct btf_encoder_func_annot {
=20
 /* state used to do later encoding of saved functions */
 struct btf_encoder_func_state {
-=09struct list_head node;
 =09struct btf_encoder *encoder;
 =09struct elf_function *elf;
 =09uint32_t type_id_off;
@@ -134,7 +133,11 @@ struct btf_encoder {
 =09struct elf_secinfo *secinfo;
 =09size_t             seccnt;
 =09int                encode_vars;
-=09struct list_head   func_states;
+=09struct {
+=09=09struct btf_encoder_func_state *array;
+=09=09int cnt;
+=09=09int cap;
+=09} func_states;
 =09/* This is a list of elf_functions tables, one per ELF.
 =09 * Multiple ELF modules can be processed in one pahole run,
 =09 * so we have to store elf_functions tables per ELF.
@@ -1078,9 +1081,31 @@ static bool funcs__match(struct btf_encoder_func_sta=
te *s1,
 =09return true;
 }
=20
+static struct btf_encoder_func_state *btf_encoder__alloc_func_state(struct=
 btf_encoder *encoder)
+{
+=09struct btf_encoder_func_state *tmp;
+
+=09if (encoder->func_states.cnt >=3D encoder->func_states.cap) {
+
+=09=09/* We only need to grow to accommodate duplicate
+=09=09 * function declarations across different CUs, so the
+=09=09 * rate of the array growth shouldn't be high.
+=09=09 */
+=09=09encoder->func_states.cap +=3D 64;
+
+=09=09tmp =3D realloc(encoder->func_states.array, sizeof(*tmp) * encoder->=
func_states.cap);
+=09=09if (!tmp)
+=09=09=09return NULL;
+
+=09=09encoder->func_states.array =3D tmp;
+=09}
+
+=09return &encoder->func_states.array[encoder->func_states.cnt++];
+}
+
 static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct =
function *fn, struct elf_function *func)
 {
-=09struct btf_encoder_func_state *state =3D zalloc(sizeof(*state));
+=09struct btf_encoder_func_state *state =3D btf_encoder__alloc_func_state(=
encoder);
 =09struct ftype *ftype =3D &fn->proto;
 =09struct btf *btf =3D encoder->btf;
 =09struct llvm_annotation *annot;
@@ -1142,7 +1167,6 @@ static int32_t btf_encoder__save_func(struct btf_enco=
der *encoder, struct functi
 =09=09=09idx++;
 =09=09}
 =09}
-=09list_add_tail(&state->node, &encoder->func_states);
 =09return 0;
 out:
 =09zfree(&state->annots);
@@ -1219,17 +1243,15 @@ static int functions_cmp(const void *_a, const void=
 *_b)
=20
 static int saved_functions_cmp(const void *_a, const void *_b)
 {
-=09struct btf_encoder_func_state * const *a =3D _a;
-=09struct btf_encoder_func_state * const *b =3D _b;
+=09const struct btf_encoder_func_state *a =3D _a;
+=09const struct btf_encoder_func_state *b =3D _b;
=20
-=09return functions_cmp((*a)->elf, (*b)->elf);
+=09return functions_cmp(a->elf, b->elf);
 }
=20
-static int saved_functions_combine(void *_a, void *_b)
+static int saved_functions_combine(struct btf_encoder_func_state *a, struc=
t btf_encoder_func_state *b)
 {
 =09uint8_t optimized, unexpected, inconsistent;
-=09struct btf_encoder_func_state *a =3D _a;
-=09struct btf_encoder_func_state *b =3D _b;
 =09int ret;
=20
 =09ret =3D strncmp(a->elf->name, b->elf->name,
@@ -1250,44 +1272,37 @@ static int saved_functions_combine(void *_a, void *=
_b)
=20
 static void btf_encoder__delete_saved_funcs(struct btf_encoder *encoder)
 {
-=09struct btf_encoder_func_state *pos, *s;
+=09struct btf_encoder_func_state *state;
=20
-=09list_for_each_entry_safe(pos, s, &encoder->func_states, node) {
-=09=09list_del(&pos->node);
-=09=09free(pos->parms);
-=09=09free(pos->annots);
-=09=09free(pos);
+=09for (int i =3D 0; i < encoder->func_states.cnt; i++) {
+=09=09state =3D &encoder->func_states.array[i];
+=09=09free(state->parms);
+=09=09free(state->annots);
 =09}
+
+=09free(encoder->func_states.array);
+
+=09encoder->func_states.array =3D NULL;
+=09encoder->func_states.cnt =3D 0;
+=09encoder->func_states.cap =3D 0;
 }
=20
 static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool =
skip_encoding_inconsistent_proto)
 {
-=09struct btf_encoder_func_state **saved_fns =3D NULL, *s;
-=09int err =3D 0, i =3D 0, j, nr_saved_fns =3D 0;
-
-=09/* Retrieve function states from the encoder, combine them
-=09 * and sort by name, addr.
-=09 */
-=09list_for_each_entry(s, &encoder->func_states, node) {
-=09=09nr_saved_fns++;
-=09}
+=09struct btf_encoder_func_state *saved_fns =3D encoder->func_states.array=
;
+=09int nr_saved_fns =3D encoder->func_states.cnt;
+=09int err =3D 0, i =3D 0, j;
=20
 =09if (nr_saved_fns =3D=3D 0)
 =09=09goto out;
=20
-=09saved_fns =3D calloc(nr_saved_fns, sizeof(*saved_fns));
-=09if (!saved_fns) {
-=09=09err =3D -ENOMEM;
-=09=09goto out;
-=09}
-
-=09list_for_each_entry(s, &encoder->func_states, node) {
-=09=09saved_fns[i++] =3D s;
-=09}
+=09/* Sort the saved_fns so that we can merge multiple states of
+=09 * the "same" function into one, before adding it to the BTF.
+=09 */
 =09qsort(saved_fns, nr_saved_fns, sizeof(*saved_fns), saved_functions_cmp)=
;
=20
 =09for (i =3D 0; i < nr_saved_fns; i =3D j) {
-=09=09struct btf_encoder_func_state *state =3D saved_fns[i];
+=09=09struct btf_encoder_func_state *state =3D &saved_fns[i];
 =09=09bool add_to_btf =3D !skip_encoding_inconsistent_proto;
=20
 =09=09/* Compare across sorted functions that match by name/prefix;
@@ -1295,7 +1310,7 @@ static int btf_encoder__add_saved_funcs(struct btf_en=
coder *encoder, bool skip_e
 =09=09 */
 =09=09j =3D i + 1;
=20
-=09=09while (j < nr_saved_fns && saved_functions_combine(saved_fns[i], sav=
ed_fns[j]) =3D=3D 0)
+=09=09while (j < nr_saved_fns && saved_functions_combine(&saved_fns[i], &s=
aved_fns[j]) =3D=3D 0)
 =09=09=09j++;
=20
 =09=09/* do not exclude functions with optimized-out parameters; they
@@ -1313,7 +1328,6 @@ static int btf_encoder__add_saved_funcs(struct btf_en=
coder *encoder, bool skip_e
 =09}
=20
 out:
-=09free(saved_fns);
 =09btf_encoder__delete_saved_funcs(encoder);
=20
 =09return err;
@@ -2404,7 +2418,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
 =09=09encoder->need_index_type =3D false;
 =09=09encoder->array_index_id  =3D 0;
 =09=09encoder->encode_vars =3D 0;
-=09=09INIT_LIST_HEAD(&encoder->func_states);
+
 =09=09if (!conf_load->skip_encoding_btf_vars)
 =09=09=09encoder->encode_vars |=3D BTF_VAR_PERCPU;
 =09=09if (conf_load->encode_btf_global_vars)
@@ -2417,6 +2431,11 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, =
const char *detached_filenam
=20
 =09=09encoder->symtab =3D funcs->symtab;
=20
+=09=09/* Start with funcs->cnt. The array may grow in btf_encoder__alloc_f=
unc_state() */
+=09=09encoder->func_states.array =3D zalloc(sizeof(*encoder->func_states.a=
rray) * funcs->cnt);
+=09=09encoder->func_states.cap =3D funcs->cnt;
+=09=09encoder->func_states.cnt =3D 0;
+
 =09=09GElf_Ehdr ehdr;
=20
 =09=09if (gelf_getehdr(cu->elf, &ehdr) =3D=3D NULL) {
--=20
2.47.1



