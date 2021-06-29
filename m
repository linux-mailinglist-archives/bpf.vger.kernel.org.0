Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AA63B7242
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 14:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhF2Mrb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 08:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53332 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233000AbhF2Mra (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Jun 2021 08:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624970703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xIjW/V4kVWn/MdXXf2UdvAErF5+HSdnEQLS6aNgfUT0=;
        b=RoFYQg2VTG0z0lEDUgHq24RvKLjlo6T8XZnQF0zB2H/WEonSGXNeuF8kVxGkNORoivbxUu
        uKx0tkJ5BYT19KGWermztjpNfpJFMzfhO7GotVeCUa/+YfPm10PQF5Q3FgEQuLuNumqtkU
        Xe1D9UxmD40qZT8rfMvK3slN5M4nr54=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-Q4zyCUDbNJWhC1ho3AIPBA-1; Tue, 29 Jun 2021 08:45:01 -0400
X-MC-Unique: Q4zyCUDbNJWhC1ho3AIPBA-1
Received: by mail-wm1-f70.google.com with SMTP id f11-20020a05600c154bb02901e0210617aaso536694wmg.1
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 05:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xIjW/V4kVWn/MdXXf2UdvAErF5+HSdnEQLS6aNgfUT0=;
        b=t6mRl0fO85020DMdvQAKUhaSveBaOwo2YdgEcC2OObi4pTKwLwLMLaD8QVV7NRaKJ6
         MHopgN7vv95xEg079ftCRmtwXnGAl1b3rUOsknf8LhtPtHDGFm4x0yxuvDeJkfUzOghM
         /GEc+SVvwYX9eBeRNK/3i0ijX2g6F6wv7SJ+r/yxQaRrkTeOADzIGR0Thj/JpQqdis0u
         +jmg5aWOLPM5PQ470URHe7YWa0FfpC6MJLggAtKyJPGw0mGR9Q0orwlDSQGBLga0VJds
         MKIlIxW0jQoBX9+zxccNRYEFNlNJHj2LyBXQ8jVYjyfCcbS+IkzVRaPy2tR3OQXGsZFw
         pVnA==
X-Gm-Message-State: AOAM532s73nj7fzYWOIOz3e18PpLvsElU24z6Qie9yivS7U9cpMpaFGp
        HugZIA2EszQAlW9+NOW8WCWyFCrUmDDhIRqe5jAZMbnHqOYgwGThwRnPV8rgtQ0CpCO96mETkRf
        phuj+kR9rgqLy
X-Received: by 2002:a5d:5742:: with SMTP id q2mr13942857wrw.256.1624970699913;
        Tue, 29 Jun 2021 05:44:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyotqRFyli+/8rVZrv9pvFzSzm2HLFibGkrDpQKFRn5/xEi7IrLcvCjXFQPc3qOoI6HNGSmcQ==
X-Received: by 2002:a5d:5742:: with SMTP id q2mr13942835wrw.256.1624970699730;
        Tue, 29 Jun 2021 05:44:59 -0700 (PDT)
Received: from localhost (net-130-25-105-72.cust.vodafonedsl.it. [130.25.105.72])
        by smtp.gmail.com with ESMTPSA id u12sm18900267wrq.50.2021.06.29.05.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 05:44:59 -0700 (PDT)
Date:   Tue, 29 Jun 2021 14:44:56 +0200
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
Subject: Re: [PATCH v9 bpf-next 01/14] net: skbuff: add data_len field to
 skb_shared_info
Message-ID: <YNsVyBw5i4hAHRN8@lore-desk>
References: <cover.1623674025.git.lorenzo@kernel.org>
 <8ad0d38259a678fb42245368f974f1a5cf47d68d.1623674025.git.lorenzo@kernel.org>
 <CAKgT0UcwYHXosz-XuQximak63=ugb9thEc=dkUUZzDpoPCH+Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TnpqoEfdeJq0NZsS"
Content-Disposition: inline
In-Reply-To: <CAKgT0UcwYHXosz-XuQximak63=ugb9thEc=dkUUZzDpoPCH+Qg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--TnpqoEfdeJq0NZsS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Jun 14, 2021 at 5:50 AM Lorenzo Bianconi <lorenzo@kernel.org> wro=
te:
> >
> > data_len field will be used for paged frame len for xdp_buff/xdp_frame.
> > This is a preliminary patch to properly support xdp-multibuff
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  include/linux/skbuff.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index dbf820a50a39..332ec56c200d 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -522,7 +522,10 @@ struct skb_shared_info {
> >         struct sk_buff  *frag_list;
> >         struct skb_shared_hwtstamps hwtstamps;
> >         unsigned int    gso_type;
> > -       u32             tskey;
> > +       union {
> > +               u32     tskey;
> > +               u32     data_len;
> > +       };
> >
>=20
> Rather than use the tskey field why not repurpose the gso_size field?
> I would think in the XDP paths that the gso fields would be unused
> since LRO and HW_GRO would be incompatible with XDP anyway.
>=20

ack, I agree. I will fix it in v10.

Regards,
Lorenzo

--TnpqoEfdeJq0NZsS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYNsVxQAKCRA6cBh0uS2t
rEmgAP9KZXucmbMs8RGZQqN1U14pzi2BrPVzx7MbkYu4b1UwjwD+MRc5OwyXRxU2
KxbPHqzyhcEiQqaZ4ETD/w8rIWaUwAU=
=T+wb
-----END PGP SIGNATURE-----

--TnpqoEfdeJq0NZsS--

