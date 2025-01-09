Return-Path: <bpf+bounces-48443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFC1A0805D
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 20:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AF531889918
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 19:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7D41A8F97;
	Thu,  9 Jan 2025 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="gHDuRYNN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CE918B460;
	Thu,  9 Jan 2025 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736449249; cv=none; b=bAyPoNuhHKt0pq5FL+lG0VjA3askvKrdH4FeYjcDYcL54jNnoY73t7eRg4YuwvIFgwqOvJdLHFKCmhBIIur17TXlsfR8KskMa5j3CcNsxcSVyx6jmmPXDrex214Rq/QSglw2VJT7anwwbmz5FIjiYisi2u6xiq7E84z7E0WgrjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736449249; c=relaxed/simple;
	bh=7ovS2eeLPplqA/W3FmMin2daJhx7VohmQwMMXiEQ+RM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTe5bH58JPCqM2qS78/3e18Ba/vPyoZWfRECPwWgGCcV2b+MQoiiI13V4VbBu4xTkyqBPjmg22zO5jpWgbVSnB7e9Vp3ydllyTJb07W91fU4u8DFnazycAhegy424ahiO1zSgEWHLRafpQzs4eWsZAUkTni8SR5c7skkcMc5gl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=gHDuRYNN; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736449240; x=1736708440;
	bh=BHoWOF28SwETmN/kPdJjiJ0vWid8McdO7im7Usp3iGQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=gHDuRYNN1mQJek+QYNn3VGJr0ag2cxqgVwyh0muMEbp34IPNt5iVsu2jk5szX+3gY
	 KddJAAKQNYsrZEBaQwsCdLt2+RdL6bVAfI7OT1WKpEzv76wyYQWKwih2xeegm7ddAA
	 C6JWwfMDDiCvRQidAjhHqndVUOeBdeM9GNmx3/QPKd2vZvFNwSCI7YfQvsht1lE2p3
	 1aybBSYz3smUut3ehVIz+ltnQ30fSaYTR0mQj/p7KoFIRHlJ0PmMc79f1hYRI9Fk1+
	 yJSsSSaWTHr8pMRg5Rp8EDddxa7ECFIpBHLal8l5v5RrmjJPBftBZ1zWd56aqvlRjd
	 xzZYw3tj6ev+g==
Date: Thu, 09 Jan 2025 19:00:33 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, olsajiri@gmail.com
Subject: [PATCH dwarves v4 RESEND 07/10] dwarf_loader: introduce cu->id
Message-ID: <20250109185950.653110-8-ihor.solodrai@pm.me>
In-Reply-To: <20250109185950.653110-1-ihor.solodrai@pm.me>
References: <20250109185950.653110-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 97d1238c827e703429adf71db2b6ec323b9227f2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add an id member to the struct cu.

An id is an index of a CU, in order they are created in dwarf_loader.c
This allows for an easy identification of a CU, particularly when they
need to be processed in order.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 dwarf_loader.c | 5 +++++
 dwarves.h      | 1 +
 2 files changed, 6 insertions(+)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 34376b2..39e4cba 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3440,6 +3440,7 @@ struct dwarf_cus {
 =09int=09=09    build_id_len;
 =09int=09=09    error;
 =09struct dwarf_cu=09    *type_dcu;
+=09uint32_t=09nr_cus_created;
 };
=20
 struct dwarf_thread {
@@ -3472,6 +3473,9 @@ static struct dwarf_cu *dwarf_cus__create_cu(struct d=
warf_cus *dcus, Dwarf_Die *
 =09cu->priv =3D dcu;
 =09cu->dfops =3D &dwarf__ops;
=20
+=09cu->id =3D dcus->nr_cus_created;
+=09dcus->nr_cus_created++;
+
 =09return dcu;
 }
=20
@@ -3783,6 +3787,7 @@ static int cus__load_module(struct cus *cus, struct c=
onf_load *conf,
 =09=09=09.type_dcu =3D type_cu ? &type_dcu : NULL,
 =09=09=09.build_id =3D build_id,
 =09=09=09.build_id_len =3D build_id_len,
+=09=09=09.nr_cus_created =3D 0,
 =09=09};
 =09=09res =3D dwarf_cus__process_cus(&dcus);
 =09}
diff --git a/dwarves.h b/dwarves.h
index 0a4d5a2..b28a66e 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -290,6 +290,7 @@ struct cu {
 =09struct ptr_table functions_table;
 =09struct ptr_table tags_table;
 =09struct rb_root=09 functions;
+=09uint32_t=09 id;
 =09const char=09 *name;
 =09char=09=09 *filename;
 =09void =09=09 *priv;
--=20
2.47.1



