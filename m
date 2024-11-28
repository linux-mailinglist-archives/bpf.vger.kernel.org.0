Return-Path: <bpf+bounces-45781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 562BF9DB0AF
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC3C16669C
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 01:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEB82556E;
	Thu, 28 Nov 2024 01:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="KX0vMQam"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C591DFE1;
	Thu, 28 Nov 2024 01:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757045; cv=none; b=UgGQCj0UV2JwMBTHrzibaT+EYLDG6QZMrHXKH8/NMk/xIQnfzj+b6neRzcTDTyky2e+PsvauXcUBqVB46TAPrCMCs9UrFXYPtRkqz6Ph/VNFm10KshGyDq/cNPlkP/apal2DPDPXIpB8A7QWI6/Vwtm7QYiTFP96GpM39G9CNLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757045; c=relaxed/simple;
	bh=5bOnr1ypHwPs1mWwGi/AQufJtaej3OMXKl4fTb0rrYQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2erG3SE/CrjsHuFsrMZ1mFFM7lYPktp0gBhxraTryrbuMzwsQVIYVvCZMYLhHp3FInMCGfg7kmMghkKYKEs2m8cszCpXMdUx8y4oWFukG6WiFVDIfATw3bDJ+DwyEknoV1iqu5arINy8VmqKdldAMe7NvakKcvdKMyoxbe8s6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=KX0vMQam; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732757036; x=1733016236;
	bh=0kNK2QLWgiitAe9nVN05yGD9VfdypXNVZMc26XViufk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=KX0vMQamO0lHAT3RtPwI7uPip9hbJHzjlJn5Yk0ueBwV8BHtYYjy5yyPuJNDaObTa
	 hAIAo4e8rtGE1f32DcR+PLDaaYQkksA8IUdp8kt0OtWNasQ0Tx6+XLx+o3pnAFG6Df
	 GQm6DFXkdFqLMDHQNVrXwAXO+LVC2clIRFhH3gqO7aHR268ees0YcfPWW2uwMYy6Ko
	 J55CKO1FakYt6KHUFHoVSSXQ1JI28XtWIkZAj8k6NoQNakvUKZQuxsEaKWjyx25O5O
	 cli3/Ax4gUzF5FON9pTDieqCZ7McG/MVf9SIkXD1bBEfIW10Zti+7eOjhhO8hN6gVT
	 m6K8xaXnl58rw==
Date: Thu, 28 Nov 2024 01:23:54 +0000
To: dwarves@vger.kernel.org, acme@kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com
Subject: [RFC PATCH 2/9] btf_encoder: store,use section-relative addresses in ELF function representation
Message-ID: <20241128012341.4081072-3-ihor.solodrai@pm.me>
In-Reply-To: <20241128012341.4081072-1-ihor.solodrai@pm.me>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 283d93515b51581ad1e491742b74a7cf52d79c9c
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Alan Maguire <alan.maguire@oracle.com>

This will help us do more accurate DWARF/ELF matching.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 98e4d7d..01d7094 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -88,6 +88,7 @@ struct btf_encoder_func_state {
 struct elf_function {
 =09const char=09*name;
 =09char=09=09*alias;
+=09uint32_t=09addr;
 =09size_t=09=09prefixlen;
 =09struct btf_encoder_func_state state;
 };
@@ -131,6 +132,7 @@ struct btf_encoder {
 =09=09int=09=09    allocated;
 =09=09int=09=09    cnt;
 =09=09int=09=09    suffix_cnt; /* number of .isra, .part etc */
+=09=09uint64_t=09    base_addr;
 =09} functions;
 };
=20
@@ -1274,13 +1276,23 @@ static int functions_cmp(const void *_a, const void=
 *_b)
 {
 =09const struct elf_function *a =3D _a;
 =09const struct elf_function *b =3D _b;
+=09int ret;
=20
 =09/* if search key allows prefix match, verify target has matching
 =09 * prefix len and prefix matches.
 =09 */
 =09if (a->prefixlen && a->prefixlen =3D=3D b->prefixlen)
-=09=09return strncmp(a->name, b->name, b->prefixlen);
-=09return strcmp(a->name, b->name);
+=09=09ret =3D strncmp(a->name, b->name, b->prefixlen);
+=09else
+=09=09ret =3D strcmp(a->name, b->name);
+=09if (ret !=3D 0)
+=09=09return ret;
+=09/* avoid address mismatch */
+        if (a->addr !=3D 0 && b->addr !=3D 0) {
+                if (a->addr !=3D b->addr)
+                        return a->addr > b->addr ? 1 : -1;
+        }
+=09return 0;
 }
=20
 #ifndef max
@@ -1301,6 +1313,7 @@ static int btf_encoder__collect_function(struct btf_e=
ncoder *encoder, GElf_Sym *
 {
 =09struct elf_function *new;
 =09const char *name;
+=09uint64_t addr;
=20
 =09if (elf_sym__type(sym) !=3D STT_FUNC)
 =09=09return 0;
@@ -1325,6 +1338,9 @@ static int btf_encoder__collect_function(struct btf_e=
ncoder *encoder, GElf_Sym *
 =09memset(&encoder->functions.entries[encoder->functions.cnt], 0,
 =09       sizeof(*new));
 =09encoder->functions.entries[encoder->functions.cnt].name =3D name;
+=09/* convert to absoulte address for DWARF/ELF matching. */
+=09addr =3D elf_sym__value(sym);
+=09encoder->functions.entries[encoder->functions.cnt].addr =3D (uint32_t)a=
ddr;
 =09if (strchr(name, '.')) {
 =09=09const char *suffix =3D strchr(name, '.');
=20
@@ -1336,9 +1352,10 @@ static int btf_encoder__collect_function(struct btf_=
encoder *encoder, GElf_Sym *
 }
=20
 static struct elf_function *btf_encoder__find_function(const struct btf_en=
coder *encoder,
-=09=09=09=09=09=09       const char *name, size_t prefixlen)
+=09=09=09=09=09=09       const char *name, size_t prefixlen,
+=09=09=09=09=09=09       uint32_t addr)
 {
-=09struct elf_function key =3D { .name =3D name, .prefixlen =3D prefixlen =
};
+=09struct elf_function key =3D { .name =3D name, .prefixlen =3D prefixlen,=
 .addr =3D addr };
=20
 =09return bsearch(&key, encoder->functions.entries, encoder->functions.cnt=
, sizeof(key), functions_cmp);
 }
@@ -2086,11 +2103,16 @@ int btf_encoder__encode(struct btf_encoder *encoder=
)
=20
 static int btf_encoder__collect_symbols(struct btf_encoder *encoder)
 {
+=09bool base_addr_set =3D false;
 =09uint32_t sym_sec_idx;
 =09uint32_t core_id;
 =09GElf_Sym sym;
=20
 =09elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_se=
c_idx) {
+=09=09if (!base_addr_set && sym_sec_idx && sym_sec_idx < encoder->seccnt) =
{
+=09=09=09encoder->functions.base_addr =3D encoder->secinfo[sym_sec_idx].ad=
dr;
+=09=09=09base_addr_set =3D true;
+=09=09}
 =09=09if (btf_encoder__collect_function(encoder, &sym))
 =09=09=09return -1;
 =09}
@@ -2543,13 +2565,16 @@ int btf_encoder__encode_cu(struct btf_encoder *enco=
der, struct cu *cu, struct co
 =09=09=09continue;
 =09=09if (encoder->functions.cnt) {
 =09=09=09const char *name;
+=09=09=09uint64_t addr;
=20
 =09=09=09name =3D function__name(fn);
 =09=09=09if (!name)
 =09=09=09=09continue;
=20
+=09=09=09addr =3D (uint32_t)function__addr(fn);
+
 =09=09=09/* prefer exact function name match... */
-=09=09=09func =3D btf_encoder__find_function(encoder, name, 0);
+=09=09=09func =3D btf_encoder__find_function(encoder, name, 0, addr);
 =09=09=09if (!func && encoder->functions.suffix_cnt &&
 =09=09=09    conf_load->btf_gen_optimized) {
 =09=09=09=09/* falling back to name.isra.0 match if no exact
@@ -2560,7 +2585,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
r, struct cu *cu, struct co
 =09=09=09=09 * in any cu.
 =09=09=09=09 */
 =09=09=09=09func =3D btf_encoder__find_function(encoder, name,
-=09=09=09=09=09=09=09=09  strlen(name));
+=09=09=09=09=09=09=09=09  strlen(name), addr);
 =09=09=09=09if (func) {
 =09=09=09=09=09if (encoder->verbose)
 =09=09=09=09=09=09printf("matched function '%s' with '%s'%s\n",
--=20
2.47.0



