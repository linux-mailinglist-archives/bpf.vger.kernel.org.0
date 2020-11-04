Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DB62A632B
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 12:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgKDLTr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 06:19:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24459 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729427AbgKDLTN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 06:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604488751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NPQaV625yVNAItvHPpJLsvhBr5fmhztyJVFWFfaunAg=;
        b=Eeau0/jxK3YfKVDKrBdA+EJBABgUpU8YUSg7gyYZjxk5A2E/ggX9PnBP09EOTKd3BcIctE
        +Y4hjJXlxSn48bnpwO1jLPSywVNRfbFbL6RRA13ve/bkAW/aFBDoHk6fHcqq0Q13ovZdfB
        VftG/oCjY302bv6i0ciMk0bgRlrtOOE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-WbuSNbWhNGSy0l43CAoHFA-1; Wed, 04 Nov 2020 06:19:08 -0500
X-MC-Unique: WbuSNbWhNGSy0l43CAoHFA-1
Received: by mail-wr1-f71.google.com with SMTP id e3so9152523wrn.19
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2020 03:19:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NPQaV625yVNAItvHPpJLsvhBr5fmhztyJVFWFfaunAg=;
        b=qaUC0T4inP8cETsw0q8HsMp4W1ykqltAeCx0P/YB5z2VCHEhdAETLLrEmUvedkdEcZ
         IL7hNkOiouomD5PRuy6bGeq9BczQS3FlTc7dA8RV6FqdRphqqz+c/ZqIHp5ccLjgllvY
         eV6thaLBcXsajzga6eefwsO8edDtcfMUKPzQ3HY/JXyf1lFIKVdbXl60jG9yPNtB0WBU
         3D91J8JfXKNMxBSYAo+65LosuPYz55D5sP2oIq7VEhvkVAI9a32JEMikRE1KivnYf/TP
         0WfmnaUzX/cNf+ZiP9E4VSQCXXE34Meos3F6AtyVuHrJuFqq7MQ905mkGE7/umX2Hz3H
         g+vg==
X-Gm-Message-State: AOAM531TzYDtIZgDe1Ns0PtvuFfLcJCpZ+x7bU6FHf2aXnSXtOw6JItO
        EKM4OmJPTjQ+k1iTQXlmgtKuf3+ZfCR429cPFlNejZop7ZujqyVamxTR3FnjA1OYDrjCQEyPBYH
        A5UMTMY+pmc9h
X-Received: by 2002:a7b:c453:: with SMTP id l19mr3936490wmi.2.1604488747088;
        Wed, 04 Nov 2020 03:19:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3J/O1NphQGmULpoL1xMie2efidpDkLHolKZvlQ62tQ0nydtPERwjou9V4tXLt77q8cktv1Q==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr3936467wmi.2.1604488746870;
        Wed, 04 Nov 2020 03:19:06 -0800 (PST)
Received: from localhost ([151.66.8.153])
        by smtp.gmail.com with ESMTPSA id i6sm1751352wma.42.2020.11.04.03.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 03:19:06 -0800 (PST)
Date:   Wed, 4 Nov 2020 12:19:02 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        ilias.apalodimas@linaro.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>
Subject: Re: [PATCH v3 net-next 1/5] net: xdp: introduce bulking for xdp tx
 return path
Message-ID: <20201104111902.GA11993@lore-desk>
References: <cover.1604484917.git.lorenzo@kernel.org>
 <5ef0c2886518d8ae1577c8b60ea6ef55d031673e.1604484917.git.lorenzo@kernel.org>
 <20201104121158.597fa64d@carbon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20201104121158.597fa64d@carbon>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed,  4 Nov 2020 11:22:54 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20

[...]

> > +/* XDP bulk APIs introduce a defer/flush mechanism to return
> > + * pages belonging to the same xdp_mem_allocator object
> > + * (identified via the mem.id field) in bulk to optimize
> > + * I-cache and D-cache.
> > + * The bulk queue size is set to 16 to be aligned to how
> > + * XDP_REDIRECT bulking works. The bulk is flushed when
>=20
> If this is connected, then why have you not redefined DEV_MAP_BULK_SIZE?
>=20
> Cc. DPAA2 maintainers as they use this define in their drivers.
> You want to make sure this driver is flexible enough for future changes.
>=20
> Like:
>=20
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 3814fb631d52..44440a36f96f 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -245,6 +245,6 @@ bool xdp_attachment_flags_ok(struct xdp_attachment_in=
fo *info,
>  void xdp_attachment_setup(struct xdp_attachment_info *info,
>                           struct netdev_bpf *bpf);
> =20
> -#define DEV_MAP_BULK_SIZE 16
> +#define DEV_MAP_BULK_SIZE XDP_BULK_QUEUE_SIZE

my idea was to address it in a separated patch, but if you prefer I can mer=
ge
this change in v4

> =20
>  #endif /* __LINUX_NET_XDP_H__ */
>=20
>=20
> > + * it is full or when mem.id changes.
> > + * xdp_frame_bulk is usually stored/allocated on the function
> > + * call-stack to avoid locking penalties.
> > + */
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
> > +	struct xdp_mem_allocator *xa;
> > +
> > +	if (mem->type !=3D MEM_TYPE_PAGE_POOL) {
> > +		__xdp_return(xdpf->data, &xdpf->mem, false);
> > +		return;
> > +	}
> >
>=20
> I cannot make up my mind: It would be a micro-optimization to move
> this if-statement to include/net/xdp.h, but it will make code harder to
> read/follow, and the call you replace xdp_return_frame() is also in
> xdp.c with same call to _xdp_return().  Let keep it as-is. (we can
> followup with micro-optimizations)

ack

Regards,
Lorenzo

>=20
>=20
> > +	rcu_read_lock();
> > +
> > +	xa =3D bq->xa;
> > +	if (unlikely(!xa)) {
> > +		xa =3D rhashtable_lookup(mem_id_ht, &mem->id, mem_id_rht_params);
> > +		bq->count =3D 0;
> > +		bq->xa =3D xa;
> > +	}
> > +
> > +	if (bq->count =3D=3D XDP_BULK_QUEUE_SIZE)
> > +		xdp_flush_frame_bulk(bq);
> > +
> > +	if (mem->id !=3D xa->mem.id) {
> > +		xdp_flush_frame_bulk(bq);
> > +		bq->xa =3D rhashtable_lookup(mem_id_ht, &mem->id, mem_id_rht_params);
> > +	}
> > +
> > +	bq->q[bq->count++] =3D xdpf->data;
> > +
> > +	rcu_read_unlock();
> > +}
> > +EXPORT_SYMBOL_GPL(xdp_return_frame_bulk);
> > +
> >  void xdp_return_buff(struct xdp_buff *xdp)
> >  {
> >  	__xdp_return(xdp->data, &xdp->rxq->mem, true);
>=20
>=20
>=20
> --=20
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>=20

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX6KOJAAKCRA6cBh0uS2t
rJaiAQDbBW8+rTsWk1k+SEJdVxwH7A9v0tuTn3eYUC37y76Z+wD+NIhapYe53zA2
cfI2cC5lYob/lwYfDLsFyly5IGNI5gg=
=mV0/
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--

