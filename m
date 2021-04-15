Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8229D361353
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 22:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbhDOUKw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 16:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41430 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234654AbhDOUKw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Apr 2021 16:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618517428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r+6Ec8PvL7gAJlQ60UG94EesWSLVFvJeLHemOou2874=;
        b=VYSB73zADGQp4bKyxWmp6zxjm2ruEqsu/EP64Dk9ytExpMmHnoP8kmFc68CGHY0YzVRDeE
        SqZZgJ6zQI53Vne5TpOc344yqMi6Bk3R+vqcaeTzpG8Q702SXk0y92QRvJKxTxGLHAlHwL
        YkYng1BsRjsW3tGpAcFnxgTsepAE8dY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-X26k8DKQMl2c-u5ZhPGt0g-1; Thu, 15 Apr 2021 16:10:26 -0400
X-MC-Unique: X26k8DKQMl2c-u5ZhPGt0g-1
Received: by mail-ej1-f71.google.com with SMTP id ne22-20020a1709077b96b02903803a047edeso52931ejc.3
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 13:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r+6Ec8PvL7gAJlQ60UG94EesWSLVFvJeLHemOou2874=;
        b=sBN0mo4Bnx/j31NPKqEJ2hgcyvy9b07ewyroDhUOgj40dJneGVh6l5GSXqvFLpWCbP
         cnlCPw+lxbMA7TJIgIciOrdYGGHQHDNPGPCKoqM96LfzXa6/C7u3Ncf6t/kdpsMPGEZq
         nY3I4FW+2fWQx8RsR9CeUf/5lRORGqp1zyzowbuCnfR1wHUfd1jLoqgOKZiZBPWAvDRh
         zxrefapvV+pFEWrCnudczz5kJj/QvnG6xYJUE2vULYcMSkbvozgdabs1onYXlVtvSt6Q
         U2qPaVaAbJsL7OgtCtllnJFGKX37ryMXQm0utKv779Vcysfg8dLKlOPn4kQ5UNIiXggF
         2laQ==
X-Gm-Message-State: AOAM5312OmVaJ5CeIZHw/dV53pm5C6DQZGj1FHaCzfKBdtzL24l68a77
        iH+myaBMh2rsfAnmUYoFplJ3zuvBFMeB7tz6WEplMtmYLNf4a9IRmPPyekbmO09SVUzz0gX0xPM
        abBM62ojI92DI
X-Received: by 2002:a05:6402:31ad:: with SMTP id dj13mr6203230edb.167.1618517425526;
        Thu, 15 Apr 2021 13:10:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywoGJtnn0SEVjzLb5h7Rp4TfuoGtQFwCD0US4htdpPzNHrMV+kbl1J/fyOKqSWMuYjEJhBYg==
X-Received: by 2002:a05:6402:31ad:: with SMTP id dj13mr6203217edb.167.1618517425343;
        Thu, 15 Apr 2021 13:10:25 -0700 (PDT)
Received: from localhost ([151.66.38.94])
        by smtp.gmail.com with ESMTPSA id z20sm3352989edd.0.2021.04.15.13.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 13:10:24 -0700 (PDT)
Date:   Thu, 15 Apr 2021 22:10:21 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, brouer@redhat.com, song@kernel.org
Subject: Re: [PATCH v2 bpf-next] cpumap: bulk skb using netif_receive_skb_list
Message-ID: <YHidrRnmDe25lact@lore-desk>
References: <bb627106428ea3223610f5623142c24270f0e14e.1618330734.git.lorenzo@kernel.org>
 <252403c5-d3a7-03fb-24c3-0f328f8f8c70@iogearbox.net>
 <47f3711d-e13a-a537-4e0e-13c3c5ff6822@gmail.com>
 <YHhj61rDPai8YKjL@lore-desk>
 <7cbba160-c56a-8ec5-b9e1-455889bacb86@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hi23/T0SndxHJlIq"
Content-Disposition: inline
In-Reply-To: <7cbba160-c56a-8ec5-b9e1-455889bacb86@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--hi23/T0SndxHJlIq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 4/15/21 9:03 AM, Lorenzo Bianconi wrote:
> >> On 4/15/21 8:05 AM, Daniel Borkmann wrote:
> >=20
> > [...]
> >>>> &stats);
> >>>
> >>> Given we stop counting drops with the netif_receive_skb_list(), we
> >>> should then
> >>> also remove drops from trace_xdp_cpumap_kthread(), imho, as otherwise=
 it
> >>> is rather
> >>> misleading (as in: drops actually happening, but 0 are shown from the
> >>> tracepoint).
> >>> Given they are not considered stable API, I would just remove those to
> >>> make it clear
> >>> to users that they cannot rely on this counter anymore anyway.
> >>>
> >>
> >> What's the visibility into drops then? Seems like it would be fairly
> >> easy to have netif_receive_skb_list return number of drops.
> >>
> >=20
> > In order to return drops from netif_receive_skb_list() I guess we need =
to introduce
> > some extra checks in the hot path. Moreover packet drops are already ac=
counted
> > in the networking stack and this is currently the only consumer for thi=
s info.
> > Does it worth to do so?
>=20
> right - softnet_stat shows the drop. So the loss here is that the packet
> is from a cpumap XDP redirect.
>=20
> Better insights into drops is needed, but I guess in this case coming
> from the cpumap does not really aid into why it is dropped - that is
> more core to __netif_receive_skb_list_core. I guess this is ok to drop
> the counter from the tracepoint.
>=20

Applying the current patch, drops just counts the number of kmem_cache_allo=
c_bulk()
failures. Looking at kmem_cache_alloc_bulk() code, it does not seem to me t=
here any
failure counters. So I am wondering, is this an important info for the user?
Is so I guess we can just rename the counter in something more meaningful
(e.g. skb_alloc_failures).

Regards,
Lorenzo

--hi23/T0SndxHJlIq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYHidqwAKCRA6cBh0uS2t
rFBIAP9Fs4CJBgQGtdrwe/5E1hPRQ2dun08AVFtJNPVM2FkgqQD9FSaDEajEUfsL
C189CbKtdvCap0OEC9MndyMssPt1CQ0=
=8KvM
-----END PGP SIGNATURE-----

--hi23/T0SndxHJlIq--

