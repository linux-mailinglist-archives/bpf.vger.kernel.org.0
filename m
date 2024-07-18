Return-Path: <bpf+bounces-34979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E50879345E7
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 03:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71EC1C2149B
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 01:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7871B86FA;
	Thu, 18 Jul 2024 01:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="b1DGKJ+u"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6830B19E;
	Thu, 18 Jul 2024 01:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721267366; cv=none; b=tpiiyS95JTZhFsBDdtZg0hfub+jtHp1lIZUgKr2K5NfVEUykPKkdN5XgaGGiIL1mFC3nWuZl9RdCgw1Sp1RaRMhtDX7sXz8gqoMJExca/cJO2QRZMOHnVra6jnxuSlBnRzb9kCHSoEZnY+y67abB5FMqY9k9eyUusnHIYIv8/58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721267366; c=relaxed/simple;
	bh=Pi8/3jwy2l9+AmJtuYgshe/ziSNw878e7MeG21eo1K8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ur2mK5JYOW/vXbL+OWaB2U1MtRFIwL4X/Qq7HSb/IapNqRY5Y3p0taj/fctDoIlEASVtPZ8hQ2RaucSAXsDYlrQ0yeEpA0I7TUtUarHrGgMWDTsdtc1Jz0yVtfxImE1SQHJWoUuN4mQC1rMfF5l6fhOeax4spEzJHZ7rneW/Qj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=b1DGKJ+u; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1721267358;
	bh=1NRM7JcRwY2THxFpUefXrObhIbdMlndIp71Mh/8WNt0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b1DGKJ+ukjIW2SzPeEReZGJvUlAc1Ap9iBHztuyhoMDvKbVONNxoXP2AmaZQA1aVo
	 /+T5AZjarjTQ6Ys/07iveL72XVI5K8vKo3jZ2nre5HrwFCwIdUZjicGAEEbG+D68U/
	 tsghnJXQ90zjn0a3gbIXrNIEeDXXzsKD+ddRn0uVMCR1vcf5r45KeXrQf+h275QRxM
	 6kDO6nu4GgFVwJAqQYxYemF8QlS6+V69WU1NBC6QyI2ogU+MQEqfUH7d4tgm6kYYx9
	 Dma9Zb9Gc6lDkoZRS3DUCn+2bSoKZTS7UsxnuPJRkCzoibt0D3JjZMMsayoM9saY4z
	 BbSN3gvraoz/A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WPbMK4D5Sz4wbr;
	Thu, 18 Jul 2024 11:49:17 +1000 (AEST)
Date: Thu, 18 Jul 2024 11:49:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mark
 Brown <broonie@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Kui-Feng Lee
 <thinker.li@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 linux-input@vger.kernel.org, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20240718114916.7fab0442@canb.auug.org.au>
In-Reply-To: <20240710091344.2f3f2029@canb.auug.org.au>
References: <ZnB9X1Jj6c04ufC0@sirena.org.uk>
	<20240710091344.2f3f2029@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2M387VI3s81L9IdtWW7R0d/";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/2M387VI3s81L9IdtWW7R0d/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 10 Jul 2024 09:13:44 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Mon, 17 Jun 2024 19:15:59 +0100 Mark Brown <broonie@kernel.org> wrote:
> >
> > After merging the bpf-next tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >=20
> > /tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:280:16: error: ini=
tialization of 'int (*)(void *, struct bpf_link *)' from incompatible point=
er type 'int (*)(void *)' [-Werror=3Dincompatible-pointer-types]
> >   280 |         .reg =3D hid_bpf_reg,
> >       |                ^~~~~~~~~~~
> > /tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:280:16: note: (nea=
r initialization for 'bpf_hid_bpf_ops.reg')
> > /tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:281:18: error: ini=
tialization of 'void (*)(void *, struct bpf_link *)' from incompatible poin=
ter type 'void (*)(void *)' [-Werror=3Dincompatible-pointer-types]
> >   281 |         .unreg =3D hid_bpf_unreg,
> >       |                  ^~~~~~~~~~~~~
> > /tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:281:18: note: (nea=
r initialization for 'bpf_hid_bpf_ops.unreg')
> >=20
> > Caused by commit
> >=20
> >   73287fe228721b ("bpf: pass bpf_struct_ops_link to callbacks in bpf_st=
ruct_ops.")
> >=20
> > interacting with commit
> >=20
> >   ebc0d8093e8c97 ("HID: bpf: implement HID-BPF through bpf_struct_ops")
> >=20
> > from the HID tree.
> >=20
> > I've fixed it up as below:
> >=20
> > From e8aeaba00440845f9bd8d6183ca5d7383a678cd3 Mon Sep 17 00:00:00 2001
> > From: Mark Brown <broonie@kernel.org>
> > Date: Mon, 17 Jun 2024 19:02:27 +0100
> > Subject: [PATCH] HID: bpf: Fix up build
> >=20
> > Fix up build error due to 73287fe228721b ("bpf: pass bpf_struct_ops_lin=
k to callbacks in bpf_struct_ops.")
> >=20
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > ---
> >  drivers/hid/bpf/hid_bpf_struct_ops.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid=
_bpf_struct_ops.c
> > index 5f200557ff12b..744318e7d936b 100644
> > --- a/drivers/hid/bpf/hid_bpf_struct_ops.c
> > +++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
> > @@ -175,7 +175,7 @@ static int hid_bpf_ops_init_member(const struct btf=
_type *t,
> >  	return 0;
> >  }
> > =20
> > -static int hid_bpf_reg(void *kdata)
> > +static int hid_bpf_reg(void *kdata, struct bpf_link *link)
> >  {
> >  	struct hid_bpf_ops *ops =3D kdata;
> >  	struct hid_device *hdev;
> > @@ -229,7 +229,7 @@ static int hid_bpf_reg(void *kdata)
> >  	return err;
> >  }
> > =20
> > -static void hid_bpf_unreg(void *kdata)
> > +static void hid_bpf_unreg(void *kdata, struct bpf_link *link)
> >  {
> >  	struct hid_bpf_ops *ops =3D kdata;
> >  	struct hid_device *hdev;
> > --=20
> > 2.39.2
> >  =20
>=20
> This fixup is now required when the hid and next-next trees are merged.

And now this is needed when the hid tree is merged with Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/2M387VI3s81L9IdtWW7R0d/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmaYdJwACgkQAVBC80lX
0Gzm4gf+K5Eaw1hvi2atamuIucgJDjivmNzXb3gDTrIWxAwufU6uM61blbV8fBJ2
H7ZcSIvsPD51QsazauCN77Xcgt80KMlhCAYixSXqoz9LU9+k5w29S7hXdseL/HYS
hlFFw1BPtnTlPx6pzXEtq6z0MxUFoif3/D6j0wWFJLFx3DQsLGCOdxVtOnQ0hboA
pFFzgZ9XKnYGhqRqpbCn/AXyFb6rgwzUM0gbgLCIoQDGfWchYfeD6Wi/+j9vGDTI
Kr4x4nUlxlt0a+FdLKHAerlAOU49cUdhMuAxsTAA0SbJCRZNm/VcevAMNMD7arH0
7ANk3vvbMrFCAYZspujkNW2ggjRC6w==
=1aIh
-----END PGP SIGNATURE-----

--Sig_/2M387VI3s81L9IdtWW7R0d/--

