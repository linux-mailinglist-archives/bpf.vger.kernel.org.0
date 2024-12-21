Return-Path: <bpf+bounces-47501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4607F9F9DB9
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 02:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9B31883FE4
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 01:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDC82AE8C;
	Sat, 21 Dec 2024 01:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="XYA+SoSa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDEC1BF37;
	Sat, 21 Dec 2024 01:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734744236; cv=none; b=IDi8vvwqq5LV0+3m4cDofiBu/9w41no5GD7+aV1XA1ID0JYNCPrMPSsHW8TaYoAvzNXAC/9vOKlbvd2lHK+83YVHrnRfEgs312cAyAb38GmdXlK+1tq1j2osYVQUbAQkxwiDxTwjM5n84B7ECoydnOFHgnG/vyxjzm+5NIMbVR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734744236; c=relaxed/simple;
	bh=KSSdXmtfzYajZw4qih4NRTECtFQ6oqSR8n4/XZVpEFw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PcQBwYxXrwxp51aN+24wYSOksrTByT9Mt22KskEu9XaCjswN1RXPM6OtCzgzdxgnKou6PiffVhM7I+1fdVR6Oa1jlrNzaf3Yz8ccZzoArWcPfeWO3UPDC591vkZjKKAVWGLtnqg8mHKbpG1OulK+SJHfPbaUOdQnNOh5S15NYgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=XYA+SoSa; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734744232; x=1735003432;
	bh=Ny/6YZ1iIK837U/U3ch6VU4EDb2Pi2hXvZfadV22vLE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=XYA+SoSa8/dzMn13AMY2E+GWdQkObVjw7h8IdebvPSSEmyqH1hr+FG3+QmS9CMbEg
	 sOo1WxNQ26vU/rPFiuI9Yv6krP9Y2Xky4wUEyYzsgfPc9SAGV6OG81uOmN+yIQeQmU
	 bjo+1Alx6bInfS08vtIA4gxxSHr/MMg0wJVtlzwRsRo21DRm2dypuOIOfm42UXH2N6
	 O9AI/IsLrR1xebIv3+zz3ffdB5rGKRoQbyKZJbtufr1o1ai+WQhprcNk9M6/hFme3+
	 gbFq27qzjCe9romGiqw24S2htqaf/yoChuae+p13Rf8M0qCvAA1QBKMgWQJrYFtQyl
	 jKFrCXiAKtMMw==
Date: Sat, 21 Dec 2024 01:23:45 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: [PATCH dwarves v3 8/8] btf_encoder: clean up global encoders list
Message-ID: <20241221012245.243845-9-ihor.solodrai@pm.me>
In-Reply-To: <20241221012245.243845-1-ihor.solodrai@pm.me>
References: <20241221012245.243845-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 96da67071566f230b425a7233e7d0eebb2407ac5
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
 btf_encoder.c | 106 ++++++++------------------------------------------
 btf_encoder.h |   4 --
 2 files changed, 17 insertions(+), 93 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 7e03ba4..88e32e4 100644
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
@@ -1326,27 +1260,29 @@ static void btf_encoder__delete_saved_funcs(struct =
btf_encoder *encoder)
 =09}
 }
=20
-static int btf_encoder__add_saved_funcs(bool skip_encoding_inconsistent_pr=
oto)
+static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool =
skip_encoding_inconsistent_proto)
 {
 =09struct btf_encoder_func_state **saved_fns, *s;
-=09struct btf_encoder *e =3D NULL;
-=09int i =3D 0, j, nr_saved_fns =3D 0;
+=09int err =3D 0, i =3D 0, j, nr_saved_fns =3D 0;
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
-=09=09return 0;
+=09=09goto out;
=20
 =09saved_fns =3D calloc(nr_saved_fns, sizeof(*saved_fns));
-=09btf_encoders__for_each_encoder(e) {
-=09=09list_for_each_entry(s, &e->func_states, node)
-=09=09=09saved_fns[i++] =3D s;
+=09if (!saved_fns) {
+=09=09err =3D -ENOMEM;
+=09=09goto out;
+=09}
+
+=09list_for_each_entry(s, &encoder->func_states, node) {
+=09=09saved_fns[i++] =3D s;
 =09}
 =09qsort(saved_fns, nr_saved_fns, sizeof(*saved_fns), saved_functions_cmp)=
;
=20
@@ -1377,11 +1313,10 @@ static int btf_encoder__add_saved_funcs(bool skip_e=
ncoding_inconsistent_proto)
=20
 =09/* Now that we are done with function states, free them. */
 =09free(saved_fns);
-=09btf_encoders__for_each_encoder(e) {
-=09=09btf_encoder__delete_saved_funcs(e);
-=09}
+=09btf_encoder__delete_saved_funcs(encoder);
=20
-=09return 0;
+out:
+=09return err;
 }
=20
 static void elf_functions__collect_function(struct elf_functions *function=
s, GElf_Sym *sym)
@@ -2134,7 +2069,7 @@ int btf_encoder__encode(struct btf_encoder *encoder, =
struct conf_load *conf)
 =09int err;
 =09size_t shndx;
=20
-=09btf_encoder__add_saved_funcs(conf->skip_encoding_btf_inconsistent_proto=
);
+=09btf_encoder__add_saved_funcs(encoder, conf->skip_encoding_btf_inconsist=
ent_proto);
=20
 =09for (shndx =3D 1; shndx < encoder->seccnt; shndx++)
 =09=09if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
@@ -2541,7 +2476,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
=20
 =09=09if (encoder->verbose)
 =09=09=09printf("File %s:\n", cu->filename);
-=09=09btf_encoders__add(encoder);
 =09}
=20
 =09return encoder;
@@ -2558,7 +2492,6 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 =09if (encoder =3D=3D NULL)
 =09=09return;
=20
-=09btf_encoders__delete(encoder);
 =09for (shndx =3D 0; shndx < encoder->seccnt; shndx++)
 =09=09__gobuffer__delete(&encoder->secinfo[shndx].secinfo);
 =09free(encoder->secinfo);
@@ -2727,8 +2660,3 @@ out:
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



