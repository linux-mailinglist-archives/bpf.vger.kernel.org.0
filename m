Return-Path: <bpf+bounces-64505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E658B13944
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 12:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC0A18997C5
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 10:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E2324DD12;
	Mon, 28 Jul 2025 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8jZ0Hv2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24421248F7F;
	Mon, 28 Jul 2025 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753699985; cv=none; b=C9Qredrd3U40BJVTfSMapz5Ki7gRgxRPmZeIAW1IFOW+m1UTaRJ0fETOPi/TsXi4a2vjWE7niaqr1G61oPf9dChaR/Ck4c40EuauJ+RHCbbCGiHcKrgNxPx18dymFM6kAvdK2rk0nK0Q9/Nw9s2L80w2s+fGQtpDTLWfi7mqLgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753699985; c=relaxed/simple;
	bh=YzxlFFzWPN1YfBjAA8t6TNM4BqaZ5QzVVLh16SHHCw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=estW61RUIS108imqUI4aSaKW62cO9KZBAezw8BdObsf9w3GDxirjO/wkTwpAFpaecbTmig8sx8n9SHYXCd9BdJF0m1grvWOF3byMl5MlbENNp6XW9JUTWG0U2uchvRIl9LP74eO4RqFWkxbKeZIhk7KCi5pbdd8eshA/Sfx7vjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8jZ0Hv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3EDC4CEE7;
	Mon, 28 Jul 2025 10:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753699984;
	bh=YzxlFFzWPN1YfBjAA8t6TNM4BqaZ5QzVVLh16SHHCw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J8jZ0Hv29q7w3cy//eaHdJ7LcWmSQy8i4vYeHxiCy6d3G3kp3Pau9kT3HI7AIWWys
	 eytN7VEXLw2xnXJSD8//wGe0ev78JDuhEcCY2cplTjidmQFec+62gkzk+5g0OCXo42
	 qpPjzgDcvWX9PQ5Z6r0wKult5vZMbzlH3BnVKz5XxJA/++oonQ+tWzKWYbgFBldHa/
	 Q39EmV+Tqh1LYP0lgSF/9l8DAYAZAU5Qc4ALioaVFN6XMZgGRYWknJbq2AClymm+7h
	 5FQOru7c9+OphqVyrK8w2AMzRikvFkTR8YUyOvwrtnGyneS2iJmY0qNZoTDjEq+3GP
	 uwFLuBKkQHjZQ==
Date: Mon, 28 Jul 2025 12:53:01 +0200
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
Message-ID: <aIdWjTCM1nOjiWfC@lore-desk>
References: <b1873a92-747d-4f32-91f8-126779947e42@kernel.org>
 <aGvcb53APFXR8eJb@mini-arch>
 <aG427EcHHn9yxaDv@lore-desk>
 <aHE2F1FJlYc37eIz@mini-arch>
 <aHeKYZY7l2i1xwel@lore-desk>
 <20250716142015.0b309c71@kernel.org>
 <fbb026f9-54cf-49ba-b0dc-0df0f54c6961@kernel.org>
 <20250717182534.4f305f8a@kernel.org>
 <ebc18aba-d832-4eb6-b626-4ca3a2f27fe2@kernel.org>
 <20250721181344.24d47fa3@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FO0y4WtgO5PCdobH"
Content-Disposition: inline
In-Reply-To: <20250721181344.24d47fa3@kernel.org>


--FO0y4WtgO5PCdobH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 18 Jul 2025 12:56:46 +0200 Jesper Dangaard Brouer wrote:
> > >> Thanks for the feedback. I can see why you'd be concerned about addi=
ng
> > >> another adhoc scheme or making xdp_frame grow into a "para-skb".
> > >>
> > >> However, I'd like to frame this as part of a long-term plan we've be=
en
> > >> calling the "mini-SKB" concept. This isn't a new idea, but a
> > >> continuation of architectural discussions from as far back as [2016]=
=2E =20
> > >=20
> > > My understanding is that while this was floated as a plan by some,
> > > nobody came up with a clean way of implementing it. =20
> >=20
> > I can see why you might think that, but from my perspective, the
> > xdp_frame *is* the implementation of the mini-SKB concept. We've been
> > building it incrementally for years. It started as the most minimal
> > structure possible and has gradually gained more context (e.g. dev_rx,
> > mem_info/rxq_info, flags, and also uses skb_shared_info with same layout
> > as SKB).
>=20
> My understanding was that just adding all the fields to xdp_frame was
> considered too wasteful. Otherwise we would have done something along
> those lines ~10 years ago :S

Hi Jakub,

sorry for the late reply.
I am completely fine to redesign the solution to overcome the problem but I
guess this feature will allow us to improve XDP performance in a common/real
use-case. Let's consider we want to redirect a packet into a veth and then =
into
a container. Preserving the hw metadata performing XDP_REDIRECT will allow =
us
to avoid recalculating the checksum creating the skb. This will result in a
very nice performance improvement.
So I guess we should really come up with some idea to add this missing feat=
ure.

Regards,
Lorenzo

>=20
> > This patch is simply the next logical step in that existing evolution:
> > adding hardware metadata to make it more capable, starting with enabling
> > XDP_REDIRECT offloads. The xdp_frame is our mini-SKB, and this patchset
> > continues its evolution.
>=20
> I thought one of the goals for mini-skb was to move the skb allocation
> out of the drivers. The patches as posted seem to make it the
> responsibility of the XDP program to save the metadata. If you're
> planning to make drivers populate this metadata by default - why add
> the helpers.
>=20
> Again, I just don't understand how these logically fit into place
> vis-a-vis the existing metadata "get" callbacks.

--FO0y4WtgO5PCdobH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaIdWjQAKCRA6cBh0uS2t
rI6CAP4g67FRjB85fO3H1vEP36zjvQfC+Edmr1E5mCbKq+CWvAD+PSVrVL1WZ7i8
sm+VfKIzYnP4zmg3VK2Ths+LoOTZdwU=
=CXBx
-----END PGP SIGNATURE-----

--FO0y4WtgO5PCdobH--

