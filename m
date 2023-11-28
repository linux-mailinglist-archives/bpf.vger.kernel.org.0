Return-Path: <bpf+bounces-16041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C657FB9D2
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 13:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29BAE1C2145E
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 12:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4EF4F8AC;
	Tue, 28 Nov 2023 12:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3VIxYVc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C97D511;
	Tue, 28 Nov 2023 12:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B976C433C8;
	Tue, 28 Nov 2023 12:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701172966;
	bh=/MXXha6RJRbrEkT11J8PV+LHcLAgGe9+oE4vLnOhv78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E3VIxYVcUgfqAdQeHkFmUY098iLKCNQULgcy5gHrjIC2/B94p42TJMGMf+ROk2IMe
	 nHndP50XSgaOfJ0hgVaHJzarxD6fMIsOlIk952QhjAuqG8rOhF83wU40PhK6e9UEiH
	 pANS4n8FULv+Y4xjV0rhD18zibpEQN9zGC2B++IXPfOO4QWdzrkq9ZxyrBH5kaXqKZ
	 ipMnqJRsdgaHZLPNiOQtI9SLwbgQyeANJvCKzts8djFK+qdwv0BQnFIhsgdKlkhXOW
	 WXF0VxO1WyLkyBmRvStI8CMRw6W/u9E+xsxtV53SxGnnNXQi2n+HhGQLAM/2opkPOH
	 teUeLHXeH5Jjg==
Date: Tue, 28 Nov 2023 13:02:42 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, lorenzo.bianconi@redhat.com,
	bpf@vger.kernel.org, hawk@kernel.org
Subject: Re: [PATCH net-next] xdp: add multi-buff support for xdp running in
 generic mode
Message-ID: <ZWXW4jF5CWr8iF1O@lore-desk>
References: <c928f7c698de070b33d38f230081fd4f993f2567.1701128026.git.lorenzo@kernel.org>
 <87o7fejjnc.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3fBsYUr9xU2GPVtj"
Content-Disposition: inline
In-Reply-To: <87o7fejjnc.fsf@toke.dk>


--3fBsYUr9xU2GPVtj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Similar to native xdp, do not always linearize the skb in
> > netif_receive_generic_xdp routine but create a non-linear xdp_buff to be
> > processed by the eBPF program. This allow to add multi-buffer support
> > for xdp running in generic mode.
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> With one nit below:
>=20
> Reviewed-by: Toke H=F8iland-J=F8rgensen <toke@redhat.com>
>=20
> > ---
> >  net/core/dev.c | 28 +++++++++++++++++++++++-----
> >  1 file changed, 23 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 3950ced396b5..5a58f3e28657 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4853,6 +4853,12 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb=
, struct xdp_buff *xdp,
> >  	xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
> >  	xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
> >  			 skb_headlen(skb) + mac_len, true);
> > +	if (skb_is_nonlinear(skb)) {
> > +		skb_shinfo(skb)->xdp_frags_size =3D skb->data_len;
> > +		xdp_buff_set_frags_flag(xdp);
> > +	} else {
> > +		xdp_buff_clear_frags_flag(xdp);
> > +	}
> > =20
> >  	orig_data_end =3D xdp->data_end;
> >  	orig_data =3D xdp->data;
> > @@ -4882,6 +4888,14 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb=
, struct xdp_buff *xdp,
> >  		skb->len +=3D off; /* positive on grow, negative on shrink */
> >  	}
> > =20
> > +	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> > +	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> > +	 */
> > +	if (xdp_buff_has_frags(xdp))
> > +		skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> > +	else
> > +		skb->data_len =3D 0;
> > +
> >  	/* check if XDP changed eth hdr such SKB needs update */
> >  	eth =3D (struct ethhdr *)xdp->data;
> >  	if ((orig_eth_type !=3D eth->h_proto) ||
> > @@ -4927,9 +4941,9 @@ static u32 netif_receive_generic_xdp(struct sk_bu=
ff *skb,
> >  	if (skb_is_redirected(skb))
> >  		return XDP_PASS;
> > =20
> > -	/* XDP packets must be linear and must have sufficient headroom
> > -	 * of XDP_PACKET_HEADROOM bytes. This is the guarantee that also
> > -	 * native XDP provides, thus we need to do it here as well.
> > +	/* XDP packets must have sufficient headroom of XDP_PACKET_HEADROOM
> > +	 * bytes. This is the guarantee that also native XDP provides,
> > +	 * thus we need to do it here as well.
> >  	 */
> >  	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
> >  	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
> > @@ -4943,8 +4957,12 @@ static u32 netif_receive_generic_xdp(struct sk_b=
uff *skb,
> >  				     hroom > 0 ? ALIGN(hroom, NET_SKB_PAD) : 0,
> >  				     troom > 0 ? troom + 128 : 0, GFP_ATOMIC))
> >  			goto do_drop;
>=20
> There's a comment above the pskb_expand_head() call that isn't quite
> part of the context here, that should also be adjusted now that we don't
> always linearise:
>=20
> 		/* In case we have to go down the path and also linearize,
> 		 * then lets do the pskb_expand_head() work just once here.
> 		 */
>=20
> Actually, I think maybe just dropping that comment entirely with this
> change would make sense?

ack, I will get rid of it. Thx.

Regards,
Lorenzo

>=20
>=20
> > -		if (skb_linearize(skb))
> > -			goto do_drop;
> > +
> > +		/* XDP does not support fraglist */
> > +		if (skb_has_frag_list(skb) || !xdp_prog->aux->xdp_has_frags) {
> > +			if (skb_linearize(skb))
> > +				goto do_drop;
> > +		}
> >  	}
> > =20
> >  	act =3D bpf_prog_run_generic_xdp(skb, xdp, xdp_prog);
> > --=20
> > 2.43.0
>=20

--3fBsYUr9xU2GPVtj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZWXW4gAKCRA6cBh0uS2t
rLi6AQDkCiAl5jg3qaCLuqdNxJEVcS3AZW9K31VTCsJWctE+bQEAzZoSq9i/M6iy
SEnM4fWCFLEN8ngSYyRBwcssjvbfugw=
=2UsZ
-----END PGP SIGNATURE-----

--3fBsYUr9xU2GPVtj--

