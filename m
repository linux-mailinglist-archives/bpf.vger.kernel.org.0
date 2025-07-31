Return-Path: <bpf+bounces-64843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFC6B177F5
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 23:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE771C275AC
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 21:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97B82512C3;
	Thu, 31 Jul 2025 21:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qi3HSgaW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E5C17DFE7;
	Thu, 31 Jul 2025 21:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753996697; cv=none; b=UdhoaMGXGBhL/ioTObmy/0Z6GRkMNxoKW5VOL1Ht9Xb5uyj++bgsB1WRwdYjAxpEHjFnm1YuKC8MGKoxRHo9Kdi4hnYgJ0fkcjfafKdzeW0sQcuyqsyW6kMKEqX/c7Q1ezpKRCTMy8w/u7BtCQdUezNvk3cd0pJWlCYMRy9nhOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753996697; c=relaxed/simple;
	bh=TyUwrn5g4RlVANWXkNRSUMckyOvX1AStRG6C6/2deTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFQZbiIKYG2HYik2N1/hB5vU/Fi0wa9gPoogo/nsix6SoSN0DTlqhOMzQskF/s3ebNTKWDOOArJvbqFsrmHfqiNRYx5PXgAJvRuePXGWur9d2XyRA+csmNsygCjaVIB8UPkcFoZJNjf3zwo0S5CGMyDr4z7UpG83GIhLvxjrhIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qi3HSgaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E27BC4CEEF;
	Thu, 31 Jul 2025 21:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753996696;
	bh=TyUwrn5g4RlVANWXkNRSUMckyOvX1AStRG6C6/2deTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qi3HSgaWoKaFbYwzF3l/Iqgs8SNCOPJsdbyyBYT3yAOlOlOTbXbtq5iQq6m54ezgz
	 54/2eI2xEiXviUmNVlsSBcOQGyeNT/u65YH6ZKQ0cpb0rwtugA+4CcfC+SSyxs2biZ
	 fIyPXTgsGJoK1U6oEHW2U1NgqxcDIpLhvK6ASyaMjZU58ofyN1r2Pgl/DwiwrHqU5n
	 yau6PS3eVVWoXaRyGcg5Jc6IqbMmhGQbK6KjI3c0kIRh3SR1mmiU5D7z5FttpwhePx
	 brSLf59bEX/B+uDqFYhssx077iMHVljthaZUnd1y2jRa56efdt1ppX2v/x8KJTZ1/R
	 PUpP3f1mch++g==
Date: Thu, 31 Jul 2025 23:18:12 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <borkmann@iogearbox.net>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
	kernel-team@cloudflare.com, arthur@arthurfabre.com,
	jakub@cloudflare.com, Jesse Brandeburg <jbrandeburg@cloudflare.com>
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
Message-ID: <aIvdlJts5JQLuzLE@lore-rh-laptop>
References: <aG427EcHHn9yxaDv@lore-desk>
 <aHE2F1FJlYc37eIz@mini-arch>
 <aHeKYZY7l2i1xwel@lore-desk>
 <20250716142015.0b309c71@kernel.org>
 <fbb026f9-54cf-49ba-b0dc-0df0f54c6961@kernel.org>
 <20250717182534.4f305f8a@kernel.org>
 <ebc18aba-d832-4eb6-b626-4ca3a2f27fe2@kernel.org>
 <20250721181344.24d47fa3@kernel.org>
 <aIdWjTCM1nOjiWfC@lore-desk>
 <20250728092956.24a7d09b@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="db76Nij/wM12quQy"
Content-Disposition: inline
In-Reply-To: <20250728092956.24a7d09b@kernel.org>


--db76Nij/wM12quQy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 28, Jakub Kicinski wrote:
> On Mon, 28 Jul 2025 12:53:01 +0200 Lorenzo Bianconi wrote:
> > > > I can see why you might think that, but from my perspective, the
> > > > xdp_frame *is* the implementation of the mini-SKB concept. We've be=
en
> > > > building it incrementally for years. It started as the most minimal
> > > > structure possible and has gradually gained more context (e.g. dev_=
rx,
> > > > mem_info/rxq_info, flags, and also uses skb_shared_info with same l=
ayout
> > > > as SKB). =20
> > >=20
> > > My understanding was that just adding all the fields to xdp_frame was
> > > considered too wasteful. Otherwise we would have done something along
> > > those lines ~10 years ago :S =20
> >=20
> > Hi Jakub,
> >=20
> > sorry for the late reply.
> > I am completely fine to redesign the solution to overcome the problem b=
ut I
> > guess this feature will allow us to improve XDP performance in a common=
/real
> > use-case. Let's consider we want to redirect a packet into a veth and t=
hen into
> > a container. Preserving the hw metadata performing XDP_REDIRECT will al=
low us
> > to avoid recalculating the checksum creating the skb. This will result =
in a
> > very nice performance improvement.
> > So I guess we should really come up with some idea to add this missing =
feature.
>=20
> I don't think the counter-proposal prevents that. As long as veth
> supports "set" callbacks the program can transfer the metadata over
> to the veth and the second program at veth can communicate them to=20
> the driver.

IIUC the 'set' proposal (please correct me if I am wrong), the eBPF program
running on the NIC that is receiving the packet from the wire is supposed
to set (or update) the hw metadata info (e.g. RX HASH or RX checksum) in
the RX DMA descriptor associated to the packet to be successively consumed.
Am I right?
I think this approach works fine if the SKB is created locally in the NAPI
loop of the receiving driver (e.g if the eBPF program bounded on the NIC is
returning XDP_PASS) but I guess it does not work if the packet is redirected
into a remote CPU or a remote device (e.g. veth). Considering the veth
use-case, veth_ndo_xdp_xmit() enqueues the packet into a ptr_ring and
schedule a NAPI. When the NAPI runs I guess the DMA descriptor originally
associated to the packet has been already queued back to the hw ring to be
consumed for a following packet. In order to be able to easily consume
these hw metadata I guess we should store these info in the same packet
buffer. Am I missing something?

Regards,
Lorenzo

>=20
> Martin mentioned to me that he had proposed in the past that we allow
> allocating the skb at the XDP level, if the program needs "skb-level
> metadata". That actually seems pretty clean to me.. Was it ever
> explored?

--db76Nij/wM12quQy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaIvdkQAKCRA6cBh0uS2t
rGrCAQC/z54AjtHwMZeNxHust+8CI4k1RZeIRsgPPdZV83R9PwD+Iz329yY0tMvt
pzdydKK00WIBDAJMy82C8mFVgPVC4gw=
=f8k/
-----END PGP SIGNATURE-----

--db76Nij/wM12quQy--

