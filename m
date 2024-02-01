Return-Path: <bpf+bounces-20947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59369845682
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 12:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E1A1F286F2
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 11:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2579A15F310;
	Thu,  1 Feb 2024 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvTLQkUD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4BB15D5CA;
	Thu,  1 Feb 2024 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788195; cv=none; b=HbEM3RcWPC8Xpmsq+psqSrHpUTY+iUIQTNEJC5+ZILRwg1UFNRCytZRU/f6wGJx0lyLvr/HFDEkWp8CDxePMuiQZIPczA12lzhAX/+/066OHjv3WVqwfXD0n44y6qpL3OiAvC7KvKgw6rPmbY4MgInArYTR+QLpoR0FmjXcBgUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788195; c=relaxed/simple;
	bh=GHYm3U5KvHW0QmfqvzEMARVH11YCM8h+3s3JMyoqgv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTgJAKONuQqEGs1+9sjCjh/Bx9afd9Vg43yBJWBLPjEvgZSg3wRqMMTz00hf0KZzdTaUKxGxMSUAVBw02RQYLHF4Lw87J8aEnriwOLYthutMPKqRBpXQiqN2ex0lmvFKIsUydBdpliUkq4bcatmJhSQczAvYGesxd3MANawlwGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvTLQkUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E69BC433C7;
	Thu,  1 Feb 2024 11:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706788195;
	bh=GHYm3U5KvHW0QmfqvzEMARVH11YCM8h+3s3JMyoqgv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fvTLQkUDd8FJJ5cvVt62az0HgZK8vjFZX7V6b0ym8qB599PddxcphBM447yJnXD0n
	 aTm2P0Vj0RcLChFW1s4Kl5H3GSzS1TfZh/KLxKQZCTI6b4DBQLgoP8ZCMJl1XuL6l8
	 jhR1igBMixeJq6PxrXtGhSsIMYwMbAo+R+xH4hDfSrCSbEzuwkiX+woFRrw3As9ASI
	 6txVBi014XfBaGR3aZXEgvW2F+w4htAthOR7J6n+Ls8Zc4VNRao13J3Ewpfn2UBCcO
	 iCRrozMshfHjw6/PlZXxGDYcBjSJtKw0PZOInLRB45Up33ZRZ9LegbyiNKVfvhs87q
	 J0vTH3nF2/O0A==
Date: Thu, 1 Feb 2024 12:49:51 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, bpf@vger.kernel.org, toke@redhat.com,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	sdf@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 1/5] net: add generic per-cpu page_pool
 allocator
Message-ID: <ZbuFX2TQUQBovDy2@lore-desk>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <5b0222d3df382c22fe0fa96154ae7b27189f7ecd.1706451150.git.lorenzo@kernel.org>
 <f6273e01-a826-4182-a5b5-564b51f2d9ae@huawei.com>
 <ZbeiZaUrWoj39_LZ@lore-desk>
 <7343292d-3273-a10a-9167-420f3232dbdd@huawei.com>
 <ZbkHDo4bxcWtGP9X@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="esvgDkuM8I7oaq1Q"
Content-Disposition: inline
In-Reply-To: <ZbkHDo4bxcWtGP9X@lore-desk>


--esvgDkuM8I7oaq1Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > On 2024/1/29 21:04, Lorenzo Bianconi wrote:
> > >> On 2024/1/28 22:20, Lorenzo Bianconi wrote:
> > >>
> > >>>  #ifdef CONFIG_LOCKDEP
> > >>>  /*
> > >>>   * register_netdevice() inits txq->_xmit_lock and sets lockdep cla=
ss
> > >>> @@ -11686,6 +11690,27 @@ static void __init net_dev_struct_check(vo=
id)
> > >>>   *
> > >>>   */
> > >>> =20
> > >>> +#define SD_PAGE_POOL_RING_SIZE	256
> > >>
> > >> I might missed that if there is a reason we choose 256 here, do we
> > >> need to use different value for differe page size, for 64K page size,
> > >> it means we might need to reserve 16MB memory for each CPU.
> > >=20
> > > honestly I have not spent time on it, most of the current page_pool u=
sers set
> > > pool_size to 256. Anyway, do you mean something like:
> > >=20
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index f70fb6cad2b2..3934a3fc5c45 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -11806,12 +11806,11 @@ static void __init net_dev_struct_check(voi=
d)
> > >   *
> > >   */
> > > =20
> > > -#define SD_PAGE_POOL_RING_SIZE	256
> > >  static int net_page_pool_alloc(int cpuid)
> > >  {
> > >  #if IS_ENABLED(CONFIG_PAGE_POOL)
> >=20
> > Isn't better to have a config like CONFIG_PER_CPU_PAGE_POOL to enable
> > this feature? and this config can be selected by whoever needs this
> > feature?
>=20
> since it will be used for generic xdp (at least) I think this will be 99%
> enabled when we have bpf enabled, right?
>=20
> >=20
> > >  	struct page_pool_params page_pool_params =3D {
> > > -		.pool_size =3D SD_PAGE_POOL_RING_SIZE,
> > > +		.pool_size =3D PAGE_SIZE < SZ_64K ? 256 : 16,
> >=20
> > What about other page size? like 16KB?
> > How about something like below:
> > PAGE_SIZE << get_order(PER_CPU_PAGE_POOL_MAX_SIZE)
>=20
> since pool_size is the number of elements in the ptr_ring associated to t=
he pool,
> assuming we want to consume PER_CPU_PAGE_POOL_MAX_SIZE for each cpu, some=
thing
> like:
>=20
> PER_CPU_PAGE_POOL_MAX_SIZE / PAGE_SIZE
>=20
> Regards,
> Lorenzo

Discussing with Jesper and Toke, we agreed page_pool infrastructure will ne=
ed
a way to release memory when the system is under memory pressure, so we can
defer this item to a subsequent series, what do you think?

Regards,
Lorenzo

>=20
> >=20
> > >  		.nid =3D NUMA_NO_NODE,
> > >  	};
> > >  	struct page_pool *pp_ptr;
> >=20



--esvgDkuM8I7oaq1Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZbuFXwAKCRA6cBh0uS2t
rCxOAP9wrR6eOQ+D2VGPIwr1z+5hST/xfOKK55hNxoj0bPIFYQEA5oUhKBIgCaXG
UNVDfzHyVkOFEkDq5VkQym+SiuwoKw4=
=R/Ms
-----END PGP SIGNATURE-----

--esvgDkuM8I7oaq1Q--

