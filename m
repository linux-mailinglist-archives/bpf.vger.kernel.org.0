Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B713402A04
	for <lists+bpf@lfdr.de>; Tue,  7 Sep 2021 15:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344269AbhIGNqF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 09:46:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344791AbhIGNp4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Sep 2021 09:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631022290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lnk+MQgYpOvpu6ZC3StBomend8wJttqrx2hILwEGg6U=;
        b=boirB9fAqcjuYnW8nKTnR6cc/TLB7woroMmUGPgfoKLxXzArsJWDDsCBMQEosUzxPIdXE9
        u7eIGukJlsm4AvIz9UYHOldaoedCO725dGYHsuoLwNypcK0koIwXJZtnNvqL0dM+TWCFDR
        Jf6qxctZQF1kmLtxOxuIOdi4aoy3NBw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-HMu6z3v8NbWp0VN2JOacdA-1; Tue, 07 Sep 2021 09:44:49 -0400
X-MC-Unique: HMu6z3v8NbWp0VN2JOacdA-1
Received: by mail-ed1-f70.google.com with SMTP id w18-20020aa7cb52000000b003c95870200fso5168532edt.16
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 06:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lnk+MQgYpOvpu6ZC3StBomend8wJttqrx2hILwEGg6U=;
        b=L96FLYcqhh/cgkLyeOtTJTSwv6OcqxeYqCvk1rR+ujCgapVS1hxdzj4T07VzMAyW6D
         Xpcz96chM7BXuLieoPDDHK+FCX7UqRofCsT8AooolQlDj4TVe/Bc1jfeVOEI1wTl3eLL
         fiLL7hvIVFPZ/lLtPRjEtdkUa3KPJ6CDsHKKjp0EQcOXx9oeG0kVLzEdNUaUny8V5dOC
         Dl1OB0HjBO1Jm5t2IxUwxGyvDh1dyFt6EgvLPUd/IbI2mxO4wfnqJ6cO3dGJHlLp1HuX
         o5C7XlPIMhc8n4umhBwdlhd/6s2Rs+EZZciJp17JrJvnoiJ9YOFixWhWUZHNSDYJfylj
         9xjA==
X-Gm-Message-State: AOAM530Y1sMFHM6AlVtixmiuUSbEmPWtK4ng7F/GBU8odSyDa848bG4W
        AndJA/DYQ9+FQTJVxxALdywhv9afyOH8FHjgjHVuUIyGLDN1J9hznphaWewqVfZtTBE//tZ/GfN
        AH19rsPW4r0n8
X-Received: by 2002:a17:906:a0da:: with SMTP id bh26mr18289208ejb.505.1631022287819;
        Tue, 07 Sep 2021 06:44:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVF/1iqIfSrn6+Si0AdBKy73K2PY5tGqudcMlZdwkLzqypht3xb386lYimlwo97HcwjdtQDA==
X-Received: by 2002:a17:906:a0da:: with SMTP id bh26mr18289182ejb.505.1631022287623;
        Tue, 07 Sep 2021 06:44:47 -0700 (PDT)
Received: from localhost (net-37-116-49-210.cust.vodafonedsl.it. [37.116.49.210])
        by smtp.gmail.com with ESMTPSA id ly7sm5580034ejb.109.2021.09.07.06.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 06:44:47 -0700 (PDT)
Date:   Tue, 7 Sep 2021 15:44:44 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, brouer@redhat.com, davem@davemloft.net,
        kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        shayagr@amazon.com, john.fastabend@gmail.com, dsahern@kernel.org,
        echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com, toke@redhat.com
Subject: Re: [PATCH v13 bpf-next 05/18] net: xdp: add
 xdp_update_skb_shared_info utility routine
Message-ID: <YTdszJFfSUVCacJq@lore-desk>
References: <cover.1631007211.git.lorenzo@kernel.org>
 <f46a84381037e76ff0e812abd77a0670d0d14767.1631007211.git.lorenzo@kernel.org>
 <29fc47da-f9b3-9698-d58d-a06010945a21@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yBVkDLz2+tzWwFpW"
Content-Disposition: inline
In-Reply-To: <29fc47da-f9b3-9698-d58d-a06010945a21@redhat.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--yBVkDLz2+tzWwFpW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
>=20
> Do we need to clear gso_type here as it is shared/union with xdp_frags_si=
ze
> ?
> (see below ... it is already cleared before call)
>=20
>=20
> > +}
> > +
> >   /* Avoids inlining WARN macro in fast-path */
> >   void xdp_warn(const char *msg, const char *func, const int line);
> >   #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index cc92ccb38432..504be3ce3ca9 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -531,8 +531,20 @@ struct sk_buff *__xdp_build_skb_from_frame(struct =
xdp_frame *xdpf,
> >   					   struct sk_buff *skb,
> >   					   struct net_device *dev)
> >   {
> > +	unsigned int frag_size, frag_tsize;
> >   	unsigned int headroom, frame_size;
> >   	void *hard_start;
> > +	u8 nr_frags;
> > +
> > +	/* xdp multi-buff frame */
> > +	if (unlikely(xdp_frame_is_mb(xdpf))) {
> > +		struct skb_shared_info *sinfo;
> > +
> > +		sinfo =3D xdp_get_shared_info_from_frame(xdpf);
> > +		frag_tsize =3D sinfo->xdp_frags_tsize;
> > +		frag_size =3D sinfo->xdp_frags_size;
> > +		nr_frags =3D sinfo->nr_frags;
> > +	}
> >   	/* Part of headroom was reserved to xdpf */
> >   	headroom =3D sizeof(*xdpf) + xdpf->headroom;
> > @@ -552,6 +564,11 @@ struct sk_buff *__xdp_build_skb_from_frame(struct =
xdp_frame *xdpf,
> >   	if (xdpf->metasize)
> >   		skb_metadata_set(skb, xdpf->metasize);
> > +	if (unlikely(xdp_frame_is_mb(xdpf)))
> > +		xdp_update_skb_shared_info(skb, nr_frags,
> > +					   frag_size, frag_tsize,
> > +					   xdp_frame_is_frag_pfmemalloc(xdpf));
> > +
>=20
> There is a build_skb_around() call before this call, which via
> __build_skb_around() will clear top part of skb_shared_info.
> (Thus, clearing gso_type not needed ... see above)

yes, this is why I need save sinfo->nr_frags, sinfo->xdp_frags_size, ...

Regards,
Lorenzo

>=20
> >   	/* Essential SKB info: protocol and skb->dev */
> >   	skb->protocol =3D eth_type_trans(skb, dev);
>=20
>=20
> Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
>=20

--yBVkDLz2+tzWwFpW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYTdsyQAKCRA6cBh0uS2t
rP7VAQCodpQzoU+PTk71eMryk6U1HRGFxa639QDaWonfRCbuOAEAzm81W4puZ4b6
eOxQy90Iz+BYLViTC61rFEyS5nI8HgU=
=t6rt
-----END PGP SIGNATURE-----

--yBVkDLz2+tzWwFpW--

