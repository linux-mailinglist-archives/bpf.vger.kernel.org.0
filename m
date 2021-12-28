Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A66480A78
	for <lists+bpf@lfdr.de>; Tue, 28 Dec 2021 15:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhL1Oph (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Dec 2021 09:45:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34337 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233186AbhL1Opg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Dec 2021 09:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640702735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rkR3Og/uvPg2B0LclcpSelNSBv7NaBt9VBoAHT0i0tE=;
        b=FEQrGRiU5MSGmJ6VFL6pp7KaXGiTm3N5TOGewhrR1YW3XT3pkCbfL1yqUzgOFsDu5dIVDE
        3MY4KAgs3YcPZ18GGxVdxJJ4N/Rl35UWWX7AiZJw6fxwpgVxttsNOFUKtUlpNHbcj2zXVb
        DEo3OGqJG4hT6F0HJlAGOo7PU4TVN5A=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-LVTebH9ZPoaHwvcYGxNM6Q-1; Tue, 28 Dec 2021 09:45:33 -0500
X-MC-Unique: LVTebH9ZPoaHwvcYGxNM6Q-1
Received: by mail-qk1-f198.google.com with SMTP id bl6-20020a05620a1a8600b0046803c08cccso11560298qkb.15
        for <bpf@vger.kernel.org>; Tue, 28 Dec 2021 06:45:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rkR3Og/uvPg2B0LclcpSelNSBv7NaBt9VBoAHT0i0tE=;
        b=r0SG2l7WJ8/cd9c7AASM2ui6M9wopvNehD9nFxxWRaKej3A4INbK7IpE60BbhH0/UO
         HQKcHtf6UkJEELfDnTVp6MSw0yNJGH+vTsPc3H6shou0uo2js9IAE87zEWVtT9skRw53
         F+/PSwXj+7W2UIQeT9zFNXJi6Me+m/VezJXE2f4VfUb6p+pgXVSFOpjSxmXU4TDkKKsI
         Xh1ixRzc32lFd5IYhQVbM2ywRJu8Ow+/djvIbSov7VOQWizAMZ7t7s2mJG7SZWEKMv/p
         PxPa4X4PFsgFFqJlG33PWZRqkAwa1h0I3pRBr8UGMxgXaVdl3MUaKEYjNgnVXhmr/LPt
         9C+g==
X-Gm-Message-State: AOAM5307HXlybvfrGuod1V8a4iTf33FkBVB2omqbEvpnbtGAtl8N6hyq
        J4KgsL9CFppe5JKYEN/VE3Gckzl8pV76Yjiy+QUERAnryNkzVI/fmEKzNI92ZpmVSIudf5QdpZM
        c0pJIR6b+35fL
X-Received: by 2002:a05:622a:245:: with SMTP id c5mr18382560qtx.189.1640702733298;
        Tue, 28 Dec 2021 06:45:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymnTJG22e2FOSz5RSgDUOTP0uTlCGK6R859we9rbRw9gTQEhMlQB5Mq1DKLRe8rVCpyUvBTw==
X-Received: by 2002:a05:622a:245:: with SMTP id c5mr18382524qtx.189.1640702733085;
        Tue, 28 Dec 2021 06:45:33 -0800 (PST)
Received: from localhost (net-2-32-198-212.cust.dsl.teletu.it. [2.32.198.212])
        by smtp.gmail.com with ESMTPSA id z8sm16079872qta.50.2021.12.28.06.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 06:45:32 -0800 (PST)
Date:   Tue, 28 Dec 2021 15:45:20 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
        kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        shayagr@amazon.com, john.fastabend@gmail.com, dsahern@kernel.org,
        brouer@redhat.com, echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com, toke@redhat.com
Subject: Re: [PATCH v20 bpf-next 00/23] mvneta: introduce XDP multi-buffer
 support
Message-ID: <YcsjAP383AmEb4pQ@localhost.localdomain>
References: <cover.1639162845.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OBmxxoznn81budC6"
Content-Disposition: inline
In-Reply-To: <cover.1639162845.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--OBmxxoznn81budC6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
>=20
> Eelco Chaudron (3):
>   bpf: add multi-buff support to the bpf_xdp_adjust_tail() API
>   bpf: add multi-buffer support to xdp copy helpers
>   bpf: selftests: update xdp_adjust_tail selftest to include
>     multi-buffer
>=20
> Lorenzo Bianconi (19):
>   net: skbuff: add size metadata to skb_shared_info for xdp
>   xdp: introduce flags field in xdp_buff/xdp_frame
>   net: mvneta: update mb bit before passing the xdp buffer to eBPF layer
>   net: mvneta: simplify mvneta_swbm_add_rx_fragment management
>   net: xdp: add xdp_update_skb_shared_info utility routine
>   net: marvell: rely on xdp_update_skb_shared_info utility routine
>   xdp: add multi-buff support to xdp_return_{buff/frame}
>   net: mvneta: add multi buffer support to XDP_TX
>   bpf: introduce BPF_F_XDP_MB flag in prog_flags loading the ebpf
>     program
>   net: mvneta: enable jumbo frames if the loaded XDP program support mb
>   bpf: introduce bpf_xdp_get_buff_len helper
>   bpf: move user_size out of bpf_test_init
>   bpf: introduce multibuff support to bpf_prog_test_run_xdp()
>   bpf: test_run: add xdp_shared_info pointer in bpf_test_finish
>     signature
>   libbpf: Add SEC name for xdp_mb programs
>   net: xdp: introduce bpf_xdp_pointer utility routine
>   bpf: selftests: introduce bpf_xdp_{load,store}_bytes selftest
>   bpf: selftests: add CPUMAP/DEVMAP selftests for xdp multi-buff
>   xdp: disable XDP_REDIRECT for xdp multi-buff
>=20
> Toke Hoiland-Jorgensen (1):
>   bpf: generalise tail call map compatibility check

Hi Alexei and Daniel,

I noticed this series's state is now set to "New, archived" in patchwork.
Is it due to conflicts? Do I need to repost?

Regards,
Lorenzo

>=20
>  drivers/net/ethernet/marvell/mvneta.c         | 204 +++++++++------
>  include/linux/bpf.h                           |  32 ++-
>  include/linux/skbuff.h                        |   1 +
>  include/net/xdp.h                             | 108 +++++++-
>  include/uapi/linux/bpf.h                      |  30 +++
>  kernel/bpf/arraymap.c                         |   4 +-
>  kernel/bpf/core.c                             |  28 +-
>  kernel/bpf/cpumap.c                           |   8 +-
>  kernel/bpf/devmap.c                           |   3 +-
>  kernel/bpf/syscall.c                          |  25 +-
>  kernel/trace/bpf_trace.c                      |   3 +
>  net/bpf/test_run.c                            | 115 +++++++--
>  net/core/filter.c                             | 244 +++++++++++++++++-
>  net/core/xdp.c                                |  78 +++++-
>  tools/include/uapi/linux/bpf.h                |  30 +++
>  tools/lib/bpf/libbpf.c                        |   8 +
>  .../bpf/prog_tests/xdp_adjust_frags.c         | 103 ++++++++
>  .../bpf/prog_tests/xdp_adjust_tail.c          | 131 ++++++++++
>  .../selftests/bpf/prog_tests/xdp_bpf2bpf.c    | 151 ++++++++---
>  .../bpf/prog_tests/xdp_cpumap_attach.c        |  65 ++++-
>  .../bpf/prog_tests/xdp_devmap_attach.c        |  56 ++++
>  .../bpf/progs/test_xdp_adjust_tail_grow.c     |  10 +-
>  .../bpf/progs/test_xdp_adjust_tail_shrink.c   |  32 ++-
>  .../selftests/bpf/progs/test_xdp_bpf2bpf.c    |   2 +-
>  .../bpf/progs/test_xdp_update_frags.c         |  42 +++
>  .../bpf/progs/test_xdp_with_cpumap_helpers.c  |   6 +
>  .../progs/test_xdp_with_cpumap_mb_helpers.c   |  27 ++
>  .../bpf/progs/test_xdp_with_devmap_helpers.c  |   7 +
>  .../progs/test_xdp_with_devmap_mb_helpers.c   |  27 ++
>  29 files changed, 1368 insertions(+), 212 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_adjust_fra=
gs.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_update_fra=
gs.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_with_cpuma=
p_mb_helpers.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_with_devma=
p_mb_helpers.c
>=20
> --=20
> 2.33.1
>=20

--OBmxxoznn81budC6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYcsi/QAKCRA6cBh0uS2t
rGmbAQDHOc/OZzf/gfVAAoRISlZ5td+5tfcYlbM5TI7e8l27WwD+I2h0bEOExp09
ezm0HeWE3RNNaz7VvO5S1zyxqHDKJAI=
=bmeW
-----END PGP SIGNATURE-----

--OBmxxoznn81budC6--

