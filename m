Return-Path: <bpf+bounces-18506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7385481B03C
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 09:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE2B6B22C0A
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 08:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75B216427;
	Thu, 21 Dec 2023 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YldkdlVo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430D21802F;
	Thu, 21 Dec 2023 08:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67253C433C7;
	Thu, 21 Dec 2023 08:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703146998;
	bh=B35QcwsC4O63UMvesltMIDSbeJC19DahzEoyJy3Ilq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YldkdlVoX0mTzOK4ybsaTzOG68Rl+Pg4b8NzYmPS8O3zZy2NMe8K51qnK8fM+v1YN
	 +YXFPdW8X7du4YYqsSE+VNji0qfX+3tptyj04fv5j/bCoesgQMUx4ZlKqDakW3XkJ2
	 gtq36tKXsDxcDs5+xkqEP38EZstI6KOeqsbWqEyU1XTBrW76/cBx3qSHvxD010+yqH
	 AkKRbL4Mjvt/VDHDoL2kXrPJTYQZvd6QJuxKOLnXtzYoQmsKUDAh4pQ73p/xIncrBe
	 8+zAhkDbLEF4AGVei8baOJpJ9E0Y06p09u9N1cQjACrGSTDuyoqXaoUIuVDdyA0RHy
	 RpC/2hztxpCxg==
Date: Thu, 21 Dec 2023 09:23:14 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, bpf@vger.kernel.org, toke@redhat.com,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	sdf@google.com, Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH v5 net-next 3/3] xdp: add multi-buff support for xdp
 running in generic mode
Message-ID: <ZYP18oSWJp87xuej@lore-desk>
References: <cover.1702563810.git.lorenzo@kernel.org>
 <e73a75e0d0f81a3b20568675829df4763fa0d389.1702563810.git.lorenzo@kernel.org>
 <d617df2b-620f-4a6f-b7dd-852bf156f904@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="shbNIzSJcJdv1gzc"
Content-Disposition: inline
In-Reply-To: <d617df2b-620f-4a6f-b7dd-852bf156f904@kernel.org>


--shbNIzSJcJdv1gzc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 14/12/2023 15.29, Lorenzo Bianconi wrote:
> > Similar to native xdp, do not always linearize the skb in
> > netif_receive_generic_xdp routine but create a non-linear xdp_buff to be
> > processed by the eBPF program. This allow to add  multi-buffer support
> > for xdp running in generic mode.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >   net/core/dev.c | 153 +++++++++++++++++++++++++++++++++++++++++++------
> >   1 file changed, 134 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index d7857de03dba..47164acc3268 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4854,6 +4854,12 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb=
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
> > @@ -4883,6 +4889,14 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb=
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
> > @@ -4916,12 +4930,118 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *s=
kb, struct xdp_buff *xdp,
> >   	return act;
> >   }
> > +static int netif_skb_segment_for_xdp(struct sk_buff **pskb,
>=20
> This function "...segment_for_xdp" always reallocate SKB and copies all
> bits over.
> Should it have been named "skb_realloc_for_xdp" ?

Hi Jesper,

ack, naming is always hard :)

>=20
> I was really hopeing we can find a design to avoid doing this realloc.
>=20
> If the BPF-prog doesn't write into any of the fragments, then we can
> avoid this realloc (+copy) dance. We designed XDP multi-buff to have
> exactly the same layout+location as SKB in skb_shared_info, exactly to
> avoid having to reallocated.

I 100% agree with you, but we will need a similar copy fallback approach
anyway, right? It is just a matter to understand if we should implement it
with page_pool or page_frag_cache (or something different).

>=20
> More comments inline below...
>=20
> > +				     struct bpf_prog *prog)
> > +{
> > +#if IS_ENABLED(CONFIG_PAGE_POOL)
> > +	struct softnet_data *sd =3D this_cpu_ptr(&softnet_data);
> > +	u32 size, truesize, len, max_head_size, off;
> > +	struct sk_buff *skb =3D *pskb, *nskb;
> > +	int err, i, head_off;
> > +	void *data;
> > +
> > +	/* XDP does not support fraglist so we need to linearize
> > +	 * the skb.
> > +	 */
> > +	if (skb_has_frag_list(skb) || !prog->aux->xdp_has_frags)
> > +		return -EOPNOTSUPP;
> > +
> > +	max_head_size =3D SKB_WITH_OVERHEAD(PAGE_SIZE - XDP_PACKET_HEADROOM);
> > +	if (skb->len > max_head_size + MAX_SKB_FRAGS * PAGE_SIZE)
> > +		return -ENOMEM;
> > +
> > +	size =3D min_t(u32, skb->len, max_head_size);
> > +	truesize =3D SKB_HEAD_ALIGN(size) + XDP_PACKET_HEADROOM;
> > +	data =3D page_pool_dev_alloc_va(sd->page_pool, &truesize);
> > +	if (!data)
> > +		return -ENOMEM;
> > +
> > +	nskb =3D napi_build_skb(data, truesize);
> > +	if (!nskb) {
> > +		page_pool_free_va(sd->page_pool, data, true);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	skb_reserve(nskb, XDP_PACKET_HEADROOM);
> > +	skb_copy_header(nskb, skb);
> > +	skb_mark_for_recycle(nskb);
> > +
> > +	err =3D skb_copy_bits(skb, 0, nskb->data, size);
>=20
> This will likely copy part of the "frags" into the SKB "head" area.
>=20
> Especially for netstack generated TCP packets, this will change the
> segmentation layout significantly.  I wonder what (performance) effects
> this will have on further handling of these SKBs.

Do you think it can be a problem? I think in this way we can reduce the
number of allocated page. Moreover, what about the case when skb head is
bigger than a single page? Do you think we should use bigger allocation ord=
er?

>=20
>=20
>=20
> > +	if (err) {
> > +		consume_skb(nskb);
> > +		return err;
> > +	}
> > +	skb_put(nskb, size);
> > +
> > +	head_off =3D skb_headroom(nskb) - skb_headroom(skb);
> > +	skb_headers_offset_update(nskb, head_off);
> > +
> > +	off =3D size;
> > +	len =3D skb->len - off;
> > +	for (i =3D 0; i < MAX_SKB_FRAGS && off < skb->len; i++) {
> > +		struct page *page;
> > +		u32 page_off;
> > +
> > +		size =3D min_t(u32, len, PAGE_SIZE);
> > +		truesize =3D size;
> > +
> > +		page =3D page_pool_dev_alloc(sd->page_pool, &page_off,
> > +					   &truesize);
> > +		if (!data) {
> > +			consume_skb(nskb);
> > +			return -ENOMEM;
> > +		}
> > +
> > +		skb_add_rx_frag(nskb, i, page, page_off, size, truesize);
> > +		err =3D skb_copy_bits(skb, off, page_address(page) + page_off,
> > +				    size);
>=20
> I think it is correct, but we can easily endup with the new SKB (nskb)
> having a different nskb->nr_frags.

see above

>=20
>=20
> > +		if (err) {
> > +			consume_skb(nskb);
> > +			return err;
> > +		}
> > +
> > +		len -=3D size;
> > +		off +=3D size;
> > +	}
> > +
> > +	consume_skb(skb);
> > +	*pskb =3D nskb;
> > +
> > +	return 0;
> > +#else
> > +	return -EOPNOTSUPP;
> > +#endif
> > +}
> > +
> > +static int netif_skb_check_for_xdp(struct sk_buff **pskb,
> > +				   struct bpf_prog *prog)
> > +{
> > +	struct sk_buff *skb =3D *pskb;
> > +	int err, hroom, troom;
> > +
> > +	if (!netif_skb_segment_for_xdp(pskb, prog))
> > +		return 0;
>=20
> IMHO the code call logic, does not make it easy to add cases where we
> can avoid the realloc.  With this patch, it feels like the realloc+copy
> code path is the "main" code path for XDP-generic.

ack, I think it would depend about the logic to avoid realloc+copy. We could
revaluate it when we have this logic in place. What do you think?

>=20
> Our goal should be to avoid realloc.
>=20
> My goal for XDP multi-buff was/is that it can co-exist with GSO/GRO
> packets.  This patchset is a step in the direction of enabling GRO on
> devices with XDP (generic) loaded.  And I was really excited about this,
> but the overhead is going to be massive compared to normal GRO (without
> realloc+copy) that XDP end-users are going to be disappointed.
>=20
>=20
> > +
> > +	/* In case we have to go down the path and also linearize,
> > +	 * then lets do the pskb_expand_head() work just once here.
> > +	 */
> > +	hroom =3D XDP_PACKET_HEADROOM - skb_headroom(skb);
> > +	troom =3D skb->tail + skb->data_len - skb->end;
> > +	err =3D pskb_expand_head(skb,
> > +			       hroom > 0 ? ALIGN(hroom, NET_SKB_PAD) : 0,
> > +			       troom > 0 ? troom + 128 : 0, GFP_ATOMIC);
> > +	if (err)
> > +		return err;
> > +
> > +	return skb_linearize(skb);
> > +}
> > +
> >   static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
> >   				     struct xdp_buff *xdp,
> >   				     struct bpf_prog *xdp_prog)
> >   {
> >   	struct sk_buff *skb =3D *pskb;
> > -	u32 act =3D XDP_DROP;
> > +	u32 mac_len, act =3D XDP_DROP;
> >   	/* Reinjected packets coming from act_mirred or similar should
> >   	 * not get XDP generic processing.
> > @@ -4929,41 +5049,36 @@ static u32 netif_receive_generic_xdp(struct sk_=
buff **pskb,
> >   	if (skb_is_redirected(skb))
> >   		return XDP_PASS;
> > -	/* XDP packets must be linear and must have sufficient headroom
> > -	 * of XDP_PACKET_HEADROOM bytes. This is the guarantee that also
> > -	 * native XDP provides, thus we need to do it here as well.
> > +	/* XDP packets must have sufficient headroom of XDP_PACKET_HEADROOM
> > +	 * bytes. This is the guarantee that also native XDP provides,
> > +	 * thus we need to do it here as well.
>=20
> Some "native" XDP provider only have 192 bytes as HEADROOM and XDP code
> can this not being static (256 bytes).  So, perhaps it is time to allow
> XDP generic to only require 192 bytes?

ack, agree. I think this can be added a separated patch.

Regards,
Lorenzo

>=20
> >   	 */
> > +	mac_len =3D skb->data - skb_mac_header(skb);
> > +	__skb_push(skb, mac_len);
> > +
> >   	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
> >   	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
> > -		int hroom =3D XDP_PACKET_HEADROOM - skb_headroom(skb);
> > -		int troom =3D skb->tail + skb->data_len - skb->end;
> > -
> > -		/* In case we have to go down the path and also linearize,
> > -		 * then lets do the pskb_expand_head() work just once here.
> > -		 */
> > -		if (pskb_expand_head(skb,
> > -				     hroom > 0 ? ALIGN(hroom, NET_SKB_PAD) : 0,
> > -				     troom > 0 ? troom + 128 : 0, GFP_ATOMIC))
> > -			goto do_drop;
> > -		if (skb_linearize(skb))
> > +		if (netif_skb_check_for_xdp(pskb, xdp_prog))
> >   			goto do_drop;
> >   	}
> > -	act =3D bpf_prog_run_generic_xdp(skb, xdp, xdp_prog);
> > +	__skb_pull(*pskb, mac_len);
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

--shbNIzSJcJdv1gzc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZYP18gAKCRA6cBh0uS2t
rD3TAP9oC3lA853JbsLlpoS8+VB70FhI4TG8Io8DcfFQApJeKAD6AyvloGY7X0Q/
t0DclHLpyFbyDmqnbleDM6E1Y5MfRgg=
=eOUp
-----END PGP SIGNATURE-----

--shbNIzSJcJdv1gzc--

