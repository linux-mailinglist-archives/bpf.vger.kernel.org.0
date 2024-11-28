Return-Path: <bpf+bounces-45785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2719DB0B3
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4646B21A95
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 01:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C13533991;
	Thu, 28 Nov 2024 01:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="V1xNxuO5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D98F2B2DA
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 01:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757056; cv=none; b=Qsaba/0Tf0eltXotJDpYNO8dp/e5U3u2GNfG8pG2hLc1oOcr/PqQ5vMvh5jg+I1JMJWgwoNjkf84WVTc9fOXl57Kxa+duRKB1gdegS9uG9yX0aw/VmwKFlpN6eBj++7tyhIkN1940Q2gaucx2oFLqBfYypwoXmvpEpsAIje+tE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757056; c=relaxed/simple;
	bh=jzBHtna2/iguP2GkcHRAJHHDMNefaJeD0Eq5X9XzimU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HYfUiu6h4kAs1Wvuc/OQ3vwJ3PVYyx55JEdbFVTvX9INRGfhgqsCyVAK+CW6Me0pXydTCrAS6q84jTTzPrD3MosCOJ8Bzd8jbJqbRnFxRZlRI4WQc5bfy/Z2K+OfEWPDKyYf67sNqFYoZ1vG36cDqbZBAmGUJalTxJOvLUXbefc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=V1xNxuO5; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732757053; x=1733016253;
	bh=th/6eyRPeUdK1eO+DlzSKa/N9zD0uhVRreyD4OrHF1c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=V1xNxuO5JGbeRxCoAhZJI8IK+3riaftkGE6DbgCCddaxEA8dznNy7QHTK/VnIccVO
	 UAgfXOL4DxyHBqwDVXhWll5GbXlHStUHPjaAxOfMNxK0TDMctHg+7mgHHphm+KVyk6
	 Jm9BakALzl+X3/MQcsbcWkOp+AuFb5lyfKtDvnLjuKOTmA4aHIghSn9elIPr3p/s6/
	 YvOEGV4ovm+mwBsiedkSFJ6qtf944x/SBnaqFhPGOO1FseNoR5Hbzupyd4/oyI/tPD
	 M+4uI9iqDe8e+bVWyto3ss7PeU3nWdohzHIfvHVk2vSyrjrr0e91e30rddDx/QDs4k
	 RkBxXxfwdvicA==
Date: Thu, 28 Nov 2024 01:24:08 +0000
To: dwarves@vger.kernel.org, acme@kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com
Subject: [RFC PATCH 6/9] btf_encoder: collect elf_functions in btf_encoder__pre_load_module
Message-ID: <20241128012341.4081072-7-ihor.solodrai@pm.me>
In-Reply-To: <20241128012341.4081072-1-ihor.solodrai@pm.me>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 5d563d802d12849c4805a68b1aec44503aa9a3f8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Introduce a global elf_functions_list variable in btf_encoder.c that
contains an elf_functions per ELF.

An elf_functions structure is allocated and filled out by
btf_encoder__pre_load_module() hook, and the list is cleared after
btf_encoder__encode() is done.

At this point btf_encoders don't use shared elf_functions yet (each
maintains their own copy as before), but it is built before encoders
are initialized.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 btf_encoder.h |  2 ++
 pahole.c      |  3 +++
 3 files changed, 71 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 8331efe..8b1db5b 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -103,6 +103,8 @@ struct elf_secinfo {
 };
=20
 struct elf_functions {
+=09struct list_head node; /* for elf_functions_list */
+=09Elf *elf; /* source ELF */
 =09struct elf_symtab *symtab;
 =09struct elf_function *entries;
 =09int cnt;
@@ -149,6 +151,67 @@ struct btf_kfunc_set_range {
 =09uint64_t end;
 };
=20
+
+/* In principle, multiple ELFs can be processed in one pahole run,
+ * so we have to store elf_functions table per ELF.
+ * An element is added to the list on btf_encoder__pre_load_module,
+ * and removed after btf_encoder__encode is done.
+ */
+static LIST_HEAD(elf_functions_list);
+
+static inline void elf_functions__delete(struct elf_functions *funcs)
+{
+=09free(funcs->entries);
+=09elf_symtab__delete(funcs->symtab);
+=09list_del(&funcs->node);
+=09free(funcs);
+}
+
+static inline void elf_functions__delete_all(void)
+{
+=09struct list_head *pos, *tmp;
+
+=09list_for_each_safe(pos, tmp, &elf_functions_list) {
+=09=09struct elf_functions *funcs =3D list_entry(pos, struct elf_functions=
, node);
+
+=09=09elf_functions__delete(funcs);
+=09}
+}
+
+static int elf_functions__collect(struct elf_functions *functions);
+
+int btf_encoder__pre_load_module(Dwfl_Module *mod, Elf *elf)
+{
+=09struct elf_functions *funcs;
+=09int err;
+
+=09funcs =3D calloc(1, sizeof(*funcs));
+=09if (!funcs) {
+=09=09err =3D -ENOMEM;
+=09=09goto out_delete;
+=09}
+
+=09funcs->symtab =3D elf_symtab__new(NULL, elf);
+=09if (!funcs->symtab) {
+=09=09err =3D -1;
+=09=09goto out_delete;
+=09}
+
+=09funcs->elf =3D elf;
+=09err =3D elf_functions__collect(funcs);
+=09if (err)
+=09=09goto out_delete;
+
+=09list_add_tail(&funcs->node, &elf_functions_list);
+
+=09return 0;
+
+out_delete:
+=09elf_functions__delete(funcs);
+=09return err;
+}
+
+
 static LIST_HEAD(encoders);
 static pthread_mutex_t encoders__lock =3D PTHREAD_MUTEX_INITIALIZER;
=20
@@ -2107,6 +2170,8 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 #endif
 =09=09err =3D btf_encoder__write_elf(encoder, encoder->btf, BTF_ELF_SEC);
 =09}
+
+=09elf_functions__delete_all();
 =09return err;
 }
=20
@@ -2424,6 +2489,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
 =09=09=09goto out;
 =09=09}
 =09=09encoder->functions.symtab =3D encoder->symtab;
+=09=09encoder->functions.elf =3D cu->elf;
=20
 =09=09/* index the ELF sections for later lookup */
=20
diff --git a/btf_encoder.h b/btf_encoder.h
index 824963b..7debd67 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -34,4 +34,6 @@ struct btf *btf_encoder__btf(struct btf_encoder *encoder)=
;
=20
 int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encod=
er *other);
=20
+int btf_encoder__pre_load_module(Dwfl_Module *mod, Elf *elf);
+
 #endif /* _BTF_ENCODER_H_ */
diff --git a/pahole.c b/pahole.c
index fa5d8c7..1f8cf4b 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3737,6 +3737,9 @@ int main(int argc, char *argv[])
 =09=09conf_load.threads_collect =3D pahole_threads_collect;
 =09}
=20
+=09if (btf_encode)
+=09=09conf_load.pre_load_module =3D btf_encoder__pre_load_module;
+
 =09// Make 'pahole --header type < file' a shorter form of 'pahole -C type=
 --count 1 < file'
 =09if (conf.header_type && !class_name && prettify_input) {
 =09=09conf.count =3D 1;
--=20
2.47.0



