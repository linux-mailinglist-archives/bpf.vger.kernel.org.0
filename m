Return-Path: <bpf+bounces-34308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8215692C67A
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 01:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D83E1F23246
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 23:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F26189F58;
	Tue,  9 Jul 2024 23:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nbK3HdcT"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FA7189F29;
	Tue,  9 Jul 2024 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720566833; cv=none; b=nox3/D7Lw+pcwF71iQph7enuuBll6M2hzDt2MehZL11cGi62T8DPjpIWNudBnIwRsCgHP8q6zZ1rliqoUE/SnUzy4X0OLsyXlKc7UUcxBV54lmEp0WDY91pdh6P6KWH7y9OA3q2QGwZjpWjW2J2+jCn2NQZXxG+S2N0F04zCam0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720566833; c=relaxed/simple;
	bh=Vrtwyvvcok8rdSqrLccJzn/vihZP5iwSppy/+5s1ZiU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATag72WEpgUdmJZo/lq7jfzGGgBDd3hR3xenSBUv97A35ck4XF5+YDWk8ITbtikNNPzhy24mgWILnK0I3zqlyrxL0ngMgMwBFgzRR24T0RB49VU2CmBPzEzX4sDfPEF1RMvXZx32AXwea91mTjDbr56eyypt6NEO6bcLN4dPF4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=nbK3HdcT; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1720566827;
	bh=BW+kkZ8KoIib99Gf2CbQkBtcvjYhYfxcs95t5irr91E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nbK3HdcT//ExOn7CC/VSdafLP/Iiy26shFTIgO76xfKZapcPQIHEOcVCBEszlL9sm
	 wMx4To8AOZg+Lw1aFmNJTldbxcuyCaAKOIQVLl0xjykqWdxf2XMekWZUYmvjOsZlZt
	 vsYui04bMWLAqrEzsOI7HQ3e9if+buentsB6yzhhD1xF4j43sKGr/9GURivXyDHnKa
	 xWRzGwAN+J68fDlvhhYEDkDDIjnNGm10zUXzgjzf81MWMywaUAyTMGAK7PNIVY50Dt
	 pNtffdgEsnAFoNneeRajqLEg47sxcSyo10dxFMDdePR7l2PWqLm9i+bUntbA7cEUDl
	 +sOIechAaOmbg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WJcHY2q3Kz4w2R;
	Wed, 10 Jul 2024 09:13:45 +1000 (AEST)
Date: Wed, 10 Jul 2024 09:13:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: Mark Brown <broonie@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Kui-Feng
 Lee <thinker.li@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 linux-input@vger.kernel.org, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20240710091344.2f3f2029@canb.auug.org.au>
In-Reply-To: <ZnB9X1Jj6c04ufC0@sirena.org.uk>
References: <ZnB9X1Jj6c04ufC0@sirena.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nUo.gqzJLx6EQt90p5bS1T.";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/nUo.gqzJLx6EQt90p5bS1T.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 17 Jun 2024 19:15:59 +0100 Mark Brown <broonie@kernel.org> wrote:
>
> After merging the bpf-next tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> /tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:280:16: error: initi=
alization of 'int (*)(void *, struct bpf_link *)' from incompatible pointer=
 type 'int (*)(void *)' [-Werror=3Dincompatible-pointer-types]
>   280 |         .reg =3D hid_bpf_reg,
>       |                ^~~~~~~~~~~
> /tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:280:16: note: (near =
initialization for 'bpf_hid_bpf_ops.reg')
> /tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:281:18: error: initi=
alization of 'void (*)(void *, struct bpf_link *)' from incompatible pointe=
r type 'void (*)(void *)' [-Werror=3Dincompatible-pointer-types]
>   281 |         .unreg =3D hid_bpf_unreg,
>       |                  ^~~~~~~~~~~~~
> /tmp/next/build/drivers/hid/bpf/hid_bpf_struct_ops.c:281:18: note: (near =
initialization for 'bpf_hid_bpf_ops.unreg')
>=20
> Caused by commit
>=20
>   73287fe228721b ("bpf: pass bpf_struct_ops_link to callbacks in bpf_stru=
ct_ops.")
>=20
> interacting with commit
>=20
>   ebc0d8093e8c97 ("HID: bpf: implement HID-BPF through bpf_struct_ops")
>=20
> from the HID tree.
>=20
> I've fixed it up as below:
>=20
> From e8aeaba00440845f9bd8d6183ca5d7383a678cd3 Mon Sep 17 00:00:00 2001
> From: Mark Brown <broonie@kernel.org>
> Date: Mon, 17 Jun 2024 19:02:27 +0100
> Subject: [PATCH] HID: bpf: Fix up build
>=20
> Fix up build error due to 73287fe228721b ("bpf: pass bpf_struct_ops_link =
to callbacks in bpf_struct_ops.")
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/hid/bpf/hid_bpf_struct_ops.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/bpf/hid_bpf_struct_ops.c b/drivers/hid/bpf/hid_b=
pf_struct_ops.c
> index 5f200557ff12b..744318e7d936b 100644
> --- a/drivers/hid/bpf/hid_bpf_struct_ops.c
> +++ b/drivers/hid/bpf/hid_bpf_struct_ops.c
> @@ -175,7 +175,7 @@ static int hid_bpf_ops_init_member(const struct btf_t=
ype *t,
>  	return 0;
>  }
> =20
> -static int hid_bpf_reg(void *kdata)
> +static int hid_bpf_reg(void *kdata, struct bpf_link *link)
>  {
>  	struct hid_bpf_ops *ops =3D kdata;
>  	struct hid_device *hdev;
> @@ -229,7 +229,7 @@ static int hid_bpf_reg(void *kdata)
>  	return err;
>  }
> =20
> -static void hid_bpf_unreg(void *kdata)
> +static void hid_bpf_unreg(void *kdata, struct bpf_link *link)
>  {
>  	struct hid_bpf_ops *ops =3D kdata;
>  	struct hid_device *hdev;
> --=20
> 2.39.2
>=20

This fixup is now required when the hid and next-next trees are merged.

--=20
Cheers,
Stephen Rothwell

--Sig_/nUo.gqzJLx6EQt90p5bS1T.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmaNxCgACgkQAVBC80lX
0GylkQgAg+KPPYF28lobbZkLK4gLI+IipLqiHb+YPyUH5vxdc1vuNIdhhPqvMlnP
n04jceDCJPWKDJXkvJ0wSmqWz33UJPT74U8gXqWKLnmrVmgM9Cj5JeZwf4XMg3XK
CpvEt5Ia0OnsmxMrlMbTDHAKhRz02A6dxnRNnREzjBNTNnGToI42ILsUFUajI3j1
4jl3j/1yXUSpjzmrYQ9gO8HgaFb0+INKnDhQp+nBx3zrUKFIhS4RJtXn5WefWLQ1
9tuerbK98tPW8EkUSo9GcS4Yp0rNo3nfICq/MklSMu0PKCSCqzHhECyf8BPBL/JR
lmehud0pVx1aZMwkR+zBiklikMNcGw==
=u3Nj
-----END PGP SIGNATURE-----

--Sig_/nUo.gqzJLx6EQt90p5bS1T.--

