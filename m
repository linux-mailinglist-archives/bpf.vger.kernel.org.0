Return-Path: <bpf+bounces-45782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12899DB0B0
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1062281E1E
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 01:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDDB219FC;
	Thu, 28 Nov 2024 01:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="jYgpzI4h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6B21DFCB
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 01:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757052; cv=none; b=FJ8ge0A3cocW1dAc3JsDTs3VxS4iBT3UoDX8a/Sf9gkMbh+Xex2WlIlSIcr3aizc02PUi10129gKX53BBYNb1kJchsdZ/S43zq8o7Y6nNadTExy5UY5mcNS+mqW8GECQuyL9ASLBcfXonEfE/jBhxIbu5ojcdi7jTgxfxo+mMFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757052; c=relaxed/simple;
	bh=VyUoytH5yipFSmUpqy83K06XS9vJ1JN0+I7sEXvVzmQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o74AopmZ0HndXZ/Q+iKR2Agd3Ns0Wsj4YuEmk4NHgxE8u/LvSMSa3Qmkkgr0U/rz4F85/3iGzuNzb8QbAdGWgYadglUNy4QRtXDYAShZwOcosshpa08oJ5OQVqrvP+cocGvYDTiJtw5fBSZBSw/3co3wQH7er+DVFnB3VUuq/5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=jYgpzI4h; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732757042; x=1733016242;
	bh=7PHLPcTP4m+jx53byFzteomqcYUMdoh6jm3404BupMc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=jYgpzI4hwpP14+hCZ4cYQ+UisQsml89NPx8eCKOFF1dI/aNY9Ledn7v1FdkekzVil
	 OWQ8aUcIYyqiZQM/iWeEnu2vuF9Y/6vrJz+zWMszq86lQksWP80aWi46Ne1AJ3KzMx
	 7bmIwHp40x1XxzK8B7JbnwdVJ+4hU9l5mbJYuTP0ASsn0VsHgcY1ke7M7jmnyKSydV
	 n+VnYncvPjXevBUw/ySvlvPREoAYez3sfkkNJQtgGekbM99PpuUfksuSQ6imcbePN6
	 +AAIByjrkSiWQ6VeYLsAkvkdT/erQdWT1GIWARR2JF7hrTX5y5cZyVgPlBkSBQaxQl
	 XkmvDFdnZj+fQ==
Date: Thu, 28 Nov 2024 01:23:57 +0000
To: dwarves@vger.kernel.org, acme@kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com
Subject: [RFC PATCH 3/9] btf_encoder: separate elf function, saved function representations
Message-ID: <20241128012341.4081072-4-ihor.solodrai@pm.me>
In-Reply-To: <20241128012341.4081072-1-ihor.solodrai@pm.me>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 65edc4c32db36b81e970ffbeba9582009362f06f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Alan Maguire <alan.maguire@oracle.com>

Have saved function representation point back at immutable ELF function
table.  This will make sharing the ELF function table across encoders
easier.  Simply accumulate saved functions for each encoder, and on
completion combine them into a name-sorted list.  Then carry out
comparisons to check for inconsistent representations, skipping functions
that are inconsistent in their representation.

Thre is a small growth in maximum resident set size due to saving
more functions; it grows from

=09Maximum resident set size (kbytes): 701888

to:

=09Maximum resident set size (kbytes): 704168

...with this patch for -j1.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 297 +++++++++++++++++++++++++++-----------------------
 1 file changed, 161 insertions(+), 136 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 01d7094..6114cc8 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -72,14 +72,15 @@ struct btf_encoder_func_annot {
=20
 /* state used to do later encoding of saved functions */
 struct btf_encoder_func_state {
+=09struct list_head node;
+=09struct btf_encoder *encoder;
+=09struct elf_function *elf;
 =09uint32_t type_id_off;
 =09uint16_t nr_parms;
 =09uint16_t nr_annots;
-=09uint8_t initialized:1;
 =09uint8_t optimized_parms:1;
 =09uint8_t unexpected_reg:1;
 =09uint8_t inconsistent_proto:1;
-=09uint8_t processed:1;
 =09int ret_type_id;
 =09struct btf_encoder_func_parm *parms;
 =09struct btf_encoder_func_annot *annots;
@@ -90,7 +91,6 @@ struct elf_function {
 =09char=09=09*alias;
 =09uint32_t=09addr;
 =09size_t=09=09prefixlen;
-=09struct btf_encoder_func_state state;
 };
=20
 struct elf_secinfo {
@@ -127,6 +127,7 @@ struct btf_encoder {
 =09struct elf_secinfo *secinfo;
 =09size_t             seccnt;
 =09int                encode_vars;
+=09struct list_head   func_states;
 =09struct {
 =09=09struct elf_function *entries;
 =09=09int=09=09    allocated;
@@ -695,25 +696,26 @@ static int32_t btf_encoder__tag_type(struct btf_encod=
er *encoder, uint32_t tag_t
 }
=20
 static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, st=
ruct ftype *ftype,
-=09=09=09=09=09   struct elf_function *func)
+=09=09=09=09=09   struct btf_encoder_func_state *state)
 {
-=09struct btf *btf =3D encoder->btf;
 =09const struct btf_type *t;
+=09struct btf *btf;
 =09struct parameter *param;
 =09uint16_t nr_params, param_idx;
 =09int32_t id, type_id;
 =09char tmp_name[KSYM_NAME_LEN];
 =09const char *name;
-=09struct btf_encoder_func_state *state;
=20
-=09assert(ftype !=3D NULL || func !=3D NULL);
+=09assert(ftype !=3D NULL || state !=3D NULL);
=20
 =09/* add btf_type for func_proto */
 =09if (ftype) {
+=09=09btf =3D encoder->btf;
 =09=09nr_params =3D ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
 =09=09type_id =3D btf_encoder__tag_type(encoder, ftype->tag.type);
-=09} else if (func) {
-=09=09state =3D &func->state;
+=09} else if (state) {
+=09=09encoder =3D state->encoder;
+=09=09btf =3D state->encoder->btf;
 =09=09nr_params =3D state->nr_parms;
 =09=09type_id =3D state->ret_type_id;
 =09} else {
@@ -1033,10 +1035,13 @@ static bool types__match(struct btf_encoder *encode=
r,
 =09return false;
 }
=20
-static bool funcs__match(struct btf_encoder *encoder, struct elf_function =
*func,
-=09=09=09 struct btf *btf1, struct btf_encoder_func_state *s1,
-=09=09=09 struct btf *btf2, struct btf_encoder_func_state *s2)
+static bool funcs__match(struct btf_encoder_func_state *s1,
+=09=09=09 struct btf_encoder_func_state *s2)
 {
+=09struct btf_encoder *encoder =3D s1->encoder;
+=09struct elf_function *func =3D s1->elf;
+=09struct btf *btf1 =3D s1->encoder->btf;
+=09struct btf *btf2 =3D s2->encoder->btf;
 =09uint8_t i;
=20
 =09if (s1->nr_parms !=3D s2->nr_parms) {
@@ -1074,8 +1079,7 @@ static bool funcs__match(struct btf_encoder *encoder,=
 struct elf_function *func,
=20
 static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct =
function *fn, struct elf_function *func)
 {
-=09struct btf_encoder_func_state *existing =3D &func->state;
-=09struct btf_encoder_func_state state =3D { 0 };
+=09struct btf_encoder_func_state *state =3D zalloc(sizeof(*state));
 =09struct ftype *ftype =3D &fn->proto;
 =09struct btf *btf =3D encoder->btf;
 =09struct llvm_annotation *annot;
@@ -1083,22 +1087,23 @@ static int32_t btf_encoder__save_func(struct btf_en=
coder *encoder, struct functi
 =09uint8_t param_idx =3D 0;
 =09int str_off, err =3D 0;
=20
-=09/* if already skipping this function, no need to proceed. */
-=09if (existing->unexpected_reg || existing->inconsistent_proto)
-=09=09return 0;
+=09if (!state)
+=09=09return -ENOMEM;
=20
-=09state.nr_parms =3D ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
-=09state.ret_type_id =3D ftype->tag.type =3D=3D 0 ? 0 : encoder->type_id_o=
ff + ftype->tag.type;
-=09if (state.nr_parms > 0) {
-=09=09state.parms =3D zalloc(state.nr_parms * sizeof(*state.parms));
-=09=09if (!state.parms) {
+=09state->encoder =3D encoder;
+=09state->elf =3D func;
+=09state->nr_parms =3D ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
+=09state->ret_type_id =3D ftype->tag.type =3D=3D 0 ? 0 : encoder->type_id_=
off + ftype->tag.type;
+=09if (state->nr_parms > 0) {
+=09=09state->parms =3D zalloc(state->nr_parms * sizeof(*state->parms));
+=09=09if (!state->parms) {
 =09=09=09err =3D -ENOMEM;
 =09=09=09goto out;
 =09=09}
 =09}
-=09state.inconsistent_proto =3D ftype->inconsistent_proto;
-=09state.unexpected_reg =3D ftype->unexpected_reg;
-=09state.optimized_parms =3D ftype->optimized_parms;
+=09state->inconsistent_proto =3D ftype->inconsistent_proto;
+=09state->unexpected_reg =3D ftype->unexpected_reg;
+=09state->optimized_parms =3D ftype->optimized_parms;
 =09ftype__for_each_parameter(ftype, param) {
 =09=09const char *name =3D parameter__name(param) ?: "";
=20
@@ -1107,21 +1112,21 @@ static int32_t btf_encoder__save_func(struct btf_en=
coder *encoder, struct functi
 =09=09=09err =3D str_off;
 =09=09=09goto out;
 =09=09}
-=09=09state.parms[param_idx].name_off =3D str_off;
-=09=09state.parms[param_idx].type_id =3D param->tag.type =3D=3D 0 ? 0 :
-=09=09=09=09=09=09encoder->type_id_off + param->tag.type;
+=09=09state->parms[param_idx].name_off =3D str_off;
+=09=09state->parms[param_idx].type_id =3D param->tag.type =3D=3D 0 ? 0 :
+=09=09=09=09=09=09  encoder->type_id_off + param->tag.type;
 =09=09param_idx++;
 =09}
 =09if (ftype->unspec_parms)
-=09=09state.parms[param_idx].type_id =3D 0;
+=09=09state->parms[param_idx].type_id =3D 0;
=20
 =09list_for_each_entry(annot, &fn->annots, node)
-=09=09state.nr_annots++;
-=09if (state.nr_annots) {
+=09=09state->nr_annots++;
+=09if (state->nr_annots) {
 =09=09uint8_t idx =3D 0;
=20
-=09=09state.annots =3D zalloc(state.nr_annots * sizeof(*state.annots));
-=09=09if (!state.annots) {
+=09=09state->annots =3D zalloc(state->nr_annots * sizeof(*state->annots));
+=09=09if (!state->annots) {
 =09=09=09err =3D -ENOMEM;
 =09=09=09goto out;
 =09=09}
@@ -1131,46 +1136,24 @@ static int32_t btf_encoder__save_func(struct btf_en=
coder *encoder, struct functi
 =09=09=09=09err =3D str_off;
 =09=09=09=09goto out;
 =09=09=09}
-=09=09=09state.annots[idx].value =3D str_off;
-=09=09=09state.annots[idx].component_idx =3D annot->component_idx;
+=09=09=09state->annots[idx].value =3D str_off;
+=09=09=09state->annots[idx].component_idx =3D annot->component_idx;
 =09=09=09idx++;
 =09=09}
 =09}
-=09state.initialized =3D 1;
-
-=09if (state.unexpected_reg)
-=09=09btf_encoder__log_func_skip(encoder, func,
-=09=09=09=09=09   "unexpected register used for parameter\n");
-=09if (!existing->initialized) {
-=09=09memcpy(existing, &state, sizeof(*existing));
-=09=09return 0;
-=09}
-
-=09/* If saving and we find an existing entry, we want to merge
-=09 * observations across both functions, checking that the
-=09 * "seen optimized parameters", "inconsistent prototype"
-=09 * and "unexpected register" status is reflected in the
-=09 * func entry.
-=09 * If the entry is new, record encoder state required
-=09 * to add the local function later (encoder + type_id_off)
-=09 * such that we can add the function later.
-=09 */
-=09existing->optimized_parms |=3D state.optimized_parms;
-=09existing->unexpected_reg |=3D state.unexpected_reg;
-=09if (!existing->unexpected_reg &&
-=09    !funcs__match(encoder, func, encoder->btf, &state,
-=09=09=09   encoder->btf, existing))
-=09=09existing->inconsistent_proto =3D 1;
+=09list_add_tail(&state->node, &encoder->func_states);
+=09return 0;
 out:
-=09zfree(&state.annots);
-=09zfree(&state.parms);
+=09zfree(&state->annots);
+=09zfree(&state->parms);
+=09free(state);
 =09return err;
 }
=20
 static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
-=09=09=09=09     struct elf_function *func)
+=09=09=09=09     struct btf_encoder_func_state *state)
 {
-=09struct btf_encoder_func_state *state =3D &func->state;
+=09struct elf_function *func =3D state->elf;
 =09int btf_fnproto_id, btf_fn_id, tag_type_id =3D 0;
 =09int16_t component_idx =3D -1;
 =09const char *name;
@@ -1178,7 +1161,7 @@ static int32_t btf_encoder__add_func(struct btf_encod=
er *encoder,
 =09char tmp_value[KSYM_NAME_LEN];
 =09uint16_t idx;
=20
-=09btf_fnproto_id =3D btf_encoder__add_func_proto(encoder, NULL, func);
+=09btf_fnproto_id =3D btf_encoder__add_func_proto(encoder, NULL, state);
 =09name =3D func->alias ?: func->name;
 =09if (btf_fnproto_id >=3D 0)
 =09=09btf_fn_id =3D btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_=
fnproto_id,
@@ -1216,62 +1199,6 @@ static int32_t btf_encoder__add_func(struct btf_enco=
der *encoder,
 =09return 0;
 }
=20
-static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
-{
-=09int i;
-
-=09for (i =3D 0; i < encoder->functions.cnt; i++) {
-=09=09struct elf_function *func =3D &encoder->functions.entries[i];
-=09=09struct btf_encoder_func_state *state =3D &func->state;
-=09=09struct btf_encoder *other_encoder =3D NULL;
-
-=09=09if (!state->initialized || state->processed)
-=09=09=09continue;
-=09=09/* merge optimized-out status across encoders; since each
-=09=09 * encoder has the same elf symbol table we can use the
-=09=09 * same index to access the same elf symbol.
-=09=09 */
-=09=09btf_encoders__for_each_encoder(other_encoder) {
-=09=09=09struct elf_function *other_func;
-=09=09=09struct btf_encoder_func_state *other_state;
-=09=09=09uint8_t optimized, unexpected, inconsistent;
-
-=09=09=09if (other_encoder =3D=3D encoder)
-=09=09=09=09continue;
-
-=09=09=09other_func =3D &other_encoder->functions.entries[i];
-=09=09=09other_state =3D &other_func->state;
-=09=09=09if (!other_state->initialized)
-=09=09=09=09continue;
-=09=09=09optimized =3D state->optimized_parms | other_state->optimized_par=
ms;
-=09=09=09unexpected =3D state->unexpected_reg | other_state->unexpected_re=
g;
-=09=09=09inconsistent =3D state->inconsistent_proto | other_state->inconsi=
stent_proto;
-=09=09=09if (!unexpected && !inconsistent &&
-=09=09=09    !funcs__match(encoder, func,
-=09=09=09=09=09  encoder->btf, state,
-=09=09=09=09=09  other_encoder->btf, other_state))
-=09=09=09=09inconsistent =3D 1;
-=09=09=09state->optimized_parms =3D other_state->optimized_parms =3D optim=
ized;
-=09=09=09state->unexpected_reg =3D other_state->unexpected_reg =3D unexpec=
ted;
-=09=09=09state->inconsistent_proto =3D other_state->inconsistent_proto =3D=
 inconsistent;
-
-=09=09=09other_state->processed =3D 1;
-=09=09}
-=09=09/* do not exclude functions with optimized-out parameters; they
-=09=09 * may still be _called_ with the right parameter values, they
-=09=09 * just do not _use_ them.  Only exclude functions with
-=09=09 * unexpected register use or multiple inconsistent prototypes.
-=09=09 */
-=09=09if (!encoder->skip_encoding_inconsistent_proto ||
-=09=09    (!state->unexpected_reg && !state->inconsistent_proto)) {
-=09=09=09if (btf_encoder__add_func(encoder, func))
-=09=09=09=09return -1;
-=09=09}
-=09=09state->processed =3D 1;
-=09}
-=09return 0;
-}
-
 static int functions_cmp(const void *_a, const void *_b)
 {
 =09const struct elf_function *a =3D _a;
@@ -1282,16 +1209,16 @@ static int functions_cmp(const void *_a, const void=
 *_b)
 =09 * prefix len and prefix matches.
 =09 */
 =09if (a->prefixlen && a->prefixlen =3D=3D b->prefixlen)
-=09=09ret =3D strncmp(a->name, b->name, b->prefixlen);
+=09=09ret =3D strncmp(a->name, b->name, a->prefixlen);
 =09else
 =09=09ret =3D strcmp(a->name, b->name);
 =09if (ret !=3D 0)
 =09=09return ret;
 =09/* avoid address mismatch */
-        if (a->addr !=3D 0 && b->addr !=3D 0) {
-                if (a->addr !=3D b->addr)
-                        return a->addr > b->addr ? 1 : -1;
-        }
+=09if (a->addr !=3D 0 && b->addr !=3D 0) {
+=09=09if (a->addr !=3D b->addr)
+=09=09=09return a->addr > b->addr ? 1 : -1;
+=09}
 =09return 0;
 }
=20
@@ -1309,6 +1236,109 @@ static void *reallocarray_grow(void *ptr, int *nmem=
b, size_t size)
 =09return new;
 }
=20
+static int saved_functions_cmp(const void *_a, const void *_b)
+{
+=09struct btf_encoder_func_state * const *a =3D _a;
+=09struct btf_encoder_func_state * const *b =3D _b;
+
+=09return functions_cmp((*a)->elf, (*b)->elf);
+}
+
+static int saved_functions_combine(void *_a, void *_b)
+{
+=09uint8_t optimized, unexpected, inconsistent;
+=09struct btf_encoder_func_state *a =3D _a;
+=09struct btf_encoder_func_state *b =3D _b;
+=09int ret;
+
+=09ret =3D strncmp(a->elf->name, b->elf->name,
+=09=09      max(a->elf->prefixlen, b->elf->prefixlen));
+=09if (ret !=3D 0)
+=09=09return ret;
+=09optimized =3D a->optimized_parms | b->optimized_parms;
+=09unexpected =3D a->unexpected_reg | b->unexpected_reg;
+=09inconsistent =3D a->inconsistent_proto | b->inconsistent_proto;
+=09if (!unexpected && !inconsistent && !funcs__match(a, b))
+=09=09inconsistent =3D 1;
+=09a->optimized_parms =3D b->optimized_parms =3D optimized;
+=09a->unexpected_reg =3D b->unexpected_reg =3D unexpected;
+=09a->inconsistent_proto =3D b->inconsistent_proto =3D inconsistent;
+
+=09return 0;
+}
+
+static void btf_encoder__delete_saved_funcs(struct btf_encoder *encoder)
+{
+=09struct btf_encoder_func_state *pos, *s;
+
+=09list_for_each_entry_safe(pos, s, &encoder->func_states, node) {
+=09=09list_del(&pos->node);
+=09=09free(pos->parms);
+=09=09free(pos->annots);
+=09=09free(pos);
+=09}
+}
+
+static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
+{
+=09struct btf_encoder_func_state **saved_fns, *s;
+=09struct btf_encoder *e =3D NULL;
+=09int i =3D 0, j, nr_saved_fns =3D 0;
+
+=09/* Retrieve function states from each encoder, combine them
+=09 * and sort by name, addr.
+=09 */
+=09btf_encoders__for_each_encoder(e) {
+=09=09list_for_each_entry(s, &e->func_states, node)
+=09=09=09nr_saved_fns++;
+=09}
+=09/* Another thread already did this work */
+=09if (nr_saved_fns =3D=3D 0) {
+=09=09printf("nothing to do for encoder...\n");
+=09=09return 0;
+=09}
+
+=09printf("got %d saved functions...\n", nr_saved_fns);
+=09saved_fns =3D calloc(nr_saved_fns, sizeof(*saved_fns));
+=09btf_encoders__for_each_encoder(e) {
+=09=09list_for_each_entry(s, &e->func_states, node)
+=09=09=09saved_fns[i++] =3D s;
+=09}
+=09printf("added %d saved fns\n", i);
+=09qsort(saved_fns, nr_saved_fns, sizeof(*saved_fns), saved_functions_cmp)=
;
+
+=09for (i =3D 0; i < nr_saved_fns; i =3D j) {
+=09=09struct btf_encoder_func_state *state =3D saved_fns[i];
+
+=09=09/* Compare across sorted functions that match by name/prefix;
+=09=09 * share inconsistent/unexpected reg state between them.
+=09=09 */
+=09=09j =3D i + 1;
+
+=09=09while (j < nr_saved_fns &&
+=09=09       saved_functions_combine(saved_fns[i], saved_fns[j]) =3D=3D 0)
+=09=09=09=09j++;
+
+=09=09/* do not exclude functions with optimized-out parameters; they
+=09=09 * may still be _called_ with the right parameter values, they
+=09=09 * just do not _use_ them.  Only exclude functions with
+=09=09 * unexpected register use or multiple inconsistent prototypes.
+=09=09 */
+=09=09if (!encoder->skip_encoding_inconsistent_proto ||
+=09=09    (!state->unexpected_reg && !state->inconsistent_proto)) {
+=09=09=09if (btf_encoder__add_func(state->encoder, state)) {
+=09=09=09=09free(saved_fns);
+=09=09=09=09return -1;
+=09=09=09}
+=09=09}
+=09}
+=09/* Now that we are done with function states, free them. */
+=09free(saved_fns);
+=09btf_encoders__for_each_encoder(e)
+=09=09btf_encoder__delete_saved_funcs(e);
+=09return 0;
+}
+
 static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf=
_Sym *sym)
 {
 =09struct elf_function *new;
@@ -1346,6 +1376,8 @@ static int btf_encoder__collect_function(struct btf_e=
ncoder *encoder, GElf_Sym *
=20
 =09=09encoder->functions.suffix_cnt++;
 =09=09encoder->functions.entries[encoder->functions.cnt].prefixlen =3D suf=
fix - name;
+=09} else {
+=09=09encoder->functions.entries[encoder->functions.cnt].prefixlen =3D str=
len(name);
 =09}
 =09encoder->functions.cnt++;
 =09return 0;
@@ -2353,6 +2385,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
 =09=09encoder->need_index_type =3D false;
 =09=09encoder->array_index_id  =3D 0;
 =09=09encoder->encode_vars =3D 0;
+=09=09INIT_LIST_HEAD(&encoder->func_states);
 =09=09if (!conf_load->skip_encoding_btf_vars)
 =09=09=09encoder->encode_vars |=3D BTF_VAR_PERCPU;
 =09=09if (conf_load->encode_btf_global_vars)
@@ -2437,16 +2470,8 @@ out_delete:
 =09return NULL;
 }
=20
-void btf_encoder__delete_func(struct elf_function *func)
-{
-=09free(func->alias);
-=09zfree(&func->state.annots);
-=09zfree(&func->state.parms);
-}
-
 void btf_encoder__delete(struct btf_encoder *encoder)
 {
-=09int i;
 =09size_t shndx;
=20
 =09if (encoder =3D=3D NULL)
@@ -2461,12 +2486,12 @@ void btf_encoder__delete(struct btf_encoder *encode=
r)
 =09encoder->btf =3D NULL;
 =09elf_symtab__delete(encoder->symtab);
=20
-=09for (i =3D 0; i < encoder->functions.cnt; i++)
-=09=09btf_encoder__delete_func(&encoder->functions.entries[i]);
 =09encoder->functions.allocated =3D encoder->functions.cnt =3D 0;
 =09free(encoder->functions.entries);
 =09encoder->functions.entries =3D NULL;
=20
+=09btf_encoder__delete_saved_funcs(encoder);
+
 =09free(encoder);
 }
=20
--=20
2.47.0



