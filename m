Return-Path: <bpf+bounces-49437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78326A18A4C
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 03:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692433A7EFC
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 02:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A04514F9CC;
	Wed, 22 Jan 2025 02:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="onLQQatR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA77249F9
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 02:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737514435; cv=none; b=NU335GXHYwcHWINIa2LSrgNhoQGc5GTArEVhyBjpxcaILj944idkE88XyhkSOaioxv5ejFcbeOYvy78Q3NAahrZL1Fw/5ZegFMqJ5btiTH4vf50xbzYr8gLzEOLUXesrFby6WMuqWtZUvz0fod3TADL6rSc5WW01lm13vhVPZsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737514435; c=relaxed/simple;
	bh=s/zfE2/Yb0TNJkAx20PWXZ4g8tw3UeLlprb0Hdq2Muk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aM98WdhKHctLSp2vzSLjbwtIAin6cG6o8/X77rHECqlNGg/ntgBOaEx+yiWzvJOOCCLeKRp73tJ+/4TTLGxN2xCJkbGDbvL2bcGVRzsvUKq30gMwDxyiumZ1vW4l6yhKX/sJ8rCcPRJAQbK/HZKNvMaESH9Tj0Z/wv+EkJJWymY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=onLQQatR; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1737514426; x=1737773626;
	bh=3qIcp8yoIVJnnKL/G+BYfuNDWjkFyRigR83veERQouo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=onLQQatRaB9XtpEOzgU2Rc0S/X/36epP9KzxX0+zX+iPtXSv19tUu1Wb+w8wWKSeU
	 LD9dgTNbJi3HYMHPGG3X85JbT3paYsDcBmetEPHK9XuxEaU/FOf6IGYXElrd47Ulxv
	 NqUw8d6HE1OMaCLx4+kPiVtyDNyDrdYHSXZUMR/xintMoxi1gjWanZd0NsdZi4Qg/2
	 SpLbIEack+WfJpAis3Q7QRLXZok/y1U5wztjQjbBiO8WWf/OnxaQnxeWHNjLS5+ffa
	 TZL12vEcGjk/2X5cDiBK62ob/u1NijpzIyAPIUMgOH2OrZBzCeGPfJ0twy3BoeMQso
	 l1zBh8I3WQ7ew==
Date: Wed, 22 Jan 2025 02:53:40 +0000
To: bpf@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, jose.marchesi@oracle.com
Subject: [PATCH bpf-next 5/5] selftests/bpf: add a BTF verification test for kflagged type_tag
Message-ID: <20250122025308.2717553-6-ihor.solodrai@pm.me>
In-Reply-To: <20250122025308.2717553-1-ihor.solodrai@pm.me>
References: <20250122025308.2717553-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 66f1e394895e67c58a48b40a19c3130a831315aa
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add a BTF verification test case for a type_tag with a kflag set.
Type tags with a kflag are now valid.

Add BTF_DECL_ATTR_ENC and BTF_TYPE_ATTR_ENC test helper macros,
corresponding to *_TAG_ENC.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 19 ++++++++++++++++++-
 tools/testing/selftests/bpf/test_btf.h       |  6 ++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/s=
elftests/bpf/prog_tests/btf.c
index aab9ad88c845..8a9ba4292109 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3870,7 +3870,7 @@ static struct btf_raw_test raw_tests[] =3D {
 =09.raw_types =3D {
 =09=09BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),=09/* [1] */
 =09=09BTF_VAR_ENC(NAME_TBD, 1, 0),=09=09=09/* [2] */
-=09=09BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DECL_TAG, 1, 0), 2), (-=
1),
+=09=09BTF_DECL_ATTR_ENC(NAME_TBD, 2, -1),
 =09=09BTF_END_RAW,
 =09},
 =09BTF_STR_SEC("\0local\0tag1"),
@@ -4204,6 +4204,23 @@ static struct btf_raw_test raw_tests[] =3D {
 =09.btf_load_err =3D true,
 =09.err_str =3D "Type tags don't precede modifiers",
 },
+{
+=09.descr =3D "type_tag test #7, tag with kflag",
+=09.raw_types =3D {
+=09=09BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),=09/* [1] */
+=09=09BTF_TYPE_ATTR_ENC(NAME_TBD, 1),=09=09=09/* [2] */
+=09=09BTF_PTR_ENC(2),=09=09=09=09=09/* [3] */
+=09=09BTF_END_RAW,
+=09},
+=09BTF_STR_SEC("\0tag"),
+=09.map_type =3D BPF_MAP_TYPE_ARRAY,
+=09.map_name =3D "tag_type_check_btf",
+=09.key_size =3D sizeof(int),
+=09.value_size =3D 4,
+=09.key_type_id =3D 1,
+=09.value_type_id =3D 1,
+=09.max_entries =3D 1,
+},
 {
 =09.descr =3D "enum64 test #1, unsigned, size 8",
 =09.raw_types =3D {
diff --git a/tools/testing/selftests/bpf/test_btf.h b/tools/testing/selftes=
ts/bpf/test_btf.h
index fb4f4714eeb4..e65889ab4adf 100644
--- a/tools/testing/selftests/bpf/test_btf.h
+++ b/tools/testing/selftests/bpf/test_btf.h
@@ -72,9 +72,15 @@
 #define BTF_TYPE_FLOAT_ENC(name, sz) \
 =09BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), sz)
=20
+#define BTF_DECL_ATTR_ENC(value, type, component_idx)=09\
+=09BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_DECL_TAG, 1, 0), type), (comp=
onent_idx)
+
 #define BTF_DECL_TAG_ENC(value, type, component_idx)=09\
 =09BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_DECL_TAG, 0, 0), type), (comp=
onent_idx)
=20
+#define BTF_TYPE_ATTR_ENC(value, type)=09\
+=09BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_TYPE_TAG, 1, 0), type)
+
 #define BTF_TYPE_TAG_ENC(value, type)=09\
 =09BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_TYPE_TAG, 0, 0), type)
=20
--=20
2.48.1



