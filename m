Return-Path: <bpf+bounces-46959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ED79F1A17
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3978516B5EC
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23671C9DCB;
	Fri, 13 Dec 2024 23:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="C8fDi51g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FEB1A8F7F
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 23:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132739; cv=none; b=qEWp63OohNlf7NoElcnvQLxJfKIbCkrp8Q5tXWV/VnmSNOXv9bvhM1N8NVkGTP7vsO8jg0TGE/iotn5/pHql+Jik9zQ0yhtgpFpGou/MyCl+G9/0KTmyK7lirBmsSbAZoQdg5v+bPC1bcMjN4Q6BfnuZY9MOeKR7iOFgppSeEj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132739; c=relaxed/simple;
	bh=5q/VMlO3zNE/BuxwZYm0y4hReSKTI9Tl064zjIRnM8A=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=t9nll22CEFYx+S4BB1+7tIrc+pWPA6JjXn6JvvFv4/OdHApIM6TrMdtXz3jhB7OoJV+U0xvz7jqxXoM9fgDn5liXjMAXLkTIebmS6EqDL3ZWzvfuZjqLacygpePymN8Iy7CFh431nnlcCkSymJQt4srKZ+hgjW0XBcKX87AXZgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=C8fDi51g; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734132735; x=1734391935;
	bh=4wa09Pjyf/VYrCvmWhZ+rDy4O5NesqDpetb9XCxl0k8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=C8fDi51guNjPwOH5V0R8lFL+OWxWW4ybwJEEYiv74wx77MvWvSFq4gtvuCybW9+Hb
	 YNlbDfMnAD3AvvJ05kuTG0GC/e9qsllTiHixAOAuuwq00s3p6zR3auCVHmQAd4J/+v
	 ii0E78+ywhAyzIGdTTbYr0jNWE3TieUgPUcWfuHgyywkZAOe61S+RVS3id41MbI5zY
	 bEfirCB6cSlQpAfZp3ldanVDMD9Sox4qccF+em6KgAhvq318UXBP+Ur6htAvwJLkKV
	 9s8gvhnd612YroLSHZ0LjFTairpMqGSVnl7s7KzIesjXLhkS4q6irK9ngL6nXqFCHa
	 Cy4P+rWhDKZ8g==
Date: Fri, 13 Dec 2024 23:32:09 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: [PATCH dwarves] btf_encoder: fix memory access bugs
Message-ID: <20241213233205.633927-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 42b5f6a4961fc8dca5f0da61cbca1ad16690e9c6
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

When compiled with address sanitizer, a couple of errors were reported
on pahole BTF encoding:
  * A memory leak of strdup(func->alias), due to unchecked
    reassignment.
  * A read of uninitialized memory in gobuffer__sort or bsearch in
    case btf_funcs gobuffer is empty.

Used compiler flags:
    -fsanitize=3Dundefined,address
    -fsanitize-recover=3Daddress
    -fno-omit-frame-pointer

I stumbled on these while working on [1].

[1] https://lore.kernel.org/dwarves/20241213223641.564002-1-ihor.solodrai@p=
m.me/

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 3754884..520ff58 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1793,6 +1793,9 @@ static int btf_encoder__collect_btf_funcs(struct btf_=
encoder *encoder, struct go
 =09=09=09goto out;
 =09}
=20
+=09if (gobuffer__nr_entries(funcs) <=3D 0)
+=09=09return 0;
+
 =09/* Now that we've collected funcs, sort them by name */
 =09gobuffer__sort(funcs, sizeof(struct btf_func), btf_func_cmp);
=20
@@ -1954,6 +1957,11 @@ static int btf_encoder__tag_kfuncs(struct btf_encode=
r *encoder)
 =09=09goto out;
 =09}
=20
+=09if (gobuffer__nr_entries(&btf_funcs) <=3D 0) {
+=09=09err =3D 0;
+=09=09goto out;
+=09}
+
 =09/* First collect all kfunc set ranges.
 =09 *
 =09 * Note we choose not to sort these ranges and accept a linear
@@ -2607,7 +2615,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
r, struct cu *cu, struct co
 =09=09=09=09=09=09       ", has optimized-out parameters" :
 =09=09=09=09=09=09       fn->proto.unexpected_reg ? ", has unexpected regi=
ster use by params" :
 =09=09=09=09=09=09       "");
-=09=09=09=09=09func->alias =3D strdup(name);
+=09=09=09=09=09if (!func->alias)
+=09=09=09=09=09=09func->alias =3D strdup(name);
 =09=09=09=09}
 =09=09=09}
 =09=09} else {
--=20
2.47.1



