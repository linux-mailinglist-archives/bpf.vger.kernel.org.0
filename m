Return-Path: <bpf+bounces-20822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B60968440B3
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 14:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4E31C29E8D
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 13:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EABB7F490;
	Wed, 31 Jan 2024 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6zMzXSe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BC97F47D;
	Wed, 31 Jan 2024 13:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708177; cv=none; b=kBBfWCOFoavPQM3OBSZeq2egOIvTyTiwlNb/KDX9d7EdPYOXAX7LjhIJ1MskVm6lI7wF6kTMMdP7wZf1mpjoD3tVVpcNFgUbVFZpgabbmkQICKoZf7FKHK46eM4soWmHefiBlCasFTXVyeSVdWcuMfCXeLHQOMOwkdgizHJ6GBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708177; c=relaxed/simple;
	bh=zPG9Ii5BeC5tacwIgwrm7eTR57WyghjQz9MsJYvoIGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ozy1AChy0ch2zszr/vQDYx6VAoHeKd0m9rWcxknNA35fT84qhOC/qknAjx+ufu1X4E4qtdhQBet4bXVnCIXImcCQwSgTqq5WKkt51pWIecBpQJ5aBSVujGMJuXECWF2+azA227LYPlvQ9XGR2FMI5cz2I7bdRdhVRfKLhRgWoPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6zMzXSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F57C433C7;
	Wed, 31 Jan 2024 13:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706708177;
	bh=zPG9Ii5BeC5tacwIgwrm7eTR57WyghjQz9MsJYvoIGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D6zMzXSe/sCaHsbo3gUSA5qryoI0bBDxVADllwpnUSTYVVkgtdNR3qqHRyrezUjZJ
	 Puvvo3lABEu3HVNug+kMBuIQ1vRP7FrleYKvKB8b8Xk6c9wQOjV+Uv+KifmKSyKNHv
	 31QyHzbeuf051JQJS6rVA1ea5ZSseXg8U7UZy5Su6Xa1jCfo8TFwMM/8FG9RLoCMgQ
	 ZgVlUtdo/qRTrL6fA0dWGAGF9Bj89g7yv2EFtZFPGxWiKCLRCkoZA1hJ+vJ7459ZWO
	 KL3COeoGXW9qqHyl6p6TmaBLlh32wF6w+w5evXzTa8J4NYwrms6uXWktAV5NX7+XJH
	 sMUO3ufxsg8jw==
Date: Wed, 31 Jan 2024 14:36:13 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, bpf@vger.kernel.org, toke@redhat.com,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	sdf@google.com, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 1/5] net: add generic per-cpu page_pool
 allocator
Message-ID: <ZbpMzQeg-UEzGE6V@lore-desk>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <5b0222d3df382c22fe0fa96154ae7b27189f7ecd.1706451150.git.lorenzo@kernel.org>
 <91cf832e-ad66-47d0-bf2b-a8c9492d16a9@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A5ZtbKwvnUq5J195"
Content-Disposition: inline
In-Reply-To: <91cf832e-ad66-47d0-bf2b-a8c9492d16a9@kernel.org>


--A5ZtbKwvnUq5J195
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 28/01/2024 15.20, Lorenzo Bianconi wrote:
> > Introduce generic percpu page_pools allocator.
> > Moreover add page_pool_create_percpu() and cpuid filed in page_pool str=
uct
> > in order to recycle the page in the page_pool "hot" cache if
> > napi_pp_put_page() is running on the same cpu.
> > This is a preliminary patch to add xdp multi-buff support for xdp runni=
ng
> > in generic mode.
> >=20
> > Signed-off-by: Lorenzo Bianconi<lorenzo@kernel.org>
> > ---
> >   include/net/page_pool/types.h |  3 +++
> >   net/core/dev.c                | 40 +++++++++++++++++++++++++++++++++++
> >   net/core/page_pool.c          | 23 ++++++++++++++++----
> >   net/core/skbuff.c             |  5 +++--
> >   4 files changed, 65 insertions(+), 6 deletions(-)
> >=20
> [...]
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index cb2dab0feee0..bf9ec740b09a 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> [...]
> > @@ -11686,6 +11690,27 @@ static void __init net_dev_struct_check(void)
> >    *
> >    */
> > +#define SD_PAGE_POOL_RING_SIZE	256
> > +static int net_page_pool_alloc(int cpuid)
>=20
> I don't like the name net_page_pool_alloc().
> It uses the page_pool_create APIs.
>=20
> Let us renamed to net_page_pool_create() ?

ack, I will fix it.

Regards,
Lorenzo

>=20
>=20
> > +{
> > +#if IS_ENABLED(CONFIG_PAGE_POOL)
> > +	struct page_pool_params page_pool_params =3D {
> > +		.pool_size =3D SD_PAGE_POOL_RING_SIZE,
> > +		.nid =3D NUMA_NO_NODE,
> > +	};
> > +	struct page_pool *pp_ptr;
> > +
> > +	pp_ptr =3D page_pool_create_percpu(&page_pool_params, cpuid);
> > +	if (IS_ERR(pp_ptr)) {
> > +		pp_ptr =3D NULL;
> > +		return -ENOMEM;
> > +	}
> > +
> > +	per_cpu(page_pool, cpuid) =3D pp_ptr;
> > +#endif
> > +	return 0;
> > +}
> > +
> >   /*
> >    *       This is called single threaded during boot, so no need
> >    *       to take the rtnl semaphore.
> > @@ -11738,6 +11763,9 @@ static int __init net_dev_init(void)
> >   		init_gro_hash(&sd->backlog);
> >   		sd->backlog.poll =3D process_backlog;
> >   		sd->backlog.weight =3D weight_p;
> > +
> > +		if (net_page_pool_alloc(i))
> > +			goto out;
> >   	}
> >   	dev_boot_phase =3D 0;
> > @@ -11765,6 +11793,18 @@ static int __init net_dev_init(void)
> >   	WARN_ON(rc < 0);
> >   	rc =3D 0;
> >   out:
> > +	if (rc < 0) {
> > +		for_each_possible_cpu(i) {
> > +			struct page_pool *pp_ptr =3D this_cpu_read(page_pool);
> > +
> > +			if (!pp_ptr)
> > +				continue;
> > +
> > +			page_pool_destroy(pp_ptr);
> > +			per_cpu(page_pool, i) =3D NULL;
> > +		}
> > +	}
> > +
> >   	return rc;
> >   }

--A5ZtbKwvnUq5J195
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZbpMzQAKCRA6cBh0uS2t
rPAKAPwIep6sdL0hZM9ENHm7rBSb2U8mhOcjEbo9d6U4D/QACQD+PNi5SK+BwU2e
gDKoFjnUd3694Zb58BJ8QHTLMCT00QM=
=L38L
-----END PGP SIGNATURE-----

--A5ZtbKwvnUq5J195--

