Return-Path: <bpf+bounces-46924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A989F192F
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561A31887495
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9931990C3;
	Fri, 13 Dec 2024 22:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="KSWntW2N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4DF192B9D
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734129423; cv=none; b=oIXI7eGAq14K/18kboccJJzickmZcfuF2NdQfpzvU/9u3oZeRwA5Z4xgubOKYHkt0Tteywn+DaBQUPnnBaNuvjlG+A5Eo8m+JO65gdk63zvVjA4cUgijw2gazx47uPwnIaAcfHurj/LnDyGFAXCTJIQ1JFGJbemqjFcerGmPXxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734129423; c=relaxed/simple;
	bh=xjiZ61jxCvyEVjXUgG6z5wwW5Cyzaj6CmMNzQhF6BeI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/0j5s7X7657+ydjhpfyt2GvoDW2oKSpmkZE7u/cgNPIoXyuS9nYMPpo+wTugrvjL6/WRafQqUx4Yhgla1DrJaZ+H9bQd+i5tIixFDRK0FT1zZa2JW+tXTylbHocn0hTC/KjI9bfl8tw4OvvWP1FPceHm3UDNlJH9FXyNIk21Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=KSWntW2N; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734129418; x=1734388618;
	bh=7wqV4u68RwfyySJAp5ucIWEhsf/H1oavVfvbDIZTUDM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=KSWntW2NPp3RPxr/3uP+nygDZoPAs+EJdXy15DZJPTCpYeJSz1XWDETnwJYdar0OF
	 Y197+F+6kZEZVuSFzhAQlyQPJ5bWnI2XCNN+Ns+d5BkcR1foX/1b5eRl6x9J1AaUSG
	 fOLofLHX6aN89LmafGU2eJYHJghEM3QAoCZxFh+4G4IVHgwHQ3aoC4gaFFiApvLn+M
	 OLG0PqxHUlFpSotHLMjksmTLlLwB6elgaYqFc5i2cQel/fkmZdNaDKa4EN3Kk5P6ud
	 FeQa7frdbhuhkTT4IEm5KWT6J23Yga2UR0ZFUt6Xax8Wy+VULh3w16Wat2ofFoSdvh
	 W/5rlrwDwqLhA==
Date: Fri, 13 Dec 2024 22:36:53 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: [PATCH dwarves v2 02/10] btf_encoder: separate elf function, saved function representations
Message-ID: <20241213223641.564002-3-ihor.solodrai@pm.me>
In-Reply-To: <20241213223641.564002-1-ihor.solodrai@pm.me>
References: <20241213223641.564002-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 23944ca638ed89928e0ef8a042facd83043f41b1
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

/usr/bin/time samples with this change:
  jobs 1, mem 837844 Kb, time 6.40 sec
  jobs 2, mem 936204 Kb, time 3.88 sec
  jobs 4, mem 1023120 Kb, time 2.75 sec
  jobs 8, mem 1163824 Kb, time 2.31 sec
  jobs 16, mem 1190588 Kb, time 2.08 sec
  jobs 32, mem 1341180 Kb, time 2.36 sec

/usr/bin/time samples on next (3ddadc1):
  jobs 1, mem 834100 Kb, time 6.20 sec
  jobs 2, mem 925048 Kb, time 3.81 sec
  jobs 4, mem 1025424 Kb, time 2.88 sec
  jobs 8, mem 1178480 Kb, time 2.21 sec
  jobs 16, mem 1241780 Kb, time 2.07 sec
  jobs 32, mem 1442316 Kb, time 2.33 sec

Link: https://lore.kernel.org/dwarves/20241128012341.4081072-4-ihor.solodra=
i@pm.me/

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Co-developed-by: Ihor Solodrai <ihor.solodrai@pm.me>
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 293 +++++++++++++++++++++++++++-----------------------
 btf_encoder.h |   1 +
 pahole.c      |   2 +
 3 files changed, 160 insertions(+), 136 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index b9a98f5..523901c 100644
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
@@ -89,7 +90,6 @@ struct elf_function {
 =09const char=09*name;
 =09char=09=09*alias;
 =09size_t=09=09prefixlen;
-=09struct btf_encoder_func_state state;
 };
=20
 struct elf_secinfo {
@@ -126,6 +126,7 @@ struct btf_encoder {
 =09struct elf_secinfo *secinfo;
 =09size_t             seccnt;
 =09int                encode_vars;
+=09struct list_head   func_states;
 =09struct {
 =09=09struct elf_function *entries;
 =09=09int=09=09    allocated;
@@ -148,8 +149,6 @@ struct btf_kfunc_set_range {
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
@@ -693,25 +692,26 @@ static int32_t btf_encoder__tag_type(struct btf_encod=
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
@@ -801,8 +801,6 @@ int32_t btf_encoder__add_encoder(struct btf_encoder *en=
coder, struct btf_encoder
 =09if (encoder =3D=3D other)
 =09=09return 0;
=20
-=09btf_encoder__add_saved_funcs(other);
-
 =09for (shndx =3D 1; shndx < other->seccnt; shndx++) {
 =09=09struct gobuffer *var_secinfo_buf =3D &other->secinfo[shndx].secinfo;
 =09=09size_t sz =3D gobuffer__size(var_secinfo_buf);
@@ -1031,10 +1029,13 @@ static bool types__match(struct btf_encoder *encode=
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
@@ -1072,8 +1073,7 @@ static bool funcs__match(struct btf_encoder *encoder,=
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
@@ -1081,22 +1081,23 @@ static int32_t btf_encoder__save_func(struct btf_en=
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
@@ -1105,21 +1106,21 @@ static int32_t btf_encoder__save_func(struct btf_en=
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
@@ -1129,46 +1130,24 @@ static int32_t btf_encoder__save_func(struct btf_en=
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
@@ -1176,7 +1155,7 @@ static int32_t btf_encoder__add_func(struct btf_encod=
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
@@ -1214,62 +1193,6 @@ static int32_t btf_encoder__add_func(struct btf_enco=
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
@@ -1297,6 +1220,107 @@ static void *reallocarray_grow(void *ptr, int *nmem=
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
+
+=09for (int i =3D 0; i < encoder->functions.cnt; i++)
+=09=09free(encoder->functions.entries[i].alias);
+}
+
+int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
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
+
+=09if (nr_saved_fns =3D=3D 0)
+=09=09return 0;
+
+=09saved_fns =3D calloc(nr_saved_fns, sizeof(*saved_fns));
+=09btf_encoders__for_each_encoder(e) {
+=09=09list_for_each_entry(s, &e->func_states, node)
+=09=09=09saved_fns[i++] =3D s;
+=09}
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
+=09=09while (j < nr_saved_fns && saved_functions_combine(saved_fns[i], sav=
ed_fns[j]) =3D=3D 0)
+=09=09=09j++;
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
@@ -1330,6 +1354,8 @@ static int btf_encoder__collect_function(struct btf_e=
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
@@ -2353,6 +2379,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
 =09=09encoder->need_index_type =3D false;
 =09=09encoder->array_index_id  =3D 0;
 =09=09encoder->encode_vars =3D 0;
+=09=09INIT_LIST_HEAD(&encoder->func_states);
 =09=09if (!conf_load->skip_encoding_btf_vars)
 =09=09=09encoder->encode_vars |=3D BTF_VAR_PERCPU;
 =09=09if (conf_load->encode_btf_global_vars)
@@ -2437,16 +2464,8 @@ out_delete:
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
@@ -2455,18 +2474,19 @@ void btf_encoder__delete(struct btf_encoder *encode=
r)
 =09btf_encoders__delete(encoder);
 =09for (shndx =3D 0; shndx < encoder->seccnt; shndx++)
 =09=09__gobuffer__delete(&encoder->secinfo[shndx].secinfo);
+=09free(encoder->secinfo);
 =09zfree(&encoder->filename);
 =09zfree(&encoder->source_filename);
 =09btf__free(encoder->btf);
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
@@ -2591,7 +2611,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
r, struct cu *cu, struct co
 =09=09=09=09=09=09       ", has optimized-out parameters" :
 =09=09=09=09=09=09       fn->proto.unexpected_reg ? ", has unexpected regi=
ster use by params" :
 =09=09=09=09=09=09       "");
-=09=09=09=09=09func->alias =3D strdup(name);
+=09=09=09=09=09if (!func->alias)
+=09=09=09=09=09=09func->alias =3D strdup(name);
 =09=09=09=09}
 =09=09=09}
 =09=09} else {
diff --git a/btf_encoder.h b/btf_encoder.h
index 824963b..9b26162 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -33,5 +33,6 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, s=
truct cu *cu, struct co
 struct btf *btf_encoder__btf(struct btf_encoder *encoder);
=20
 int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encod=
er *other);
+int btf_encoder__add_saved_funcs(struct btf_encoder *encoder);
=20
 #endif /* _BTF_ENCODER_H_ */
diff --git a/pahole.c b/pahole.c
index fa5d8c7..a36b732 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3185,6 +3185,7 @@ static int pahole_threads_collect(struct conf_load *c=
onf, int nr_threads, void *
 =09if (error)
 =09=09goto out;
=20
+=09btf_encoder__add_saved_funcs(btf_encoder);
 =09for (i =3D 0; i < nr_threads; i++) {
 =09=09/*
 =09=09 * Merge content of the btf instances of worker threads to the btf
@@ -3843,6 +3844,7 @@ try_sole_arg_as_class_names:
 =09=09}
=20
 =09=09err =3D btf_encoder__encode(btf_encoder);
+=09=09btf_encoder__delete(btf_encoder);
 =09=09if (err) {
 =09=09=09fputs("Failed to encode BTF\n", stderr);
 =09=09=09goto out_cus_delete;
--=20
2.47.1



