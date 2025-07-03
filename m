Return-Path: <bpf+bounces-62274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 425A3AF740B
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28D03A3A8E
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 12:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473F52E54A8;
	Thu,  3 Jul 2025 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2aU65QR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD211D5142;
	Thu,  3 Jul 2025 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545579; cv=none; b=G8/BuSqQyU/J5O+jM4webOJZR5xzDihsfa65HSrxQDJjlO+/0F7cgLDp+AY1NmMNkYh3ETR8vO0JNVfZmSddcYUVJtUkpLahLoKzGQouG8QOPmnQAFg0E30Ws6C3Q7ZGwhOyqpkg40Ox4GcyQ3erv03RxBbt79LD7vaVl4EGeW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545579; c=relaxed/simple;
	bh=FGGDxsEbhFQvw8rRrT3WmXoyONQi0V7r2zXqtnk/B7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEcCjrirBCxLYjOEs207VZhtdesaTzDoNncA1EvrG9+7zFBgGy4cSveyqt6QUD7TlND67pmg5KqegRgvro80b5YJ8BvaRqYVhert2OeUU9RUi68IL5L3tbXFtF1LCVI7KN5uxFlkDXckdkRi938YkmaGdL9whnayzG/0ZZEfV94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2aU65QR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF94C4CEE3;
	Thu,  3 Jul 2025 12:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751545578;
	bh=FGGDxsEbhFQvw8rRrT3WmXoyONQi0V7r2zXqtnk/B7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X2aU65QRDKR60l59uymldg2kEa4Se/gGiTVnyPNabl4nf4Uf2iguO1PTe1n65Bhn1
	 lnOkbXoph9UcZxgqgNA7+A01SEQpuo4GfeW8YUkh1lWoLfrnW9rnS5FoMyI2NPVNzX
	 vE5ssFD2I/200MnPJ1V/Mv65+11q26gnJxhsevx2v/VUtbYsgDHnKBO6rDIr5ZA648
	 edu4npApn7y0W1lixLdAyEb4IE+ssx0k6JiGEEZop5k4/w/bij3KsKXIAmSkuHsizJ
	 lL/Znw+TBytqM9tf4vuywabWXt3ZAeWV3eNNzfbq8bTK0vydIziunq/KIjoO8cbIFE
	 9V6BG0rHPz7ug==
Date: Thu, 3 Jul 2025 14:26:15 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <borkmann@iogearbox.net>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
	kernel-team@cloudflare.com, arthur@arthurfabre.com,
	jakub@cloudflare.com
Subject: Re: [PATCH bpf-next V2 3/7] net: xdp: Add kfuncs to store hw
 metadata in xdp_buff
Message-ID: <aGZ25_gUxziOoNZp@lore-desk>
References: <175146824674.1421237.18351246421763677468.stgit@firesoul>
 <175146831297.1421237.17665319427079757435.stgit@firesoul>
 <85eee028-2784-4bcd-b9a9-9e1bdf0799f3@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xPVA+SWq1wChkKMJ"
Content-Disposition: inline
In-Reply-To: <85eee028-2784-4bcd-b9a9-9e1bdf0799f3@kernel.org>


--xPVA+SWq1wChkKMJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
> On 02/07/2025 16.58, Jesper Dangaard Brouer wrote:
> > From: Lorenzo Bianconi<lorenzo@kernel.org>
> >=20
> > Introduce the following kfuncs to store hw metadata provided by the NIC
> > into the xdp_buff struct:
> >=20
> > - rx-hash: bpf_xdp_store_rx_hash
> > - rx-vlan: bpf_xdp_store_rx_vlan
> > - rx-hw-ts: bpf_xdp_store_rx_ts
> >=20
> > Signed-off-by: Lorenzo Bianconi<lorenzo@kernel.org>
> > Signed-off-by: Jesper Dangaard Brouer<hawk@kernel.org>
> > ---
> >   include/net/xdp.h |    5 +++++
> >   net/core/xdp.c    |   45 +++++++++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 50 insertions(+)
> >=20
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index bd3110fc7ef8..1ffba57714ea 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -963,12 +963,57 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(cons=
t struct xdp_md *ctx,
> [...]
> > +__bpf_kfunc int bpf_xdp_store_rx_ts(struct xdp_md *ctx, u64 ts)
> > +{
> > +	struct xdp_buff *xdp =3D (struct xdp_buff *)ctx;
> > +	struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(xdp);
> > +	struct skb_shared_hwtstamps *shwt =3D &sinfo->hwtstamps;
> > +
> > +	shwt->hwtstamp =3D ts;
>=20
> Here we are storing into the SKB shared_info struct.  This is located at
> the SKB data tail.  Thus, this will very likely cause a cache-miss.
>=20
> What about storing it into xdp->rx_meta and then starting a prefetch for
> shared_info?  (and updating patch-4 that moved it into SKB)

ack, I am fine with it. I can address it in v3.

Regards,
Lorenzo

>=20
> (Reviewers should be aware that writing into the xdp_frame headroom
> (xdp->rx_meta) likely isn't a cache-miss, because all drivers does a
> prefetchw for this memory prior to running BPF-prog).
>=20
>=20
> > +	xdp->flags |=3D XDP_FLAGS_META_RX_TS;
> > +
> > +	return 0;
> > +}

--xPVA+SWq1wChkKMJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaGZ25wAKCRA6cBh0uS2t
rEGKAQC3kQLYnv0+ZQBPZFycOo3LedDafyfcd8gPMRsf8fdXLQD8CV9huCZbmKaB
au+Tnw1bQvDN82WaCGitu5kI0qbQYQY=
=gkxR
-----END PGP SIGNATURE-----

--xPVA+SWq1wChkKMJ--

