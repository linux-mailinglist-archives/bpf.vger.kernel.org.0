Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B565222C7D
	for <lists+bpf@lfdr.de>; Thu, 16 Jul 2020 22:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgGPUJW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jul 2020 16:09:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56531 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729650AbgGPUJV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Jul 2020 16:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594930159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ez9kSf3C99h3MbxOXeTKF0m1HHkl4jQ86xmI9lFRRtU=;
        b=WJhSRDMrtZAaizJWYYuoThoT7FkYvqoHq9qQuwQP8HTO98kagZCUVPCofefdRq/GX+qusJ
        6uzHCoaJn+ob0DOp6PgV1J/8DKKiRWqcTjLLAfxwQg3zqfsKkblCoAsmSOEIL50R2J7gdd
        GBX5tB340CMDX7hpZoWzx35eqSvDZHU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-KhlK7-WJNguz6UKh-9QBfQ-1; Thu, 16 Jul 2020 16:09:15 -0400
X-MC-Unique: KhlK7-WJNguz6UKh-9QBfQ-1
Received: by mail-wm1-f72.google.com with SMTP id g187so5757292wme.0
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2020 13:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ez9kSf3C99h3MbxOXeTKF0m1HHkl4jQ86xmI9lFRRtU=;
        b=U3yuXcGLGx5InH5ZogUXdfqU9sWq00k+sCqEWddqmxeRnNvB0zaHnOM5aMGML1Wlu2
         Sdv9C6Z+o9YL4hMqPEVMh6f/sUd+l5Zx8n6jrret6zTnjfrVYKcs+Vh0pR2NB7HNbYkK
         cmCMb8z1sqL/KfW9SurNpSU7c+a40m0C3nOHVNTqa2tmOTIBiOlpOP61/IcQa3pnt9Ng
         7MmN1QSEdd6th+LQBUDqqEugExoBZtYPmwSBcKoinkrfk3vgM7yzVHjnIWQOV9WVptCf
         gc5vm/4L188eVktLuJTEMbzWrmjuxejQ3c3py80Tyrmfm+Uhq6jDFMhmgDB8p1ifzUxA
         +6LQ==
X-Gm-Message-State: AOAM533LR3D4dLHnsyJtf4oxsJnvkM9tQsQ5QteZoPa38DRPur/N1bs0
        T9J3bsErrVnH2rnVzhPjn6Y8/ZesqPckvDc1EoD7j9HMwj06FVlYfhG2cv3LRP4cBOpkehPT75u
        51uemu4XalHOx
X-Received: by 2002:a1c:1bc4:: with SMTP id b187mr6118064wmb.105.1594930153991;
        Thu, 16 Jul 2020 13:09:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0BayKJJx8tyF9sFuhtaRO6aybkj1qTN7Tatdq/i+X2iJesqBOHYObM2Z30+oiaJV+rkArbw==
X-Received: by 2002:a1c:1bc4:: with SMTP id b187mr6118044wmb.105.1594930153725;
        Thu, 16 Jul 2020 13:09:13 -0700 (PDT)
Received: from localhost ([151.48.133.17])
        by smtp.gmail.com with ESMTPSA id x18sm10820513wrq.13.2020.07.16.13.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 13:09:12 -0700 (PDT)
Date:   Thu, 16 Jul 2020 22:09:09 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
        davem@davemloft.net, bpf@vger.kernel.org,
        ilias.apalodimas@linaro.org, brouer@redhat.com,
        echaudro@redhat.com, sameehj@amazon.com
Subject: Re: [PATCH 2/6] net: mvneta: move skb build after descriptors
 processing
Message-ID: <20200716200909.GJ2174@localhost.localdomain>
References: <cover.1594309075.git.lorenzo@kernel.org>
 <f5e95c08e22113d21e86662f1cf5ccce16ccbfca.1594309075.git.lorenzo@kernel.org>
 <20200715125844.567e5795@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200716191251.GH2174@localhost.localdomain>
 <20200716124426.4f7c3a67@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SLfjTIIQuAzj8yil"
Content-Disposition: inline
In-Reply-To: <20200716124426.4f7c3a67@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--SLfjTIIQuAzj8yil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 16 Jul 2020 21:12:51 +0200 Lorenzo Bianconi wrote:
> > > > +static struct sk_buff *
> > > > +mvneta_swbm_build_skb(struct mvneta_port *pp, struct mvneta_rx_que=
ue *rxq,
> > > > +		      struct xdp_buff *xdp, u32 desc_status)
> > > > +{
> > > > +	struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(x=
dp);
> > > > +	int i, num_frags =3D sinfo->nr_frags;
> > > > +	skb_frag_t frags[MAX_SKB_FRAGS];
> > > > +	struct sk_buff *skb;
> > > > +
> > > > +	memcpy(frags, sinfo->frags, sizeof(skb_frag_t) * num_frags);
> > > > +
> > > > +	skb =3D build_skb(xdp->data_hard_start, PAGE_SIZE);
> > > > +	if (!skb)
> > > > +		return ERR_PTR(-ENOMEM);
> > > > +
> > > > +	page_pool_release_page(rxq->page_pool, virt_to_page(xdp->data));
> > > > +
> > > > +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> > > > +	skb_put(skb, xdp->data_end - xdp->data);
> > > > +	mvneta_rx_csum(pp, desc_status, skb);
> > > > +
> > > > +	for (i =3D 0; i < num_frags; i++) {
> > > > +		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> > > > +				frags[i].bv_page, frags[i].bv_offset,
> > > > +				skb_frag_size(&frags[i]), PAGE_SIZE);
> > > > +		page_pool_release_page(rxq->page_pool, frags[i].bv_page);
> > > > +	}
> > > > +
> > > > +	return skb;
> > > > +} =20
> > >=20
> > > Here as well - is the plan to turn more of this function into common
> > > code later on? Looks like most of this is not really driver specific.=
 =20
> >=20
> > I agree. What about adding it when other drivers will add multi-buff su=
pport?
> > (here we have even page_pool dependency)
>=20
> I guess that's okay on the condition that you're going to be the one
> adding the support to the next driver, or at least review it very
> closely to make sure it's done.

I am completely fine to work on it if I have the hw handy (or if someone el=
se
can test it) otherwise I will review the code :)

Regards,
Lorenzo

>=20
> In general vendors prove rather resistant to factoring code out,=20
> the snowflakes they feel they are.
>=20

--SLfjTIIQuAzj8yil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXxCz4gAKCRA6cBh0uS2t
rKYeAP9T+DbMpV8y5blKeFxebc+VsOhV9BX7DTvhxv2dTaQcPQEAz1I7ZrI8O+Ix
y1BTBeec7AxBIFs4X0hPIRHFwMYVAAs=
=xYTl
-----END PGP SIGNATURE-----

--SLfjTIIQuAzj8yil--

