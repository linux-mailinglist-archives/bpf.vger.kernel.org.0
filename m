Return-Path: <bpf+bounces-16878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF522807133
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 14:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEEC91C20D4F
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 13:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25633BB31;
	Wed,  6 Dec 2023 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZkqBg0A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408EA321AE;
	Wed,  6 Dec 2023 13:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A0BC433C7;
	Wed,  6 Dec 2023 13:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701870694;
	bh=4yJEOyXZICGTPIYoLV9zvlyTK4vOBWYD6er6RDgInGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZkqBg0A4hzkm7E32fn25fsGUQzsPFGOVtxsUVNn0NU+ZTzeLnbDt7RSUbpZxWP4G
	 7p4KGUAFwfFu5VhayRNgXApi6Yvhkvyg3NNX5dZRFOt76AqzM0g6B2dMCEQuzzFVoQ
	 UktUjH7rggGTvgg9G4TFHL/I66BPz43yVwmGtXu9aPMVlViab2DQDG4JaXlEN5g2ab
	 6i/wMEEpXHKHqyZQ7NzVUl/urnFSsh4/EOQYlwDAsBqTTBodE0+OZGTJKtZeuQnWfg
	 4Klc6nNcEPo5jtPEKOCxiZZm1MC0Q9fKK/VjU1jE9rO8BN5zxAuXw57BmhJ+ND+VUE
	 xPEKNHrnWq2uw==
Date: Wed, 6 Dec 2023 14:51:30 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, aleksander.lobakin@intel.com,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, lorenzo.bianconi@redhat.com, bpf@vger.kernel.org,
	toke@redhat.com, willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com, sdf@google.com
Subject: Re: [PATCH v3 net-next 2/2] xdp: add multi-buff support for xdp
 running in generic mode
Message-ID: <ZXB8Yr-nkhYaF5nS@lore-desk>
References: <cover.1701437961.git.lorenzo@kernel.org>
 <c9ee1db92c8baa7806f8949186b43ffc13fa01ca.1701437962.git.lorenzo@kernel.org>
 <20231201194829.428a96da@kernel.org>
 <ZW3zvEbI6o4ydM_N@lore-desk>
 <20231204120153.0d51729a@kernel.org>
 <ZW-tX9EAnbw9a2lF@lore-desk>
 <20231205155849.49af176c@kernel.org>
 <4b9804e2-42f0-4aed-b191-2abe24390e37@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="egsugcSD3Fs8QYbL"
Content-Disposition: inline
In-Reply-To: <4b9804e2-42f0-4aed-b191-2abe24390e37@kernel.org>


--egsugcSD3Fs8QYbL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 12/6/23 00:58, Jakub Kicinski wrote:
> > On Wed, 6 Dec 2023 00:08:15 +0100 Lorenzo Bianconi wrote:
> > > v00 (NS:ns0 - 192.168.0.1/24) <---> (NS:ns1 - 192.168.0.2/24) v01 =3D=
=3D(XDP_REDIRECT)=3D=3D> v10 (NS:ns1 - 192.168.1.1/24) <---> (NS:ns2 - 192.=
168.1.2/24) v11
> > >=20
> > > - v00: iperf3 client (pinned on core 0)
> > > - v11: iperf3 server (pinned on core 7)
> > >=20
> > > net-next veth codebase (page_pool APIs):
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > - MTU  1500: ~ 5.42 Gbps
> > > - MTU  8000: ~ 14.1 Gbps
> > > - MTU 64000: ~ 18.4 Gbps
> > >=20
> > > net-next veth codebase + page_frag_cahe APIs [0]:
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > - MTU  1500: ~ 6.62 Gbps
> > > - MTU  8000: ~ 14.7 Gbps
> > > - MTU 64000: ~ 19.7 Gbps
> > >=20
> > > xdp_generic codebase + page_frag_cahe APIs (current proposed patch):
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > - MTU  1500: ~ 6.41 Gbps
> > > - MTU  8000: ~ 14.2 Gbps
> > > - MTU 64000: ~ 19.8 Gbps
> > >=20
> > > xdp_generic codebase + page_frag_cahe APIs [1]:
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > This one should say page pool?

yep, sorry

> >=20
> > > - MTU  1500: ~ 5.75 Gbps
> > > - MTU  8000: ~ 15.3 Gbps
> > > - MTU 64000: ~ 21.2 Gbps
> > >=20
> > > It seems page_pool APIs are working better for xdp_generic codebase
> > > (except MTU 1500 case) while page_frag_cache APIs are better for
> > > veth driver. What do you think? Am I missing something?
> >=20
> > IDK the details of veth XDP very well but IIUC they are pretty much
> > the same. Are there any clues in perf -C 0 / 7?
> >=20
> > > [0] Here I have just used napi_alloc_frag() instead of
> > > page_pool_dev_alloc_va()/page_pool_dev_alloc() in
> > > veth_convert_skb_to_xdp_buff()
> > >=20
> > > [1] I developed this PoC to use page_pool APIs for xdp_generic code:
> >=20
> > Why not put the page pool in softnet_data?
>=20
> First I thought cool that Jakub is suggesting softnet_data, which will
> make page_pool (PP) even more central as the netstacks memory layer.
>=20
> BUT then I realized that PP have a weakness, which is the return/free
> path that need to take a normal spin_lock, as that can be called from
> any CPU (unlike the RX/alloc case).  Thus, I fear that making multiple
> devices share a page_pool via softnet_data, increase the chance of lock
> contention when packets are "freed" returned/recycled.

yep, afaik skb_attempt_defer_free() is used just by the tcp stack so far
(e.g. we will have contention for udp).

moreover it seems page_pool return path is not so optimized for the percpu
approach (we have a lot of atomic read/write operations and page_pool stats
are already implemented as percpu variables).

Regards,
Lorenzo

>=20
> --Jesper
>=20
> p.s. PP have the page_pool_put_page_bulk() API, but only XDP (NIC-drivers)
> leverage this.

--egsugcSD3Fs8QYbL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZXB8YgAKCRA6cBh0uS2t
rA2HAP932KDGT1rX/CBkEVNxOYG/9eujkDW8ijLslHaJmH0HPAEAlbqMrAUV5ALh
UCXLIrKwNWx9qYbrrbdVANgk/CHRLQc=
=OF0s
-----END PGP SIGNATURE-----

--egsugcSD3Fs8QYbL--

