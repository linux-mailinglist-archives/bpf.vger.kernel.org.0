Return-Path: <bpf+bounces-48438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36225A08058
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 20:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81DBA18899B7
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 19:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DA11922ED;
	Thu,  9 Jan 2025 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="bk0a7tKX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA1B18F2D8
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736449227; cv=none; b=OtJkfIpus3XjgMRil5f9Xqh0+hLpxANpLyYqhl5xaI886y5trLjpUfHutX0iY9hNXQmrogLoBXSsCdU727qrCY/gESQ3+D1rLufJyDGnyKZleVY0DhPrvM1zo5an4zLbWsnywTw/M4THKSEkqXX2O1iqd+cVZ6z37HtZUmPt68s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736449227; c=relaxed/simple;
	bh=iY8dxi18W8m0AjytMJ+3iiVxFLu8XdyPv+0o+KP8dGI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=js/D42tWiOAZGhzszKVh2dQsTn3y5HQeiKdaSwsCAmQwPqqqCXMJe0jtCq7azFgU8mvrLiOK3jry2Ib499tp9VcaDAfO1YBdEGiKz2/AbkjY4qy4HV9ORMQ9mfegITjoLVePNKZj+eNDdGTVJyRghduOxyvI5tixFphFjaXCjsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=bk0a7tKX; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736449209; x=1736708409;
	bh=iY8dxi18W8m0AjytMJ+3iiVxFLu8XdyPv+0o+KP8dGI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=bk0a7tKXrO+mpUo4V57CXwO3qBefMTor6e22DWyGB2tTh0Viigdh0ULe/2RBWzCnb
	 yYepdguYVcVly/conQ8kD7oX6I1nhA/cUU0SQD3ICnbvGw1sG4T15lF4n+ov67u54B
	 bmO6aNw7gm5hCzd1EFUoQ05+A4Mh/FxnXrW7Me4dVUQvW0hGXiQmvioToU3Q7ENyL8
	 +zFhohzuuoroaorgr1rgxsI/TrnMFUuwVR/4t0fTcGaaDpg+X4844c4jnUm/CQNs5x
	 lP9f2442Go/745ak4nma4m2G0MI8JjrnZ6DPrNHyMuoTncKtMTKfVDkcs/8ElQXz19
	 wLsiA4PDF81jw==
Date: Thu, 09 Jan 2025 19:00:04 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, olsajiri@gmail.com
Subject: [PATCH dwarves v4 RESEND 02/10] btf_encoder: free encoder->secinfo in btf_encoder__delete
Message-ID: <20250109185950.653110-3-ihor.solodrai@pm.me>
In-Reply-To: <20250109185950.653110-1-ihor.solodrai@pm.me>
References: <20250109185950.653110-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 08b356c7c7cc7d02ab43a2dbe9704412cf7decf2
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
index 0835848..6d8b78a 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2447,6 +2447,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 =09btf_encoders__delete(encoder);
 =09for (shndx =3D 0; shndx < encoder->seccnt; shndx++)
 =09=09__gobuffer__delete(&encoder->secinfo[shndx].secinfo);
+=09free(encoder->secinfo);
 =09zfree(&encoder->filename);
 =09zfree(&encoder->source_filename);
 =09btf__free(encoder->btf);
--=20
2.47.1



