Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786B96F402A
	for <lists+bpf@lfdr.de>; Tue,  2 May 2023 11:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjEBJ3t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 May 2023 05:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjEBJ3s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 05:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8747F49FD
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 02:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683019742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EA89Mu2bFSBvYrAFwxo01YZgtY9Jypho3d/0E2qf64o=;
        b=Oc5d96FfZBd235KRZUnNtkoaOLawgyCX1kuFhN1yfErxgeBZ0WUAtwPencp1Km37WGqsoC
        HKtnlIuzYhQiXV5EL9Qxg3qv9kuRbPyZGJZf4d4oTBfawT14IeAA/N7z7iz+tYpCW7VlGh
        TjtT56Em7Xu+9kG7RPIbnafm6ZsdzSg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-RwmQnkOoN9-r9uunDLB38A-1; Tue, 02 May 2023 05:28:59 -0400
X-MC-Unique: RwmQnkOoN9-r9uunDLB38A-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-61acaa32164so6999696d6.1
        for <bpf@vger.kernel.org>; Tue, 02 May 2023 02:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683019739; x=1685611739;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EA89Mu2bFSBvYrAFwxo01YZgtY9Jypho3d/0E2qf64o=;
        b=h28pps3uxkciBMtM7Q6TPUE6ueSYEoLoMwkvq2T0i2tbGqhoQQogq7XXyG1xFCf7Rk
         d/P9b9/pS0SmUufE1wacCKOGVZnMTqi5Mw3Ze0x6jfCN/SMddX+AN/8ZFcHoaFExQk7c
         2LZ+90+PUytoKGacZ1Kvo+X34+DYpYLaCR5lUVmRE/J0It5c84hb3+KAl86JxRZ92O5W
         BpnGnlpwuWZCQqnwxI/7l6RK2S496VrYJ44cbrCp059eA4eITMCLbC3OuoUAnoX8/szY
         FHNyvD03qDtnvkUZWHDBW6aTkL4IHOY9Nn/deY4ElIG7vYHzUPQUhvncBUp55aqCmGS7
         6OZQ==
X-Gm-Message-State: AC+VfDypEpvPmDFbAnKdC1HQ8ucj+e6AcXqjMyZNhY3hRtmsbhw762gT
        hbGVqD+BX1L3Sn0cIaf45imJqKLU8lpxko0ta6KEWbTNJF3ei0zAKF+YUc+wiEg/sRFL/oPAGNT
        gDZADGFuZy3YC
X-Received: by 2002:ac8:5ad0:0:b0:3ef:37fa:e1d6 with SMTP id d16-20020ac85ad0000000b003ef37fae1d6mr3272514qtd.2.1683019739143;
        Tue, 02 May 2023 02:28:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5EnCPwFHmto6yRv4uLS88cpI4qnSJd41ZM2L9flKNyNKTQo587E0dmQkD1hxRKxVNcM65zdQ==
X-Received: by 2002:ac8:5ad0:0:b0:3ef:37fa:e1d6 with SMTP id d16-20020ac85ad0000000b003ef37fae1d6mr3272482qtd.2.1683019738763;
        Tue, 02 May 2023 02:28:58 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-253-104.dyn.eolo.it. [146.241.253.104])
        by smtp.gmail.com with ESMTPSA id h6-20020a05620a244600b0074a1d2a17c8sm9551193qkn.29.2023.05.02.02.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 02:28:58 -0700 (PDT)
Message-ID: <5a1c7de53daaa6180b207ff42d1736f50b5d90b9.camel@redhat.com>
Subject: Re: [PATCH v2 net] bonding: add xdp_features support
From:   Paolo Abeni <pabeni@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, j.vosburgh@gmail.com,
        andy@greyhouse.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
        mykolal@fb.com, ast@kernel.org, martin.lau@linux.dev,
        alardam@gmail.com, memxor@gmail.com, sdf@google.com,
        brouer@redhat.com, toke@redhat.com, Jussi Maki <joamaki@gmail.com>
Date:   Tue, 02 May 2023 11:28:53 +0200
In-Reply-To: <1260d53a-1a05-9615-5a39-4c38171285fd@iogearbox.net>
References: <e82117190648e1cbb2740be44de71a21351c5107.1682848658.git.lorenzo@kernel.org>
         <1260d53a-1a05-9615-5a39-4c38171285fd@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2023-05-01 at 15:33 +0200, Daniel Borkmann wrote:
> On 4/30/23 12:02 PM, Lorenzo Bianconi wrote:
> > Introduce xdp_features support for bonding driver according to the slav=
e
> > devices attached to the master one. xdp_features is required whenever w=
e
> > want to xdp_redirect traffic into a bond device and then into selected
> > slaves attached to it.
> >=20
> > Fixes: 66c0e13ad236 ("drivers: net: turn on XDP features")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Please also keep Jussi in Cc for bonding + XDP reviews [added here].

Perhaps worth adding such info to the maintainer file for future
memory?

> > ---
> > Change since v1:
> > - remove bpf self-test patch from the series
>=20
> Given you targeted net tree, was this patch run against BPF CI locally fr=
om
> your side to avoid breakage again?
>=20
> Thanks,
> Daniel
>=20
> > ---
> >   drivers/net/bonding/bond_main.c    | 48 +++++++++++++++++++++++++++++=
+
> >   drivers/net/bonding/bond_options.c |  2 ++
> >   include/net/bonding.h              |  1 +
> >   3 files changed, 51 insertions(+)
> >=20
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond=
_main.c
> > index 710548dbd0c1..c98121b426a4 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -1789,6 +1789,45 @@ static void bond_ether_setup(struct net_device *=
bond_dev)
> >   	bond_dev->priv_flags &=3D ~IFF_TX_SKB_SHARING;
> >   }
> >  =20
> > +void bond_xdp_set_features(struct net_device *bond_dev)
> > +{
> > +	struct bonding *bond =3D netdev_priv(bond_dev);
> > +	xdp_features_t val =3D NETDEV_XDP_ACT_MASK;
> > +	struct list_head *iter;
> > +	struct slave *slave;
> > +
> > +	ASSERT_RTNL();
> > +
> > +	if (!bond_xdp_check(bond)) {
> > +		xdp_clear_features_flag(bond_dev);
> > +		return;
> > +	}
> > +
> > +	bond_for_each_slave(bond, slave, iter) {
> > +		struct net_device *dev =3D slave->dev;
> > +
> > +		if (!(dev->xdp_features & NETDEV_XDP_ACT_BASIC)) {
> > +			xdp_clear_features_flag(bond_dev);
> > +			return;
> > +		}
> > +
> > +		if (!(dev->xdp_features & NETDEV_XDP_ACT_REDIRECT))
> > +			val &=3D ~NETDEV_XDP_ACT_REDIRECT;
> > +		if (!(dev->xdp_features & NETDEV_XDP_ACT_NDO_XMIT))
> > +			val &=3D ~NETDEV_XDP_ACT_NDO_XMIT;
> > +		if (!(dev->xdp_features & NETDEV_XDP_ACT_XSK_ZEROCOPY))
> > +			val &=3D ~NETDEV_XDP_ACT_XSK_ZEROCOPY;
> > +		if (!(dev->xdp_features & NETDEV_XDP_ACT_HW_OFFLOAD))
> > +			val &=3D ~NETDEV_XDP_ACT_HW_OFFLOAD;
> > +		if (!(dev->xdp_features & NETDEV_XDP_ACT_RX_SG))
> > +			val &=3D ~NETDEV_XDP_ACT_RX_SG;
> > +		if (!(dev->xdp_features & NETDEV_XDP_ACT_NDO_XMIT_SG))
> > +			val &=3D ~NETDEV_XDP_ACT_NDO_XMIT_SG;

Can we expect NETDEV_XDP_ACT_MASK changing in the future (e.g. new
features to be added)? If so the above code will break silently, as the
new features will be unconditionally enabled. What about adding a
BUILD_BUG() to catch such situation?=20

>=20
Cheers,

Paolo

