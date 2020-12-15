Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68752DAFC4
	for <lists+bpf@lfdr.de>; Tue, 15 Dec 2020 16:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgLOPII (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Dec 2020 10:08:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730149AbgLOPHy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 15 Dec 2020 10:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608044788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DcdqPcWVa7Q5OJlIrxC80T8T6quWzmePI9cxg9pK7z0=;
        b=HG/Mk1YqeDpQ3azJHubnelwvGk8z3e3yqjDMNDVHWGM/+LLAPvoOxd97wMCW1g0yM8QSiW
        pd0L3W5EW5pVhl2yiE/E5KRbQMgxr5hJ5tJPIPusVJr2t7qG9lqyGA8n7ZFe/MG7tA3n3c
        Jb8aODmHcmP0eXwJPlNSx1aEH6CRuJA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-9bAN48X0Naa0bv1uQvKk6w-1; Tue, 15 Dec 2020 10:06:26 -0500
X-MC-Unique: 9bAN48X0Naa0bv1uQvKk6w-1
Received: by mail-ej1-f71.google.com with SMTP id ny19so6090976ejb.10
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 07:06:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DcdqPcWVa7Q5OJlIrxC80T8T6quWzmePI9cxg9pK7z0=;
        b=NMELPSKeqQM725hg8CoEOz5Bd0GBJCrcadqmlpwGvwlxacdBo2YOv12eyqY7/3+ikS
         LqIApq85bKko+F3k04QH6UQpZkGPpxDoeqMLb+3DFsE49zAGDwSsrsWVwL8tA1uzKA5y
         dN0NgQI6WYgc88VtVn/WnpBfBj6ambu55q8fI74O1XCb3MWol5hRlSK5m4RzbQfPIrUV
         O8J5xzwf/ZSkdbATZAvN1vgU/jO3orZ8X1lKBeEhi0z9QVCRiJylF5uIGap+hhoR9mif
         0asTspsWUtoFrvTQ5JgCLFofAL627CWtqBEOwcLj94skCsTZeWVpWI1IKCvVzKKnEhUM
         vlLA==
X-Gm-Message-State: AOAM532wK+vaOXHbYpRmCl9rUl9GqXAQLLXbN6mzuTLt6hxP4wSA69mL
        vutGRni25PgTQs1n7IYl+2nAmJ6OhRLoX+SojHcGTWGARBsaEaw3O2IEpfhEAn9vSs4PqjMPbzu
        Ewvy+pZtu4WXc
X-Received: by 2002:a17:906:6d14:: with SMTP id m20mr7607436ejr.3.1608044784688;
        Tue, 15 Dec 2020 07:06:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/hzDgKivoIdgH5LF2UMjNGzM5XKukCkVfBH4dxR7iYBaD+/yZlOkUCx8Zfx6cP5TcbS9rlQ==
X-Received: by 2002:a17:906:6d14:: with SMTP id m20mr7607420ejr.3.1608044784429;
        Tue, 15 Dec 2020 07:06:24 -0800 (PST)
Received: from localhost ([151.66.8.153])
        by smtp.gmail.com with ESMTPSA id l12sm1572098ejk.10.2020.12.15.07.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 07:06:23 -0800 (PST)
Date:   Tue, 15 Dec 2020 16:06:20 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, brouer@redhat.com, alexander.duyck@gmail.com,
        saeed@kernel.org
Subject: Re: [PATCH v3 bpf-next 2/2] net: xdp: introduce xdp_prepare_buff
 utility routine
Message-ID: <20201215150620.GC5477@lore-desk>
References: <cover.1607794551.git.lorenzo@kernel.org>
 <71d5ae9f810c2c80f1cb09e304330be0b5ce5345.1607794552.git.lorenzo@kernel.org>
 <20201215123643.GA23785@ranger.igk.intel.com>
 <20201215134710.GB5477@lore-desk>
 <6886cd02-8dec-1905-b878-d45ee9a0c9b4@iogearbox.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Content-Disposition: inline
In-Reply-To: <6886cd02-8dec-1905-b878-d45ee9a0c9b4@iogearbox.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 12/15/20 2:47 PM, Lorenzo Bianconi wrote:
> [...]
> > > > diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
> > > > index 329397c60d84..61d3f5f8b7f3 100644
> > > > --- a/drivers/net/xen-netfront.c
> > > > +++ b/drivers/net/xen-netfront.c
> > > > @@ -866,10 +866,8 @@ static u32 xennet_run_xdp(struct netfront_queu=
e *queue, struct page *pdata,
> > > >   	xdp_init_buff(xdp, XEN_PAGE_SIZE - XDP_PACKET_HEADROOM,
> > > >   		      &queue->xdp_rxq);
> > > > -	xdp->data_hard_start =3D page_address(pdata);
> > > > -	xdp->data =3D xdp->data_hard_start + XDP_PACKET_HEADROOM;
> > > > +	xdp_prepare_buff(xdp, page_address(pdata), XDP_PACKET_HEADROOM, l=
en);
> > > >   	xdp_set_data_meta_invalid(xdp);
> > > > -	xdp->data_end =3D xdp->data + len;
> > > >   	act =3D bpf_prog_run_xdp(prog, xdp);
> > > >   	switch (act) {
> > > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > > index 3fb3a9aa1b71..66d8a4b317a3 100644
> > > > --- a/include/net/xdp.h
> > > > +++ b/include/net/xdp.h
> > > > @@ -83,6 +83,18 @@ xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz=
, struct xdp_rxq_info *rxq)
> > > >   	xdp->rxq =3D rxq;
> > > >   }
> > > > +static inline void
>=20
> nit: maybe __always_inline

ack, I will add in v4

>=20
> > > > +xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
> > > > +		 int headroom, int data_len)
> > > > +{
> > > > +	unsigned char *data =3D hard_start + headroom;
> > > > +
> > > > +	xdp->data_hard_start =3D hard_start;
> > > > +	xdp->data =3D data;
> > > > +	xdp->data_end =3D data + data_len;
> > > > +	xdp->data_meta =3D data;
> > > > +}
> > > > +
> > > >   /* Reserve memory area at end-of data area.
> > > >    *
>=20
> For the drivers with xdp_set_data_meta_invalid(), we're basically setting=
 xdp->data_meta
> twice unless compiler is smart enough to optimize the first one away (did=
 you double check?).
> Given this is supposed to be a cleanup, why not integrate this logic as w=
ell so the
> xdp_set_data_meta_invalid() doesn't get extra treatment?

we discussed it before, but I am fine to add it in v4. Something like:

static __always_inline void
xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
		 int headroom, int data_len, bool meta_valid)
{
	unsigned char *data =3D hard_start + headroom;
=09
	xdp->data_hard_start =3D hard_start;
	xdp->data =3D data;
	xdp->data_end =3D data + data_len;
	xdp->data_meta =3D meta_valid ? data : data + 1;
}

Regards,
Lorenzo

>=20
> Thanks,
> Daniel
>=20

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX9jQ6AAKCRA6cBh0uS2t
rM8MAP9MLACgU0TRzTmmVZqiZXhgAObLDiHlg/VGOVnt6OtOtgD/Q1/EVSFdDnVu
eQ1XTE3yuMXo1ItYaK02rFNMiWIcdAk=
=BCK6
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--

