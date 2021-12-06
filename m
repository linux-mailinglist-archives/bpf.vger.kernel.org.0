Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D4B46A59C
	for <lists+bpf@lfdr.de>; Mon,  6 Dec 2021 20:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348108AbhLFT1r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 14:27:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37865 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234018AbhLFT1r (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 6 Dec 2021 14:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638818657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S3rsO42uHxO9mNNGJSnr2GiWnzfE46YS1E4UgACqwYA=;
        b=CcTfE3iK62tbQzghHpeKCz9u/G2evUZFojwXY4VSJWVUnpGDnW9uwHrv3/EsJgOIE/zuuO
        hDT7C6fl9khDpOcvHWIEElJXYSQlQaSxDN1fNx8wI7ZxlVsmbq0yYaMuw/FYVmYFlAdWxl
        56ITUIjbfJMTLQh4ms7q63yCkRycAuw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505--LffsphtNmiIhOlY9rbpfQ-1; Mon, 06 Dec 2021 14:24:16 -0500
X-MC-Unique: -LffsphtNmiIhOlY9rbpfQ-1
Received: by mail-wm1-f72.google.com with SMTP id y141-20020a1c7d93000000b0033c2ae3583fso6560609wmc.5
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 11:24:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S3rsO42uHxO9mNNGJSnr2GiWnzfE46YS1E4UgACqwYA=;
        b=rZvZy3CpSH6LN0/ouSIA6jb+7fr30hIq9pE3twDuk2RMluFnPjdXaXtKJ/tT94AGfc
         dr6adzULt9OUzwPsgQ4whZmtTI+v/IMAIEimBWapXA2JMD2/Gigv1zvJC62e6T4aklgg
         RvQrm7j6TXro8SoEzXfv+jCQXlIb7ja42WCUYCvJaVQX4HCJ5j3IfnpntyVdox6Qh+rb
         uPPHLufVkg6Di2nwuNwJfmUr0qh9dpxOph+Wk95aGoG3V+ElrH0Mj4p+xOHSFbmeZ7X8
         OBw6LjK5eUSvGl6MskLPDghiIFjU9Qa0/5zzGeY5eBbIauxz8kT00AOpIFAt5QUkTBNY
         nplg==
X-Gm-Message-State: AOAM532aQPJh1ipOv1VwO+nK2YIxFwdGtP3+QA8ozTBO2jCKdLOSvrpH
        k0gEGJ2BwVO4ZVbOO7umRZKtLkZ7Y0xrP8ngVOJRo9CmnYlSEM2Zm4wy0eRxI+rqn+n+KYz1xkp
        39U8Pbnwr2Gih
X-Received: by 2002:adf:df89:: with SMTP id z9mr44888578wrl.336.1638818655374;
        Mon, 06 Dec 2021 11:24:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkykkLv6o5dlmxLy6TABKOGT4fSijPZX62+4gZUbqIgsOj+57hhPoOPtVAVvSCg8C2puncXQ==
X-Received: by 2002:adf:df89:: with SMTP id z9mr44888543wrl.336.1638818655167;
        Mon, 06 Dec 2021 11:24:15 -0800 (PST)
Received: from localhost (net-37-182-17-175.cust.vodafonedsl.it. [37.182.17.175])
        by smtp.gmail.com with ESMTPSA id z5sm322570wmp.26.2021.12.06.11.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 11:24:14 -0800 (PST)
Date:   Mon, 6 Dec 2021 20:24:12 +0100
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
Subject: Re: [PATCH v19 bpf-next 23/23] xdp: disable XDP_REDIRECT for xdp
 multi-buff
Message-ID: <Ya5jXHfwQltzCUns@lore-desk>
References: <cover.1638272238.git.lorenzo@kernel.org>
 <df855fe05b80746fa7f657fce78b24d582f133cb.1638272239.git.lorenzo@kernel.org>
 <88f9b4e9-9074-a507-426d-7c947f1e2b13@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xMO+1iV3FO7CJ/V+"
Content-Disposition: inline
In-Reply-To: <88f9b4e9-9074-a507-426d-7c947f1e2b13@redhat.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--xMO+1iV3FO7CJ/V+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 30/11/2021 12.53, Lorenzo Bianconi wrote:
> > XDP_REDIRECT is not fully supported yet for xdp multi-buff since not
> > all XDP capable drivers can map non-linear xdp_frame in ndo_xdp_xmit
> > so disable it for the moment.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >   net/core/filter.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >=20
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index b70725313442..a87d835d1122 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -4189,6 +4189,13 @@ int xdp_do_redirect(struct net_device *dev, stru=
ct xdp_buff *xdp,
> >   	struct bpf_map *map;
> >   	int err;
> > +	/* XDP_REDIRECT is not fully supported yet for xdp multi-buff since
> > +	 * not all XDP capable drivers can map non-linear xdp_frame in
> > +	 * ndo_xdp_xmit.
> > +	 */
> > +	if (unlikely(xdp_buff_is_mb(xdp)))
> > +		return -EOPNOTSUPP;
> > +
>=20
> This approach also exclude 'cpumap' use-case, which you AFAIK have added =
MB
> support for in this patchset.

ack, right. We can exclude CPUMAPs here.

>=20
> Generally this check is hopefully something we can remove again, once
> drivers add MB ndo_xdp_xmit support.

right.

Regards,
Lorenzo

>=20
>=20
> >   	ri->map_id =3D 0; /* Valid map id idr range: [1,INT_MAX[ */
> >   	ri->map_type =3D BPF_MAP_TYPE_UNSPEC;
> >=20
>=20

--xMO+1iV3FO7CJ/V+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYa5jXAAKCRA6cBh0uS2t
rNe0AP453sRneFopaL4JgS2CYBt61jkitTgmCgWwV+6FxiqDogD/WR821V1zz0zS
buRHjHLZY/SErVp+4xvt3vcEuKLlkA8=
=5Yr3
-----END PGP SIGNATURE-----

--xMO+1iV3FO7CJ/V+--

