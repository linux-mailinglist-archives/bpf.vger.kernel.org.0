Return-Path: <bpf+bounces-48157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63412A049E5
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 20:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F33188808A
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 19:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658B81F4282;
	Tue,  7 Jan 2025 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="OybTIgW1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10E718FDD2;
	Tue,  7 Jan 2025 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736276952; cv=none; b=RJ9xwEuQVxtHlqxaiJWSf+X+iFjpIgPZGitdPLD0B5n2cTUkUUcQ+WPFgUj/5Cp17Phihrx4SlQH9s1mWvEd+38OaRy+6JtP4B1GEylVrplHnDV/lRjxyBr79q6NhbJDKUJDi2yXf8P784C0O/AVNEFlDruCoqkgB2ktfqoY8Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736276952; c=relaxed/simple;
	bh=dySSB0RGJEkU2f2fyoTgxCQRAftkucTKcJk4MztaF4o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ll5wSE8yR6M8wJIoMDU7pwtm+MKGqAUN0kFXp8ecJFHPz9PCyzh9l9kW9e1ziFNlHkkss3jU6BZnfK3jS3z9RXoC+b+tMi2DxEqyXEND7gifGG8rXIVpZD+xzHd2jvJpFX4XLkgJjtkEWfyqt7eJzh/v9SlxNcPW47sr8Y/d7nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=OybTIgW1; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736276947; x=1736536147;
	bh=2Q4VXTMtpMVCKGOkGDpzz8LKAjMiPCKFGdDDgMYRKKI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=OybTIgW1MSGaHUHl9xhrDQAX0RSFP8MB6PBAK0QoyFg+s0rqY6WNrbKWJH/ZZ9SRK
	 FemD5/+x3/sqOE9NDI5Z2oTojinpL1pQ4s/S8p+pjstdZDc26PJmwjgobIZ7B3qDkX
	 NUjP055MInvx8oOQxKA6VBakHWogLJXyNtJ47AhcwrPY+FfFVUawZlso1ADF2XiX0S
	 o9iiRAHvm44EYkNM9FHBI7ffOhE7pzWUVGA9f9xPeOwY9NeDO/LD5/olwRpIrQiUHh
	 nMVb+Qg3KcYcHWnpEgyDgNH+OMH8chpPwpMOesq9nGzwoZRAvcv4X9RCjG7GNCdUIO
	 L1d9VE//PYWoQ==
Date: Tue, 07 Jan 2025 19:09:03 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, olsajiri@gmail.com
Subject: [PATCH dwarves v4 01/10] btf_encoder: simplify function encoding
Message-ID: <20250107190855.2312210-2-ihor.solodrai@pm.me>
In-Reply-To: <20250107190855.2312210-1-ihor.solodrai@pm.me>
References: <20250107190855.2312210-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 01a2101a254da4c1b43707bf361aeb26425b7d9c
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Alan Maguire <alan.maguire@oracle.com>

Currently we have two modes of function encoding; one adds functions
based upon the first instance found and ignores inconsistent
representations.  The second saves function representations and later
finds inconsistencies.  The mode chosen is determined by
conf_load->skip_encoding_btf_inconsistent_proto.

The knock-on effect is that we need to support two modes in
btf_encoder__add_func(); one for each case.  Simplify by using
the "save function" approach for both cases; only difference is
that we allow inconsistent representations if
skip_encoding_btf_inconsistent_proto is not set (it is set by default
for upstream kernels and has been for a while).

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>

Link: https://lore.kernel.org/dwarves/20241128012341.4081072-2-ihor.solodra=
i@pm.me/
---
 btf_encoder.c | 79 +++++++++++++++++----------------------------------
 1 file changed, 26 insertions(+), 53 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index fbc9509..2e51afd 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -88,7 +88,6 @@ struct btf_encoder_func_state {
 struct elf_function {
 =09const char=09*name;
 =09char=09=09*alias;
-=09bool=09=09 generated;
 =09size_t=09=09prefixlen;
 =09struct btf_encoder_func_state state;
 };
@@ -120,6 +119,7 @@ struct btf_encoder {
 =09=09=09  force,
 =09=09=09  gen_floats,
 =09=09=09  skip_encoding_decl_tag,
+=09=09=09  skip_encoding_inconsistent_proto,
 =09=09=09  tag_kfuncs,
 =09=09=09  gen_distilled_base;
 =09uint32_t=09  array_index_id;
@@ -1165,18 +1165,18 @@ out:
 =09return err;
 }
=20
-static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct f=
unction *fn,
+static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
 =09=09=09=09     struct elf_function *func)
 {
+=09struct btf_encoder_func_state *state =3D &func->state;
 =09int btf_fnproto_id, btf_fn_id, tag_type_id =3D 0;
 =09int16_t component_idx =3D -1;
 =09const char *name;
 =09const char *value;
 =09char tmp_value[KSYM_NAME_LEN];
+=09uint16_t idx;
=20
-=09assert(fn !=3D NULL || func !=3D NULL);
-
-=09btf_fnproto_id =3D btf_encoder__add_func_proto(encoder, fn ? &fn->proto=
 : NULL, func);
+=09btf_fnproto_id =3D btf_encoder__add_func_proto(encoder, NULL, func);
 =09name =3D func->alias ?: func->name;
 =09if (btf_fnproto_id >=3D 0)
 =09=09btf_fn_id =3D btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_=
fnproto_id,
@@ -1186,40 +1186,23 @@ static int32_t btf_encoder__add_func(struct btf_enc=
oder *encoder, struct functio
 =09=09       name, btf_fnproto_id < 0 ? "proto" : "func");
 =09=09return -1;
 =09}
-=09if (!fn) {
-=09=09struct btf_encoder_func_state *state =3D &func->state;
-=09=09uint16_t idx;
-
-=09=09if (state->nr_annots =3D=3D 0)
-=09=09=09return 0;
+=09if (state->nr_annots =3D=3D 0)
+=09=09return 0;
=20
-=09=09for (idx =3D 0; idx < state->nr_annots; idx++) {
-=09=09=09struct btf_encoder_func_annot *a =3D &state->annots[idx];
+=09for (idx =3D 0; idx < state->nr_annots; idx++) {
+=09=09struct btf_encoder_func_annot *a =3D &state->annots[idx];
=20
-=09=09=09value =3D btf__str_by_offset(encoder->btf, a->value);
-=09=09=09/* adding BTF data may result in a mode of the
-=09=09=09 * value string memory, so make a temporary copy.
-=09=09=09 */
-=09=09=09strncpy(tmp_value, value, sizeof(tmp_value) - 1);
-=09=09=09component_idx =3D a->component_idx;
-
-=09=09=09tag_type_id =3D btf_encoder__add_decl_tag(encoder, tmp_value,
-=09=09=09=09=09=09=09=09btf_fn_id, component_idx);
-=09=09=09if (tag_type_id < 0)
-=09=09=09=09break;
-=09=09}
-=09} else {
-=09=09struct llvm_annotation *annot;
-
-=09=09list_for_each_entry(annot, &fn->annots, node) {
-=09=09=09value =3D annot->value;
-=09=09=09component_idx =3D annot->component_idx;
+=09=09value =3D btf__str_by_offset(encoder->btf, a->value);
+=09=09/* adding BTF data may result in a mode of the
+=09=09 * value string memory, so make a temporary copy.
+=09=09 */
+=09=09strncpy(tmp_value, value, sizeof(tmp_value) - 1);
+=09=09component_idx =3D a->component_idx;
=20
-=09=09=09tag_type_id =3D btf_encoder__add_decl_tag(encoder, value, btf_fn_=
id,
-=09=09=09=09=09=09=09=09component_idx);
-=09=09=09if (tag_type_id < 0)
-=09=09=09=09break;
-=09=09}
+=09=09tag_type_id =3D btf_encoder__add_decl_tag(encoder, tmp_value,
+=09=09=09=09=09=09=09btf_fn_id, component_idx);
+=09=09if (tag_type_id < 0)
+=09=09=09break;
 =09}
 =09if (tag_type_id < 0) {
 =09=09fprintf(stderr,
@@ -1277,8 +1260,9 @@ static int btf_encoder__add_saved_funcs(struct btf_en=
coder *encoder)
 =09=09 * just do not _use_ them.  Only exclude functions with
 =09=09 * unexpected register use or multiple inconsistent prototypes.
 =09=09 */
-=09=09if (!state->unexpected_reg && !state->inconsistent_proto) {
-=09=09=09if (btf_encoder__add_func(encoder, NULL, func))
+=09=09if (!encoder->skip_encoding_inconsistent_proto ||
+=09=09    (!state->unexpected_reg && !state->inconsistent_proto)) {
+=09=09=09if (btf_encoder__add_func(encoder, func))
 =09=09=09=09return -1;
 =09=09}
 =09=09state->processed =3D 1;
@@ -2359,6 +2343,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
 =09=09encoder->force=09=09 =3D conf_load->btf_encode_force;
 =09=09encoder->gen_floats=09 =3D conf_load->btf_gen_floats;
 =09=09encoder->skip_encoding_decl_tag=09 =3D conf_load->skip_encoding_btf_=
decl_tag;
+=09=09encoder->skip_encoding_inconsistent_proto =3D conf_load->skip_encodi=
ng_btf_inconsistent_proto;
 =09=09encoder->tag_kfuncs=09 =3D conf_load->btf_decl_tag_kfuncs;
 =09=09encoder->gen_distilled_base =3D conf_load->btf_gen_distilled_base;
 =09=09encoder->verbose=09 =3D verbose;
@@ -2564,7 +2549,6 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
r, struct cu *cu, struct co
=20
 =09cu__for_each_function(cu, core_id, fn) {
 =09=09struct elf_function *func =3D NULL;
-=09=09bool save =3D false;
=20
 =09=09/*
 =09=09 * Skip functions that:
@@ -2586,15 +2570,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encod=
er, struct cu *cu, struct co
=20
 =09=09=09/* prefer exact function name match... */
 =09=09=09func =3D btf_encoder__find_function(encoder, name, 0);
-=09=09=09if (func) {
-=09=09=09=09if (func->generated)
-=09=09=09=09=09continue;
-=09=09=09=09if (conf_load->skip_encoding_btf_inconsistent_proto)
-=09=09=09=09=09save =3D true;
-=09=09=09=09else
-=09=09=09=09=09func->generated =3D true;
-=09=09=09} else if (encoder->functions.suffix_cnt &&
-=09=09=09=09   conf_load->btf_gen_optimized) {
+=09=09=09if (!func && encoder->functions.suffix_cnt &&
+=09=09=09    conf_load->btf_gen_optimized) {
 =09=09=09=09/* falling back to name.isra.0 match if no exact
 =09=09=09=09 * match is found; only bother if we found any
 =09=09=09=09 * .suffix function names.  The function
@@ -2605,7 +2582,6 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
r, struct cu *cu, struct co
 =09=09=09=09func =3D btf_encoder__find_function(encoder, name,
 =09=09=09=09=09=09=09=09  strlen(name));
 =09=09=09=09if (func) {
-=09=09=09=09=09save =3D true;
 =09=09=09=09=09if (encoder->verbose)
 =09=09=09=09=09=09printf("matched function '%s' with '%s'%s\n",
 =09=09=09=09=09=09       name, func->name,
@@ -2624,10 +2600,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encod=
er, struct cu *cu, struct co
 =09=09if (!func)
 =09=09=09continue;
=20
-=09=09if (save)
-=09=09=09err =3D btf_encoder__save_func(encoder, fn, func);
-=09=09else
-=09=09=09err =3D btf_encoder__add_func(encoder, fn, func);
+=09=09err =3D btf_encoder__save_func(encoder, fn, func);
 =09=09if (err)
 =09=09=09goto out;
 =09}
--=20
2.47.1



