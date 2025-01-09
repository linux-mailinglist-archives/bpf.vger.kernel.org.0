Return-Path: <bpf+bounces-48445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 742C6A08062
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 20:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B8B168E1E
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 19:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35DC1F4293;
	Thu,  9 Jan 2025 19:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="hgmNljJF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA7218F2D8
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 19:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736449259; cv=none; b=nis2RcFfO3QTc75jBxLs+tEULelBACux6tBxuCw9vWdpad17yk6+VmNaA6Gxun1hmhwtwB6XWTTJ/+vUabr/3PWzN7OtVjL8pdMaggtVYvu6uOgXebCPaL05NVMiCrxu9GOEoJ3QLptmVXdKW/BMLzjR1Tbg7HfSvDZAf+fDoFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736449259; c=relaxed/simple;
	bh=x9hZ2oVQt8iOgS9QTbPBy5fmgAjH61+/ZbWS65SgwVQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgReuzbIn9KO+W6t3k/nKygzutx4TDNcKR1vxXQA80Gz6fiXb5kD4RpolEpZYuGI3UA6RRffd49K/oHZWAcicGLY3HiE/5V55XOrSl5k8J/Z+X3p2x3CWny74tTe/E2TG47edKyIogogAw0d0umrjDtoxeyGxFmf+4ysSUZNvVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=hgmNljJF; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736449254; x=1736708454;
	bh=y9tOu0h7xeRv/pv4oPFpFJNobDWr/o9xarccW7BFzn0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=hgmNljJFho2RuYadgrdp8uN+sQs35HSLXLFDVBNhjnYqGk7LJ7w9wemIL7/BDKOcr
	 kGIf5Ey2v0fUSHUfvmQNUoNSyXxf/oE+mqpvbAwqe4QI6GMMZZvAW/Ksgyx2kYqxXY
	 QjBVD/ylYiOX/1+4kXHY6+9sQEliya2uj2NMQ5kVdM13ZLwDBMl+fwcJTGdFZOc5nZ
	 UvyMYsBiwfYoEMCWf8ORd89jizrkFYb1m42mOW1ejTKSTwnmEnfTUfR8QyIBUhOrhQ
	 2X8qdYU0TMumgAV/hUDUWHwExzVIaZnY6HoZ56kdV3dTZqwNcq5Z0yKCvO7wSRoIZ0
	 PxYofB7DFa9Cg==
Date: Thu, 09 Jan 2025 19:00:48 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, olsajiri@gmail.com
Subject: [PATCH dwarves v4 RESEND 09/10] btf_encoder: clean up global encoders list
Message-ID: <20250109185950.653110-10-ihor.solodrai@pm.me>
In-Reply-To: <20250109185950.653110-1-ihor.solodrai@pm.me>
References: <20250109185950.653110-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: af122c5718d6f6fc9a5163aa201d462776ec8e7b
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

With multithreading moved entirely to the dwarf_loader, now there is
only one btf_encoder. Hence there is no need to maintain a global list
of encoders anymore.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 94 +++++----------------------------------------------
 btf_encoder.h |  4 ---
 2 files changed, 8 insertions(+), 90 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index ce0259e..da99fbb 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -218,39 +218,6 @@ static struct elf_functions *elf_functions__find(const=
 Elf *elf, const struct li
 =09return NULL;
 }
=20
-
-static LIST_HEAD(encoders);
-static pthread_mutex_t encoders__lock =3D PTHREAD_MUTEX_INITIALIZER;
-
-/* mutex only needed for add/delete, as this can happen in multiple encodi=
ng
- * threads.  Traversal of the list is currently confined to thread collect=
ion.
- */
-
-#define btf_encoders__for_each_encoder(encoder)=09=09\
-=09list_for_each_entry(encoder, &encoders, node)
-
-static void btf_encoders__add(struct btf_encoder *encoder)
-{
-=09pthread_mutex_lock(&encoders__lock);
-=09list_add_tail(&encoder->node, &encoders);
-=09pthread_mutex_unlock(&encoders__lock);
-}
-
-static void btf_encoders__delete(struct btf_encoder *encoder)
-{
-=09struct btf_encoder *existing =3D NULL;
-
-=09pthread_mutex_lock(&encoders__lock);
-=09/* encoder may not have been added to list yet; check. */
-=09btf_encoders__for_each_encoder(existing) {
-=09=09if (encoder =3D=3D existing)
-=09=09=09break;
-=09}
-=09if (encoder =3D=3D existing)
-=09=09list_del(&encoder->node);
-=09pthread_mutex_unlock(&encoders__lock);
-}
-
 #define PERCPU_SECTION ".data..percpu"
=20
 /*
@@ -868,39 +835,6 @@ static int32_t btf_encoder__add_var_secinfo(struct btf=
_encoder *encoder, size_t
 =09return gobuffer__add(&encoder->secinfo[shndx].secinfo, &si, sizeof(si))=
;
 }
=20
-int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_e=
ncoder *other)
-{
-=09size_t shndx;
-=09if (encoder =3D=3D other)
-=09=09return 0;
-
-=09for (shndx =3D 1; shndx < other->seccnt; shndx++) {
-=09=09struct gobuffer *var_secinfo_buf =3D &other->secinfo[shndx].secinfo;
-=09=09size_t sz =3D gobuffer__size(var_secinfo_buf);
-=09=09uint16_t nr_var_secinfo =3D sz / sizeof(struct btf_var_secinfo);
-=09=09uint32_t type_id;
-=09=09uint32_t next_type_id =3D btf__type_cnt(encoder->btf);
-=09=09int32_t i, id;
-=09=09struct btf_var_secinfo *vsi;
-
-=09=09if (strcmp(encoder->secinfo[shndx].name, other->secinfo[shndx].name)=
) {
-=09=09=09fprintf(stderr, "mismatched ELF sections at index %zu: \"%s\", \"=
%s\"\n",
-=09=09=09=09shndx, encoder->secinfo[shndx].name, other->secinfo[shndx].nam=
e);
-=09=09=09return -1;
-=09=09}
-
-=09=09for (i =3D 0; i < nr_var_secinfo; i++) {
-=09=09=09vsi =3D (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
-=09=09=09type_id =3D next_type_id + vsi->type - 1; /* Type ID starts from =
1 */
-=09=09=09id =3D btf_encoder__add_var_secinfo(encoder, shndx, type_id, vsi-=
>offset, vsi->size);
-=09=09=09if (id < 0)
-=09=09=09=09return id;
-=09=09}
-=09}
-
-=09return btf__add_btf(encoder->btf, other->btf);
-}
-
 static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, size_=
t shndx)
 {
 =09struct gobuffer *var_secinfo_buf =3D &encoder->secinfo[shndx].secinfo;
@@ -1326,18 +1260,16 @@ static void btf_encoder__delete_saved_funcs(struct =
btf_encoder *encoder)
 =09}
 }
=20
-static int btf_encoder__add_saved_funcs(bool skip_encoding_inconsistent_pr=
oto)
+static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool =
skip_encoding_inconsistent_proto)
 {
 =09struct btf_encoder_func_state **saved_fns =3D NULL, *s;
 =09int err =3D 0, i =3D 0, j, nr_saved_fns =3D 0;
-=09struct btf_encoder *e =3D NULL;
=20
-=09/* Retrieve function states from each encoder, combine them
+=09/* Retrieve function states from the encoder, combine them
 =09 * and sort by name, addr.
 =09 */
-=09btf_encoders__for_each_encoder(e) {
-=09=09list_for_each_entry(s, &e->func_states, node)
-=09=09=09nr_saved_fns++;
+=09list_for_each_entry(s, &encoder->func_states, node) {
+=09=09nr_saved_fns++;
 =09}
=20
 =09if (nr_saved_fns =3D=3D 0)
@@ -1349,9 +1281,8 @@ static int btf_encoder__add_saved_funcs(bool skip_enc=
oding_inconsistent_proto)
 =09=09goto out;
 =09}
=20
-=09btf_encoders__for_each_encoder(e) {
-=09=09list_for_each_entry(s, &e->func_states, node)
-=09=09=09saved_fns[i++] =3D s;
+=09list_for_each_entry(s, &encoder->func_states, node) {
+=09=09saved_fns[i++] =3D s;
 =09}
 =09qsort(saved_fns, nr_saved_fns, sizeof(*saved_fns), saved_functions_cmp)=
;
=20
@@ -1383,9 +1314,7 @@ static int btf_encoder__add_saved_funcs(bool skip_enc=
oding_inconsistent_proto)
=20
 out:
 =09free(saved_fns);
-=09btf_encoders__for_each_encoder(e) {
-=09=09btf_encoder__delete_saved_funcs(e);
-=09}
+=09btf_encoder__delete_saved_funcs(encoder);
=20
 =09return err;
 }
@@ -2141,7 +2070,7 @@ int btf_encoder__encode(struct btf_encoder *encoder, =
struct conf_load *conf)
 =09int err;
 =09size_t shndx;
=20
-=09err =3D btf_encoder__add_saved_funcs(conf->skip_encoding_btf_inconsiste=
nt_proto);
+=09err =3D btf_encoder__add_saved_funcs(encoder, conf->skip_encoding_btf_i=
nconsistent_proto);
 =09if (err < 0)
 =09=09return err;
=20
@@ -2547,7 +2476,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
=20
 =09=09if (encoder->verbose)
 =09=09=09printf("File %s:\n", cu->filename);
-=09=09btf_encoders__add(encoder);
 =09}
=20
 =09return encoder;
@@ -2564,7 +2492,6 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 =09if (encoder =3D=3D NULL)
 =09=09return;
=20
-=09btf_encoders__delete(encoder);
 =09for (shndx =3D 0; shndx < encoder->seccnt; shndx++)
 =09=09__gobuffer__delete(&encoder->secinfo[shndx].secinfo);
 =09free(encoder->secinfo);
@@ -2733,8 +2660,3 @@ out:
 =09encoder->cu =3D NULL;
 =09return err;
 }
-
-struct btf *btf_encoder__btf(struct btf_encoder *encoder)
-{
-=09return encoder->btf;
-}
diff --git a/btf_encoder.h b/btf_encoder.h
index 0081a99..0f345e2 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -27,10 +27,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, cons=
t char *detached_filenam
 void btf_encoder__delete(struct btf_encoder *encoder);
=20
 int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *con=
f);
-
 int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, str=
uct conf_load *conf_load);
=20
-struct btf *btf_encoder__btf(struct btf_encoder *encoder);
-
-int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encod=
er *other);
 #endif /* _BTF_ENCODER_H_ */
--=20
2.47.1



