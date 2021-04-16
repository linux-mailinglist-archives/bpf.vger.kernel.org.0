Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE00B362A52
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 23:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344197AbhDPVaC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Apr 2021 17:30:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235451AbhDPVaB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Apr 2021 17:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618608575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XeO4BER1G31a5T0rppP5pwUd7m/pGl6W9xONhQxZ6VY=;
        b=hJL3qpFIxHLB/dG5bkdW+hPrJ+xDJebt+/ChX+mrYEp9GcrXIF+N8WHVHRA48Aq1uJVeD5
        +hfEbmgyqj2HCdlR1IdgcWIoWTkprOwt7YPA+aSkNFXj3fLZBcjKOkKkHrfiDnuckl3fRo
        5DDOBtpt+SppmXyXWW+x6TdRNnrG/Z4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-jZAFbjBFMtSMcasy1K-Owg-1; Fri, 16 Apr 2021 17:29:31 -0400
X-MC-Unique: jZAFbjBFMtSMcasy1K-Owg-1
Received: by mail-ed1-f69.google.com with SMTP id ay2-20020a0564022022b02903824b52f2d8so7688496edb.22
        for <bpf@vger.kernel.org>; Fri, 16 Apr 2021 14:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XeO4BER1G31a5T0rppP5pwUd7m/pGl6W9xONhQxZ6VY=;
        b=Rdmw4UBJNr2FGu1uB7DYx3QTE/O42PXafbae4jVYO7xXpbHd+zCQYS1g199aLWw+gS
         Z5XB8lqLHsYh7RX/g7yI4wj/4XH8z7GkCPAocAinJhwZ31gEhr/MuIYX/h4WVcES6ySa
         Va9QSUVWlvO/ZJbGISRiKl7s1Nlg03Z0TJYI4BqVtcGmUVRDlFcd8fvur+0HXb/AnD2E
         k5FynjjsxQlyYpODc5f2YnY9lW2LNGrOTGoY8HsuqAUWlHiLpfhxzoi3lBp8KQ9rY9M5
         2tKTDFNRaqFZY5MD2IWuZ8CHSlRYGRybgtfg6YM2S7vjLDcSCMrx+Gqh9iLIeQ1KqwK9
         GAdg==
X-Gm-Message-State: AOAM531Kel87NvPbtWSSQlaflmocfPYJnwiLxu+9//WURzg8/4FNTmXJ
        ZulGRowOYG/i5BVIrbHOxl1ATQQUYzW7r/rRRi+E1Sl5z2go3PUocEKcEGf9TPVsf0z5feAFeyi
        k8qmWsBjIgRQc
X-Received: by 2002:a05:6402:27ca:: with SMTP id c10mr11941218ede.382.1618608570315;
        Fri, 16 Apr 2021 14:29:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1vh+WAMfqnk3rkHgBWL2/nWXCYYBG9W7LGpiEfYSi2E3lKl3y6tqGMvx2ahkgLp9j6kNCgw==
X-Received: by 2002:a05:6402:27ca:: with SMTP id c10mr11941206ede.382.1618608570177;
        Fri, 16 Apr 2021 14:29:30 -0700 (PDT)
Received: from localhost ([151.66.28.185])
        by smtp.gmail.com with ESMTPSA id l1sm6513150edt.59.2021.04.16.14.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:29:29 -0700 (PDT)
Date:   Fri, 16 Apr 2021 23:29:26 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, shayagr@amazon.com,
        sameehj@amazon.com, John Fastabend <john.fastabend@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Saeed Mahameed <saeed@kernel.org>,
        "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
        Tirthendu <tirthendu.sarkar@intel.com>
Subject: Re: [PATCH v8 bpf-next 00/14] mvneta: introduce XDP multi-buffer
 support
Message-ID: <YHoBtldcPyKNFKPv@lore-desk>
References: <cover.1617885385.git.lorenzo@kernel.org>
 <CAJ8uoz1MOYLzyy7xXq_fmpKDEakxSomzfM76Szjr5gWsqHc9jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6j9e9qg2MrHVlirf"
Content-Disposition: inline
In-Reply-To: <CAJ8uoz1MOYLzyy7xXq_fmpKDEakxSomzfM76Szjr5gWsqHc9jQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--6j9e9qg2MrHVlirf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
> Took your patches for a test run with the AF_XDP sample xdpsock on an
> i40e card and the throughput degradation is between 2 to 6% depending
> on the setup and microbenchmark within xdpsock that is executed. And
> this is without sending any multi frame packets. Just single frame
> ones. Tirtha made changes to the i40e driver to support this new
> interface so that is being included in the measurements.

Hi Magnus,

thx for working on it. Assuming the fragmented part is only initialized/acc=
essed
if mb is set (so for multi frame packets), I would not expect any throughput
degradation in the single frame scenario. Can you please share the i40e
support added by Tirtha?

>=20
> What performance do you see with the mvneta card? How much are we
> willing to pay for this feature when it is not being used or can we in
> some way selectively turn it on only when needed?

IIRC I did not get sensible throughput degradation on mvneta but I will re-=
run
the tests running an updated bpf-next tree.

Regards,
Lorenzo

>=20
> Thanks: Magnus
>=20
> > Eelco Chaudron (4):
> >   bpf: add multi-buff support to the bpf_xdp_adjust_tail() API
> >   bpd: add multi-buffer support to xdp copy helpers
> >   bpf: add new frame_length field to the XDP ctx
> >   bpf: update xdp_adjust_tail selftest to include multi-buffer
> >
> > Lorenzo Bianconi (10):
> >   xdp: introduce mb in xdp_buff/xdp_frame
> >   xdp: add xdp_shared_info data structure
> >   net: mvneta: update mb bit before passing the xdp buffer to eBPF layer
> >   xdp: add multi-buff support to xdp_return_{buff/frame}
> >   net: mvneta: add multi buffer support to XDP_TX
> >   net: mvneta: enable jumbo frames for XDP
> >   net: xdp: add multi-buff support to xdp_build_skb_from_fram
> >   bpf: move user_size out of bpf_test_init
> >   bpf: introduce multibuff support to bpf_prog_test_run_xdp()
> >   bpf: test_run: add xdp_shared_info pointer in bpf_test_finish
> >     signature
> >
> >  drivers/net/ethernet/marvell/mvneta.c         | 182 ++++++++++--------
> >  include/linux/filter.h                        |   7 +
> >  include/net/xdp.h                             | 105 +++++++++-
> >  include/uapi/linux/bpf.h                      |   1 +
> >  net/bpf/test_run.c                            | 109 +++++++++--
> >  net/core/filter.c                             | 134 ++++++++++++-
> >  net/core/xdp.c                                | 103 +++++++++-
> >  tools/include/uapi/linux/bpf.h                |   1 +
> >  .../bpf/prog_tests/xdp_adjust_tail.c          | 105 ++++++++++
> >  .../selftests/bpf/prog_tests/xdp_bpf2bpf.c    | 127 ++++++++----
> >  .../bpf/progs/test_xdp_adjust_tail_grow.c     |  17 +-
> >  .../bpf/progs/test_xdp_adjust_tail_shrink.c   |  32 ++-
> >  .../selftests/bpf/progs/test_xdp_bpf2bpf.c    |   3 +-
> >  13 files changed, 767 insertions(+), 159 deletions(-)
> >
> > --
> > 2.30.2
> >
>=20

--6j9e9qg2MrHVlirf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYHoBswAKCRA6cBh0uS2t
rHN1AQD2U5dTQY+vrjWhNC2+YD/9ExF6p88dNDXyiLH5OCu6nQD/YtpEwgVSu9Mu
beXla4CsKvRxRCIQ2gtk8jj/7+OtdQk=
=L6FN
-----END PGP SIGNATURE-----

--6j9e9qg2MrHVlirf--

