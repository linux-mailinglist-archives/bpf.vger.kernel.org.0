Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9B6423D82
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 14:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbhJFMRF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 08:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44202 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238211AbhJFMRE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 08:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633522512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NLJDxGCsLtM9ccJH6kiPgyOqPYxsu/19sS8dpDIPdPM=;
        b=F/2mUppvHKa3A1/GGTnSRqInYEDSavsoNvZF0ciEZyM/yUarTaZtabaBmRTTgyKygm6rXF
        RwpCYqOzHzrRwHOB2YknRX3Hykz0yMT564YcmX1C+xzlBp7aXFV6ikEVrW+KiLl5INKGg/
        Ra5w7lkdsEyja7gLRCP2GrJ42bVyIK4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-p9EVlfP9OM26x7iJO344Ew-1; Wed, 06 Oct 2021 08:15:11 -0400
X-MC-Unique: p9EVlfP9OM26x7iJO344Ew-1
Received: by mail-ed1-f70.google.com with SMTP id g28-20020a50d0dc000000b003dae69dfe3aso2457908edf.7
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 05:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NLJDxGCsLtM9ccJH6kiPgyOqPYxsu/19sS8dpDIPdPM=;
        b=Wa+R+0Jy7bdoXRLvyTbfNFCxK0HH3fU6WO8oDk2SDgl81+qk82fw0JDdnbD5h1d/59
         wdb1lEg/bb7GhA1Cp9wLjKCtbdhTVYePNsUWnp4Jfpuv9IdYkqHuMcXZ+6MnitRSIbBw
         HiaSPQe75J2w8azNOFPptoLwTSUQ5Q4SL1OzhUt5MFwKpZFAWPAgWI6tYHAYL/++BQwd
         3n/1wP3Q+VADy+E5H5bEkFuZxwqmu9CsDJmlE2sNrtUX3Sjlm1X3VFOeUeUANBkfHnys
         TNg268sm4d8v0cZjxvu1u5Bm0U9mBDHeGWXNUjUCov6Lb/5Q+8Fn/q1zbmeSBiZywfMo
         Quuw==
X-Gm-Message-State: AOAM531tisy9TcMRGV9wg7x3PpeTjBaa5dihdxo11WJxI6ui6VWhyFXU
        s6wc/qRoBYrnk6PZl10EWiTUlq8+99AwITCkcYMj0F8uvwKe5RYpUwdTrJ14Y5Ltm//rEkT5vYR
        7VgKZdSW4arbT
X-Received: by 2002:aa7:ccc1:: with SMTP id y1mr34104029edt.177.1633522510044;
        Wed, 06 Oct 2021 05:15:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz69CHBG30WbggQA82zKcdWCkWDnt9Vz5DS7oQDFKv4bAyKG9sjyy8vtFp53tnNxHwzn/TfzA==
X-Received: by 2002:aa7:ccc1:: with SMTP id y1mr34103997edt.177.1633522509800;
        Wed, 06 Oct 2021 05:15:09 -0700 (PDT)
Received: from localhost (net-130-25-199-50.cust.vodafonedsl.it. [130.25.199.50])
        by smtp.gmail.com with ESMTPSA id r1sm4265623edp.56.2021.10.06.05.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 05:15:09 -0700 (PDT)
Date:   Wed, 6 Oct 2021 14:15:07 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Eelco Chaudron <echaudro@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, shayagr@amazon.com,
        John Fastabend <john.fastabend@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Saeed Mahameed <saeed@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        tirthendu.sarkar@intel.com
Subject: Re: [PATCH v14 bpf-next 00/18] mvneta: introduce XDP multi-buffer
 support
Message-ID: <YV2TSyQWBQWtQEEw@lore-desk>
References: <CACAyw9-8t8RpJgJUTd7u6bOLnJ1xQsgK7z37QrL9T1FUaJ7WNQ@mail.gmail.com>
 <87v92jinv7.fsf@toke.dk>
 <CACAyw99S9v658UyiKz3ad4kja7rDNfYv+9VOXZHCUOtam_C8Wg@mail.gmail.com>
 <CAADnVQ+XXGUxzqMdbPMYf+t_ViDkqvGDdogrmv-wH-dckzujLw@mail.gmail.com>
 <20210929122229.1d0c4960@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87mtnvi0bc.fsf@toke.dk>
 <YVbO/kit/mjWTrv6@lore-desk>
 <20211001113528.79f35460@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YV1tNFy971iqq0Ay@lore-desk>
 <B46C005A-CCB0-442D-A2E4-19B34ABB97CE@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DmI2FLle5PywA/6F"
Content-Disposition: inline
In-Reply-To: <B46C005A-CCB0-442D-A2E4-19B34ABB97CE@redhat.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--DmI2FLle5PywA/6F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 6 Oct 2021, at 11:32, Lorenzo Bianconi wrote:
>=20
> >> On Fri, 1 Oct 2021 11:03:58 +0200 Lorenzo Bianconi wrote:
> >>> Can you please check if the code above is aligned to current requirem=
ents or if
> >>> it is missing something?
> >>> If this code it is fine, I guess we have two option here:
> >>> - integrate the commits above in xdp multi-buff series (posting v15) =
and work on
> >>>   the verfier code in parallel (if xdp_mb_pointer helper is not requi=
red from day0)
> >>> - integrate verfier changes in xdp multi-buff series, drop bpf_xdp_lo=
ad_bytes
> >>>   helper (probably we will still need bpf_xdp_store_bytes) and introd=
uce
> >>>   bpf_xdp_pointer as new ebpf helper.
> >>
> >> It wasn't clear to me that we wanted bpf_xdp_load_bytes() to exist.
> >> But FWIW no preference here.
> >>
> >
> > ack, same here. Any other opinion about it?
>=20
> I was under the impression getting a pointer might be enough. But playing=
 with the bpf ring buffers for a bit, it still might be handy to extract so=
me data to be sent to userspace. So I would not mind keeping it.
>=20

ok, so it seems we have a use-case for bpf_xdp_load_bytes(). If everybody
agree, I will post v15 with them included and we then we can work in parall=
el
for a bpf_xdp_pointer ebpf helper.

Regards,
Lorenzo


--DmI2FLle5PywA/6F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYV2TSwAKCRA6cBh0uS2t
rKXcAQDO69mz7ZJ7gXb49kXbXF5nNs2M7SD1iJGnB381wZcg5AEAz8CLUM+dJUeC
bQoR/Bo1eLZRiij42Idr0lGejKYrgAA=
=e+yE
-----END PGP SIGNATURE-----

--DmI2FLle5PywA/6F--

