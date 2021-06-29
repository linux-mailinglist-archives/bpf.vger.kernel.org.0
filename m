Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22753B77E3
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 20:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbhF2Sgl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 14:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54605 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234727AbhF2Sgk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Jun 2021 14:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624991652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R2MQbP/A49/6sDoZWA76lTlymmXsuQNCj0N0M76QdRY=;
        b=L376FkYZzOfalUO3TWCmEMwGIpbhpQOlNSKzDvUcyR3Y4lVy9Qd97gJdPAcpx7QMewBGKE
        U/NDq6Z0GoUeSrHEwkZJ5w9n1qA7dbVuxXW5iCR7rRGQJlBCuLEhH2L/p50DwGXSbAsLdk
        MKkyHimaFZxhZxcgPTuft5jletAFOm0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-CRN4AhcsMgSkGOXgXOk1GQ-1; Tue, 29 Jun 2021 14:34:11 -0400
X-MC-Unique: CRN4AhcsMgSkGOXgXOk1GQ-1
Received: by mail-wm1-f69.google.com with SMTP id i82-20020a1c22550000b02901d64e84b3c9so1927171wmi.5
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 11:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R2MQbP/A49/6sDoZWA76lTlymmXsuQNCj0N0M76QdRY=;
        b=cmunLWEVi4uZCEgVq7dGZ0hN8E8Vto4wOpCl6oZkpoSXf8O9LLkUlvcHcgoSE5Hs/r
         DnGG4UP6OWr8SbqpULmzbv544ot7KWJqz4DEUOk5TNJT3pPuhTg/Ir+TBIIB3he6hnPl
         xRwxaJLKN5YovzQCuXujAo+RMC/NUbVkTxtKZRbHYkHNc57/MbjBnCcshUazOk25Rkpo
         pjyApG0JVC2/1n1Z/iDjuhMidBOaoCl/oRBdXtdZIGrmTv+cP8h63ZnjStncUf24+bhK
         r5gc9sC4DsO8bktyfsKxIKTIn4gJjAgWsCvUyYomFL+fcx3yzThuLl2kZdFjaM4GCqji
         Q7wQ==
X-Gm-Message-State: AOAM531CKJzwcKuhZnGwHdQSucyxp7fSMyydNKMuLnKejFTBYymSlpRf
        nmFm3NM8DvNjvQxNSoE6jn4VlI4Atujf14oeZN/j9rG5b9hUcWt+bqEeB8IyLSTEEB3Jc7IFJBa
        S+pP5tQ6oUfUL
X-Received: by 2002:a05:6000:18af:: with SMTP id b15mr35087536wri.252.1624991649956;
        Tue, 29 Jun 2021 11:34:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcPU9rnK0qoPNvtCMVtvejWGLb97uNAxhvOLmQs+SuNd3G24LguhlfeXS2IC/pDz0bYVBESQ==
X-Received: by 2002:a05:6000:18af:: with SMTP id b15mr35087501wri.252.1624991649720;
        Tue, 29 Jun 2021 11:34:09 -0700 (PDT)
Received: from localhost (net-130-25-105-72.cust.vodafonedsl.it. [130.25.105.72])
        by smtp.gmail.com with ESMTPSA id r12sm19925237wrn.2.2021.06.29.11.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 11:34:09 -0700 (PDT)
Date:   Tue, 29 Jun 2021 20:34:05 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf <bpf@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, shayagr@amazon.com,
        "Jubran, Samih" <sameehj@amazon.com>,
        John Fastabend <john.fastabend@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Saeed Mahameed <saeed@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Tirthendu <tirthendu.sarkar@intel.com>
Subject: Re: [PATCH v9 bpf-next 07/14] net: xdp: add multi-buff support to
 xdp_build_skb_from_frame
Message-ID: <YNtnnT8kEgT5KdWF@lore-desk>
References: <cover.1623674025.git.lorenzo@kernel.org>
 <7f61f8f7d38cf819383db739c14c874ccd3b53e2.1623674025.git.lorenzo@kernel.org>
 <CAKgT0Ue=74BPWFDFYtWEA9DnNj35PgigDZAwCc5N6X=QpKz4GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uJais3+mmovwl+2D"
Content-Disposition: inline
In-Reply-To: <CAKgT0Ue=74BPWFDFYtWEA9DnNj35PgigDZAwCc5N6X=QpKz4GA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--uJais3+mmovwl+2D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Jun 14, 2021 at 5:51 AM Lorenzo Bianconi <lorenzo@kernel.org> wro=
te:
> >
> > Introduce xdp multi-buff support to
> > __xdp_build_skb_from_frame/xdp_build_skb_from_frame
> > utility routines.
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  net/core/xdp.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index f61c63115c95..71bedf6049a1 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -582,9 +582,15 @@ struct sk_buff *__xdp_build_skb_from_frame(struct =
xdp_frame *xdpf,
> >                                            struct sk_buff *skb,
> >                                            struct net_device *dev)
> >  {
> > +       struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_fram=
e(xdpf);
> >         unsigned int headroom, frame_size;
> > +       int i, num_frags =3D 0;
> >         void *hard_start;
> >
> > +       /* xdp multi-buff frame */
> > +       if (unlikely(xdp_frame_is_mb(xdpf)))
> > +               num_frags =3D sinfo->nr_frags;
> > +
> >         /* Part of headroom was reserved to xdpf */
> >         headroom =3D sizeof(*xdpf) + xdpf->headroom;
> >
> > @@ -603,6 +609,13 @@ struct sk_buff *__xdp_build_skb_from_frame(struct =
xdp_frame *xdpf,
> >         if (xdpf->metasize)
> >                 skb_metadata_set(skb, xdpf->metasize);
> >
> > +       for (i =3D 0; i < num_frags; i++)
> > +               skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> > +                               skb_frag_page(&sinfo->frags[i]),
> > +                               skb_frag_off(&sinfo->frags[i]),
> > +                               skb_frag_size(&sinfo->frags[i]),
> > +                               xdpf->frame_sz);
> > +
>=20
> So this is assuming the header frame and all of the frags are using
> the same size. Rather than reading the frags out and then writing them
> back, why not just directly rewrite the nr_frags, add the total size
> to skb->len and skb->data_len, and then update the truesize?

ack, thx. I will look into it.

Regards,
Lorenzo

>=20
> Actually, I think you might need to store the truesize somewhere in
> addition to the data_len that you were storing in the shared info.
>=20

--uJais3+mmovwl+2D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYNtnmgAKCRA6cBh0uS2t
rByTAP48uTzQfVi3Y083nkrWyBKDEIBTRRGiNRYgl5DBie62FgD/TwBjA7pHEvMR
e0s53x1QbwTkNicllhT0lkoa0SE+Xw0=
=7yl3
-----END PGP SIGNATURE-----

--uJais3+mmovwl+2D--

