Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBCD411119
	for <lists+bpf@lfdr.de>; Mon, 20 Sep 2021 10:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhITIjn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Sep 2021 04:39:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30541 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234158AbhITIiz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Sep 2021 04:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632127048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gYgK4jQ8dPS3k+veeE2Irpao848Z+jPaY59OoYwZ+eU=;
        b=JSW8FotxIqOgUB0rXwJvxO7fN1eMZE8wTTQ997WRM4kq4Blf0AfRl1YFDSq9ByvO17Pm9M
        0qpu+YYQD85ffOtT39252OHGZSgR85rz81QBj7UliT+wWBUcM7y4UMiQ0nbHWDR+yh2yM1
        sgiEDPG2Z4WU4014762NwxJzSDmB57A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-c70v9t_tOA6_R-aPpkyIkQ-1; Mon, 20 Sep 2021 04:37:24 -0400
X-MC-Unique: c70v9t_tOA6_R-aPpkyIkQ-1
Received: by mail-wm1-f70.google.com with SMTP id v5-20020a1cac05000000b0030b85d2d479so100124wme.9
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 01:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gYgK4jQ8dPS3k+veeE2Irpao848Z+jPaY59OoYwZ+eU=;
        b=1wiNKl8/44i0ia7AxAu7sp6RZa4b+9cQWtRavXAu5kx+zkPvGHqBDnvZ45w6MS6wZj
         oipYYMNuun2jkvEnj0ZlK42nzvyl8jZ3uUvOJv56Zj78GwyGJcAb+4TL8m/l9uyYb70N
         pNWWQ6yX780Tatzw+vYP3TuXRlhtSK/oNDMqyVrtrPDbpSJG3MLyEU+RJU6QDwr4M7fQ
         GTC268dhWuy7TUDX4jRmXwyl3pdI62gfhoqMEpnD9PSr7Z1hSQzYjN8DkzEmOjnp2cr3
         9pkqzHd8HW8KP2w39DpSXABROiOMa+n7cxf6GQPckmfTIALR5DjRHP4b+ftVo/co6zap
         v5ig==
X-Gm-Message-State: AOAM5325PXu0dB7iAdgsbwKJNHXSYY1vjxNHgpKZWrCVGaKdMmfd4rJK
        4IbPCH2nmIoEVEmtgZRMUopLKVEUmYKvJohk4FaWYvddpy3qzQj1KdkGwRyUaeiUTpr3/4xYOhQ
        UrL14G81WgbOy
X-Received: by 2002:adf:ce84:: with SMTP id r4mr27299080wrn.107.1632127042929;
        Mon, 20 Sep 2021 01:37:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwd1Bt0lR/J03gYLONSFIiyXq88wd4UjJM1kSbjxwss+8NsZAob8n+sZWyu1UUFeKW8+CxLag==
X-Received: by 2002:adf:ce84:: with SMTP id r4mr27299064wrn.107.1632127042741;
        Mon, 20 Sep 2021 01:37:22 -0700 (PDT)
Received: from localhost (net-130-25-199-50.cust.vodafonedsl.it. [130.25.199.50])
        by smtp.gmail.com with ESMTPSA id c8sm7924480wru.30.2021.09.20.01.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 01:37:22 -0700 (PDT)
Date:   Mon, 20 Sep 2021 10:37:20 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Shay Agroskin <shayagr@amazon.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        dsahern@kernel.org, brouer@redhat.com, echaudro@redhat.com,
        jasowang@redhat.com, alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com, toke@redhat.com
Subject: Re: [PATCH v14 bpf-next 03/18] net: mvneta: update mb bit before
 passing the xdp buffer to eBPF layer
Message-ID: <YUhIQEIJxLRPpaRP@lore-desk>
References: <cover.1631289870.git.lorenzo@kernel.org>
 <f11d8399e17bc82f9ffcb613da0a457a96f56fec.1631289870.git.lorenzo@kernel.org>
 <pj41zlh7ef8xgt.fsf@u570694869fb251.ant.amazon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UA4i3FwRTjGeOf5o"
Content-Disposition: inline
In-Reply-To: <pj41zlh7ef8xgt.fsf@u570694869fb251.ant.amazon.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--UA4i3FwRTjGeOf5o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > ...
> > diff --git a/drivers/net/ethernet/marvell/mvneta.c
> > b/drivers/net/ethernet/marvell/mvneta.c
> > index 9d460a270601..0c7b84ca6efc 100644
> > --- a/drivers/net/ethernet/marvell/mvneta.c
> > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > ...
> > @@ -2320,8 +2325,12 @@ mvneta_swbm_build_skb(struct mvneta_port *pp,
> > struct page_pool *pool,
> >  		      struct xdp_buff *xdp, u32 desc_status)
> >  {
> >  	struct skb_shared_info *sinfo =3D  xdp_get_shared_info_from_buff(xdp);
> > -	int i, num_frags =3D sinfo->nr_frags;
> >  	struct sk_buff *skb;
> > +	u8 num_frags;
> > +	int i;
> > +
> > +	if (unlikely(xdp_buff_is_mb(xdp)))
> > +		num_frags =3D sinfo->nr_frags;
>=20
> Hi,
> nit, it seems that the num_frags assignment can be moved after the other
> 'if' condition you added (right before the 'for' for num_frags), or even =
be
> eliminated completely so that sinfo->nr_frags is used directly.
> Either way it looks like you can remove one 'if'.
>=20
> Shay

Hi Shay,

we can't move nr_frags assignement after build_skb() since this field will =
be
overwritten by that call.

Regards,
Lorenzo

>=20
> >  	skb =3D build_skb(xdp->data_hard_start, PAGE_SIZE);
> >  	if (!skb)
> > @@ -2333,6 +2342,9 @@ mvneta_swbm_build_skb(struct mvneta_port *pp,
> > struct page_pool *pool,
> >  	skb_put(skb, xdp->data_end - xdp->data);
> >  	skb->ip_summed =3D mvneta_rx_csum(pp, desc_status);
> > +	if (likely(!xdp_buff_is_mb(xdp)))
> > +		goto out;
> > +
> >  	for (i =3D 0; i < num_frags; i++) {
> >  		skb_frag_t *frag =3D &sinfo->frags[i];
> >   @@ -2341,6 +2353,7 @@ mvneta_swbm_build_skb(struct mvneta_port *pp,
> > struct page_pool *pool,
> >  				skb_frag_size(frag), PAGE_SIZE);
> >  	}
> > +out:
> >  	return skb;
> >  }
>=20

--UA4i3FwRTjGeOf5o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYUhIQAAKCRA6cBh0uS2t
rBmfAP9w7lk5Q/MjTbSdfWiCIoBslUWDYZoNKZLUsiloEYcpOQD8DwKzOQI+Z7T0
mSjfB0Y7aaF77m96RBnLiVxBv6e0WQY=
=GN9Z
-----END PGP SIGNATURE-----

--UA4i3FwRTjGeOf5o--

