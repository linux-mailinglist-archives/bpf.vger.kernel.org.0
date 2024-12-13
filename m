Return-Path: <bpf+bounces-46927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E27E9F1934
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA4716427D
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5FB199E80;
	Fri, 13 Dec 2024 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="IgledVY9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF99C18D621;
	Fri, 13 Dec 2024 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734129436; cv=none; b=QnxRXbwGWyl4hD5btYVV9ia1wJWaHdLG8VYbLrBE2D1cvQeYinzw5NZtz+W0WQBveV4LGnhL8OPDL8iQwkR2CI7/Tx6aNmSt2FSjcFyb77N6pRYttyULwmZqYzaKGLm6w+QEsM6KD2FDyp48OGh9h0oXQbsBwPeftz6HrNP60Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734129436; c=relaxed/simple;
	bh=ocZFW3dwBhDwpKmvYTG2pn2FrrTM6Wzlz3K01QUnStg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzSuATX8O8BOv844isZOIKUlyOmJ5OeH+pU9rxNPqVP/7BlpNSGj0eoreX5T1PTX/D0C8YI6o73/3VAkc04/FC70RfBzTVLh1lDJ1FtNhL/GKkG+j7T1h2r6i+1/zMuz9rWa8y13SVBH7WuQYkc0oDbMlufUkzthTzjRqnqfoJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=IgledVY9; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734129433; x=1734388633;
	bh=IDvruiPUiIwrGs/LemsEDhmNXz8HONdA0R0b1emuZn0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=IgledVY9r3A9S5s7S6VDHkNGNAobsUBSMKSXxddx8klhcjJhvKdYj/dqhR1k579G1
	 lVMzpmNmTrAPmoWpWOryWkyamWPowLQamqw1MLo9muYvkcLjXOwWrrD8csadszjfsk
	 /DK5mQbczfFxwEO9FcI8SP/ZgICHA1q6meMd6a8AYukeupvTBuweYBRNn4mIIIuO+M
	 g58vPM2jr4Wwe35diXvNXhfhDQMBbjkvVUGJgrfLug20CvzZQKsTse6R9Hhhm/d+rZ
	 jFhdFtAZMod/nIUO1nsxLsXWD7WIcspTW/e++7xwRG/UsbeTraUphXL5wLmp30YUfd
	 nAtQd1446VMjg==
Date: Fri, 13 Dec 2024 22:37:07 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: [PATCH dwarves v2 05/10] btf_encoder: collect elf_functions in btf_encoder__pre_load_module
Message-ID: <20241213223641.564002-6-ihor.solodrai@pm.me>
In-Reply-To: <20241213223641.564002-1-ihor.solodrai@pm.me>
References: <20241213223641.564002-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: beb1cd205237169f04abff63a673b63969d9232a
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>

Link: https://lore.kernel.org/dwarves/20241128012341.4081072-7-ihor.solodra=
i@pm.me/
---
 btf_encoder.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 btf_encoder.h |  2 ++
 pahole.c      |  3 +++
 3 files changed, 71 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 5c1e6e0..88d2872 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -102,6 +102,8 @@ struct elf_secinfo {
 };
=20
 struct elf_functions {
+=09struct list_head node; /* for elf_functions_list */
+=09Elf *elf; /* source ELF */
 =09struct elf_symtab *symtab;
 =09struct elf_function *entries;
 =09int cnt;
@@ -148,6 +150,67 @@ struct btf_kfunc_set_range {
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
@@ -2105,6 +2168,8 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 #endif
 =09=09err =3D btf_encoder__write_elf(encoder, encoder->btf, BTF_ELF_SEC);
 =09}
+
+=09elf_functions__delete_all();
 =09return err;
 }
=20
@@ -2419,6 +2484,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
 =09=09=09goto out;
 =09=09}
 =09=09encoder->functions.symtab =3D encoder->symtab;
+=09=09encoder->functions.elf =3D cu->elf;
=20
 =09=09/* index the ELF sections for later lookup */
=20
diff --git a/btf_encoder.h b/btf_encoder.h
index 9b26162..7fa0390 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -35,4 +35,6 @@ struct btf *btf_encoder__btf(struct btf_encoder *encoder)=
;
 int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encod=
er *other);
 int btf_encoder__add_saved_funcs(struct btf_encoder *encoder);
=20
+int btf_encoder__pre_load_module(Dwfl_Module *mod, Elf *elf);
+
 #endif /* _BTF_ENCODER_H_ */
diff --git a/pahole.c b/pahole.c
index a36b732..17af0b4 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3738,6 +3738,9 @@ int main(int argc, char *argv[])
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
2.47.1



