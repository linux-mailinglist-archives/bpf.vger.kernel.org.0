Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3814D4D1D
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 16:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343777AbiCJPLp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 10:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343718AbiCJPLe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 10:11:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 286DA198EFC
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 07:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646924767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hpj0XcQBrpfIu7ayxJ3XggJ/KoAfHwvIFzO0/VwNfmI=;
        b=QD1MHKb304jZPuVNRqEXCXyDJtEBXtnMzqUyFK6YF70bZZYy7EzN9LpeIjXSf/bhk/bA/W
        XUoZYxJo/fug7hLyHq36wu8XH0jEdi4QPiBomMvIEE9dgfnG0wuTXoLclIaR/rhwVlw5mX
        WCBCOtWyMmZpu1UTKF86c0GIGuLmIz0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-CtkTH7tGOZWKcaC6bmsisw-1; Thu, 10 Mar 2022 10:06:05 -0500
X-MC-Unique: CtkTH7tGOZWKcaC6bmsisw-1
Received: by mail-wm1-f70.google.com with SMTP id 20-20020a05600c231400b00389886f6b23so2394248wmo.6
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 07:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hpj0XcQBrpfIu7ayxJ3XggJ/KoAfHwvIFzO0/VwNfmI=;
        b=n8f3ESCIilfWTKv4+jtYgF7Eq5FK7oXyCUukskOWwmzT8FszcCOvE1w1qUrJNB/vDL
         b/bTw53+1dJSoVL7mSBBcjdyYZ/x9RhsrOjGcvqYjdsUgdDtVtnli4KvNZfY10ocjZZa
         AExA2S6IPu7f707fxBT4jJf3YWv3t80YrqyhOVKWALdVwW2M+xRBNZfKZBts0bR9iQE1
         okq4FZWh1R09mS9+8rDXeI67/Yol+fH7ScE+zg0gBFfoZPQ9TVEOlTJDI2fcP0O0sua9
         UVJc0cZPhjB/2neUWPI8aKnmAZdFtvvtP9WGVk+c1I6MJ9DpIR8YKJn4erK4xs+lDKtR
         Xgfg==
X-Gm-Message-State: AOAM532k5HYd744tTKvTUal75kdU75sCmHnIY9zw/5r1+6lw79XgyUlD
        nRSLymszgbhNzxG6HEZ0SFrDpX0lgyFU6oDH2GhIpgakaUIGPuiy5da6KIqcObo3hIsJv2fCHfB
        h60O4CISiCMNN
X-Received: by 2002:a05:6000:1687:b0:1f1:e5ad:7643 with SMTP id y7-20020a056000168700b001f1e5ad7643mr3867574wrd.117.1646924764027;
        Thu, 10 Mar 2022 07:06:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZmERHUVpy4dTjBCfk0l3o9sKFYyw/yh5Fl6WdbfnaggODl0/0bmyEL0dvkLkfcxMXPeLFfw==
X-Received: by 2002:a05:6000:1687:b0:1f1:e5ad:7643 with SMTP id y7-20020a056000168700b001f1e5ad7643mr3867551wrd.117.1646924763699;
        Thu, 10 Mar 2022 07:06:03 -0800 (PST)
Received: from localhost ([37.183.9.66])
        by smtp.gmail.com with ESMTPSA id e2-20020adfe7c2000000b001f04d622e7fsm4262793wrn.39.2022.03.10.07.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 07:06:03 -0800 (PST)
Date:   Thu, 10 Mar 2022 16:06:01 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, brouer@redhat.com,
        pabeni@redhat.com, echaudro@redhat.com, toshiaki.makita1@gmail.com,
        andrii@kernel.org
Subject: Re: [PATCH v4 bpf-next 3/3] veth: allow jumbo frames in xdp mode
Message-ID: <YioT2TGc8M42V2K2@lore-desk>
References: <cover.1646755129.git.lorenzo@kernel.org>
 <930b1ad3d84f7ca5a41ba75571f9146a932c5394.1646755129.git.lorenzo@kernel.org>
 <87bkyeujrv.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/psosy4Wmhwl3PD3"
Content-Disposition: inline
In-Reply-To: <87bkyeujrv.fsf@toke.dk>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--/psosy4Wmhwl3PD3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Allow increasing the MTU over page boundaries on veth devices
> > if the attached xdp program declares to support xdp fragments.
> > Enable NETIF_F_ALL_TSO when the device is running in xdp mode.
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/veth.c | 28 +++++++++++++++++-----------
> >  1 file changed, 17 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > index 47b21b1d2fd9..c5a2dc2b2e4b 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> > @@ -293,8 +293,7 @@ static int veth_forward_skb(struct net_device *dev,=
 struct sk_buff *skb,
> >  /* return true if the specified skb has chances of GRO aggregation
> >   * Don't strive for accuracy, but try to avoid GRO overhead in the most
> >   * common scenarios.
> > - * When XDP is enabled, all traffic is considered eligible, as the xmit
> > - * device has TSO off.
> > + * When XDP is enabled, all traffic is considered eligible.
> >   * When TSO is enabled on the xmit device, we are likely interested on=
ly
> >   * in UDP aggregation, explicitly check for that if the skb is suspect=
ed
> >   * - the sock_wfree destructor is used by UDP, ICMP and XDP sockets -
> > @@ -302,11 +301,13 @@ static int veth_forward_skb(struct net_device *de=
v, struct sk_buff *skb,
> >   */
> >  static bool veth_skb_is_eligible_for_gro(const struct net_device *dev,
> >  					 const struct net_device *rcv,
> > +					 const struct veth_rq *rq,
> >  					 const struct sk_buff *skb)
> >  {
> > -	return !(dev->features & NETIF_F_ALL_TSO) ||
> > -		(skb->destructor =3D=3D sock_wfree &&
> > -		 rcv->features & (NETIF_F_GRO_FRAGLIST | NETIF_F_GRO_UDP_FWD));
> > +	return rcu_access_pointer(rq->xdp_prog) ||
> > +	       !(dev->features & NETIF_F_ALL_TSO) ||
> > +	       (skb->destructor =3D=3D sock_wfree &&
> > +		rcv->features & (NETIF_F_GRO_FRAGLIST | NETIF_F_GRO_UDP_FWD));
> >  }
> > =20
> >  static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *d=
ev)
> > @@ -335,7 +336,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, s=
truct net_device *dev)
> >  		 * Don't bother with napi/GRO if the skb can't be aggregated
> >  		 */
> >  		use_napi =3D rcu_access_pointer(rq->napi) &&
> > -			   veth_skb_is_eligible_for_gro(dev, rcv, skb);
> > +			   veth_skb_is_eligible_for_gro(dev, rcv, rq, skb);
> >  	}
> > =20
> >  	skb_tx_timestamp(skb);
> > @@ -1525,9 +1526,14 @@ static int veth_xdp_set(struct net_device *dev, =
struct bpf_prog *prog,
> >  			goto err;
> >  		}
> > =20
> > -		max_mtu =3D PAGE_SIZE - VETH_XDP_HEADROOM -
> > -			  peer->hard_header_len -
> > -			  SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > +		max_mtu =3D SKB_WITH_OVERHEAD(PAGE_SIZE - VETH_XDP_HEADROOM) -
> > +			  peer->hard_header_len;
>=20
> Why are we no longer accounting the size of the skb_shared_info if the
> program doesn't support frags?

doing so we do not allow packets over page boundaries (so non-linear xdp_bu=
ff)
if the attached program does not delclare to support them, right?

>=20
> > +		/* Allow increasing the max_mtu if the program supports
> > +		 * XDP fragments.
> > +		 */
> > +		if (prog->aux->xdp_has_frags)
> > +			max_mtu +=3D PAGE_SIZE * MAX_SKB_FRAGS;
> > +
> >  		if (peer->mtu > max_mtu) {
> >  			NL_SET_ERR_MSG_MOD(extack, "Peer MTU is too large to set XDP");
> >  			err =3D -ERANGE;
> > @@ -1549,7 +1555,7 @@ static int veth_xdp_set(struct net_device *dev, s=
truct bpf_prog *prog,
> >  		}
> > =20
> >  		if (!old_prog) {
> > -			peer->hw_features &=3D ~NETIF_F_GSO_SOFTWARE;
> > +			peer->hw_features &=3D ~NETIF_F_GSO_FRAGLIST;
>=20
> The patch description says we're enabling TSO, but this change enables a
> couple of other flags as well. Also, it's not quite obvious to me why
> your change makes this possible? Is it because we can now execute XDP on
> a full TSO packet at once? Because then this should be coupled to the
> xdp_has_frags flag of the XDP program? Or will the TSO packet be
> segmented before it hits the XDP program? But then this change has
> nothing to do with the rest of your series?

actually tso support is not mandatory for this feature (even if it is proba=
bly
meaningful). I will drop it from v5 and we can take care of it in a suseque=
nt
patch.

Regards,
Lorenzo

>=20
> Please also add this explanation to the commit message :)
>=20
> -Toke
>=20

--/psosy4Wmhwl3PD3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYioT2QAKCRA6cBh0uS2t
rFnZAPsFSCsfjqYg9ob/gTiHQVSNM3tPrPUTA2vw16hMP+fstQEAwmN3+Op7d25W
SLtZabPSBmoGUGayzCbEzp2l4zmNawk=
=7Npn
-----END PGP SIGNATURE-----

--/psosy4Wmhwl3PD3--

