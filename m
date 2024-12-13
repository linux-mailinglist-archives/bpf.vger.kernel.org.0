Return-Path: <bpf+bounces-46930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B51959F1938
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C6918892C1
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C899E1A4F21;
	Fri, 13 Dec 2024 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="HwQeeBst"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA9F199E80
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 22:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734129451; cv=none; b=V9RxJVfah5ZsQXrTboWXspRdVMG60L8sLoOscBkMoy/rSG95BabOq2igfNCVxugaA6FOXGa2GYqlM64q+qTnDojZIYqHSzZWMOmQu07fW9TX2/9RWSN4LlBUb8VpxeiOSPHQq4eKnOF3S9G69p1FCMMTMG8ovaiFRUHcA4FgV6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734129451; c=relaxed/simple;
	bh=ND8sCu4siixILE6d4FPJTQJ8PNE4TD2qvqMGCvBgpWU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITjBxPMtSXWjTzNzSU3MxDVhNrejUQG3omsIsVS7so58DA4KsnyrS+gO4z87w+44WkRVq/UBd3EaP1DWPBd45pE5MlNvs4iBWUAkwyUN6KGiotOeFfqCGNAinOWJv5aMMZNaTjgXYuMljKmfmPFtqexmOpihgf88EQISws75Hlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=HwQeeBst; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734129448; x=1734388648;
	bh=YDQWUO3nJbuvJbMDWwOY6KRiu1nYMDRqPoivW9apiyQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=HwQeeBstuJkJ5CxDoahJDdInuxMFCIYC/YDs5HS9Jtkgy9a5C0C5E7CHeIvSbGXvZ
	 GVN1FSJylUQgGFfBdN9IBLIni2qUBqM7hQEqTfQBDuDRvghn1VygDkEPq3nnlXSifw
	 aaUkIoX5OQ4O6TlHuvCZVNakbTj7cJlZiAWI6RQpkqn55puc4Ivwob0lU/Wd+LT8rB
	 duyh/3ISt5s+/PQnLd+7BEjQWvSAp4Y3QV6WxsJccg4T6Ug7YP0qN9imqSsBXNtnCI
	 GqXisDGjF0yzhUk/mN6cY8aediC6M9hTsNCWddaTYotFP1AQz0Ro5Hq4Q6n6R/Oypq
	 8qkms8Wv1OAOg==
Date: Fri, 13 Dec 2024 22:37:22 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: [PATCH dwarves v2 08/10] btf_encoder: remove skip_encoding_inconsistent_proto
Message-ID: <20241213223641.564002-9-ihor.solodrai@pm.me>
In-Reply-To: <20241213223641.564002-1-ihor.solodrai@pm.me>
References: <20241213223641.564002-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 27255b935a62e76e7736507cdc89130402733612
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
 btf_encoder.c | 6 ++----
 btf_encoder.h | 2 +-
 pahole.c      | 4 ++--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index a362fb2..0b71498 100644
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
@@ -1379,7 +1378,7 @@ static void btf_encoder__delete_saved_funcs(struct bt=
f_encoder *encoder)
 =09}
 }
=20
-int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
+int btf_encoder__add_saved_funcs(bool skip_encoding_inconsistent_proto)
 {
 =09struct btf_encoder_func_state **saved_fns, *s;
 =09struct btf_encoder *e =3D NULL;
@@ -1419,7 +1418,7 @@ int btf_encoder__add_saved_funcs(struct btf_encoder *=
encoder)
 =09=09 * just do not _use_ them.  Only exclude functions with
 =09=09 * unexpected register use or multiple inconsistent prototypes.
 =09=09 */
-=09=09if (!encoder->skip_encoding_inconsistent_proto ||
+=09=09if (!skip_encoding_inconsistent_proto ||
 =09=09    (!state->unexpected_reg && !state->inconsistent_proto)) {
 =09=09=09if (btf_encoder__add_func(state->encoder, state)) {
 =09=09=09=09free(saved_fns);
@@ -2500,7 +2499,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
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
index f14edc1..421cde1 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -36,7 +36,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, s=
truct cu *cu, struct co
 struct btf *btf_encoder__btf(struct btf_encoder *encoder);
=20
 int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encod=
er *other);
-int btf_encoder__add_saved_funcs(struct btf_encoder *encoder);
+int btf_encoder__add_saved_funcs(bool skip_encoding_inconsistent_proto);
=20
 int btf_encoder__pre_load_module(Dwfl_Module *mod, Elf *elf);
=20
diff --git a/pahole.c b/pahole.c
index 6bbc9e4..7964a03 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3185,7 +3185,7 @@ static int pahole_threads_collect(struct conf_load *c=
onf, int nr_threads, void *
 =09if (error)
 =09=09goto out;
=20
-=09err =3D btf_encoder__add_saved_funcs(btf_encoder);
+=09err =3D btf_encoder__add_saved_funcs(conf_load.skip_encoding_btf_incons=
istent_proto);
 =09if (err < 0)
 =09=09goto out;
=20
@@ -3854,7 +3854,7 @@ try_sole_arg_as_class_names:
 =09=09}
=20
 =09=09if (conf_load.nr_jobs <=3D 1 || conf_load.reproducible_build)
-=09=09=09btf_encoder__add_saved_funcs(btf_encoder);
+=09=09=09btf_encoder__add_saved_funcs(conf_load.skip_encoding_btf_inconsis=
tent_proto);
=20
 =09=09err =3D btf_encoder__encode(btf_encoder);
 =09=09btf_encoder__delete(btf_encoder);
--=20
2.47.1



