Return-Path: <bpf+bounces-16252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E847FED4D
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 11:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C00AB2105D
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 10:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40383B2BC;
	Thu, 30 Nov 2023 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9VUdcHo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5383B7E1;
	Thu, 30 Nov 2023 10:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D82C433C8;
	Thu, 30 Nov 2023 10:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701341468;
	bh=C5kbXo/gctXjAbzU0h/Mx0eFgqpdb3BArHPQBNYJcRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I9VUdcHoFH4AY0XC7+sC4TWxIPLEaT5ev4M9japNPVVLIAcQ3gqd+vYBnS9Yuq6Vc
	 AUVOm0LbIemdSbxMRmjgMjcSmLhR8PsKVhXA4rjhR7EU0Q8jr20F/9Xo+We6u14jdw
	 7yBacNtg4Tf7ckx4eN403woWVupBxSM/oN2AS4x2etYe779G1Hs3cGkgPS9VHh2HK8
	 BDhZTniEaoYh2AlFsOzsguyi2jOl6wWch/wAeHC5TK14KKgVCPFLyY7//h4xeQfxbt
	 2lr0jazPDrU+PgqV+tJHibXFVeMhqozZrFAboPtbyBzgZtg/uqIByaCLeWpl5v6n4i
	 egpb+h1LrmiXw==
Date: Thu, 30 Nov 2023 11:51:05 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, lorenzo.bianconi@redhat.com,
	bpf@vger.kernel.org, toke@redhat.com,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	kernel-team <kernel-team@cloudflare.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH v2 net-next 2/2] xdp: add multi-buff support for xdp
 running in generic mode
Message-ID: <ZWhpGWDP6mrM-Y35@lore-desk>
References: <cover.1701334869.git.lorenzo@kernel.org>
 <ce8cc5ce6e25d5e455704aa42fbf633be206ce85.1701334869.git.lorenzo@kernel.org>
 <f41935a3-790b-4d23-870c-a37b757aea99@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xJ4yJrSLfRCBhu4w"
Content-Disposition: inline
In-Reply-To: <f41935a3-790b-4d23-870c-a37b757aea99@kernel.org>


--xJ4yJrSLfRCBhu4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 11/30/23 10:11, Lorenzo Bianconi wrote:
> > Similar to native xdp, do not always linearize the skb in
> > netif_receive_generic_xdp routine but create a non-linear xdp_buff to be
> > processed by the eBPF program. This allow to add  multi-buffer support
> > for xdp running in generic mode.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >   net/core/dev.c | 144 ++++++++++++++++++++++++++++++++++++++++---------
> >   1 file changed, 119 insertions(+), 25 deletions(-)
> >=20
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 4df68d7f04a2..0d08e755bb7f 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4853,6 +4853,12 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb=
, struct xdp_buff *xdp,
> >   	xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
> >   	xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
> >   			 skb_headlen(skb) + mac_len, true);
> > +	if (skb_is_nonlinear(skb)) {
> > +		skb_shinfo(skb)->xdp_frags_size =3D skb->data_len;
> > +		xdp_buff_set_frags_flag(xdp);
> > +	} else {
> > +		xdp_buff_clear_frags_flag(xdp);
> > +	}
> >   	orig_data_end =3D xdp->data_end;
> >   	orig_data =3D xdp->data;
> > @@ -4882,6 +4888,14 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb=
, struct xdp_buff *xdp,
> >   		skb->len +=3D off; /* positive on grow, negative on shrink */
> >   	}
> > +	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> > +	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> > +	 */
> > +	if (xdp_buff_has_frags(xdp))
> > +		skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> > +	else
> > +		skb->data_len =3D 0;
> > +
> >   	/* check if XDP changed eth hdr such SKB needs update */
> >   	eth =3D (struct ethhdr *)xdp->data;
> >   	if ((orig_eth_type !=3D eth->h_proto) ||
> > @@ -4915,54 +4929,134 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *s=
kb, struct xdp_buff *xdp,
> >   	return act;
> >   }
> > -static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
> > -				     struct xdp_buff *xdp,
> > -				     struct bpf_prog *xdp_prog)
> > +static int netif_skb_check_for_generic_xdp(struct sk_buff **pskb,
> > +					   struct bpf_prog *prog)
>=20
> I like this is split out into a check function.
>=20
> >   {
> >   	struct sk_buff *skb =3D *pskb;
> > -	u32 act =3D XDP_DROP;
> > -
> > -	/* Reinjected packets coming from act_mirred or similar should
> > -	 * not get XDP generic processing.
> > -	 */
> > -	if (skb_is_redirected(skb))
> > -		return XDP_PASS;
>=20
> (For other reviewers)
> This reinjected check is moved further down.
>=20
> > +	int err;
> > -	/* XDP packets must be linear and must have sufficient headroom
> > -	 * of XDP_PACKET_HEADROOM bytes. This is the guarantee that also
> > -	 * native XDP provides, thus we need to do it here as well.
> > +	/* XDP does not support fraglist so we need to linearize
> > +	 * the skb.
> >   	 */
> > -	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
> > -	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
> > +	if (skb_has_frag_list(skb) || !prog->aux->xdp_has_frags) {
> >   		int hroom =3D XDP_PACKET_HEADROOM - skb_headroom(skb);
> >   		int troom =3D skb->tail + skb->data_len - skb->end;
> >   		/* In case we have to go down the path and also linearize,
> >   		 * then lets do the pskb_expand_head() work just once here.
> >   		 */
> > -		if (pskb_expand_head(skb,
> > -				     hroom > 0 ? ALIGN(hroom, NET_SKB_PAD) : 0,
> > -				     troom > 0 ? troom + 128 : 0, GFP_ATOMIC))
> > -			goto do_drop;
> > -		if (skb_linearize(skb))
> > -			goto do_drop;
> > +		err =3D pskb_expand_head(skb,
> > +				       hroom > 0 ? ALIGN(hroom, NET_SKB_PAD) : 0,
> > +				       troom > 0 ? troom + 128 : 0, GFP_ATOMIC);
> > +		if (err)
> > +			return err;
> > +
> > +		err =3D skb_linearize(skb);
> > +		if (err)
> > +			return err;
> > +
> > +		return 0;
> > +	}
> > +
> > +	/* XDP packets must have sufficient headroom of XDP_PACKET_HEADROOM
> > +	 * bytes. This is the guarantee that also native XDP provides,
> > +	 * thus we need to do it here as well.
> > +	 */
> > +	if (skb_cloned(skb) || skb_shinfo(skb)->nr_frags ||
>=20
> I though we could allow a SKB with skb_shinfo(skb)->nr_frags (that isn't
> cloned or shared) to be processed by generic XDP without any reallocation?

I do not think so, we discussed about it with Jakub here [0]

[0] https://lore.kernel.org/netdev/20231128105145.7b39db7d@kernel.org/

>=20
> So check would be: (skb_cloned(skb) || skb_shared(skb) ||)
>=20
> > +	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
>=20
> [Headroom trick]
> For layered devices the netstack could be the process that created the
> SKB.  If you noticed my veth patchset[4/4], when I detect an XDP-prog
> attach, I'm increasing the net_device headroom (.ndo_set_rx_headroom)
> such that netstack will allocated enough headroom to satisfy
> XDP_PACKET_HEADROOM.
>=20
> [4/4] https://lore.kernel.org/netdev/169272716651.1975370.105147112338782=
78884.stgit@firesoul/

Ah nice, for some reason I missed this patch

>=20
>=20
>=20
> > +		u32 mac_len =3D skb->data - skb_mac_header(skb);
> > +		u32 size, len, max_head_size, off;
> > +		struct sk_buff *nskb;
> > +		int i, head_off;
> > +
> > +		__skb_push(skb, mac_len);
> > +		max_head_size =3D SKB_WITH_OVERHEAD(PAGE_SIZE -
> > +						  XDP_PACKET_HEADROOM);
> > +		if (skb->len > max_head_size + MAX_SKB_FRAGS * PAGE_SIZE)
> > +			return -ENOMEM;
> > +
> > +		size =3D min_t(u32, skb->len, max_head_size);
> > +		nskb =3D netdev_alloc_skb(skb->dev, size + XDP_PACKET_HEADROOM);
>=20
>=20
> Would is be possible to use napi_alloc_skb() here?
>=20
> The napi_alloc_skb() is faster than netdev_alloc_skb(), but it as name
> suggest assumes this is called under NAPI protection/context.  It
> used-to-be the case for generic XDP, but code got moved around to
> support layered devices, so I not 100% sure if this is always true (NAPI
> context).

Actually I was thinking about it and I was not 100% sure too (so I decided =
to
use the non-NAPI version). Any input about it?

Regards,
Lorenzo

>=20
>=20
> > +		if (!nskb)
> > +			return -ENOMEM;
> > +
> > +		skb_reserve(nskb, XDP_PACKET_HEADROOM);
> > +		skb_copy_header(nskb, skb);
> > +
> > +		err =3D skb_copy_bits(skb, 0, nskb->data, size);
> > +		if (err) {
> > +			consume_skb(nskb);
> > +			return err;
> > +		}
> > +		skb_put(nskb, size);
> > +
> > +		head_off =3D skb_headroom(nskb) - skb_headroom(skb);
> > +		skb_headers_offset_update(nskb, head_off);
> > +
> > +		off =3D size;
> > +		len =3D skb->len - off;
> > +		for (i =3D 0; i < MAX_SKB_FRAGS && off < skb->len; i++) {
> > +			struct page *page;
> > +			void *frag;
> > +
> > +			size =3D min_t(u32, len, PAGE_SIZE);
> > +			frag =3D netdev_alloc_frag(size);
>=20
> Again the slower variant.
>=20
> > +			if (!frag) {
> > +				consume_skb(nskb);
> > +				return -ENOMEM;
> > +			}
> > +
> > +			page =3D virt_to_head_page(frag);
> > +			skb_add_rx_frag(nskb, i, page,
> > +					frag - page_address(page), size, size);
> > +			err =3D skb_copy_bits(skb, off, frag, size);
> > +			if (err) {
> > +				consume_skb(nskb);
> > +				return err;
> > +			}
> > +
> > +			len -=3D size;
> > +			off +=3D size;
> > +		}
> > +
> > +		consume_skb(skb);
> > +		*pskb =3D nskb;
> > +		__skb_pull(nskb, mac_len);
> >   	}
> > -	act =3D bpf_prog_run_generic_xdp(skb, xdp, xdp_prog);
> > +	return 0;
> > +}
> > +
> > +static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
> > +				     struct xdp_buff *xdp,
> > +				     struct bpf_prog *xdp_prog)
> > +{
> > +	u32 act =3D XDP_DROP;
> > +
> > +	/* Reinjected packets coming from act_mirred or similar should
> > +	 * not get XDP generic processing.
> > +	 */
> > +	if (skb_is_redirected(*pskb))
> > +		return XDP_PASS;
> > +
> > +	if (netif_skb_check_for_generic_xdp(pskb, xdp_prog))
> > +		goto do_drop;
> > +
> > +	act =3D bpf_prog_run_generic_xdp(*pskb, xdp, xdp_prog);
> >   	switch (act) {
> >   	case XDP_REDIRECT:
> >   	case XDP_TX:
> >   	case XDP_PASS:
> >   		break;
> >   	default:
> > -		bpf_warn_invalid_xdp_action(skb->dev, xdp_prog, act);
> > +		bpf_warn_invalid_xdp_action((*pskb)->dev, xdp_prog, act);
> >   		fallthrough;
> >   	case XDP_ABORTED:
> > -		trace_xdp_exception(skb->dev, xdp_prog, act);
> > +		trace_xdp_exception((*pskb)->dev, xdp_prog, act);
> >   		fallthrough;
> >   	case XDP_DROP:
> >   	do_drop:
> > -		kfree_skb(skb);
> > +		kfree_skb(*pskb);
> >   		break;
> >   	}
>=20
> Overall I like the patch :-)
>=20
> Are we missing more things to allow GRO packets getting processed by gene=
ric
> XDP?
>=20
> --Jesper

--xJ4yJrSLfRCBhu4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZWhpGQAKCRA6cBh0uS2t
rNSXAPkBbXXtyondlxXatKSCQ1Q4FHmYZpEX3qhUQa0g6uf1TwD/RxipW7a3poGE
InG6F5JCmDWSt3aPSB8/Y6qJuC+6CAo=
=hxOB
-----END PGP SIGNATURE-----

--xJ4yJrSLfRCBhu4w--

