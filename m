Return-Path: <bpf+bounces-21349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D981884B94F
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 16:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DEE287B63
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 15:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19625134CCB;
	Tue,  6 Feb 2024 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soXgTDT0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC691339B4;
	Tue,  6 Feb 2024 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232599; cv=none; b=qRSluzhVm1kx0pz1T8vzQC+1/7Q1SgPeueAyT9rfFwbZbX/dAhFOv8jmGGN//GDap5VxTWLEth2xUhO/0Qy05y3/yF8G1eTzVwY4qHNOgcSOYsQbZVLcRhXlH4chsXyeruDxiw+RpIzEUV+YrDkZDqXzHUtfSm1r2R6ykyNzDz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232599; c=relaxed/simple;
	bh=XsdWdytMvZwMcahXMHmv2mp3rx181G3KH+mF9flZX3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JifCunmbB9e9yExZmMO7BfbXBTr/56ckHDnBoU9bUJM3cHWPr4IJMwfOvKTMJFb6MYAQsy84onlAAdD5la1GALiFsNY9ytOFQtDIl7vOrFZIUZ54awr/9yKVDk9E7G/E3eDXBF6EI0UqK93cQbydxNBFS/fRRO7S5/leKdpOyE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soXgTDT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867FFC433C7;
	Tue,  6 Feb 2024 15:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707232599;
	bh=XsdWdytMvZwMcahXMHmv2mp3rx181G3KH+mF9flZX3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=soXgTDT0fJoGfMxzBL/HEFMqwmY4B1PXFEANujlNcYYQR0E0WP8GGHpKcb3zQRVhm
	 HaZuByk5hj7MffetrWFZnjrD0DyFs9oOUI4kH9l6tTNsaavu2b/Xp4Z3wB86Gr5nxz
	 LQLk9BMkE1ts083FWnD+6J6FvSNyqLyxd2BpR0OaroSyqxIYlDRBrIIui0wNKE531A
	 AEg5A/U+DyW3U/dTWwXGE7zWtYsSz9l2HndvAoIQ4ph+ZGxzNhR4LUDz7KlNSmzup5
	 +aIrrpbQzBpiUdM5/H1iX+tx1/sC+Tcjbio16xpeQVyaCYIKipCDoy8mcyGJVCghSr
	 72O95WKBFEVSg==
Date: Tue, 6 Feb 2024 16:16:35 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, netdev@vger.kernel.org,
	maciej.fijalkowski@intel.com, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, j.vosburgh@gmail.com, andy@greyhouse.net,
	hawk@kernel.org, john.fastabend@gmail.com, edumazet@google.com,
	bpf@vger.kernel.org, Prashant Batra <prbatra.mail@gmail.com>
Subject: Re: [PATCH net] bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY
Message-ID: <ZcJNUyUV_Z-GkFBV@lore-desk>
References: <20240205123011.22036-1-magnus.karlsson@gmail.com>
 <87le7zvz1o.fsf@toke.dk>
 <CAJ8uoz03-AcOwMj3-20ritbYQT9CSJMQ8oz6OuhyE-U=2F7+Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zCzGVAeTNowh1sME"
Content-Disposition: inline
In-Reply-To: <CAJ8uoz03-AcOwMj3-20ritbYQT9CSJMQ8oz6OuhyE-U=2F7+Gg@mail.gmail.com>


--zCzGVAeTNowh1sME
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 5 Feb 2024 at 14:08, Toke H=F8iland-J=F8rgensen <toke@redhat.com>=
 wrote:
> >
> > Magnus Karlsson <magnus.karlsson@gmail.com> writes:
> >
> > > From: Magnus Karlsson <magnus.karlsson@intel.com>
> > >
> > > Do not report the XDP capability NETDEV_XDP_ACT_XSK_ZEROCOPY as the
> > > bonding driver does not support XDP and AF_XDP in zero-copy mode even
> > > if the real NIC drivers do.
> > >
> > > Fixes: cb9e6e584d58 ("bonding: add xdp_features support")
> > > Reported-by: Prashant Batra <prbatra.mail@gmail.com>
> > > Link: https://lore.kernel.org/all/CAJ8uoz2ieZCopgqTvQ9ZY6xQgTbujmC6Xk=
MTamhp68O-h_-rLg@mail.gmail.com/T/
> > > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > > ---
> > >  drivers/net/bonding/bond_main.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bo=
nd_main.c
> > > index 4e0600c7b050..79a37bed097b 100644
> > > --- a/drivers/net/bonding/bond_main.c
> > > +++ b/drivers/net/bonding/bond_main.c
> > > @@ -1819,6 +1819,8 @@ void bond_xdp_set_features(struct net_device *b=
ond_dev)
> > >       bond_for_each_slave(bond, slave, iter)
> > >               val &=3D slave->dev->xdp_features;
> > >
> > > +     val &=3D ~NETDEV_XDP_ACT_XSK_ZEROCOPY;
> > > +
> > >       xdp_set_features_flag(bond_dev, val);
> > >  }
> > >
> > > @@ -5910,8 +5912,10 @@ void bond_setup(struct net_device *bond_dev)
> > >               bond_dev->features |=3D BOND_XFRM_FEATURES;
> > >  #endif /* CONFIG_XFRM_OFFLOAD */
> > >
> > > -     if (bond_xdp_check(bond))
> > > +     if (bond_xdp_check(bond)) {
> > >               bond_dev->xdp_features =3D NETDEV_XDP_ACT_MASK;
> > > +             bond_dev->xdp_features &=3D ~NETDEV_XDP_ACT_XSK_ZEROCOP=
Y;
> > > +     }
> >
> > Shouldn't we rather drop this assignment completely? It makes no sense
> > to default to all features, it should default to none...
>=20
> Good point. Seems the bond device defaults to supporting everything
> before a device is bonded to it, but I might have misunderstood
> something. Lorenzo, could you enlighten us please?

ack, I agree we can get rid of it since the xdp features will be calculated
again as soon as a new device is added to the bond.

Regards,
Lorenzo

>=20
> Thanks: Magnus
>=20
> > -Toke
> >

--zCzGVAeTNowh1sME
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZcJNUwAKCRA6cBh0uS2t
rOwhAP4jhkFuBEZcqF9xSUby4YHotziOFQIxCywPqt14NCAi2wD+L6fT4PUkSWG2
30f3jtqBO/mUEzEtfuHPBSioojO1qAw=
=Z2iv
-----END PGP SIGNATURE-----

--zCzGVAeTNowh1sME--

