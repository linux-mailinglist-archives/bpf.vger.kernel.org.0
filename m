Return-Path: <bpf+bounces-47497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351A39F9DB5
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 02:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812E51657CC
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 01:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A153FBB3;
	Sat, 21 Dec 2024 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="mRgw+txn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80651096F;
	Sat, 21 Dec 2024 01:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734744210; cv=none; b=OR6osP9BQEyY5gowv870Wnq8dEK6IzVtLuckU1DuOw3IoiQEJg/9EX3TdFI3wvmqeXxPry4FjFPCVqQK0W01fT/LrnvAXPQAjEMyFtL4Wz/xh5g4suO6YgFDLD4571Oqdsyazo6QU5wQlQXPtnX1+BBP6tnGL7H4lzhK7ErXCgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734744210; c=relaxed/simple;
	bh=tvjV7TJKCR7TqQVVHq/jb2EAlkRr16DgKRJp+LHctxA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfYZqjb2K6DveRXG1Qx2Xoz2byacddqTCsoiUQJ3tXdDD654OHFuOJsRdpXGNUtqBe4kKF7yYz2TjGO/7k26Xo1739mDQCkaGdEiI8cF7IgFysQsd8l2fQjzcTN9JWPjA/C62TXFA7eLb77JRj9mxgPeuY2etQnT3DWtj1ilzuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=mRgw+txn; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734744206; x=1735003406;
	bh=5/xuxSQ+gCJi0lxyRPP3+7mgc1ZFRb6x6NXjVLZJPJ0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=mRgw+txn2TKTKokcs5gtL4W8s/VybBOr6TepBaJwO2QLYBHPPX+RNA906EDOub5KG
	 30moMO+HNeQF9k0LCUFCmoZ385v+dlOnippQIHUUPWbrudpcUo+WyX8j9AxwJ2dA+C
	 701XR2dN8ePseJ7DztnwzxgEK3xVWgXG7MyiEHUuAgiWRhzh9ECy/x1p4XNA5G2Fnf
	 QBXAwXbsgo7Zd6tD7SRHN82H0ilQPVd0TSqT49LZlIpTNKLL7PnZYuCSTpnSmWy9Gj
	 jQGrTakvexRbA5zfBOVxM2sSxbm4R7Y7UAGs7iOz29NajzeSVxh1GizvlftXkATHJt
	 OBQ8S7QHWmO1Q==
Date: Sat, 21 Dec 2024 01:23:23 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: [PATCH dwarves v3 5/8] btf_encoder: remove skip_encoding_inconsistent_proto
Message-ID: <20241221012245.243845-6-ihor.solodrai@pm.me>
In-Reply-To: <20241221012245.243845-1-ihor.solodrai@pm.me>
References: <20241221012245.243845-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 838246001f1f428a320655ec19ce978de073ed7f
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
index 566ecfe..90f1b9a 100644
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
 =09struct btf_encoder_func_state **saved_fns, *s;
 =09struct btf_encoder *e =3D NULL;
@@ -1367,7 +1366,7 @@ int btf_encoder__add_saved_funcs(struct btf_encoder *=
encoder)
 =09=09 * just do not _use_ them.  Only exclude functions with
 =09=09 * unexpected register use or multiple inconsistent prototypes.
 =09=09 */
-=09=09if (!encoder->skip_encoding_inconsistent_proto ||
+=09=09if (!skip_encoding_inconsistent_proto ||
 =09=09    (!state->unexpected_reg && !state->inconsistent_proto)) {
 =09=09=09if (btf_encoder__add_func(state->encoder, state)) {
 =09=09=09=09free(saved_fns);
@@ -2129,14 +2128,14 @@ out:
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
 =09/* for single-threaded case, saved funcs are added here */
-=09btf_encoder__add_saved_funcs(encoder);
+=09btf_encoder__add_saved_funcs(conf->skip_encoding_btf_inconsistent_proto=
);
=20
 =09for (shndx =3D 1; shndx < encoder->seccnt; shndx++)
 =09=09if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
@@ -2464,7 +2463,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
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



