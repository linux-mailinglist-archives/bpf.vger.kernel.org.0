Return-Path: <bpf+bounces-19742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0DE830C20
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 18:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C8D1F21E24
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 17:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF59B22EEF;
	Wed, 17 Jan 2024 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuvRmuWh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3412422627;
	Wed, 17 Jan 2024 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705512989; cv=none; b=A8+4tK1zmbv758espabBlq9kpSEe4RZs0hmcuyCCpg4ZhhSAl9YM/BPluVm9AmQkIxf8qcUc11k7khbST2GdhFr1PGsg3wCO31Lqq3DK5kGxjzG8pksE++IONPtVT1ncFMJ8GaqiDqp20IwGaTjLKDantrNPMShdqqyRO8CfzUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705512989; c=relaxed/simple;
	bh=wjgCd2jcqo8gZcQ6efUyJqoTMhZvFPsWN3t2C5TYdmE=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=lVk66F8Z9656PE0iQYF69/7kLGjoyqtcUzKZAy90fMwFSVGZUiTQ4oqHsSRzuc8V4P0ETIkFmvHjG14/6RAxZFiU5cKdukZSjikP3BDAgL3Q6NB5ePG1CrySTncdzJ2WCBj8KBkSdSG69rVD9IEwBLJBl6EKwaadae3oPTpd0Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuvRmuWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE3CC433F1;
	Wed, 17 Jan 2024 17:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705512988;
	bh=wjgCd2jcqo8gZcQ6efUyJqoTMhZvFPsWN3t2C5TYdmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HuvRmuWhiwpHij+QB828uuIClciG2jn1uGSiAnx0MhWYtd9haWO4R5Ck1oCJwg/fI
	 3F+Js+i43j0jW625tRmwQPCt0xaUoRRMdJSkvh01AL/FKOaICYXPFRL+laAoG+s7lN
	 LJtdze9+ldMg7uucqz11L9vIay3lVtRhEdTi7vxO8SAdnpXWen5DZiTKQj9n0AhXQt
	 8P92n90Ayb0xmu5noIZploMGSJuVDju2bBTIUf5zAkxGilAH7p5PaU5FUy+O+Sol7i
	 cZMWb0y7jPgJGVWdCHXzGKb+PTLlOpNH5N0GWY+v+WhYOhks35gdqr50mlAtt39ywB
	 OJvQEr9gy/SJQ==
Date: Wed, 17 Jan 2024 18:36:25 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>, kuba@kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	netdev@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	willemdebruijn.kernel@gmail.com, toke@redhat.com,
	davem@davemloft.net, edumazet@google.com, bpf@vger.kernel.org,
	lorenzo.bianconi@redhat.com, sdf@google.com, jasowang@redhat.com
Subject: Re: [PATCH v5 net-next 1/3] net: introduce page_pool pointer in
 softnet_data percpu struct
Message-ID: <ZagQGZ5CM3vEH2RP@lore-desk>
References: <cover.1702563810.git.lorenzo@kernel.org>
 <b1432fc51c694f1be8daabb19773744fcee13cf1.1702563810.git.lorenzo@kernel.org>
 <c49124012f186e06a4a379b060c85e4cca1a9d53.camel@redhat.com>
 <33bbb170-afdd-477f-9296-a9cede9bc2f2@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1UCwbyeSi2aR2x7c"
Content-Disposition: inline
In-Reply-To: <33bbb170-afdd-477f-9296-a9cede9bc2f2@kernel.org>


--1UCwbyeSi2aR2x7c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 19/12/2023 16.23, Paolo Abeni wrote:
> > On Thu, 2023-12-14 at 15:29 +0100, Lorenzo Bianconi wrote:
> > > Allocate percpu page_pools in softnet_data.
> > > Moreover add cpuid filed in page_pool struct in order to recycle the
> > > page in the page_pool "hot" cache if napi_pp_put_page() is running on
> > > the same cpu.
> > > This is a preliminary patch to add xdp multi-buff support for xdp run=
ning
> > > in generic mode.
> > >=20
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >   include/linux/netdevice.h       |  1 +
> > >   include/net/page_pool/helpers.h |  5 +++++
> > >   include/net/page_pool/types.h   |  1 +
> > >   net/core/dev.c                  | 39 ++++++++++++++++++++++++++++++=
++-
> > >   net/core/page_pool.c            |  5 +++++
> > >   net/core/skbuff.c               |  5 +++--
> > >   6 files changed, 53 insertions(+), 3 deletions(-)
> >=20
> > @Jesper, @Ilias: could you please have a look at the pp bits?
> >=20
>=20
> I have some concerns... I'm still entertaining the idea, but we need to
> be aware of the tradeoffs we are making.
>=20
> (1)
> Adding PP to softnet_data means per CPU caching 256 pages in the
> ptr_ring (plus likely 64 in the alloc-cache).   Fortunately, PP starts
> out empty, so as long as this PP isn't used they don't get cached. But
> if used, then PP don't have a MM shrinker that removes these cached
> pages, in case system is under MM pressure.  I guess, you can argue that
> keeping this per netdev rx-queue would make memory usage even higher.
> This is a tradeoff, we are trading memory (waste) for speed.
>=20
>=20
> (2) (Question to Jakub I guess)
> How does this connect with Jakub's PP netlink stats interface?
> E.g. I find it very practical that this allow us get PP stats per
> netdev, but in this case there isn't a netdev.
>=20
>=20
> (3) (Implicit locking)
> PP have lockless "alloc" because it it relies on drivers NAPI context.
> The places where netstack access softnet_data provide similar protection
> that we can rely on for PP, so this is likely correct implementation
> wise.  But it will give people like Sebastian (Cc) more gray hair when
> figuring out how PREEMPT_RT handle these cases.
>=20
> (4)
> The optimization is needed for the case where we need to re-allocate and
> copy SKB fragments.  I think we should focus on avoiding this code path,
> instead of optimizing it.  For UDP it should be fairly easy, but for TCP
> this is harder.

Hi all,

I would resume this activity and it seems to me there is no a clear directi=
on
about where we should add the page_pool (in a per_cpu pointer or in
netdev_rx_queue struct) or if we can rely on page_frag_cache instead.

@Jakub: what do you think? Should we add a page_pool in a per_cpu pointer?

Regards,
Lorenzo

>=20
> --Jesper

--1UCwbyeSi2aR2x7c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZagQGQAKCRA6cBh0uS2t
rNoaAP9t9LZotrbqc4WqbGm0jzEm2FElQUWUAdQ1KSTL6uCXBQEA1cTXDVFiv7Hl
mMTtCEySyRtJQhKFjM7DtPDcF6a93QM=
=IOpa
-----END PGP SIGNATURE-----

--1UCwbyeSi2aR2x7c--

