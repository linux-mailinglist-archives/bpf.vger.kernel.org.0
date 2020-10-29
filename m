Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813D629E91C
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 11:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgJ2KhK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Oct 2020 06:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726266AbgJ2KhK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 29 Oct 2020 06:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603967828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FdtfNOJJRBxkYl33Se5aA6YmrpQ9HjRR7fCyRpYBu90=;
        b=LcDdEEyjgs2DOGJzFEKbPEmKgd9rsoVsfmDDBO7X5ppnjVQ3G2fwZnYpWSkog9aerD/NW0
        RnLG6szXVsN1SkGM5RteERA6oj1AYYh2w/Y3wcnX6CxvoLPPEMAF0SqXteYh5atlwX5NSI
        FEqHKg9nQd6DIFXyJibmBisXsyJxV3U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-pMU0cXLyM8STfzjgY7Kpgg-1; Thu, 29 Oct 2020 06:37:03 -0400
X-MC-Unique: pMU0cXLyM8STfzjgY7Kpgg-1
Received: by mail-wm1-f71.google.com with SMTP id s25so942265wmj.7
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2020 03:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FdtfNOJJRBxkYl33Se5aA6YmrpQ9HjRR7fCyRpYBu90=;
        b=Af+pMvuTb9Mndi96zvDNhM0fohDXtM86AyjCkQvexxfNme+EWrZg3U+24ythHNo7H/
         qbL/SYokbEHL0WSxULWADTzo9savwNcmVVrjQD1kANAmIKY7itvNCNuOgoSjKXq09JSp
         fY+tjElyH9O8P/TZEFNTZXQP0flSZjRsqlvOUH8X2eFzAdDwRAVDnwDdsUQ/kuBv9hg4
         NWZZbrYHPO4TDx63btxsLQlbXxyNzm4Uh8uJim+0/WgYkCS37JPcniXsGQafRK0F7wSN
         5e4YUYjQiqmzkGPT8PFjShc+aV40qVftpafNY/u8d4c7/PztxyMbwdgy6cURWKE+EgJ+
         qqOA==
X-Gm-Message-State: AOAM530fZQNtYcsxxdtraEj5Eig4eeU06FPCXfoLjLtzTiWiN+bJfj7H
        x733JPQUGj7TnBQ05u5trpYHRmyVCvn4Mi2yK7musgPTTYUgBLjWYd6GFnzyYBj73Ay1X+97il9
        mhKY5bfPYOii1
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr4948427wrm.41.1603967822543;
        Thu, 29 Oct 2020 03:37:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuHa6rschtqclx1k9tvnFUZzxYZWiPOBJp9eH5HgyhDd1tv/RbNxVqkDGeSr9oFdGiG1m0ng==
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr4948404wrm.41.1603967822354;
        Thu, 29 Oct 2020 03:37:02 -0700 (PDT)
Received: from localhost ([151.66.29.159])
        by smtp.gmail.com with ESMTPSA id s11sm4060101wrm.56.2020.10.29.03.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 03:37:01 -0700 (PDT)
Date:   Thu, 29 Oct 2020 11:36:58 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        brouer@redhat.com
Subject: Re: [PATCH net-next 2/4] net: page_pool: add bulk support for
 ptr_ring
Message-ID: <20201029103658.GB15697@lore-desk>
References: <cover.1603824486.git.lorenzo@kernel.org>
 <cd58ca966fbe11cabbd6160decea6ce748ebce9f.1603824486.git.lorenzo@kernel.org>
 <20201029070848.GA61336@apalos.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <20201029070848.GA61336@apalos.home>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,=20
>=20
> On Tue, Oct 27, 2020 at 08:04:08PM +0100, Lorenzo Bianconi wrote:
> > Introduce the capability to batch page_pool ptr_ring refill since it is
> > usually run inside the driver NAPI tx completion loop.
> >=20
> > Suggested-by: Jesper Dangaard Brouer <brouer@redhat.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  include/net/page_pool.h | 26 ++++++++++++++++++++++++++
> >  net/core/page_pool.c    | 33 +++++++++++++++++++++++++++++++++
> >  net/core/xdp.c          |  9 ++-------
> >  3 files changed, 61 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/include/net/page_pool.h b/include/net/page_pool.h
> > index 81d7773f96cd..b5b195305346 100644
> > --- a/include/net/page_pool.h
> > +++ b/include/net/page_pool.h
> > @@ -152,6 +152,8 @@ struct page_pool *page_pool_create(const struct pag=
e_pool_params *params);
> >  void page_pool_destroy(struct page_pool *pool);
> >  void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(=
void *));
> >  void page_pool_release_page(struct page_pool *pool, struct page *page);
> > +void page_pool_put_page_bulk(struct page_pool *pool, void **data,
> > +			     int count);
> >  #else
> >  static inline void page_pool_destroy(struct page_pool *pool)
> >  {
> > @@ -165,6 +167,11 @@ static inline void page_pool_release_page(struct p=
age_pool *pool,
> >  					  struct page *page)
> >  {
> >  }
> > +
> > +static inline void page_pool_put_page_bulk(struct page_pool *pool, voi=
d **data,
> > +					   int count)
> > +{
> > +}
> >  #endif
> > =20
> >  void page_pool_put_page(struct page_pool *pool, struct page *page,
> > @@ -215,4 +222,23 @@ static inline void page_pool_nid_changed(struct pa=
ge_pool *pool, int new_nid)
> >  	if (unlikely(pool->p.nid !=3D new_nid))
> >  		page_pool_update_nid(pool, new_nid);
> >  }
> > +
> > +static inline void page_pool_ring_lock(struct page_pool *pool)
> > +	__acquires(&pool->ring.producer_lock)
> > +{
> > +	if (in_serving_softirq())
> > +		spin_lock(&pool->ring.producer_lock);
> > +	else
> > +		spin_lock_bh(&pool->ring.producer_lock);
> > +}
> > +
> > +static inline void page_pool_ring_unlock(struct page_pool *pool)
> > +	__releases(&pool->ring.producer_lock)
> > +{
> > +	if (in_serving_softirq())
> > +		spin_unlock(&pool->ring.producer_lock);
> > +	else
> > +		spin_unlock_bh(&pool->ring.producer_lock);
> > +}
> > +
> >  #endif /* _NET_PAGE_POOL_H */
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index ef98372facf6..84fb21f8865e 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -11,6 +11,8 @@
> >  #include <linux/device.h>
> > =20
> >  #include <net/page_pool.h>
> > +#include <net/xdp.h>
> > +
> >  #include <linux/dma-direction.h>
> >  #include <linux/dma-mapping.h>
> >  #include <linux/page-flags.h>
> > @@ -408,6 +410,37 @@ void page_pool_put_page(struct page_pool *pool, st=
ruct page *page,
> >  }
> >  EXPORT_SYMBOL(page_pool_put_page);
> > =20
> > +void page_pool_put_page_bulk(struct page_pool *pool, void **data,
> > +			     int count)
> > +{
> > +	struct page *page_ring[XDP_BULK_QUEUE_SIZE];
> > +	int i, len =3D 0;
> > +
> > +	for (i =3D 0; i < count; i++) {
> > +		struct page *page =3D virt_to_head_page(data[i]);
> > +
> > +		if (unlikely(page_ref_count(page) !=3D 1 ||
> > +			     !pool_page_reusable(pool, page))) {
> > +			page_pool_release_page(pool, page);
>=20
> Mind switching this similarly to how page_pool_put_page() is using it?
> unlikely -> likely and remove the !

Hi Ilias,

thx for the review. ack, I will do it in v2

Regards,
Lorenzo

>=20
> > +			put_page(page);
> > +			continue;
> > +		}
> > +
> > +		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
> > +			page_pool_dma_sync_for_device(pool, page, -1);
> > +
> > +		page_ring[len++] =3D page;
> > +	}
> > +
> > +	page_pool_ring_lock(pool);
> > +	for (i =3D 0; i < len; i++) {
> > +		if (__ptr_ring_produce(&pool->ring, page_ring[i]))
> > +			page_pool_return_page(pool, page_ring[i]);
> > +	}
> > +	page_pool_ring_unlock(pool);
> > +}
> > +EXPORT_SYMBOL(page_pool_put_page_bulk);
> > +
> >  static void page_pool_empty_ring(struct page_pool *pool)
> >  {
> >  	struct page *page;
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index 93eabd789246..9f9a8d14df38 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -383,16 +383,11 @@ EXPORT_SYMBOL_GPL(xdp_return_frame_rx_napi);
> >  void xdp_flush_frame_bulk(struct xdp_frame_bulk *bq)
> >  {
> >  	struct xdp_mem_allocator *xa =3D bq->xa;
> > -	int i;
> > =20
> > -	if (unlikely(!xa))
> > +	if (unlikely(!xa || !bq->count))
> >  		return;
> > =20
> > -	for (i =3D 0; i < bq->count; i++) {
> > -		struct page *page =3D virt_to_head_page(bq->q[i]);
> > -
> > -		page_pool_put_full_page(xa->page_pool, page, false);
> > -	}
> > +	page_pool_put_page_bulk(xa->page_pool, bq->q, bq->count);
> >  	bq->count =3D 0;
> >  }
> >  EXPORT_SYMBOL_GPL(xdp_flush_frame_bulk);
> > --=20
> > 2.26.2
> >=20
>=20
> Cheers
> /Ilias
>=20

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX5qbRwAKCRA6cBh0uS2t
rN81AQDHPOZfQLb7yGeAfqPZ+QOWy6doMgjyncYe0eft71SIBwD7BLkSnS9X6YEK
3oFFtwilcK38y03EbKdA3uZVZMMEEAo=
=yWs1
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--

