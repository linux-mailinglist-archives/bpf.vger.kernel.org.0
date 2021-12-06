Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FBF469BB1
	for <lists+bpf@lfdr.de>; Mon,  6 Dec 2021 16:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349857AbhLFPSP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 10:18:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31827 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346059AbhLFPOp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 6 Dec 2021 10:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638803471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I8YVfdsVmuWFyLTwXYbNGyLU3lEs0YzOVf+e12QlznI=;
        b=Yg87Z3uCBWG42kdyedP07glpxn69W3QxdH47aHmQFQg4O1yERVxjFxsxthJYZxjue3Y4yE
        xzbZlfxDV6Rniza4itRAc8wnYFSwdEsQjOVnxR/77jVeIwPj4H64NU0o9//aqA2ASI7L+P
        lob3ry0Zirv0mEKfW+6+BJ7Km8vNlCo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-9FP9Rv7dPeqUwHy1xCg0Tw-1; Mon, 06 Dec 2021 10:11:10 -0500
X-MC-Unique: 9FP9Rv7dPeqUwHy1xCg0Tw-1
Received: by mail-wm1-f70.google.com with SMTP id p12-20020a05600c1d8c00b0033a22e48203so35932wms.6
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 07:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I8YVfdsVmuWFyLTwXYbNGyLU3lEs0YzOVf+e12QlznI=;
        b=wKeGorUWgVoezLjI0gEnbWVXpLHgtuM4Q3HeihCKSbumFqlWabnf7A1KnX9jp0+1eW
         tAxvjbyDnFNgGfHuAyZ7Coh2kD/XYCoLAms3Mm3kZTmp07vhDcEto2F+hCYhQkmU1M+z
         3db6UPX0XueNDfNC86HAZUGEeyrOeYHeRy91Ka9nJIjb5rSwyIrW1ay4G1B0WWxS4nSO
         Hu2Iqf9Qc5W3vwyMsQf/CaGDfi2Sq33eLc3ulg1oew1d4c9RO+zoxxy/4bnxY6inENrJ
         /w15I5J73L4qIn0ZNORdVz6gZ3kB77eUM8zdXVaT2aQxZa3yMpGRmomJiNoy1mXr9cy7
         NMNA==
X-Gm-Message-State: AOAM532Jx6FBnVp5ZlVspdaIry+6Xu4pOfqNvZwkIkL7Y6iiYeSdub3L
        sPxE+Ttr/MzuYfFzSTNkCmKvr1/jnXkfuwUyZI8pB2135C1wuoB85QxYZJUWV4n/+pBVncuIyGR
        I7IG9HLH20Gxb
X-Received: by 2002:a5d:4b06:: with SMTP id v6mr43958069wrq.194.1638803468848;
        Mon, 06 Dec 2021 07:11:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxHmPtlb6i24RSULyO8F8snPKQnyrJ8mLFAu6nVynyOYjz4anUxoe3aA4azwqGWtWAr2wuDxA==
X-Received: by 2002:a5d:4b06:: with SMTP id v6mr43958045wrq.194.1638803468689;
        Mon, 06 Dec 2021 07:11:08 -0800 (PST)
Received: from localhost (net-37-182-17-175.cust.vodafonedsl.it. [37.182.17.175])
        by smtp.gmail.com with ESMTPSA id t11sm11906945wrz.97.2021.12.06.07.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:11:08 -0800 (PST)
Date:   Mon, 6 Dec 2021 16:11:06 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, shayagr@amazon.com,
        dsahern@kernel.org, brouer@redhat.com, echaudro@redhat.com,
        jasowang@redhat.com, alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com, toke@redhat.com
Subject: Re: [PATCH v19 bpf-next 03/23] net: mvneta: update mb bit before
 passing the xdp buffer to eBPF layer
Message-ID: <Ya4oCkbOjBHFOHyS@lore-desk>
References: <cover.1638272238.git.lorenzo@kernel.org>
 <95151f4b8a25ce38243e82f0a82104d0f46fb33a.1638272238.git.lorenzo@kernel.org>
 <61ad7e4cbc69d_444e20888@john.notmuch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="S7WehjOHIu6+ZNCa"
Content-Disposition: inline
In-Reply-To: <61ad7e4cbc69d_444e20888@john.notmuch>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--S7WehjOHIu6+ZNCa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi wrote:
> > Update multi-buffer bit (mb) in xdp_buff to notify XDP/eBPF layer and
> > XDP remote drivers if this is a "non-linear" XDP buffer. Access
> > skb_shared_info only if xdp_buff mb is set in order to avoid possible
> > cache-misses.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> [...]
>=20
> > @@ -2320,8 +2325,12 @@ mvneta_swbm_build_skb(struct mvneta_port *pp, st=
ruct page_pool *pool,
> >  		      struct xdp_buff *xdp, u32 desc_status)
> >  {
> >  	struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(xdp);
> > -	int i, num_frags =3D sinfo->nr_frags;
> >  	struct sk_buff *skb;
> > +	u8 num_frags;
> > +	int i;
> > +
> > +	if (unlikely(xdp_buff_is_mb(xdp)))
> > +		num_frags =3D sinfo->nr_frags;
>=20
> Doesn't really need a respin IMO, but rather an observation. Its not
> obvious to me the unlikely/likely pair here is wanted. Seems it could
> be relatively common for some applications sending jumbo frames.
>=20
> Maybe worth some experimenting in the future.

Probably for mvneta it will not make any difference but in general I tried =
to
avoid possible cache-misses here (accessing sinfo pointers). I will carry o=
ut
some comparison to see if I can simplify the code.

Regards,
Lorenzo

>=20
> > =20
> >  	skb =3D build_skb(xdp->data_hard_start, PAGE_SIZE);
> >  	if (!skb)
> > @@ -2333,6 +2342,9 @@ mvneta_swbm_build_skb(struct mvneta_port *pp, str=
uct page_pool *pool,
> >  	skb_put(skb, xdp->data_end - xdp->data);
> >  	skb->ip_summed =3D mvneta_rx_csum(pp, desc_status);
> > =20
> > +	if (likely(!xdp_buff_is_mb(xdp)))
> > +		goto out;
> > +
> >  	for (i =3D 0; i < num_frags; i++) {
> >  		skb_frag_t *frag =3D &sinfo->frags[i];
>=20

--S7WehjOHIu6+ZNCa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYa4oCgAKCRA6cBh0uS2t
rLqjAP9t3XmU/u/EawcvBisua/InTVuCECfa4euaDMInORkC9AEAh5gKETMpz8xF
6x5+vxGNkdNsvJdJ0Zk3mr8KCcCOtQg=
=Fm4y
-----END PGP SIGNATURE-----

--S7WehjOHIu6+ZNCa--

