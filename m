Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614D029EDCA
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 15:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgJ2ODS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Oct 2020 10:03:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726132AbgJ2OCg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 29 Oct 2020 10:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603980144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3MS3pbx4qqX4jfmj8pSCa/S9jyck4aWSKuFZ9GMYSIg=;
        b=PsmdW+BP/RciTHQZYZqcarksm8lvjZSxFAEPGkCYqoY7rQhX9IePZwrEcYH8bjfStFfMoo
        psXcKpzbo/qQLNHzCGRG55/p1AU+YCRvoeZTj/+FS3yDr/YNOoFj/YDypBIYysSj2ptnpI
        x5u9D05sslePP9wWCT0FlGpaKkHIZqQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-3AhVb8-lObujnVkBo0bDrA-1; Thu, 29 Oct 2020 10:02:21 -0400
X-MC-Unique: 3AhVb8-lObujnVkBo0bDrA-1
Received: by mail-wr1-f71.google.com with SMTP id t11so1325244wrv.10
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2020 07:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3MS3pbx4qqX4jfmj8pSCa/S9jyck4aWSKuFZ9GMYSIg=;
        b=lbI4e7cy+nEqfZIjCuTUkOdVb+ZniSHkdwMiY2Hw/5gfT5SmuiY3OcC0EYHOvTuuK7
         VFMKfueCtRI1IvYweHoFXdOoHmZ7m70ZhCFFsPPuPqtR06wm+f9JBu/Y6hlN4POTuYCI
         vQiERPDxfEqxAleP1EBSxy1wItQ+jHW1CYdIKzBMX7fqQVtw+Ri2E9IzdIYij61UhlqV
         QVEnAdf8jMLZdXMKJHIKsI8znOnfAjHvs1D+NXt84XcyhrsGsfndP/tzyrhLIBz6kNuM
         FMay9TbqK5DsHNIE43TDH8czcjMk6btBhutwFL+9b0GHHRu7QkuWriYigegF2isgZqLc
         2uHA==
X-Gm-Message-State: AOAM533NVclfFRpMUUBUITUhkk0AQT+JdQiSyQgCj6A4ET35ujwotHLb
        axxhSbynL7BeVJIcU22qzrw3JOOWV74maDgF+SDqbOremhxWNa/xgpVtEPOFfPKDw+jLA1UN+ej
        DAfLD7L4lOr7x
X-Received: by 2002:a1c:a90e:: with SMTP id s14mr2981wme.46.1603980140628;
        Thu, 29 Oct 2020 07:02:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynZAvGh9tkrHE7n1hqoz9rfEOQoXcK+Eg63o5/OCEWjlk9szpe/tI/6tMX9pgqo9rgPEQQ3g==
X-Received: by 2002:a1c:a90e:: with SMTP id s14mr2964wme.46.1603980140432;
        Thu, 29 Oct 2020 07:02:20 -0700 (PDT)
Received: from localhost ([151.66.29.159])
        by smtp.gmail.com with ESMTPSA id x3sm4489387wmi.45.2020.10.29.07.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 07:02:19 -0700 (PDT)
Date:   Thu, 29 Oct 2020 15:02:16 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        ilias.apalodimas@linaro.org
Subject: Re: [PATCH net-next 1/4] net: xdp: introduce bulking for xdp tx
 return path
Message-ID: <20201029140216.GE15697@lore-desk>
References: <cover.1603824486.git.lorenzo@kernel.org>
 <7495b5ac96b0fd2bf5ab79b12e01bf0ee0fff803.1603824486.git.lorenzo@kernel.org>
 <20201029145239.6f6d1713@carbon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Content-Disposition: inline
In-Reply-To: <20201029145239.6f6d1713@carbon>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 27 Oct 2020 20:04:07 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index 48aba933a5a8..93eabd789246 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -380,6 +380,57 @@ void xdp_return_frame_rx_napi(struct xdp_frame *xd=
pf)
> >  }
> >  EXPORT_SYMBOL_GPL(xdp_return_frame_rx_napi);
> > =20
> > +void xdp_flush_frame_bulk(struct xdp_frame_bulk *bq)
> > +{
> > +	struct xdp_mem_allocator *xa =3D bq->xa;
> > +	int i;
> > +
> > +	if (unlikely(!xa))
> > +		return;
> > +
> > +	for (i =3D 0; i < bq->count; i++) {
> > +		struct page *page =3D virt_to_head_page(bq->q[i]);
> > +
> > +		page_pool_put_full_page(xa->page_pool, page, false);
> > +	}
> > +	bq->count =3D 0;
> > +}
> > +EXPORT_SYMBOL_GPL(xdp_flush_frame_bulk);
> > +
> > +void xdp_return_frame_bulk(struct xdp_frame *xdpf,
> > +			   struct xdp_frame_bulk *bq)
> > +{
> > +	struct xdp_mem_info *mem =3D &xdpf->mem;
> > +	struct xdp_mem_allocator *xa, *nxa;
> > +
> > +	if (mem->type !=3D MEM_TYPE_PAGE_POOL) {
> > +		__xdp_return(xdpf->data, &xdpf->mem, false);
> > +		return;
> > +	}
> > +
> > +	rcu_read_lock();
> > +
> > +	xa =3D bq->xa;
> > +	if (unlikely(!xa || mem->id !=3D xa->mem.id)) {
> > +		nxa =3D rhashtable_lookup(mem_id_ht, &mem->id, mem_id_rht_params);
> > +		if (unlikely(!xa)) {
> > +			bq->count =3D 0;
> > +			bq->xa =3D nxa;
> > +			xa =3D nxa;
> > +		}
> > +	}
> > +
> > +	if (mem->id !=3D xa->mem.id || bq->count =3D=3D XDP_BULK_QUEUE_SIZE)
> > +		xdp_flush_frame_bulk(bq);
> > +
> > +	bq->q[bq->count++] =3D xdpf->data;
> > +	if (mem->id !=3D xa->mem.id)
> > +		bq->xa =3D nxa;
> > +
> > +	rcu_read_unlock();
> > +}
> > +EXPORT_SYMBOL_GPL(xdp_return_frame_bulk);
>=20
> We (Ilias my co-maintainer and I) think above code is hard to read and
> understand (as a reader you need to keep too many cases in your head).
>=20
> I think we both have proposals to improve this, here is mine:
>=20
> /* Defers return when frame belongs to same mem.id as previous frame */
> void xdp_return_frame_bulk(struct xdp_frame *xdpf,
>                            struct xdp_frame_bulk *bq)
> {
>         struct xdp_mem_info *mem =3D &xdpf->mem;
>         struct xdp_mem_allocator *xa;
>=20
>         if (mem->type !=3D MEM_TYPE_PAGE_POOL) {
>                 __xdp_return(xdpf->data, &xdpf->mem, false);
>                 return;
>         }
>=20
>         rcu_read_lock();
>=20
>         xa =3D bq->xa;
>         if (unlikely(!xa)) {
> 		xa =3D rhashtable_lookup(mem_id_ht, &mem->id, mem_id_rht_params);
>                 bq->count =3D 0;
>                 bq->xa =3D xa;
>         }
>=20
>         if (bq->count =3D=3D XDP_BULK_QUEUE_SIZE)
>                 xdp_flush_frame_bulk(bq);
>=20
>         if (mem->id !=3D xa->mem.id) {
> 		xdp_flush_frame_bulk(bq);
> 		bq->xa =3D rhashtable_lookup(mem_id_ht, &mem->id, mem_id_rht_params);
>         }
>=20
> 	bq->q[bq->count++] =3D xdpf->data;
>=20
>         rcu_read_unlock();
> }
>=20
> Please review for correctness, and also for readability.

the code seems fine to me (and even easier to read :)).
I will update v2 using this approach. Thx.

Regards,
Lorenzo

>=20
> --=20
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>=20

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX5rLZgAKCRA6cBh0uS2t
rJuMAQCN8HaEDJ+NUa/83HHc56YusU0vrRV8xjpUZlzjjU4K2wEAh+3uEv48MB0u
aKm0nUoJy/c8FIWD61xc4yDQ7G+rmgM=
=rW7Y
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--

