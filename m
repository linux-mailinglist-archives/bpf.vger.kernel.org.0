Return-Path: <bpf+bounces-47494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9C59F9DB2
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 02:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C0D27A25A4
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 01:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83742558BB;
	Sat, 21 Dec 2024 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ZMgZ9Ki0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135C2558BA
	for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 01:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734744183; cv=none; b=mtPBMVsEouHDj+Swywa/kHrqo/SSnoho/yXpXJZVojcValxN/Ma09BAwLEZmc54BFimcn4uvuc5aXCEUJVeRgHFjLyX9r60jxE3yuAoPrc/ILVYCfHTaiD7MP+2npG8goRj+9TiJPaQamiikqHlnPLYnnfSSzVfVk471nMhsUk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734744183; c=relaxed/simple;
	bh=I3oPgmN4K9uxpqEkRMbd+WpJT0xZL+GZFruStITHhkw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHjuwvSpiltnT59QbEfmhxARqjeHQSgtqdZqjf6/Nrv9JLIWQObktb4HWDCcMafcFCsbfNN7ytvwUkUsyzOscSq2WpkPtGtnh8RRPQzgdpbNQp97RL+AJds4snH/WeoTqS6PV2dpz0+WgsVH6j7xwOoyR6gwdraSZyFkRVJ6k+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ZMgZ9Ki0; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734744178; x=1735003378;
	bh=p44UIYEBYYbuvBXm30vj9U/QJpb+uK/8cHiO8HWX4fs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ZMgZ9Ki04d1uZ3RTeG0tCsNj1uaCd0I2DPW8vg4UALUH7pQBbZU01vRs7rdM1W+nv
	 8m22rJ1MKpzpibQ9bKse93PhterWl1WAmcMudJuAJrT2wfcb5KZY2PBPaFKNioF0ES
	 oAN0ZColU9CmQwv05nfOpJHKuBBMTCxuKu36xxeJgHyIGWbeo+mhr4V1ceNjnAbl3X
	 ul9DAbxXwKpH5Qz9DOIEnHHykHl+KDfhAk/2d5YdDESLB8L+CFzscyreb1qE/do6Hj
	 lW20EhAlHFnCeUP33AsoH453COu/5sacQAcqkBQq+YLq+WGlyJ/gC1644P72dtU+4M
	 ozGlGpjXDt+Lw==
Date: Sat, 21 Dec 2024 01:22:54 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: [PATCH dwarves v3 1/8] btf_encoder: simplify function encoding
Message-ID: <20241221012245.243845-2-ihor.solodrai@pm.me>
In-Reply-To: <20241221012245.243845-1-ihor.solodrai@pm.me>
References: <20241221012245.243845-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 123b4ccd171f934311f1e9aabc31d5e737be48fa
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
index 3754884..0835848 100644
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
@@ -2353,6 +2337,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
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
@@ -2558,7 +2543,6 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
r, struct cu *cu, struct co
=20
 =09cu__for_each_function(cu, core_id, fn) {
 =09=09struct elf_function *func =3D NULL;
-=09=09bool save =3D false;
=20
 =09=09/*
 =09=09 * Skip functions that:
@@ -2580,15 +2564,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encod=
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
@@ -2599,7 +2576,6 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
r, struct cu *cu, struct co
 =09=09=09=09func =3D btf_encoder__find_function(encoder, name,
 =09=09=09=09=09=09=09=09  strlen(name));
 =09=09=09=09if (func) {
-=09=09=09=09=09save =3D true;
 =09=09=09=09=09if (encoder->verbose)
 =09=09=09=09=09=09printf("matched function '%s' with '%s'%s\n",
 =09=09=09=09=09=09       name, func->name,
@@ -2617,10 +2593,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encod=
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



