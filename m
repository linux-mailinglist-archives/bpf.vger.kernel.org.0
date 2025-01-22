Return-Path: <bpf+bounces-49434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17567A18A49
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 03:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5AB3169C1E
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 02:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8924E14F9F9;
	Wed, 22 Jan 2025 02:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="BlydKpL/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7325C14F125
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 02:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737514420; cv=none; b=QAONvsQwoEnlS/MBQe6/sv9N+slEBI0vRoRTdNr9AkqaOrCyXMYSWl1V5YMHuQJ2APHuj5AndVB25OPK9uu8vi7vbBbBIDvrvj8dsacfoUKltLPdoVQi5cR032W4WyrdxPY1bhRWmqdb16I42urzUxEb6KH2x+VKZ2gglNCW2cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737514420; c=relaxed/simple;
	bh=RuhFxQ+NTeF6mB6P04+lHasNUIWGScBCvEOukRBbmPg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9aETSRJRm5AHoR3wBeCVK1fYX2mWo7DtBfHjdSh68BesyvQrsqgAYaEcucB1ToNWufc3Mz6PbEXwf0MCoXcP69WCoinWeihpJy9tXMBcjvsrVe3h20nR5c83jYuMGeSVGf18lakMSAy1skRY+dF8jP4nGkAauMdcawfgtemlME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=BlydKpL/; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1737514410; x=1737773610;
	bh=RuhFxQ+NTeF6mB6P04+lHasNUIWGScBCvEOukRBbmPg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=BlydKpL/DQCQyrdtg++VRLK+CXJMVmyMEuZZIzzfefucczSju5icVtl6dDxgIbJHP
	 qxlARVShX1kjQ80t1QBrpKXRYyL8NKaMfD6D1V2LuM1xCheETNBeUkSTexj8V5B0hF
	 Ta2nN4TYLn6sqXvaMXwvFMgdvoc5bT1XMyCvl6+CtvzzDW3nKbk6zvladtFCeM2YDl
	 ZfdVZifnfBA+ZNh6FYsXeY47uDD4t1waV4sJNc9jMi74LcpytzGyFC0NbKw0SNP7B2
	 sWC5xUerzjrx1TajqhA08Suw/MhveD0OuktCCOHLj30shLuHvjc9IvgYD6NWuIIRnV
	 D63dPAV4Ygyhg==
Date: Wed, 22 Jan 2025 02:53:25 +0000
To: bpf@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, jose.marchesi@oracle.com
Subject: [PATCH bpf-next 2/5] libbpf: check the kflag of type tags in btf_dump
Message-ID: <20250122025308.2717553-3-ihor.solodrai@pm.me>
In-Reply-To: <20250122025308.2717553-1-ihor.solodrai@pm.me>
References: <20250122025308.2717553-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 5f3aa5a34393c5afc2e5de2e01a9c6561e796a5c
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

If the kflag is set for a BTF type tag, then the tag represents an
arbitrary __attribute__. Change btf_dump accordingly.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 tools/lib/bpf/btf_dump.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index a3fc6908f6c9..460c3e57fadb 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1494,7 +1494,10 @@ static void btf_dump_emit_type_chain(struct btf_dump=
 *d,
 =09=09case BTF_KIND_TYPE_TAG:
 =09=09=09btf_dump_emit_mods(d, decls);
 =09=09=09name =3D btf_name_of(d, t->name_off);
-=09=09=09btf_dump_printf(d, " __attribute__((btf_type_tag(\"%s\")))", name=
);
+=09=09=09if (btf_kflag(t))
+=09=09=09=09btf_dump_printf(d, " __attribute__((%s))", name);
+=09=09=09else
+=09=09=09=09btf_dump_printf(d, " __attribute__((btf_type_tag(\"%s\")))", n=
ame);
 =09=09=09break;
 =09=09case BTF_KIND_ARRAY: {
 =09=09=09const struct btf_array *a =3D btf_array(t);
--=20
2.48.1



