Return-Path: <bpf+bounces-21657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD1784FF1F
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 22:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0C08B2906F
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 21:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29554210FB;
	Fri,  9 Feb 2024 21:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgdGDBVO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AAF210EE;
	Fri,  9 Feb 2024 21:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515243; cv=none; b=fwBwHIB2BPvCw0OgDagGmP8qKUHqwYX+FDkJlcaoGr/aZTMKvFMHzgBK4BpNIyk6StEKD87Mjtz5KnB8TipoPHOLyxB+NaDV+3t6iQpldmxaIzKpyjVQgJxN6qvCy64zP6QA5vQuZIy6+pWvdr4CVGtnlbc7DOVOPz2qO+3ld7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515243; c=relaxed/simple;
	bh=Gtqx3D5Gbbnno6TsCD64LQ0pTqiMIshXtXteTUCc1g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oazw9fPrkvXhI2RXLHYHBOO1lyAae0iDV88nwOQ0m6rwgK7NIcA0zVB7fonu74DhltUdLVS0Kke0UVHkJ6AGUTYBAYw0j9zIn778RLemM7U0ZPhI5yf7EsJLOGpLNdv4tVZN7wjW6Y0KnhZGO9Vl2PQRYpJBDsKJZ19sQHsGu/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgdGDBVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4A5C433F1;
	Fri,  9 Feb 2024 21:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707515243;
	bh=Gtqx3D5Gbbnno6TsCD64LQ0pTqiMIshXtXteTUCc1g4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XgdGDBVOuzv+za9SNorNgn+PTtSl9mPVciU4CqjuFS64a26En4KXo1PALP5sydVNt
	 dXLOuPe741TTnd9bElcOAdjaqqSkDMMLD8pSgX1GjAjvpc4aqwPuBqYnLeqB4mLad0
	 wWKlJsuroOlNzhhX5Sd3aolX6GseyapCzj+8OK6GbXrO7hTAVU1Q5XUxE+6trl+GOt
	 VgISeaG6PjpiKhjly/tJ4cANj4Afdlnr8BD3u0jauP6mqu4tu7kPz9M/qSx5C7dxty
	 tR36Iv/+ETzHK+9oUiGB/Vx3iyUww5OQqOmyO8JPcbhb0AnBm6LVHsCgvSerlL3uhF
	 tYiDX889EBflg==
Date: Fri, 9 Feb 2024 22:47:19 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	bpf@vger.kernel.org, toke@redhat.com,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	sdf@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com
Subject: Re: [PATCH v8 net-next 0/4] add multi-buff support for xdp running
 in generic mode
Message-ID: <ZcadZx1IMoB9xgG8@lore-desk>
References: <cover.1707132752.git.lorenzo@kernel.org>
 <20240209083834.78a9e941@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QPYuqvCzkqYHWj6Y"
Content-Disposition: inline
In-Reply-To: <20240209083834.78a9e941@kernel.org>


--QPYuqvCzkqYHWj6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon,  5 Feb 2024 12:35:11 +0100 Lorenzo Bianconi wrote:
> > Introduce multi-buffer support for xdp running in generic mode not alwa=
ys
> > linearizing the skb in netif_receive_generic_xdp routine.
> > Introduce generic percpu page_pools allocator.
>=20
> breaks the veth test, apparently:
>=20
> https://netdev-3.bots.linux.dev/vmksft-net/results/458181/60-veth-sh/stdo=
ut
>=20
> could be that the test needs fixing not the code.
> But either way we need a respin :(
> --=20
> pw-bot: cr

Hi Jakub,

Ack, thx for reporting the problem. The issue is we should use skb_pp_cow_d=
ata()
instead of skb_cow_data_for_xdp() in veth_convert_skb_to_xdp_buff() since w=
e do
not have any requirement for the attached bpf_prog there. I will fix it in =
v9.

Regards,
Lorenzo

--QPYuqvCzkqYHWj6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZcadZwAKCRA6cBh0uS2t
rMb9AQCaD1jFTLZkYCpxZWkclrCBKsWkCh82J9PKeqBVVCRx5AD6Aqtj/sbfnW4u
nrO5sxyd2Y84Nrqp6Gcx0Te82zm6eg0=
=9Nar
-----END PGP SIGNATURE-----

--QPYuqvCzkqYHWj6Y--

