Return-Path: <bpf+bounces-49523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C52A1986A
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 19:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9189165B1A
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 18:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC4321518C;
	Wed, 22 Jan 2025 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="BoFHy6rS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4E2212F93
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737570357; cv=none; b=G8AbxzNKdFJEQtTFUB0dgGyE4QKHE+CP6d79pDyyQcV2AHfkY43yn5hs8DtT6Y2zGlPzywsj9PghkPGNsrBboXMj8l+gH2E24UJyHhd3L2UUNDiJgHOtFgC1qvaB8JRgw2H3kF1/DtJ9b3BnwnZoAz9rsBlBipvEUwW085a6Nio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737570357; c=relaxed/simple;
	bh=vA/Tpkmrs038ZKQV/UHgtbVl1TLob6IyyQPTLW/RUM4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IP8in5OxHDCj54gQbkz6nfZh2WhVcRCPJQtR17mfcR1JdwoNscGfmzDXJZeG8Dq7kx7ZUT/2sZ8bCXtTxJIZ1hcvkBF7Ii39faHqB4OChcOxY1CfMY6OBZtRoWUCVLpKa9lf4rFXC35G+SmDjjsobqBL0PQAmAHe8Ojl+XqfrLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=BoFHy6rS; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1737570352; x=1737829552;
	bh=WrqmV56Z1QRAIVaKRQ211G3q+/f/vZz7RFUjG8lCa9s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=BoFHy6rSwnkVhUrqVtSwn14N0Wb5rPfkFsVjJfy7t1rRB3yi6ZQLfQzKcQeaCS6qx
	 jSzAcW6uLSrmLr9sEICOax5fZ3n6fpe0YE7jMmHIK9ztaQzmwysGAwIKL9oNAnjUCs
	 kP3w4/qMDcUPWgnryOJ9TtEynsEJR0ip8Yvj/Z6TrAAtk2L7dCOfnZs14dOkzWnd22
	 JMvpeq/YASpGf4UfpeeR0K83wrQ8m6uN9B2SFIpZ3tJ9/N4vdQmLSMaJ67smFbLRAu
	 k+Q3CgtydUwg0G17/zA1n+CaF0qmVRwQL/ZFu+3mncwPAEInAKDutPj0I78AjFzgdp
	 i/dD4biCoaWLw==
Date: Wed, 22 Jan 2025 18:25:45 +0000
To: Alan Maguire <alan.maguire@oracle.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, jose.marchesi@oracle.com
Subject: Re: [PATCH bpf-next 4/5] bpf: allow kind_flag for BTF type and decl tags
Message-ID: <idL8a_Xx8Egdif45vNKYwEXdmswHysFIWXM13SVV-D74fgRqiyMjcZLx5vaoM1RaQ8WktwoLQvqliBsWElka50Wzdrx-3xCtQ1a40nH48Fw=@pm.me>
In-Reply-To: <6cd15fc6-3149-4898-af40-6917f713f053@oracle.com>
References: <20250122025308.2717553-1-ihor.solodrai@pm.me> <20250122025308.2717553-5-ihor.solodrai@pm.me> <6cd15fc6-3149-4898-af40-6917f713f053@oracle.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 21874931774cf342253ab6a570f411a9f42a86a0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, January 22nd, 2025 at 3:09 AM, Alan Maguire <alan.maguire@ora=
cle.com> wrote:

>=20
>=20
> On 22/01/2025 02:53, Ihor Solodrai wrote:
>=20
> > BTF type tags and decl tags now may have info->kflag set to 1,
> > changing the semantics of the tag.
> >=20
> > Change BTF verification to permit BTF that makes use of this feature:
> > * remove kflag check in btf_decl_tag_check_meta(), as both values
> > are valid
> > * allow kflag to be set for BTF_KIND_TYPE_TAG type in
> > btf_ref_type_check_meta()
> >=20
> > Modify a selftest checking for kflag in decl_tag accordingly.
> >=20
> > Signed-off-by: Ihor Solodrai ihor.solodrai@pm.me
>=20
>=20
> Looks good, but I have a few questions here. Today in btf_struct_walk()
> we check pointer type tags like this:
>=20
> /* check type tag */
> t =3D btf_type_by_id(btf, mtype->type);
>=20
> if (btf_type_is_type_tag(t)) {
> tag_value =3D __btf_name_by_offset(btf,
> t->name_off);
>=20
> /* check __user tag /
> if (strcmp(tag_value, "user") =3D=3D 0)
> tmp_flag =3D MEM_USER;
> / check __percpu tag /
> if (strcmp(tag_value, "percpu") =3D=3D 0)
> tmp_flag =3D MEM_PERCPU;
> / check __rcu tag */
> if (strcmp(tag_value, "rcu") =3D=3D 0)
> tmp_flag =3D MEM_RCU;
> }
>=20
>=20
> Do we need to add in a check for kind_flag =3D=3D 0 here to ensure it's a
> BTF type tag attribute? Similar question for type tag kptr checking in
> btf_find_kptr() (we could perhaps add a btf_type_is_btf_type_tag() or
> something to include the kind_flag =3D=3D 0 check).

Yes, we should check for kflag here. Thanks for pointing this out.

    __attribute__((user))
vs
    __attribute__((bpf_type_tag("user")))

are very different things.

>=20
> And I presume the btf_check_type_tags() logic still applies for generic
> attributes - i.e. that they always precede the modifiers in the chain?

Yes, that is my understanding too.

>=20
> [...]

