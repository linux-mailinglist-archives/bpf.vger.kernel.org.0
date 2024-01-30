Return-Path: <bpf+bounces-20742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C438428A7
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 17:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7941F2964C
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 16:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F161272C1;
	Tue, 30 Jan 2024 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IateNKPQ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687FE86AE7
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630531; cv=none; b=bdKNdCzLy2oWSxN0TEGrD3ogUs1rR1zSA+fy6A/LloZKwrHbrQHeCeA/h7r3jseIqxt7TeUcZrxma08/6aXf4acQ23ATgxnuabOXKIDErUHrv1Em/OBNKvpnqXOcooWbNRXtXGfZETgXPbZ+bVmPHllYlV8I14tkbwvj7z9xNeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630531; c=relaxed/simple;
	bh=R/+PGrqlIQzRx/YC8Yw0Yia2E8Fz6ExLuynaZh2F/aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7RNEf31lM4G0iEJQZqBTt5JyUfXccUnUaVq+laxskCam1o8LrsDh9GYY4dWj6aDlj9c/JIraz0QBIDFHQjvHBYHz10Gt53/2/ncqcZ8xuojDqON3wFcSg6UOX9NSkuaNaUx0jRyzDOWtU807qNMvMYTiatrAM+myaGxXBJ/Lps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IateNKPQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706630526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nsPhw/UFv6rmTQuuvbVRDjJ+6ofGxDXqAnyB7KVB/58=;
	b=IateNKPQazNnNpv1NPB9IbAfTehn0An3HmBW/YMzlKQ7oE4WxoVXlZgF1ItDtGVQZm9VpH
	c+Xil3NAIpPgfxzCFCAj1RXhMbAjxeRYtNzj5MS6KFvk1Iq1O1/ghj8SeIsfINZAoQ/ID6
	QLAbDi2JIINwRUaUBbaxZbkob9GAsyY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-lSG35M5tMVyqkOGvq8wm-g-1; Tue, 30 Jan 2024 11:01:55 -0500
X-MC-Unique: lSG35M5tMVyqkOGvq8wm-g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40fa6610ddfso3202455e9.3
        for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 08:01:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706630513; x=1707235313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsPhw/UFv6rmTQuuvbVRDjJ+6ofGxDXqAnyB7KVB/58=;
        b=YSSQfBCX9fi7PVRP70nO8twePH9JthEJkE8HUsg1kGiVKK8r+9cKRILrVit4a2Tc8S
         DF9BTVQatTeoIfPQwOO5Y760UzWxqE6Wex2cGnNZCyjoenhXs4WYQpEvUzPY+P7Zd5bi
         Lc5gCwAOldjJ73Xj7WlfGPbYKyiohZNsM3y7vgGvXpAiNdI7QwydKRgGOjW6N3iHFJ/o
         78lQ9s/Ys4orWasKrCNQcCcYX3NRxkakA35txoPE60MMSGL0WxI9NM2K/pre1JfOPSB/
         3A8PZMV9d97H+Go2mslc2BiXvWEm+wj8DHMDbqGTJYbpUpB5oOkUnVnQBmNYAO/3/JKQ
         ZoZw==
X-Gm-Message-State: AOJu0YwAKzA5fY2RW8KkDdvxItYmP53oV1XN2j/ZMNaP36XNxXGHa2fA
	eTAmhz2q6jIhQO6YCS7Vts7C/aTLlBuCnhbZ+9FL9M/W1zSKOEnrmnKIAOWvPx99/eiPi9bWWRu
	sFNHUA8BxYfzp+kFUOe0JBotuOqXVAWABkQTNI/wizWaZHFcPfQ==
X-Received: by 2002:a05:600c:1e0a:b0:40f:30b:ee96 with SMTP id ay10-20020a05600c1e0a00b0040f030bee96mr1465912wmb.37.1706630512862;
        Tue, 30 Jan 2024 08:01:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKCIESEWm8fMGWFUaJ+FFroIeLj4O+hrnJRknoMG+eYSSv9IFnneCyG5F85fWBjknHDEP85Q==
X-Received: by 2002:a05:600c:1e0a:b0:40f:30b:ee96 with SMTP id ay10-20020a05600c1e0a00b0040f030bee96mr1465887wmb.37.1706630512517;
        Tue, 30 Jan 2024 08:01:52 -0800 (PST)
Received: from localhost (net-93-71-3-198.cust.vodafonedsl.it. [93.71.3.198])
        by smtp.gmail.com with ESMTPSA id b3-20020a05600003c300b0033afe6968bfsm631053wrg.64.2024.01.30.08.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 08:01:51 -0800 (PST)
Date: Tue, 30 Jan 2024 17:01:50 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, bpf@vger.kernel.org, toke@redhat.com,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	sdf@google.com, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 4/5] net: page_pool: make stats available
 just for global pools
Message-ID: <ZbkdblTwF19lBYbf@lore-desk>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <9f0a571c1f322ff6c4e6facfd7d6d508e73a8f2f.1706451150.git.lorenzo@kernel.org>
 <bc5dc202-de63-4dee-5eb4-efd63dcb162b@huawei.com>
 <ZbejGhc8K4J4dLbL@lore-desk>
 <ef59f9ac-b622-315a-4892-6c7723a2986a@huawei.com>
 <Zbj_Cb9oHRseTa3u@lore-desk>
 <fcf8678b-b373-49a8-8268-0a8b1a49f739@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XGsBPEjow8ZYXOm2"
Content-Disposition: inline
In-Reply-To: <fcf8678b-b373-49a8-8268-0a8b1a49f739@kernel.org>


--XGsBPEjow8ZYXOm2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 30/01/2024 14.52, Lorenzo Bianconi wrote:
> > > On 2024/1/29 21:07, Lorenzo Bianconi wrote:
> > > > > On 2024/1/28 22:20, Lorenzo Bianconi wrote:
> > > > > > Move page_pool stats allocation in page_pool_create routine and=
 get rid
> > > > > > of it for percpu page_pools.
> > > > >=20
> > > > > Is there any reason why we do not need those kind stats for per c=
pu
> > > > > page_pool?
> > > > >=20
> > > >=20
> > > > IIRC discussing with Jakub, we decided to not support them since th=
e pool is not
> > > > associated to any net_device in this case.
> > >=20
> > > It seems what jakub suggested is to 'extend netlink to dump unbound p=
age pools'?
> >=20
> > I do not have a strong opinion about it (since we do not have any use-c=
ase for
> > it at the moment).
> > In the case we want to support stats for per-cpu page_pools, I think we=
 should
> > not create a per-cpu recycle_stats pointer and add a page_pool_recycle_=
stats field
> > in page_pool struct since otherwise we will endup with ncpu^2 copies, r=
ight?
> > Do we want to support it now?
> >=20
> > @Jakub, Jesper: what do you guys think?
> >=20
>=20
>=20
> I do see an need for being able to access page_pool stats for all
> page_pool's in the system.
> And I do like Jakub's netlink based stats.

ack from my side if you have some use-cases in mind.
Some questions below:
- can we assume ethtool will be used to report stats just for 'global'
  page_pool (not per-cpu page_pool)?
- can we assume netlink/yaml will be used to report per-cpu page_pool stats?

I think in the current series we can fix the accounting part (in particular
avoiding memory wasting) and then we will figure out how to report percpu
page_pool stats through netlink/yaml. Agree?

Regards,
Lorenzo

>=20
> --Jesper
> (p.s. I'm debugging some production issues with page_pool and broadcom
> bnxt_en driver).
>=20

--XGsBPEjow8ZYXOm2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZbkdbgAKCRA6cBh0uS2t
rPJHAP9rXcNf2AVzWKoU8ZHGcju4f1EgGLYov0X+uPMRZ8n/vwEAor0WqOqXpmKB
KD0CZsS0eaVlAe5RMs1AIUlDXHLU3g8=
=UQ1L
-----END PGP SIGNATURE-----

--XGsBPEjow8ZYXOm2--


