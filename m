Return-Path: <bpf+bounces-48159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C45A049E9
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 20:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331E6188808A
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 19:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866D71F429A;
	Tue,  7 Jan 2025 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="PCB2LT2W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185531F4E29;
	Tue,  7 Jan 2025 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736276966; cv=none; b=Inx7uQU9VXQ0P/BoSQpA4ali5URGYMHX7tvmZ3zJgQLVyZ1jRfKOro4I1sITCPgMzziX2HJWf9koEfp5IWkVwpA6mbMYQz1RawW5ZlWuB8oyVqgjZ/jpHVbBUTTJbk2FAtt3q2iqErgugSdYoQdymwM0GsyHph9T53NdY1yKsxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736276966; c=relaxed/simple;
	bh=LSXxYJXI1/a5lYvOsKGKTi34t3dhW6RnI45SOWi99cY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eqE/JkxQhH2TiD924NGFgwWJLGpfFR0GUZOYjAtv1c24IcGx5/i1+Zt50CyoIna0c0QRTaZsSw4/ZgtyvekrbDxInR1PqPwo0ZnGXdtp2R8iJJD54TsTaYKWtPatLFngwIU40hmDSgi4Gz6IA9dJosdn7Ey8DCHygJob3qbyUSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=PCB2LT2W; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736276954; x=1736536154;
	bh=LSXxYJXI1/a5lYvOsKGKTi34t3dhW6RnI45SOWi99cY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=PCB2LT2WBZJqq0uJ7yABUZdbsW27WlQTM9k0F2Cq0rgPQgFrBYgpsBkWBwZORPvoi
	 DoscldOChLMe4k8BPW+j0I7k/xreOg76Jn/2GQvMzqtgQzUCdv0RdE1qiXHeAVVcKl
	 MyKd7xFox4yaD24YSQCj4uPmiBxdPoIZf5pG/bZoPAF7NRzUGh2nWhZ6z1wCCZl8tu
	 RBUUjqCeumlmCy9L2foKs4hZvgL8ZeDWVlYLqWYVa1vGwvE7pnp0+Si3LHJSQkzsdJ
	 tTiJ0JR0XJDvhGH9DaRUrWoZEYYzwmahXJa1jDkFzdIJldMIG8xsIMaLB6Akg//waG
	 9q/vHqJOPbjIw==
Date: Tue, 07 Jan 2025 19:09:10 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, olsajiri@gmail.com
Subject: [PATCH dwarves v4 02/10] btf_encoder: free encoder->secinfo in btf_encoder__delete
Message-ID: <20250107190855.2312210-3-ihor.solodrai@pm.me>
In-Reply-To: <20250107190855.2312210-1-ihor.solodrai@pm.me>
References: <20250107190855.2312210-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: cbbe895be26f12b3128991d6b620b2fe614d5f46
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

encoder->secinfo is allocated in btf_encoder__new and is
never freed. Fix that.

Link: https://lore.kernel.org/dwarves/YiiVvWJxHUyK75b4FqlvAOnHvX9WLzCsRLG-2=
36zf_cPZy1jmgbUq2xM4ChxRob1kaTVUdtVljtcpL2Cs3v1wXPGcP8dPeASBiYVGH3jEaQ=3D@p=
m.me/

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 2e51afd..6720065 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2453,6 +2453,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 =09btf_encoders__delete(encoder);
 =09for (shndx =3D 0; shndx < encoder->seccnt; shndx++)
 =09=09__gobuffer__delete(&encoder->secinfo[shndx].secinfo);
+=09free(encoder->secinfo);
 =09zfree(&encoder->filename);
 =09zfree(&encoder->source_filename);
 =09btf__free(encoder->btf);
--=20
2.47.1



