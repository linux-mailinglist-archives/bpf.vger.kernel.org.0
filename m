Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21B92F363E
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 17:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388051AbhALQz3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 11:55:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53593 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390519AbhALQz3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 Jan 2021 11:55:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610470443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RJtenorxDtU5qCjG/2C59Y/pygUXPLN1pUzLWTld9gk=;
        b=Cr0LBqGDhlnW1t72deKqB+4sYBV+pwfxi/JF4doaGdQKI00mV5zfEUfD0iXEEi26BttRoi
        zM4yDpAvDUB4DA++J08KCabP6OyIfL6bzyIr1VWhaRfpLMRhu532LV7wTx3FUSARDjry82
        pkUz8RqrJlV+HkYSKl6DoFBLXcHuGOA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-9nvkha3IMVK4NzgOnCegvQ-1; Tue, 12 Jan 2021 11:53:58 -0500
X-MC-Unique: 9nvkha3IMVK4NzgOnCegvQ-1
Received: by mail-wm1-f71.google.com with SMTP id b4so712347wmj.4
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 08:53:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RJtenorxDtU5qCjG/2C59Y/pygUXPLN1pUzLWTld9gk=;
        b=AaZoXhg9PZwBv0siMRRnI31Ce1G17on6+CjxQZM9P46z8IfKH03oWqfVLbqmD6bJdM
         lGf2EYINTG47kXStSeSYA0ESmmWwXbP+72Ol3Wp+8v0i1qUTDfz8rXYiQxwBdWm4b7tp
         7pfG6s46ggmb9tEPPeQwtOTC+6H00RTudKiNrUbMQRnc+AVBFVQ1iYyHjw6tQtSNx60I
         jdYlgqSsZ9Aw0IQZPe4GMOtv0M1xBid9+E0Hogb0rBklAUIH9nmw+LUxjEzd/AA/ZR9/
         FxrOUnVcF/aUhv9qXxa+fqthjnckofgAO0hZadsCDp2Gs/0jtTTY6/dsqPLBtxQ5gSRT
         m07g==
X-Gm-Message-State: AOAM531WYc/wBMS2wjVI0ATEm7PA445y9myGTSJ66pQmxwT7lpi27t6l
        sjUmas/dBD1d996f1SwMdHLz/xb9YuF8zIRU6rYmUsPGCa2QTW7JhjTtJhDnBWv6ifmQBz+UWYD
        BfhQvIKSm82Zd
X-Received: by 2002:a7b:c259:: with SMTP id b25mr216179wmj.40.1610470437708;
        Tue, 12 Jan 2021 08:53:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkpsJgLE4nHknWC0kIpvnV/jVYsf6dNCkqVBTyu/Q/yN0VKpaJ+lHsw2I62kyayjn0SAEgiw==
X-Received: by 2002:a7b:c259:: with SMTP id b25mr216165wmj.40.1610470437551;
        Tue, 12 Jan 2021 08:53:57 -0800 (PST)
Received: from localhost ([151.66.42.92])
        by smtp.gmail.com with ESMTPSA id z6sm4431035wmi.15.2021.01.12.08.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 08:53:57 -0800 (PST)
Date:   Tue, 12 Jan 2021 17:53:53 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
        kuba@kernel.org, ast@kernel.org, brouer@redhat.com,
        toshiaki.makita1@gmail.com
Subject: Re: [PATCH bpf-next 0/2] add xdp_build_skb_from_frame utility routine
Message-ID: <20210112165353.GD2555@lore-desk>
References: <cover.1608142960.git.lorenzo@kernel.org>
 <20210112160842.GC2555@lore-desk>
 <de334a62-c249-ea05-abec-2e1fe6c282ac@iogearbox.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EP0wieDxd4TSJjHq"
Content-Disposition: inline
In-Reply-To: <de334a62-c249-ea05-abec-2e1fe6c282ac@iogearbox.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--EP0wieDxd4TSJjHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 1/12/21 5:08 PM, Lorenzo Bianconi wrote:
> > > Introduce __xdp_build_skb_from_frame and xdp_build_skb_from_frame rou=
tines to
> > > build the skb from a xdp_frame. Respect to __xdp_build_skb_from_frame,
> > > xdp_build_skb_from_frame will allocate the skb object.
> > > Rely on __xdp_build_skb_from_frame/xdp_build_skb_from_frame in cpumap=
 and veth
> > > code.
> >=20
> > since this series is marked as "archived" in patchwork, do I need to re=
submit it?
>=20
> Yes please do, afaik there was some minor feedback from Toshiaki which wa=
s not yet
> addressed from your side.

ack, will do.

Regards,
Lorenzo

>=20
> Thanks,
> Daniel
>=20

--EP0wieDxd4TSJjHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX/3UHwAKCRA6cBh0uS2t
rAFrAQDgKHdlgiLGIXXoYEj/3XCfNFtleVVttuwpKlhTZhytiAEAmPhDQeCtnLbu
f/XVwUslLScgyS9r2ZKpp6DahFrT5Qs=
=fIjx
-----END PGP SIGNATURE-----

--EP0wieDxd4TSJjHq--

