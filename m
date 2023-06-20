Return-Path: <bpf+bounces-2954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6712F737685
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 23:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4E8281468
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 21:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52664182CD;
	Tue, 20 Jun 2023 21:17:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8CF174D1;
	Tue, 20 Jun 2023 21:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C7CC433C9;
	Tue, 20 Jun 2023 21:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687295825;
	bh=VSt5kV5zA9koKw+yON45/sHrnzDV4SzSWC86WRbHIeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQGv0q9HX7IhJ8yP+50t80IdMhMWRtzzvDXTZEhNbTJH3ZV0WdqcrShRSDg5Bjkwb
	 BTfnQyNnkTAdD/JNyDqbqt13s6bOKsk62tuunQgHrTk+xC/nfCTIaBRLSkiJxXRAGN
	 NgJfGtEduvDnd42gkm4qnCjJXNx4dsGlR0ca9gWwldikrLKFCKnzLnP+aXsaoD2Jtw
	 Jz4VrM7ZNsxFA8G2eUm+xCa4UuUSQnlwsYr2afi+fFcitbgsPR+HoEthmk7IR9eWDO
	 Z5RXRSQ5lagEeDiSAwmqS3wdbvWGwS4SHLfpc8dxuOA1QIKLZxOGIV6V2N8wCRk0nC
	 BXhQjK+JT8RDg==
Date: Tue, 20 Jun 2023 23:16:59 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jesper Dangaard Brouer <jbrouer@redhat.com>, brouer@redhat.com,
	Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Eric Dumazet <edumazet@google.com>,
	Maryam Tahhan <mtahhan@redhat.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v3 3/4] page_pool: introduce page_pool_alloc()
 API
Message-ID: <ZJIXSyjxPf7FQQKo@lore-rh-laptop>
References: <c06f6f59-6c35-4944-8f7a-7f6f0e076649@huawei.com>
 <CAKgT0UccmDe+CE6=zDYQHi1=3vXf5MptzDo+BsPrKdmP5j9kgQ@mail.gmail.com>
 <0ba1bf9c-2e45-cd44-60d3-66feeb3268f3@redhat.com>
 <dcc9db4c-207b-e118-3d84-641677cd3d80@huawei.com>
 <f8ce176f-f975-af11-641c-b56c53a8066a@redhat.com>
 <CAKgT0UfzP30OiBQu+YKefLD+=32t+oA6KGzkvsW6k7CMTXU8KA@mail.gmail.com>
 <699563f5-c4fa-0246-5e79-61a29e1a8db3@redhat.com>
 <CAKgT0UcNOYwxRP_zkaBaZh-VBL-CriL8dFG-VY7-FUyzxfHDWw@mail.gmail.com>
 <ZI8dP5+guKdR7IFE@lore-desk>
 <CAKgT0UfFVFa4zT2DnPZEGaHp0uh5V1u1aGymgdL4Vu8Q1VV8hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IDE08eaH4RavKRtY"
Content-Disposition: inline
In-Reply-To: <CAKgT0UfFVFa4zT2DnPZEGaHp0uh5V1u1aGymgdL4Vu8Q1VV8hQ@mail.gmail.com>


--IDE08eaH4RavKRtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]

> > I did some experiments using page_frag_cache/page_frag_alloc() instead =
of
> > page_pools in a simple environment I used to test XDP for veth driver.
> > In particular, I allocate a new buffer in veth_convert_skb_to_xdp_buff(=
) from
> > the page_frag_cache in order to copy the full skb in the new one, actua=
lly
> > "linearizing" the packet (since we know the original skb length).
> > I run an iperf TCP connection over a veth pair where the
> > remote device runs the xdp_rxq_info sample (available in the kernel sou=
rce
> > tree, with action XDP_PASS):
> >
> > TCP clietn -- v0 =3D=3D=3D v1 (xdp_rxq_info) -- TCP server
> >
> > net-next (page_pool):
> > - MTU 1500B: ~  7.5 Gbps
> > - MTU 8000B: ~ 15.3 Gbps
> >
> > net-next + page_frag_alloc:
> > - MTU 1500B: ~  8.4 Gbps
> > - MTU 8000B: ~ 14.7 Gbps
> >
> > It seems there is no a clear "win" situation here (at least in this env=
ironment
> > and we this simple approach). Moreover:
>=20
> For the 1500B packets it is a win, but for 8000B it looks like there
> is a regression. Any idea what is causing it?

nope, I have not looked into it yet.

>=20
> > - can the linearization introduce any issue whenever we perform XDP_RED=
IRECT
> >   into a destination device?
>=20
> It shouldn't. If it does it would probably point to an issue w/ the
> destination driver rather than an issue with the code doing this.

ack, fine.

>=20
> > - can the page_frag_cache introduce more memory fragmentation (IIRC we =
were
> >   experiencing this issue in mt76 before switching to page_pools).
>=20
> I think it largely depends on where the packets are ending up. I know
> this is the approach we are using for sockets, see
> skb_page_frag_refill(). If nothing else, if you took a similar
> approach to it you might be able to bypass the need for the
> page_frag_cache itself, although you would likely still end up
> allocating similar structures.

ack.

Regards,
Lorenzo

--IDE08eaH4RavKRtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZJIXSAAKCRA6cBh0uS2t
rLojAP4vEPyrpT81w5Pjsfhued/eWj+HL/TUK74YFhQg7gHJ7gD/TpqIHLpG45Tn
cY88letgy76oS6jrFFZlVyzqmkuDXwk=
=dC3S
-----END PGP SIGNATURE-----

--IDE08eaH4RavKRtY--

