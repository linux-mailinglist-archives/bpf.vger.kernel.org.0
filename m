Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCAA03BD4C0
	for <lists+bpf@lfdr.de>; Tue,  6 Jul 2021 14:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbhGFMRJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Jul 2021 08:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239726AbhGFL4B (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 6 Jul 2021 07:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625572403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v+KqBRx37GHazbrEYLLrAx3jPN6x/mr0O28bD/AHrEQ=;
        b=atalgSdnNUM8at1Lpg3PQ4Mi/QUVFUiluM+mAcmIDGaeTGfulZyGYTvJC2SNiyoxFn9aCm
        7IQ52ezcmbR58TTwYo1f88DrD4eg7Zt6dDWR7Y7Lnq/f/ZlEdb+Trut/Klir26ZfJLe+h1
        HP9aBK7fBdxF6g3w51q2imm2jfzSLFM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-t7chfggmP6isByCus6OLZA-1; Tue, 06 Jul 2021 07:53:21 -0400
X-MC-Unique: t7chfggmP6isByCus6OLZA-1
Received: by mail-ed1-f70.google.com with SMTP id p13-20020a05640210cdb029039560ff6f46so10669225edu.17
        for <bpf@vger.kernel.org>; Tue, 06 Jul 2021 04:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v+KqBRx37GHazbrEYLLrAx3jPN6x/mr0O28bD/AHrEQ=;
        b=tgOANz3YsNJVOHjhIOOmWcO3JTVmComQJHAZUWSeXH2l+t9P+5DZahTaIAOzxV5apC
         2apiva9sB9NftWQbWH7K7Xa7u7LGfLAWO4OTfY3ZeD4xPNAyvnFknybICB4g3FB6FKoI
         cyZDa6xlRxI2Yy9EOBYMlb5Yo7KfTcd5sWKin8tDVgJw3VXy5YszWIPeLR0kBERfGNW7
         sYQE36lZbao/4WiZ41c2IcTf8Beg/7Sgx+boAVOaPNbrrMjrhzm5nOkYwh9Ddo355uZE
         dQQurQeLuyUYNyDaLzwdpcjVmEKyK4KbRhkTLm0k1ofhhjlyINfOwEc7uO2CqH25P8Wn
         svGQ==
X-Gm-Message-State: AOAM530SWkQWmDfKVHgTOgPlHdY+i9uyM8sXgf/11DsWE+e1HHV+Pb7P
        QRN7oQ/8+Fh7tvFIrovbawC7VEZgvp0U0c79hj4VIaSjtm97lgD7GO0Ix3IEKrDK6hZZhGEM1/Q
        RyG3WQ6jIxn2X
X-Received: by 2002:a05:6402:28a1:: with SMTP id eg33mr22453593edb.249.1625572400271;
        Tue, 06 Jul 2021 04:53:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEfb/3dVMfJMNrITNAg2I1tARs2f2DFCfF9AM3+rFYnT+3k7BTi74dHnYH6VHbNpvZuTehtw==
X-Received: by 2002:a05:6402:28a1:: with SMTP id eg33mr22453579edb.249.1625572400123;
        Tue, 06 Jul 2021 04:53:20 -0700 (PDT)
Received: from localhost (net-93-71-3-244.cust.vodafonedsl.it. [93.71.3.244])
        by smtp.gmail.com with ESMTPSA id d13sm7039781edt.31.2021.07.06.04.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 04:53:19 -0700 (PDT)
Date:   Tue, 6 Jul 2021 13:53:16 +0200
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
Subject: Re: [PATCH v9 bpf-next 02/14] xdp: introduce flags field in
 xdp_buff/xdp_frame
Message-ID: <YORELD7ve/RMYsua@lore-desk>
References: <cover.1623674025.git.lorenzo@kernel.org>
 <1316f3ef2763ff4c02244fb726c61568c972514c.1623674025.git.lorenzo@kernel.org>
 <CAKgT0Ue7TsgwbQF+mfeDB-18Q-R29YZWe=y6Kgeg0xxbwds=vw@mail.gmail.com>
 <YNsVcy8e4Mgyg7g3@lore-desk>
 <CAKgT0Ucg5RbzKt63u5RfXee94kd+1oJ+o_qgUwCwnVCoQjDdPw@mail.gmail.com>
 <YOMq0WRu4lsGZJk2@lore-desk>
 <CAKgT0Udn90g9s3RYiGA0hFz7bXaepPNJNqgRjMtwjpdj1zZTDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4gKitswv7GoTaRt2"
Content-Disposition: inline
In-Reply-To: <CAKgT0Udn90g9s3RYiGA0hFz7bXaepPNJNqgRjMtwjpdj1zZTDw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--4gKitswv7GoTaRt2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Jul 5, 2021 at 8:52 AM Lorenzo Bianconi
> <lorenzo.bianconi@redhat.com> wrote:
> >
> > > On Tue, Jun 29, 2021 at 5:43 AM Lorenzo Bianconi
> > > <lorenzo.bianconi@redhat.com> wrote:

[...]
>=20
> Hi Lorenzo,
>=20
> What about doing something like breaking up the type value in
> xdp_mem_info? The fact is having it as an enum doesn't get us much
> since we have a 32b type field but are only storing 4 possible values
> there currently
>=20
> The way I see it, scatter-gather is just another memory model
> attribute rather than being something entirely new. It makes as much
> sense to have a bit there for MEM_TYPE_PAGE_SG as it does for
> MEM_TYPE_PAGE_SHARED. I would consider either splitting the type field
> into two 16b fields. For example you might have one field that
> describes the source pool which is currently either allocated page
> (ORDER0, SHARED), page_pool (PAGE_POOL), or XSK pool (XSK_BUFF_POOL),
> and then two flags for type with there being either shared and/or
> scatter-gather.

Hi Alex,

I am fine reducing the xdp_mem_info size defining type field as u16 instead=
 of
u32 but I think mb is a per-xdp_buff/xdp_frame property since at runtime we=
 can
receive a tiny single page xdp_buff/xdp_frame and a "jumbo" xdp_buff/xdp_fr=
ame
composed by multiple pages. According to the documentation available in
include/net/xdp.h, xdp_rxq_info (where xdp_mem_info is contained for xdp_bu=
ff)=20
is "associated with the driver level RX-ring queues and it is information t=
hat
is specific to how the driver have configured a given RX-ring queue" so I g=
uess
it is a little bit counterintuitive to add this info there.
Moreover we have the "issue" for devmap in dev_map_bpf_prog_run() when we
perform XDP_REDIRECT with the approach you proposed and last we can reuse t=
his
new flags filed for XDP hw-hints support.
What about reducing xdp_mem_info and add the flags field in xdp_buff/xdp_fr=
ame
in order to avoid increasing the xdp_buff/xdp_frame size? Am I missing
something?

Regards,
Lorenzo

>=20
> Also, looking over the code I don't see any reason why current
> ORDER0/SHARED couldn't be merged as the free paths are essentially
> identical since the MEM_TYPE_PAGE_SHARED path would function perfectly
> fine to free MEM_TYPE_PAGE_ORDER0 pages.
>=20
> Thanks,
>=20
> - Alex
>=20

--4gKitswv7GoTaRt2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYOREKgAKCRA6cBh0uS2t
rBYzAQDOsV2aChstpZW4dPa1vZ9yJzqGlm3aybO0ZgyCxT8J8AEAtqJojLaOE/i7
tYTXiyq/jYSzSDFG9TaHO1dx/HuBnQY=
=pqks
-----END PGP SIGNATURE-----

--4gKitswv7GoTaRt2--

