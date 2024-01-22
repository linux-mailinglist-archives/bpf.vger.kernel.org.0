Return-Path: <bpf+bounces-20005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8AB8361BA
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 12:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F641C23E27
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 11:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BE046B99;
	Mon, 22 Jan 2024 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3geCpYh"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03E446BA6
	for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922380; cv=none; b=YL3GX6HDl/M+N4K/bT6JGvwMlImHoJJWpS9U2wnx/tP7/kQmE1t9eodsThuhMUfhYuT4R2FEOLqIIGsgxDnphlKYXXD7sjTyCkGM1R2nC3G7hYfPUDkUfosYUCOwozaLpZxW07k+cv4lW74HJU7yMtf//gfR3+T89ZL5IvP8h1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922380; c=relaxed/simple;
	bh=QX+S72Jw/G+LWgzrgP6E8bocfqZMYncUlCjzuKuS+tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvUIS6RaF6zobNlJTNq+tHf6yk+tPhwi3pW8fVT5i5GcesLUSKebG0kEPr725mnWLuVT9eBvoMyo82LeTHC1OGUxcwcfAbQt7X1t06QLvyU7BRrfe806x3HPKstELowl7Jai+G/YYr8GmRu3Wyc1VduboAzBneSV9xWLlcU2XjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3geCpYh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705922377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/EdLluhqM4YiUBc7bl3e3yyhKpkhN20GphfcOQyoLCw=;
	b=T3geCpYhkgLBN0K7BF9AXxByp4CA9LpE3+lnYOlZKQZ28nv3rv1wNVF3aUv6uV/MUYFCWd
	p33uFcsi+JfDVWPH+JmaqtUIbKKrOUXr3zVPCHh4eLfEMgJOMW1/iBCnmqtnTJaLjS2bpN
	3jLfF0P+CpqLdEGYsAjvpzV/DZz5gR0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-l_YyhUMiMHmYADTgVlep0Q-1; Mon, 22 Jan 2024 06:19:33 -0500
X-MC-Unique: l_YyhUMiMHmYADTgVlep0Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a2bc664528fso145366166b.3
        for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 03:19:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705922372; x=1706527172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EdLluhqM4YiUBc7bl3e3yyhKpkhN20GphfcOQyoLCw=;
        b=RI1iRZGjegVuUo2CxszwhSTp8sZI0VdV4/2TSKd4W7jTPr5AuaYogcGjHx3ee33/Tp
         5xOkjD9CYYImhI0H3D4YTKD/MjcXwTie/4kEfnZ8KHiXdeEdvu+2Tzd2LBQqj4xbfhTH
         fQtOCDaQKAYBdo+VKIxGnkyzm5cqkoyu5jBFRKHHD3m6JNG6CsctgwZF8HYqG/WUe8pY
         l8lEUofM0eKoR40x/khIAxHqCu8fS6uQ5aaudNKI4QGtO2cTvI2J0DuH69EpRkWKSTzl
         BlyCWUmBQI5vjN2IWQT8yig8pXRgNxb3FMNoz66zcuEsq86xAnaqEsg14uQEK+WngdBd
         I3/w==
X-Gm-Message-State: AOJu0Ywy5+l38dmQjkw1/vCgQrswVrW2RMbv/6d6MQqVro31EGi+Bomu
	GkYZX6jrUfHrlQrqbNaLlxaFweMuT39pCt+lVsMQ1APPY3ADkRXEYOmTY2SWY65D8WBkfh5zYHn
	ihI/BrbSTrChLHw2Kfb6pJdeZYDxpcJlM8+QrbczvmlOG12eXkw==
X-Received: by 2002:a05:6402:1019:b0:55a:2f61:3697 with SMTP id c25-20020a056402101900b0055a2f613697mr2194699edu.21.1705922372743;
        Mon, 22 Jan 2024 03:19:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXE5re1Q26n7a0bbj0zp1GIOA0AcKwmF9mk/MNxA2zC+pxvngJHD0TfzSIsf7876Tl0T1qTA==
X-Received: by 2002:a05:6402:1019:b0:55a:2f61:3697 with SMTP id c25-20020a056402101900b0055a2f613697mr2194689edu.21.1705922372432;
        Mon, 22 Jan 2024 03:19:32 -0800 (PST)
Received: from localhost (net-93-71-3-198.cust.vodafonedsl.it. [93.71.3.198])
        by smtp.gmail.com with ESMTPSA id c14-20020a05640227ce00b0055b49fc4e4esm2524744ede.26.2024.01.22.03.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 03:19:31 -0800 (PST)
Date: Mon, 22 Jan 2024 12:19:29 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	willemdebruijn.kernel@gmail.com, toke@redhat.com,
	davem@davemloft.net, edumazet@google.com, bpf@vger.kernel.org,
	sdf@google.com, jasowang@redhat.com
Subject: Re: [PATCH v5 net-next 1/3] net: introduce page_pool pointer in
 softnet_data percpu struct
Message-ID: <Za5PQX6ORCXtTtF4@lore-desk>
References: <cover.1702563810.git.lorenzo@kernel.org>
 <b1432fc51c694f1be8daabb19773744fcee13cf1.1702563810.git.lorenzo@kernel.org>
 <c49124012f186e06a4a379b060c85e4cca1a9d53.camel@redhat.com>
 <33bbb170-afdd-477f-9296-a9cede9bc2f2@kernel.org>
 <ZagQGZ5CM3vEH2RP@lore-desk>
 <20240117174722.521c9fdf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a9ZKnG+ePERiuFE3"
Content-Disposition: inline
In-Reply-To: <20240117174722.521c9fdf@kernel.org>


--a9ZKnG+ePERiuFE3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, 17 Jan 2024 18:36:25 +0100 Lorenzo Bianconi wrote:
> > I would resume this activity and it seems to me there is no a clear dir=
ection
> > about where we should add the page_pool (in a per_cpu pointer or in
> > netdev_rx_queue struct) or if we can rely on page_frag_cache instead.
> >=20
> > @Jakub: what do you think? Should we add a page_pool in a per_cpu point=
er?

Hi Jakub,

>=20
> Let's try to summarize. We want skb reallocation without linearization
> for XDP generic. We need some fast-ish way to get pages for the payload.

correct

>=20
> First, options for placing the allocator:
>  - struct netdev_rx_queue
>  - per-CPU
>=20
> IMO per-CPU has better scaling properties - you're less likely to
> increase the CPU count to infinity than spawn extra netdev queues.

ack

>=20
> The second question is:
>  - page_frag_cache
>  - page_pool
>=20
> I like the page pool because we have an increasing amount of infra for
> it, and page pool is already used in veth, which we can hopefully also
> de-duplicate if we have a per-CPU one, one day. But I do agree that
> it's not a perfect fit.
>=20
> To answer Jesper's questions:
>  ad1. cache size - we can lower the cache to match page_frag_cache,=20
>       so I think 8 entries? page frag cache can give us bigger frags=20
>       and therefore lower frag count, so that's a minus for using=20
>       page pool
>  ad2. nl API - we can extend netlink to dump unbound page pools fairly
>       easily, I didn't want to do it without a clear use case, but I
>       don't think there are any blockers
>  ad3. locking - a bit independent of allocator but fair point, we assume
>       XDP generic or Rx path for now, so sirq context / bh locked out
>  ad4. right, well, right, IDK what real workloads need, and whether=20
>       XDP generic should be optimized at all.. I personally lean
>       towards "no"
> =20
> Sorry if I haven't helped much to clarify the direction :)
> I have no strong preference on question #2, I would prefer to not add
> per-queue state for something that's in no way tied to the device
> (question #1 -> per-CPU).=20

Relying on netdev_alloc_cache/napi_alloc_cache will have the upside of reus=
ing
current infrastructure (iirc my first revision used this approach).
The downside is we can't unify the code with veth driver.
There other way around adding per-cpu page_pools :). Anyway I am fine to ha=
ve a
per-cpu page_pool similar to netdev_alloc_cache/napi_alloc_cache.

@Jesper/Ilias: what do you think?

>=20
> You did good perf analysis of the options, could you share it here
> again?
>=20

copying them out from my previous tests:

v00 (NS:ns0 - 192.168.0.1/24) <---> (NS:ns1 - 192.168.0.2/24) v01 =3D=3D(XD=
P_REDIRECT)=3D=3D> v10 (NS:ns1 - 192.168.1.1/24) <---> (NS:ns2 - 192.168.1.=
2/24) v11

- v00: iperf3 client (pinned on core 0)
- v11: iperf3 server (pinned on core 7)

net-next veth codebase (page_pool APIs):
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- MTU  1500: ~ 5.42 Gbps
- MTU  8000: ~ 14.1 Gbps
- MTU 64000: ~ 18.4 Gbps

net-next veth codebase + netdev_alloc_cache/napi_alloc_cache:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- MTU  1500: ~ 6.62 Gbps
- MTU  8000: ~ 14.7 Gbps
- MTU 64000: ~ 19.7 Gbps

xdp_generic codebase + netdev_alloc_cache/napi_alloc_cache:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
- MTU  1500: ~ 6.41 Gbps
- MTU  8000: ~ 14.2 Gbps
- MTU 64000: ~ 19.8 Gbps

xdp_generic codebase + page_pool in netdev_rx_queue:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
- MTU  1500: ~ 5.75 Gbps
- MTU  8000: ~ 15.3 Gbps
- MTU 64000: ~ 21.2 Gbps

IIRC relying on per-cpu page_pool has similar results of adding them in net=
dev_rx_queue,
but I can test them again with an updated kernel.

Regards,
Lorenzo

--a9ZKnG+ePERiuFE3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZa5PQQAKCRA6cBh0uS2t
rJFPAP92LI5/lVOXGQw2f5E8RBlSmRWxrraBMZxN4N4L6C3TmAEAr1kgFvaQKy+Z
HB84CxxRYiPIvttJpU+tgPnB/Ox6YAk=
=B/pY
-----END PGP SIGNATURE-----

--a9ZKnG+ePERiuFE3--


