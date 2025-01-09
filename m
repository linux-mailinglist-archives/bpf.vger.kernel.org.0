Return-Path: <bpf+bounces-48442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4B1A0805C
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 20:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4771889FBE
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 19:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BCE1922ED;
	Thu,  9 Jan 2025 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="NoqpFeFP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55C319E7F7
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736449236; cv=none; b=JlgJbkp3Llqs6BtY/7MyTwlfrUm1wtyKQUfopQQ9IybaUt1G65y/JQUBHVWrJEXhqsGIDM5wKqWmcsQGDgjyw3X6HjDeLBAgCtfdee9z4+VwEYe5Z9MQy0aBr1IAWZhhJJslyTc6Zd9DzbkKMf+6LlnWjWiK7GzBJhGDvno+qzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736449236; c=relaxed/simple;
	bh=CFW+vDiQVGSlO/z+OsqS3YzcuZkZeAV7Lj9H7gYjyko=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXS1MjmgK5Mh+9r1EilnyVM1JNuJWBWnsFulJ9x+WQ3S0UnigRmRWMC25W+5Lbz0NQCerMoAMAgjug6UwnExkjoHAgj0RV/IKSyikzJ3i3tvQAVZHdCKZ4OVmN+pBAW2qRt8UVEhXklzO+WlQMyTvyv6/ChjxAHaFO6R8Py+JzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=NoqpFeFP; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736449233; x=1736708433;
	bh=gUXY5BNz3bE1re0XtT0F+fgl5LoPAa4vDxUPtMY8QhU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=NoqpFeFPb136qBErs09UK3tk3ytJfmfnvY66Vl6IFqDlVlex3jgNLPCS9Keen2ZAx
	 +N5hHBnKbsbflLMsXmr/hOHLFIiED/vL/cvmOZhD2tUP+Y8cSxWSlt9GzLNET7htla
	 p5geRHAsfSBvxx3GP3rfCCE40T8SpLQcVgrt7ZGiJa3MU77Z8bIrJDH3w73Gr7KSYY
	 lNjlOpjDLWh72m+z/rYyPt1GYv9K0X27kKXEnpQ8U9P5lB23DJE2XcAh88K8898DGw
	 An8cTF4yrFO5Q15kDHVkF7KfesGnX8tZwN2s1TL0dHxsauqGH3cvwObXr6mlrOdv2v
	 //Hh32CFrDQEg==
Date: Thu, 09 Jan 2025 19:00:27 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, olsajiri@gmail.com
Subject: [PATCH dwarves v4 RESEND 06/10] btf_encoder: remove skip_encoding_inconsistent_proto
Message-ID: <20250109185950.653110-7-ihor.solodrai@pm.me>
In-Reply-To: <20250109185950.653110-1-ihor.solodrai@pm.me>
References: <20250109185950.653110-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: a2562b6955338b3fd766462575636dc5f24c49f7
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This flag is needed only for btf_encoder__add_saved_funcs(), so there
is no reason to keep it in each btf_encoder.

Link: https://lore.kernel.org/dwarves/e1df45360963d265ea5e0b3634f0a3dae0c9c=
343.camel@gmail.com/

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 10 ++++------
 btf_encoder.h |  4 ++--
 pahole.c      |  7 +++++--
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index f0715c5..8243eb4 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -128,7 +128,6 @@ struct btf_encoder {
 =09=09=09  force,
 =09=09=09  gen_floats,
 =09=09=09  skip_encoding_decl_tag,
-=09=09=09  skip_encoding_inconsistent_proto,
 =09=09=09  tag_kfuncs,
 =09=09=09  gen_distilled_base;
 =09uint32_t=09  array_index_id;
@@ -1327,7 +1326,7 @@ static void btf_encoder__delete_saved_funcs(struct bt=
f_encoder *encoder)
 =09}
 }
=20
-int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
+int btf_encoder__add_saved_funcs(bool skip_encoding_inconsistent_proto)
 {
 =09struct btf_encoder_func_state **saved_fns =3D NULL, *s;
 =09int err =3D 0, i =3D 0, j, nr_saved_fns =3D 0;
@@ -1358,7 +1357,7 @@ int btf_encoder__add_saved_funcs(struct btf_encoder *=
encoder)
=20
 =09for (i =3D 0; i < nr_saved_fns; i =3D j) {
 =09=09struct btf_encoder_func_state *state =3D saved_fns[i];
-=09=09bool add_to_btf =3D !encoder->skip_encoding_inconsistent_proto;
+=09=09bool add_to_btf =3D !skip_encoding_inconsistent_proto;
=20
 =09=09/* Compare across sorted functions that match by name/prefix;
 =09=09 * share inconsistent/unexpected reg state between them.
@@ -2136,13 +2135,13 @@ out:
 =09return err;
 }
=20
-int btf_encoder__encode(struct btf_encoder *encoder)
+int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *con=
f)
 {
 =09bool should_tag_kfuncs;
 =09int err;
 =09size_t shndx;
=20
-=09err =3D btf_encoder__add_saved_funcs(encoder);
+=09err =3D btf_encoder__add_saved_funcs(conf->skip_encoding_btf_inconsiste=
nt_proto);
 =09if (err < 0)
 =09=09return err;
=20
@@ -2469,7 +2468,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
 =09=09encoder->force=09=09 =3D conf_load->btf_encode_force;
 =09=09encoder->gen_floats=09 =3D conf_load->btf_gen_floats;
 =09=09encoder->skip_encoding_decl_tag=09 =3D conf_load->skip_encoding_btf_=
decl_tag;
-=09=09encoder->skip_encoding_inconsistent_proto =3D conf_load->skip_encodi=
ng_btf_inconsistent_proto;
 =09=09encoder->tag_kfuncs=09 =3D conf_load->btf_decl_tag_kfuncs;
 =09=09encoder->gen_distilled_base =3D conf_load->btf_gen_distilled_base;
 =09=09encoder->verbose=09 =3D verbose;
diff --git a/btf_encoder.h b/btf_encoder.h
index 9b26162..b95f2f3 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -26,13 +26,13 @@ enum btf_var_option {
 struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_f=
ilename, struct btf *base_btf, bool verbose, struct conf_load *conf_load);
 void btf_encoder__delete(struct btf_encoder *encoder);
=20
-int btf_encoder__encode(struct btf_encoder *encoder);
+int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *con=
f);
=20
 int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, str=
uct conf_load *conf_load);
=20
 struct btf *btf_encoder__btf(struct btf_encoder *encoder);
=20
 int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encod=
er *other);
-int btf_encoder__add_saved_funcs(struct btf_encoder *encoder);
+int btf_encoder__add_saved_funcs(bool skip_encoding_inconsistent_proto);
=20
 #endif /* _BTF_ENCODER_H_ */
diff --git a/pahole.c b/pahole.c
index a36b732..37d76b1 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3185,7 +3185,10 @@ static int pahole_threads_collect(struct conf_load *=
conf, int nr_threads, void *
 =09if (error)
 =09=09goto out;
=20
-=09btf_encoder__add_saved_funcs(btf_encoder);
+=09err =3D btf_encoder__add_saved_funcs(conf_load.skip_encoding_btf_incons=
istent_proto);
+=09if (err < 0)
+=09=09goto out;
+
 =09for (i =3D 0; i < nr_threads; i++) {
 =09=09/*
 =09=09 * Merge content of the btf instances of worker threads to the btf
@@ -3843,7 +3846,7 @@ try_sole_arg_as_class_names:
 =09=09=09exit(1);
 =09=09}
=20
-=09=09err =3D btf_encoder__encode(btf_encoder);
+=09=09err =3D btf_encoder__encode(btf_encoder, &conf_load);
 =09=09btf_encoder__delete(btf_encoder);
 =09=09if (err) {
 =09=09=09fputs("Failed to encode BTF\n", stderr);
--=20
2.47.1



