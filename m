Return-Path: <bpf+bounces-20572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EE68405B6
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6701C22D77
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 12:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DAC62A0D;
	Mon, 29 Jan 2024 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fa7O4HpB"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C85F612FE
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532759; cv=none; b=KN5Se3fS75VV+eUfXVADNATIzqa2/nXyshpvQyOs3gYIO8mJmSRIiw0N/sNGAUf/C6pKvq/4aPqiw23x2V94y/8vtd/5jZO6p0BiYh8TGjCVxkwalilaGTW6gCzIrc3Yq39YXto0P2spyLp6SfOaLyS164wDSyfJdTcJJ0VkcJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532759; c=relaxed/simple;
	bh=9QaSZLiCN1wf4oQCl/cYFudoj/IZujYRa+tug9ga+Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+VZ1yDP9TgV8/hnCAw0yfFS67QA4ez6Md6aUQ8uVqFBrP7RbADQseovUqUCceVykBM0tnX9CDUkTMTt7nExaCr0zG6BrsUlhM3R+KdTxc3w24QUAEsVNIAb/XLkc5lAEK1ZvwFxIGedB87kVYLj7Ddp+e4RnoXzxflTIhgHwZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fa7O4HpB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706532756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HFGou14JoZNUFYFvgdT1vD08s06+DwHZnpkq7nELQBc=;
	b=Fa7O4HpBrsyRC2p3H8d03XGvEN+E3xD+I00Ti9pN64fmuS0TRM7+smmWwDCVjFGi3qwj5K
	IidVP9Lfhg6s7xDVARjogvuODGw0aPcRRCjao9T1YuSdWTubYM1YPeW60J/norjWOSUpf6
	pCUs77wKKmLZifQxSfrEVl6lqP4wL4c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-ROZqcpA4NAWDzgMOcBoQfg-1; Mon, 29 Jan 2024 07:52:34 -0500
X-MC-Unique: ROZqcpA4NAWDzgMOcBoQfg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40ef75adf5fso4704075e9.0
        for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 04:52:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706532753; x=1707137553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFGou14JoZNUFYFvgdT1vD08s06+DwHZnpkq7nELQBc=;
        b=uqRAz6MK990fkrzb+yvom0/Ojgf7/qY6BEWkEC9DoPc4TZFRAbp7tEzYWoja+T9QgE
         oW3CYG2wbLYiqELuuE8bU48KZq07Gb4W6et2hgZJckj3oau6jyvBFHaBP94H/qtUsRnj
         nGS3QA6cQ4dhkaqYPvagpRGfoefFleVUwfmPy32z46dRZwpb0egPTzxVAxnkymKuFcwr
         6CPT0wtZv0l+iVnSgdI0is7ZI2bqZQWFvNRIqfpGC1QZCZRRfZwWzyq0oOUgoBtMOG9e
         X2JdEr3OV+inthFbABFnNAO7FFwXI9luUtQxHs4DM3WLWX4s0q9b+jZTqWUUPmiYapc6
         lFFQ==
X-Gm-Message-State: AOJu0YzU7nNECZfNO1slQvsONAc8YgZLxeKAl9FXhD4ctr2kAQ4M/aMi
	V7W7xjtQRB+QPA/Q4XxP4ZZTLWfoC/CdA8RzegE6f3MPGnG334riTytxIBGp3AMrJrSHNsjdz1T
	IDqK8qM026ZBEfcUE7aqik35WtOR3dJe2xnUmNZebFW/5XGeutw==
X-Received: by 2002:a1c:7903:0:b0:40e:ce03:e61f with SMTP id l3-20020a1c7903000000b0040ece03e61fmr5019849wme.11.1706532753680;
        Mon, 29 Jan 2024 04:52:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQEfBWuBXgVTSkJU7aaKjF34oJdO8b+R18K0tXiJxOntO8oyDdgVOUZH7C9pfQwNKpimYr8Q==
X-Received: by 2002:a1c:7903:0:b0:40e:ce03:e61f with SMTP id l3-20020a1c7903000000b0040ece03e61fmr5019830wme.11.1706532753378;
        Mon, 29 Jan 2024 04:52:33 -0800 (PST)
Received: from localhost (net-93-71-3-198.cust.vodafonedsl.it. [93.71.3.198])
        by smtp.gmail.com with ESMTPSA id l5-20020a05600c4f0500b0040e5951f199sm10137605wmq.34.2024.01.29.04.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 04:52:31 -0800 (PST)
Date: Mon, 29 Jan 2024 13:52:29 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, bpf@vger.kernel.org,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	sdf@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 1/5] net: add generic per-cpu page_pool
 allocator
Message-ID: <ZbefjZvKUMtaCbm1@lore-desk>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <5b0222d3df382c22fe0fa96154ae7b27189f7ecd.1706451150.git.lorenzo@kernel.org>
 <87jzns1f71.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5WpXeB60xZqPdpub"
Content-Disposition: inline
In-Reply-To: <87jzns1f71.fsf@toke.dk>


--5WpXeB60xZqPdpub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Introduce generic percpu page_pools allocator.
> > Moreover add page_pool_create_percpu() and cpuid filed in page_pool str=
uct
> > in order to recycle the page in the page_pool "hot" cache if
> > napi_pp_put_page() is running on the same cpu.
> > This is a preliminary patch to add xdp multi-buff support for xdp runni=
ng
> > in generic mode.
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  include/net/page_pool/types.h |  3 +++
> >  net/core/dev.c                | 40 +++++++++++++++++++++++++++++++++++
> >  net/core/page_pool.c          | 23 ++++++++++++++++----
> >  net/core/skbuff.c             |  5 +++--
> >  4 files changed, 65 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/net/page_pool/types.h b/include/net/page_pool/type=
s.h
> > index 76481c465375..3828396ae60c 100644
> > --- a/include/net/page_pool/types.h
> > +++ b/include/net/page_pool/types.h
> > @@ -128,6 +128,7 @@ struct page_pool_stats {
> >  struct page_pool {
> >  	struct page_pool_params_fast p;
> > =20
> > +	int cpuid;
> >  	bool has_init_callback;
> > =20
> >  	long frag_users;
> > @@ -203,6 +204,8 @@ struct page *page_pool_alloc_pages(struct page_pool=
 *pool, gfp_t gfp);
> >  struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int=
 *offset,
> >  				  unsigned int size, gfp_t gfp);
> >  struct page_pool *page_pool_create(const struct page_pool_params *para=
ms);
> > +struct page_pool *page_pool_create_percpu(const struct page_pool_param=
s *params,
> > +					  int cpuid);
> > =20
> >  struct xdp_mem_info;
> > =20
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index cb2dab0feee0..bf9ec740b09a 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -153,6 +153,8 @@
> >  #include <linux/prandom.h>
> >  #include <linux/once_lite.h>
> >  #include <net/netdev_rx_queue.h>
> > +#include <net/page_pool/types.h>
> > +#include <net/page_pool/helpers.h>
> > =20
> >  #include "dev.h"
> >  #include "net-sysfs.h"
> > @@ -442,6 +444,8 @@ static RAW_NOTIFIER_HEAD(netdev_chain);
> >  DEFINE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
> >  EXPORT_PER_CPU_SYMBOL(softnet_data);
> > =20
> > +DEFINE_PER_CPU_ALIGNED(struct page_pool *, page_pool);
>=20
> I think we should come up with a better name than just "page_pool" for
> this global var. In the code below it looks like it's a local variable
> that's being referenced. Maybe "global_page_pool" or "system_page_pool"
> or something along those lines?

ack, I will fix it. system_page_pool seems better, agree?

Regards,
Lorenzo

>=20
> -Toke
>=20

--5WpXeB60xZqPdpub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZbefjQAKCRA6cBh0uS2t
rOS+AQD8Av/Pk3dzrbbWX6Azk82mOQCadq59+rhpP+c148nyyAEA7K4Q7Sk9a/0P
uj8xfcE1334l4jwcAsUL2mPy18gatQI=
=DD6I
-----END PGP SIGNATURE-----

--5WpXeB60xZqPdpub--


