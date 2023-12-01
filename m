Return-Path: <bpf+bounces-16360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1FF80071B
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 10:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B88DB2116B
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 09:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533431DA4F;
	Fri,  1 Dec 2023 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJZPBSuc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58711D6A6;
	Fri,  1 Dec 2023 09:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B551C433CB;
	Fri,  1 Dec 2023 09:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701423228;
	bh=anqnBg54UELl83MBkuAmSveambaO/XIBX7loJW294YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJZPBSuc23LMF9zSLvAReeULMT18p3PD8WQXxQiTJj1vXEg56cO2Mn844aEnxA/F8
	 bC6OWUCNmlHGRxNimD/M8QqN70zCVkqG/SkIbXJtWH0ZpGvBqxrImLKQuywm9Ru0at
	 s3TgPJFZNWuBOtmSKEumwkd2cAbIL1wFdK+WcSI+/2Po+5gftlW0rTss4n4tGBBXO+
	 sQYa4PpyOeTVClC5MFpn4PnQdb21D3LlhRPtTRlQxHfILoIBYZaGBi4iFW+XNaDEdX
	 FL0Oq5cfV5384hd8165ZOrmWb9NsxOeYbbuiXDsCTOLVO0L117R93epb8XVzC/6tFw
	 uQdN/hqtixUFw==
Date: Fri, 1 Dec 2023 10:33:43 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Stanislav Fomichev <sdf@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, lorenzo.bianconi@redhat.com, bpf@vger.kernel.org,
	toke@redhat.com, willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com, kernel-team <kernel-team@cloudflare.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH v2 net-next 2/2] xdp: add multi-buff support for xdp
 running in generic mode
Message-ID: <ZWmod5vq-txlGg5L@lore-desk>
References: <cover.1701334869.git.lorenzo@kernel.org>
 <ce8cc5ce6e25d5e455704aa42fbf633be206ce85.1701334869.git.lorenzo@kernel.org>
 <f41935a3-790b-4d23-870c-a37b757aea99@kernel.org>
 <ZWhpGWDP6mrM-Y35@lore-desk>
 <ZWjZKPYCglmjFJUH@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VsjUZvWKa4NVqNYC"
Content-Disposition: inline
In-Reply-To: <ZWjZKPYCglmjFJUH@google.com>


--VsjUZvWKa4NVqNYC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 11/30, Lorenzo Bianconi wrote:
> > >=20
> > >=20
> > > On 11/30/23 10:11, Lorenzo Bianconi wrote:
> > > > Similar to native xdp, do not always linearize the skb in
> > > > netif_receive_generic_xdp routine but create a non-linear xdp_buff =
to be
> > > > processed by the eBPF program. This allow to add  multi-buffer supp=
ort
> > > > for xdp running in generic mode.
> > > >=20
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > >   net/core/dev.c | 144 ++++++++++++++++++++++++++++++++++++++++----=
-----
> > > >   1 file changed, 119 insertions(+), 25 deletions(-)
> > > >=20
> > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > index 4df68d7f04a2..0d08e755bb7f 100644
> > > > --- a/net/core/dev.c
> > > > +++ b/net/core/dev.c
> > > > @@ -4853,6 +4853,12 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff =
*skb, struct xdp_buff *xdp,
> > > >   	xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
> > > >   	xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
> > > >   			 skb_headlen(skb) + mac_len, true);
> > > > +	if (skb_is_nonlinear(skb)) {
> > > > +		skb_shinfo(skb)->xdp_frags_size =3D skb->data_len;
> > > > +		xdp_buff_set_frags_flag(xdp);
> > > > +	} else {
> > > > +		xdp_buff_clear_frags_flag(xdp);
> > > > +	}
> > > >   	orig_data_end =3D xdp->data_end;
> > > >   	orig_data =3D xdp->data;
> > > > @@ -4882,6 +4888,14 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff =
*skb, struct xdp_buff *xdp,
> > > >   		skb->len +=3D off; /* positive on grow, negative on shrink */
> > > >   	}
> > > > +	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> > > > +	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> > > > +	 */
> > > > +	if (xdp_buff_has_frags(xdp))
> > > > +		skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> > > > +	else
> > > > +		skb->data_len =3D 0;
> > > > +
> > > >   	/* check if XDP changed eth hdr such SKB needs update */
> > > >   	eth =3D (struct ethhdr *)xdp->data;
> > > >   	if ((orig_eth_type !=3D eth->h_proto) ||
> > > > @@ -4915,54 +4929,134 @@ u32 bpf_prog_run_generic_xdp(struct sk_buf=
f *skb, struct xdp_buff *xdp,
> > > >   	return act;
> > > >   }
> > > > -static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
> > > > -				     struct xdp_buff *xdp,
> > > > -				     struct bpf_prog *xdp_prog)
> > > > +static int netif_skb_check_for_generic_xdp(struct sk_buff **pskb,
> > > > +					   struct bpf_prog *prog)
> > >=20
> > > I like this is split out into a check function.
> > >=20
> > > >   {
> > > >   	struct sk_buff *skb =3D *pskb;
> > > > -	u32 act =3D XDP_DROP;
> > > > -
> > > > -	/* Reinjected packets coming from act_mirred or similar should
> > > > -	 * not get XDP generic processing.
> > > > -	 */
> > > > -	if (skb_is_redirected(skb))
> > > > -		return XDP_PASS;
> > >=20
> > > (For other reviewers)
> > > This reinjected check is moved further down.
> > >=20
> > > > +	int err;
> > > > -	/* XDP packets must be linear and must have sufficient headroom
> > > > -	 * of XDP_PACKET_HEADROOM bytes. This is the guarantee that also
> > > > -	 * native XDP provides, thus we need to do it here as well.
> > > > +	/* XDP does not support fraglist so we need to linearize
> > > > +	 * the skb.
> > > >   	 */
> > > > -	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
> > > > -	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
> > > > +	if (skb_has_frag_list(skb) || !prog->aux->xdp_has_frags) {
> > > >   		int hroom =3D XDP_PACKET_HEADROOM - skb_headroom(skb);
> > > >   		int troom =3D skb->tail + skb->data_len - skb->end;
> > > >   		/* In case we have to go down the path and also linearize,
> > > >   		 * then lets do the pskb_expand_head() work just once here.
> > > >   		 */
> > > > -		if (pskb_expand_head(skb,
> > > > -				     hroom > 0 ? ALIGN(hroom, NET_SKB_PAD) : 0,
> > > > -				     troom > 0 ? troom + 128 : 0, GFP_ATOMIC))
> > > > -			goto do_drop;
> > > > -		if (skb_linearize(skb))
> > > > -			goto do_drop;
> > > > +		err =3D pskb_expand_head(skb,
> > > > +				       hroom > 0 ? ALIGN(hroom, NET_SKB_PAD) : 0,
> > > > +				       troom > 0 ? troom + 128 : 0, GFP_ATOMIC);
> > > > +		if (err)
> > > > +			return err;
> > > > +
> > > > +		err =3D skb_linearize(skb);
> > > > +		if (err)
> > > > +			return err;
> > > > +
> > > > +		return 0;
> > > > +	}
> > > > +
> > > > +	/* XDP packets must have sufficient headroom of XDP_PACKET_HEADRO=
OM
> > > > +	 * bytes. This is the guarantee that also native XDP provides,
> > > > +	 * thus we need to do it here as well.
> > > > +	 */
> > > > +	if (skb_cloned(skb) || skb_shinfo(skb)->nr_frags ||
> > >=20
> > > I though we could allow a SKB with skb_shinfo(skb)->nr_frags (that is=
n't
> > > cloned or shared) to be processed by generic XDP without any realloca=
tion?
> >=20
> > I do not think so, we discussed about it with Jakub here [0]
> >=20
> > [0] https://lore.kernel.org/netdev/20231128105145.7b39db7d@kernel.org/
>=20
> Can this be done as an optimization later on? If, from the bpf side,
> the verifier can attest that the program is not calling
> bpf_xdp_{load,store}_bytes on the frags for example.

Yes, I think so. Moreover this would be useful for veth too.

Regards,
Lorenzo


--VsjUZvWKa4NVqNYC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZWmodwAKCRA6cBh0uS2t
rKUJAP9HqqWOsznBBiNRXFbOxaz+9GCDdltRQnL+Qd2BgtFJDgEAuBbJa/QGObHd
RPcxS1o4gkEIBiVudrqneDbzbQlnZgg=
=UJez
-----END PGP SIGNATURE-----

--VsjUZvWKa4NVqNYC--

