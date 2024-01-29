Return-Path: <bpf+bounces-20573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7AE8405FB
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB811F22450
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427605BAD2;
	Mon, 29 Jan 2024 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SuyLjV0x"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B0860EC9
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533487; cv=none; b=Qgjx+BgSO3QCJkamOgsUm+zWTSRFKveNa13YheMXOEFpC0s9pE/2Zh7fthHCgZZia7NShzDRJQQBbnfK+UH9dWXBD5DOf8Wg9hRiw9lnzej9EP//0EHPnxBqN4hDZDwYdHKjKBCA7a0jB/sZk9A/lqJq/4rBmcKCLdjTU+Yp1KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533487; c=relaxed/simple;
	bh=hUDcLPxTWBVh758l5satDFc80w73JtYQL5IlyNLMEXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnt/rpdn3Xw7ztpTVbmfAASs7tNrR9nWdinJSgnx5XesexBBmgrwK7s4uzdb7pzRvk89aIfQ0xFLhYSqs68Uo69/bDfPVyhIxM6c4bPg3XdhQKrL7CTQr+9iv6wSeTAhNqZLO3/UoyloVYWyNkz2Qk9KWtTcJ/8srTcNTX0HOIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SuyLjV0x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706533483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5u9+rqZEDkYDVIagmMTSVu3GUhA/FISTOqo0Vf+Xld8=;
	b=SuyLjV0xvflXYZOt1xN60q84XK4k6SzyGZTl9nZ9Gk9Iyl0p2SkAHswcaF/z841eB+nMzd
	mClr5f4xsOUF7HZYv1YKA5GrHFZcKjFtMB2F84iIwZstyFW9zavjrQA6kXNTOGPbDxC9zE
	6foz43+I6vnTEnEjsBiTRhz8iLAWm8E=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-k4HOXeA8MmOtKgULMHBKzg-1; Mon, 29 Jan 2024 08:04:41 -0500
X-MC-Unique: k4HOXeA8MmOtKgULMHBKzg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-511160618abso430291e87.3
        for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 05:04:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706533480; x=1707138280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5u9+rqZEDkYDVIagmMTSVu3GUhA/FISTOqo0Vf+Xld8=;
        b=rgQSePIf56KVlwuYu8uXpQ+uihF8xs/Ot6ZBea0PUEWQ3FjEwNI9W4axJ1dDK7WK9t
         6GQwkaCzS0HdjqT/ZqR1yk0wgkF/eXNJSxWdOV+hviHF4Op5j2ednt6sz8fFGJbh+kEy
         0kQGCNa8dXSmKSqHJH4HbEVUur/cZ1wnL993q72qQOjkfSyniyk4HbeZWxgW29CS33bA
         iiKY7lVsG4tow4a1QY05DGXrqI+kA8OqJrsveb/i1b6YkoV7QA27aDv/e2zCcB2iDXIu
         POL9VG8IAEmZ12Ys4fDiDsp1Uzzmf4a8OiETuRCMapB3f5NuKu4Va83GRYy8krTGRZj3
         9W2w==
X-Gm-Message-State: AOJu0Yx6AZfEuEKGuWBfBvx5YhiieN2Ar9QCM4TXUtjs3F5MuAg8Sxgd
	dsr37L2vJMGkioBc6pkSgUSv9OtWpwOTx22c1Qv89hh8uAy2CSRL8RC9z41AU6ha8pUXsASjVVN
	Tjqhhkl2T/nq/3tinDDRarp32MD61Eh14xyjUc0ikLrsqawhHrQ==
X-Received: by 2002:a05:6512:390a:b0:511:e7d:7ccb with SMTP id a10-20020a056512390a00b005110e7d7ccbmr2091529lfu.67.1706533479981;
        Mon, 29 Jan 2024 05:04:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPuLeGuj0HqqLM0ujALnFVdJ8umbAk2oV1aS/oyJ3j0StOqm/I4MZvQjNS8hiY44ql48oEhQ==
X-Received: by 2002:a05:6512:390a:b0:511:e7d:7ccb with SMTP id a10-20020a056512390a00b005110e7d7ccbmr2091511lfu.67.1706533479607;
        Mon, 29 Jan 2024 05:04:39 -0800 (PST)
Received: from localhost (net-93-71-3-198.cust.vodafonedsl.it. [93.71.3.198])
        by smtp.gmail.com with ESMTPSA id fa6-20020a05600c518600b0040ee8765901sm8323688wmb.43.2024.01.29.05.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:04:39 -0800 (PST)
Date: Mon, 29 Jan 2024 14:04:37 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, bpf@vger.kernel.org, toke@redhat.com,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	sdf@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 1/5] net: add generic per-cpu page_pool
 allocator
Message-ID: <ZbeiZaUrWoj39_LZ@lore-desk>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <5b0222d3df382c22fe0fa96154ae7b27189f7ecd.1706451150.git.lorenzo@kernel.org>
 <f6273e01-a826-4182-a5b5-564b51f2d9ae@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t7HFx7zhTzopyoJv"
Content-Disposition: inline
In-Reply-To: <f6273e01-a826-4182-a5b5-564b51f2d9ae@huawei.com>


--t7HFx7zhTzopyoJv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 2024/1/28 22:20, Lorenzo Bianconi wrote:
>=20
> >  #ifdef CONFIG_LOCKDEP
> >  /*
> >   * register_netdevice() inits txq->_xmit_lock and sets lockdep class
> > @@ -11686,6 +11690,27 @@ static void __init net_dev_struct_check(void)
> >   *
> >   */
> > =20
> > +#define SD_PAGE_POOL_RING_SIZE	256
>=20
> I might missed that if there is a reason we choose 256 here, do we
> need to use different value for differe page size, for 64K page size,
> it means we might need to reserve 16MB memory for each CPU.

honestly I have not spent time on it, most of the current page_pool users s=
et
pool_size to 256. Anyway, do you mean something like:

diff --git a/net/core/dev.c b/net/core/dev.c
index f70fb6cad2b2..3934a3fc5c45 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11806,12 +11806,11 @@ static void __init net_dev_struct_check(void)
  *
  */
=20
-#define SD_PAGE_POOL_RING_SIZE	256
 static int net_page_pool_alloc(int cpuid)
 {
 #if IS_ENABLED(CONFIG_PAGE_POOL)
 	struct page_pool_params page_pool_params =3D {
-		.pool_size =3D SD_PAGE_POOL_RING_SIZE,
+		.pool_size =3D PAGE_SIZE < SZ_64K ? 256 : 16,
 		.nid =3D NUMA_NO_NODE,
 	};
 	struct page_pool *pp_ptr;

>=20
> > +static int net_page_pool_alloc(int cpuid)
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
>=20
> unnecessary NULL setting?

ack, I will get rid of it.

>=20
> > +		return -ENOMEM;
> > +	}
> > +
> > +	per_cpu(page_pool, cpuid) =3D pp_ptr;
> > +#endif
> > +	return 0;
> > +}
> > +
> >  /*
> >   *       This is called single threaded during boot, so no need
> >   *       to take the rtnl semaphore.
> > @@ -11738,6 +11763,9 @@ static int __init net_dev_init(void)
> >  		init_gro_hash(&sd->backlog);
> >  		sd->backlog.poll =3D process_backlog;
> >  		sd->backlog.weight =3D weight_p;
> > +
> > +		if (net_page_pool_alloc(i))
> > +			goto out;
> >  	}
> > =20
> >  	dev_boot_phase =3D 0;
> > @@ -11765,6 +11793,18 @@ static int __init net_dev_init(void)
> >  	WARN_ON(rc < 0);
> >  	rc =3D 0;
> >  out:
> > +	if (rc < 0) {
> > +		for_each_possible_cpu(i) {
> > +			struct page_pool *pp_ptr =3D this_cpu_read(page_pool);
>=20
> this_cpu_read() -> per_cpu_ptr()?

ack, I will fix it.

Regards,
Lorenzo

>=20
> > +
> > +			if (!pp_ptr)
> > +				continue;
> > +
> > +			page_pool_destroy(pp_ptr);
> > +			per_cpu(page_pool, i) =3D NULL;
> > +		}
> > +	}
> > +
> >  	return rc;
> >  }
>=20
>=20

--t7HFx7zhTzopyoJv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZbeiZQAKCRA6cBh0uS2t
rPrfAQDWVTEyiJb6xP1bIrl2vekhXG29VwHF7IKXJC/eup9Y0AEA6EqHOog0YCva
u7qA1QY4Kmy11xuk24H3A4HBd+UkwgQ=
=QKN6
-----END PGP SIGNATURE-----

--t7HFx7zhTzopyoJv--


