Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BA1360FB0
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 18:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhDOQE1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 12:04:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22922 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233741AbhDOQE0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Apr 2021 12:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618502643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Y79IGuOtq9K0+3NdYsvcAEnwc5UxsAQ/GxhVXEpoGM=;
        b=bytempy6UuBQXC63uPsAovPfBpUpNa4euF0IGX2RzThQuSnzJpkQknVjSUeZWu36Gg6F/X
        N5BlSuKlLS6u0uhJsIYqQrt+hTF1NMXEEBB3PqFKPOT90ISHSdPCqfTDew6ujEjt0cYeq+
        8gjmDjUveWyiXXpjATzSctttRxeM2lo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-qcCTc6wXNmSlDKG3fEsrzA-1; Thu, 15 Apr 2021 12:04:00 -0400
X-MC-Unique: qcCTc6wXNmSlDKG3fEsrzA-1
Received: by mail-ej1-f71.google.com with SMTP id z6-20020a17090665c6b02903700252d1ccso1105864ejn.10
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 09:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Y79IGuOtq9K0+3NdYsvcAEnwc5UxsAQ/GxhVXEpoGM=;
        b=Obm7EkSN3bVU9C64WXBTyhb1nnmEP6bm2dLg69awx2Ya0+pyvmUavq7opxnKV383GJ
         8gZvbh4cEiHGpriM9Pxaz83fJhOVCqmtzUyfpVW/XBg3j3dT28iXxdeBeHe7uCwkM9wh
         06NlDBB6vTg9RutrC36egJkdHUMakLvw2WyR5kJqI31otJX4scS0OvbvMfmywIl51eB1
         pqp8uDu84oyxNH7mivDKxubS6pWHmeEljH47tR//mQaSlJTwFmbFy8ZiOgTGuCDebakq
         WiTo8551d5/mKagrixpHef+PDoWYlG4clNCNCmRSAouOChDPHbBp+jzi6e37hFKr6irZ
         /TvA==
X-Gm-Message-State: AOAM532VVX03m3inPOvde5i3hxffJ7WQTWdiuk1oOllWiAr69cFhBogp
        NZmm+AbZCPetGo/O2mBTkl6cOh6IbElylUU1O5WhwM7fZzwqgB2dD3OUCjHrKGQ9M1y+SCKtiqn
        w/WTk6R5tgj3c
X-Received: by 2002:a05:6402:48c:: with SMTP id k12mr5102776edv.237.1618502639469;
        Thu, 15 Apr 2021 09:03:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFEKOhWoxcde4FwNbW2fDCrUQ1O9HV4XoN11Awb/tLFaITPWZ49fI6pvUla7wJjsYvdDlAZA==
X-Received: by 2002:a05:6402:48c:: with SMTP id k12mr5102757edv.237.1618502639360;
        Thu, 15 Apr 2021 09:03:59 -0700 (PDT)
Received: from localhost ([151.66.38.94])
        by smtp.gmail.com with ESMTPSA id z6sm2181819ejp.86.2021.04.15.09.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 09:03:58 -0700 (PDT)
Date:   Thu, 15 Apr 2021 18:03:55 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, brouer@redhat.com, song@kernel.org
Subject: Re: [PATCH v2 bpf-next] cpumap: bulk skb using netif_receive_skb_list
Message-ID: <YHhj61rDPai8YKjL@lore-desk>
References: <bb627106428ea3223610f5623142c24270f0e14e.1618330734.git.lorenzo@kernel.org>
 <252403c5-d3a7-03fb-24c3-0f328f8f8c70@iogearbox.net>
 <47f3711d-e13a-a537-4e0e-13c3c5ff6822@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ztOcW2VeYSs9vFIg"
Content-Disposition: inline
In-Reply-To: <47f3711d-e13a-a537-4e0e-13c3c5ff6822@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--ztOcW2VeYSs9vFIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 4/15/21 8:05 AM, Daniel Borkmann wrote:

[...]
> >> &stats);
> >=20
> > Given we stop counting drops with the netif_receive_skb_list(), we
> > should then
> > also remove drops from trace_xdp_cpumap_kthread(), imho, as otherwise it
> > is rather
> > misleading (as in: drops actually happening, but 0 are shown from the
> > tracepoint).
> > Given they are not considered stable API, I would just remove those to
> > make it clear
> > to users that they cannot rely on this counter anymore anyway.
> >=20
>=20
> What's the visibility into drops then? Seems like it would be fairly
> easy to have netif_receive_skb_list return number of drops.
>=20

In order to return drops from netif_receive_skb_list() I guess we need to i=
ntroduce
some extra checks in the hot path. Moreover packet drops are already accoun=
ted
in the networking stack and this is currently the only consumer for this in=
fo.
Does it worth to do so?

Regards,
Lorenzo

--ztOcW2VeYSs9vFIg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYHhj6QAKCRA6cBh0uS2t
rEQHAQCMp7U2VOiFgWscimxXkWctHZdQ8pTkKIGFDqLHqECu+AEA68KZmwUam7KF
21c7X92gk6jzx0shPpjPfKHHQ/VEDAM=
=u7Y2
-----END PGP SIGNATURE-----

--ztOcW2VeYSs9vFIg--

