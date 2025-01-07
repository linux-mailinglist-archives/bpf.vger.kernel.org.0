Return-Path: <bpf+bounces-48162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECFFA049F0
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 20:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E093A2FA3
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 19:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CB01F4E30;
	Tue,  7 Jan 2025 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="GjF8W9zO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C891F4710
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736276982; cv=none; b=mC9CEekdRMoghr4y4gTWEnPB54RnyYLuFiO/QQuBZ06t05bND9ePHmrE01tmisaBymbIPPuDLnqqkOMvhNa+iVnV/5a6lL9kJoI5A4eg68lSssP+8mwzRuL0clkuYsa34XITxrhxGq4z+kATnABQIGOHw1C9Dtmau6NCT/lODi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736276982; c=relaxed/simple;
	bh=sdehCcje+opowFDMp/Ilx40UpCuq0VZkGfeORqRinMw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=madcWBMR3tgs4PlLTkryKdk1YGy22KrfC+f6aq3UyT1iSt7aE964U/VNbU5BYxXHFL638hxO6A3Uk5BDLuYnGkVzASY29rrUEzjQY1Mum+/hAfK8QTIww3Kmm+Zd0eioC9ZZiySDW54OB5r/3bJ4s2fkuTyAVsD3qwIFcX6AIa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=GjF8W9zO; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736276978; x=1736536178;
	bh=QUtmwT64ALJrJ4hzLZ830aIqcDu2BdhXwL69XnC87Pg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=GjF8W9zO8LzZWk5Kd80m+PFAOqAhj5DDK+wHIC/NNhX2R+1WRAi2GrMTYNiXIlig/
	 O2uuU5peHtHWMkh7Z62ErkdNq8vsl+8Jz9GzvlxaM1dds8JLZTP01oIBhm35wMSwYS
	 /rBUGepkeiWB76lcV4RjIMtcu4oF1axvMZXL1vbnugmz4O+VbABxmkS+nLTzGxrDPa
	 5vUF2fIY0FgCySRtNHxUGuZ89fKNxQil+Dc0T5RbrSzZs7mnPvD9zdcre6qyEn4AEV
	 T0Ee2utN2gB/qQrjG8l/T4LbPfncQ/GslFtU4T2sjf+dmZsrCrMPdu33mxQ4UAjzn8
	 MZ2dx3sxwysgQ==
Date: Tue, 07 Jan 2025 19:09:32 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, olsajiri@gmail.com
Subject: [PATCH dwarves v4 06/10] btf_encoder: remove skip_encoding_inconsistent_proto
Message-ID: <20250107190855.2312210-7-ihor.solodrai@pm.me>
In-Reply-To: <20250107190855.2312210-1-ihor.solodrai@pm.me>
References: <20250107190855.2312210-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 8b9647ae7ce26096ed20e01c7a3179701822d1b1
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
index 7b4523b..875ec9d 100644
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
@@ -2142,13 +2141,13 @@ out:
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
@@ -2475,7 +2474,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
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



