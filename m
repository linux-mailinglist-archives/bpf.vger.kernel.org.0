Return-Path: <bpf+bounces-40942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 073229905D1
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 16:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1F51F22DFE
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 14:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50151215F6A;
	Fri,  4 Oct 2024 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARk+eqzg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB119381AF;
	Fri,  4 Oct 2024 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051500; cv=none; b=R6uBnUWPSzGULizZVhofayGiWmh1jPeB4mQCCkjlaju5Mvyh4okwVi5dxz8ZpJmnWO1mz2g2IAnq8blASbmtQXG5sIl6f49FGNccs74podhSDQTkzXDZOKQlLmu1WhV9hwszcykaWojbId5G1IUHfN5ELd1mEbq3CkgT8okVDoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051500; c=relaxed/simple;
	bh=4kvEOwxD0KmLhLBIGFcwqKxiF4pucCN8YvTgTZKsDI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWaLJztfQMDZ9KxQSmB4wm+WOkIETIcdH1irWrFqAqhTVjHx6ebnNQJOaMXb6iMPaY3jLrPkhiZE5+0u7JMm0JrRf8yeoJwxIlKNEpSeY1JLL+smVmgMnO4ScW6xpx8yGMKKZcdFH6en9/+6gQDdtuH4+ZMS0/mDyAyEQdwttPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARk+eqzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46E9C4CEC7;
	Fri,  4 Oct 2024 14:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728051499;
	bh=4kvEOwxD0KmLhLBIGFcwqKxiF4pucCN8YvTgTZKsDI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ARk+eqzgybEFCfVHWaZ6qsXg76DeOz71DtgJenZKfH6b5n6jpJg6xJzQFdIZbz4I5
	 wpBWv946XypX9e7sWnA6R86JpqACnBrmRg6R8PNW7SAdfbcB7mSpsECNInSPZLjz/m
	 KaDxVspmPFt70vU3GsiYzfHYxhTUE/GS5+5W8DZbnoDLMAYx6iwGx4ySOLqnzjoWTH
	 TURLJGUGIPM8hA+yQQNOl8MQo4H3d6DgnmnQmzkkl/W/CdwNeMkD0pMdI/lB38Az1i
	 uyD+5+vSdlT45l1H0uTGkeq3i+q27J587ayxa0F4m3PtFBR5XUN4/mWuh1zW7PGXbL
	 TlCCaH3LcQIyQ==
Date: Fri, 4 Oct 2024 16:18:17 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Arthur Fabre <afabre@cloudflare.com>, Daniel Xu <dxu@dxuuu.xyz>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
	john.fastabend@gmail.com, edumazet@google.com, pabeni@redhat.com,
	sdf@fomichev.me, tariqt@nvidia.com, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org, mst@redhat.com,
	jasowang@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	kernel-team <kernel-team@cloudflare.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
Message-ID: <Zv_5KdpkaYY-6z1f@lore-desk>
References: <87zfnnq2hs.fsf@toke.dk>
 <Zv18pxsiTGTZSTyO@mini-arch>
 <87ttdunydz.fsf@toke.dk>
 <Zv3N5G8swr100EXm@mini-arch>
 <D4LYNKGLE7G0.3JAN5MX1ATPTB@bobby>
 <Zv794Ot-kOq1pguM@mini-arch>
 <2fy5vuewgwkh3o3mx5v4bkrzu6josqylraa4ocgzqib6a7ozt4@hwsuhcibtcb6>
 <038fffa3-1e29-4c6d-9e27-8181865dca46@kernel.org>
 <D4N2N1YKKI54.1WAGONIYZH0Y4@bobby>
 <75fb1dd3-fe14-426c-bc59-9a582c4b0e8d@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sMZhZyVlOLBRigTk"
Content-Disposition: inline
In-Reply-To: <75fb1dd3-fe14-426c-bc59-9a582c4b0e8d@kernel.org>


--sMZhZyVlOLBRigTk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 04, Jesper Dangaard Brouer wrote:
>=20
>=20
> On 04/10/2024 15.55, Arthur Fabre wrote:
> > On Fri Oct 4, 2024 at 12:38 PM CEST, Jesper Dangaard Brouer wrote:
> > > [...]
> > > > > > There are two different use-cases for the metadata:
> > > > > >=20
> > > > > > * "Hardware" metadata (like the hash, rx_timestamp...). There a=
re only a
> > > > > >     few well known fields, and only XDP can access them to set =
them as
> > > > > >     metadata, so storing them in a struct somewhere could make =
sense.
> > > > > >=20
> > > > > > * Arbitrary metadata used by services. Eg a TC filter could set=
 a field
> > > > > >     describing which service a packet is for, and that could be=
 reused for
> > > > > >     iptables, routing, socket dispatch...
> > > > > >     Similarly we could set a "packet_id" field that uniquely id=
entifies a
> > > > > >     packet so we can trace it throughout the network stack (thr=
ough
> > > > > >     clones, encap, decap, userspace services...).
> > > > > >     The skb->mark, but with more room, and better support for s=
haring it.
> > > > > >=20
> > > > > > We can only know the layout ahead of time for the first one. An=
d they're
> > > > > > similar enough in their requirements (need to be stored somewhe=
re in the
> > > > > > SKB, have a way of retrieving each one individually, that it se=
ems to
> > > > > > make sense to use a common API).
> > > > >=20
> > > > > Why not have the following layout then?
> > > > >=20
> > > > > +---------------+-------------------+----------------------------=
------------+------+
> > > > > | more headroom | user-defined meta | hw-meta (potentially fixed =
skb format) | data |
> > > > > +---------------+-------------------+----------------------------=
------------+------+
> > > > >                   ^                                              =
              ^
> > > > >               data_meta                                          =
            data
> > > > >=20
> > > > > You obviously still have a problem of communicating the layout if=
 you
> > > > > have some redirects in between, but you, in theory still have this
> > > > > problem with user-defined metadata anyway (unless I'm missing
> > > > > something).
> > > > >=20
> > >=20
> > > Hmm, I think you are missing something... As far as I'm concerned we =
are
> > > discussing placing the KV data after the xdp_frame, and not in the XDP
> > > data_meta area (as your drawing suggests).  The xdp_frame is stored at
> > > the very top of the headroom.  Lorenzo's patchset is extending struct
> > > xdp_frame and now we are discussing to we can make a more flexible API
> > > for extending this. I understand that Toke confirmed this here [3].  =
Let
> > > me know if I missed something :-)
> > >=20
> > >    [3] https://lore.kernel.org/all/874j62u1lb.fsf@toke.dk/
> > >=20
> > > As part of designing this flexible API, we/Toke are trying hard not to
> > > tie this to a specific data area.  This is a good API design, keeping=
 it
> > > flexible enough that we can move things around should the need arise.
> >=20
> > +1. And if we have an API for doing this for user-defined metadata, it
> > seems like we might as well use it for hardware metadata too.
> >=20
> > With something roughly like:
> >=20
> >      *val get(id)
> >=20
> >      set(id, *val)
> >=20
> > with pre-defined ids for hardware metadata, consumers don't need to know
> > the layout, or where / how the data is stored.
> >=20
> > Under the hood we can implement it however we want, and change it in the
> > future.
> >=20
> > I was initially thinking we could store hardware metadata the same way
> > as user defined metadata, but Toke and Lorenzo seem to prefer storing it
> > in a fixed struct.
>=20
> If the API hide the actual location then we can always move things
> around, later.  If your popcnt approach is fast enough, then IMO we
> don't need a fixed struct for hardware metadata.

+1. I am fine with the KV approach for nic metadata as well if it is fast e=
nough.
If you want I can modify my series to use kfunc sto store data after xdp_fr=
ame
and then you can plug the KV encoding. What do you think? Up to you.

Regards,
Lorenzo

>=20
> --Jesper

--sMZhZyVlOLBRigTk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZv/5KQAKCRA6cBh0uS2t
rK2oAQDNbiLhK1nE9+UoEM0jzz+0frq4p/JrgIjOzg5/mzElBwD6AxE86bij0lLW
fseZvIVZ8CKu08MMvL0UTI928vc0aAk=
=JprQ
-----END PGP SIGNATURE-----

--sMZhZyVlOLBRigTk--

