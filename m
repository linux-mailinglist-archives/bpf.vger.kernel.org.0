Return-Path: <bpf+bounces-63703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04585B0A027
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 11:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2C13A6890
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 09:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B58829B76B;
	Fri, 18 Jul 2025 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGiQPedG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838181EEA55;
	Fri, 18 Jul 2025 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752832507; cv=none; b=W9qEOGb9lLgUVjvGqQhUEeJF+ElPmmUpC7tH22WDdhKX2FUtDlJRWi1599QREKOM/tUjjJvpRFqIhrAIAiJfbbQAx2kJEZjoHS7DJ/esXdn7LyFZDOB+ChIUPYzaTa6iCh1mhYVP3y3VrbqJouGBqwRMN457B4jyn+vxBp3iy1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752832507; c=relaxed/simple;
	bh=ZOpxGvlB4jXA+g08s6brGIOXdPzVhwvsEnSWfq9WdFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiXoE9IMgsiwEKmIsqjWdow7EgPfPTos2GVd+uogd9QRBsb70Bh2tYIgJXEjNM1HfJbsdamstfZDrgiqIQ/K8eKAzqiZssbhqwIt3L7JOzmFT4983twuhJZClI28WVH+1rDryR+1Nx3SYGNoOR3uRT+WZAlpOIzdW94KLHXK9IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGiQPedG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8901C4CEEB;
	Fri, 18 Jul 2025 09:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752832507;
	bh=ZOpxGvlB4jXA+g08s6brGIOXdPzVhwvsEnSWfq9WdFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qGiQPedGYIJQhddVeiLfKZCQ61FNIFbIAGmkvICPdk5FCjrKswrbQ3OUKhH1gsAUM
	 uztcV1j7faqMlUhC0svXM7alPcYeAknWBiV/sG5tKGv6a7R+j2FP+ZGO/h8tdyDqvY
	 FkfN0YiWhzU33fEYesDanVP9XU6Xu125sk+3jDEHZEuPZOBuwDzr4VwlCahPBls2nZ
	 cHqPjkFWvVsMk5TavDpB38V/A+1AQUQBhy0crvSbLPwxMGt7UypXgeec3x07v96yu3
	 Ou1MzuqkOGi2gKoKNWyWNTXXHntftD/fzFSaz0SWb6E/tN8AaZobtUg4KKf9UsyGzX
	 frcSvogauAdqg==
Date: Fri, 18 Jul 2025 11:55:04 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <aHoZ-LtKT9p5FKAD@lore-desk>
References: <175146824674.1421237.18351246421763677468.stgit@firesoul>
 <aGVY2MQ18BWOisWa@mini-arch>
 <b1873a92-747d-4f32-91f8-126779947e42@kernel.org>
 <aGvcb53APFXR8eJb@mini-arch>
 <aG427EcHHn9yxaDv@lore-desk>
 <aHE2F1FJlYc37eIz@mini-arch>
 <aHeKYZY7l2i1xwel@lore-desk>
 <20250716142015.0b309c71@kernel.org>
 <fbb026f9-54cf-49ba-b0dc-0df0f54c6961@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8cQoNIRDvDCW5dqT"
Content-Disposition: inline
In-Reply-To: <fbb026f9-54cf-49ba-b0dc-0df0f54c6961@kernel.org>


--8cQoNIRDvDCW5dqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 16/07/2025 23.20, Jakub Kicinski wrote:
> > On Wed, 16 Jul 2025 13:17:53 +0200 Lorenzo Bianconi wrote:
> > > > > I can't see what the non-redirected use-case could be. Can you pl=
ease provide
> > > > > more details?
> > > > > Moreover, can it be solved without storing the rx_hash (or the ot=
her
> > > > > hw-metadata) in a non-driver specific format?
> > > >=20
> > > > Having setters feels more generic than narrowly solving only the re=
direct,
> > > > but I don't have a good use-case in mind.
> > > > > Storing the hw-metadata in some of hw-specific format in xdp_fram=
e will not
> > > > > allow to consume them directly building the skb and we will requi=
re to decode
> > > > > them again. What is the upside/use-case of this approach? (not co=
nsidering the
> > > > > orthogonality with the get method).
> > > >=20
> > > > If we add the store kfuncs to regular drivers, the metadata  won't =
be stored
> > > > in the xdp_frame; it will go into the rx descriptors so regular pat=
h that
> > > > builds skbs will use it.
> > >=20
> > > IIUC, the described use-case would be to modify the hw metadata via a
> > > 'setter' kfunc executed by an eBPF program bounded to the NIC and to =
store
> > > the new metadata in the DMA descriptor in order to be consumed by the=
 driver
> > > codebase building the skb, right?
> > > If so:
> > > - we can get the same result just storing (running a kfunc) the modif=
ied hw
> > >    metadata in the xdp_buff struct using a well-known/generic layout =
and
> > >    consume it in the driver codebase (e.g. if the bounded eBPF program
> > >    returns XDP_PASS) using a generic xdp utility routine. This part i=
s not in
> > >    the current series.
> > > - Using this approach we are still not preserving the hw metadata if =
we pass
> > >    the xdp_frame to a remote CPU returning XDP_REDIRCT (we need to ad=
d more
> > >    code)
> > > - I am not completely sure if can always modify the DMA descriptor di=
rectly
> > >    since it is DMA mapped.
>=20
> Let me explain why it is a bad idea of writing into the RX descriptors.
> The DMA descriptors are allocated as coherent DMA (dma_alloc_coherent).
> This is memory that is shared with the NIC hardware device, which
> implies cache-line coherence.  NIC performance is tightly coupled to
> limiting cache misses for descriptors.  One common trick is to pack more
> descriptors into a single cache-line.  Thus, if we start to write into
> the current RX-descriptor, then we invalidate that cache-line seen from
> the device, and next RX-descriptor (from this cache-line) will be in an
> unfortunate coherent state.  Behind the scene this might lead to some
> extra PCIe transactions.
>=20
> By writing to the xdp_frame, we don't have to modify the DMA descriptors
> directly and risk invalidating cache lines for the NIC.
>=20
> > >=20
> > > What do you think?
> >=20
> > FWIW I commented on an earlier revision to similar effect as Stanislav.
> > To me the main concern is that we're adding another adhoc scheme, and
> > are making xdp_frame grow into a para-skb. We added XDP to make raw
> > packet access fast, now we're making drivers convert metadata twice :/
>=20
> Thanks for the feedback. I can see why you'd be concerned about adding
> another adhoc scheme or making xdp_frame grow into a "para-skb".
>=20
> However, I'd like to frame this as part of a long-term plan we've been
> calling the "mini-SKB" concept. This isn't a new idea, but a
> continuation of architectural discussions from as far back as [2016].
>=20
> The long-term goal, described in these presentations from [2018] and
> [2019], has always been to evolve the xdp_frame to handle more hardware
> offloads, with the ultimate vision of moving SKB allocation out of NIC
> drivers entirely. In the future, the netstack could perform L3
> forwarding (and L2 bridging) directly on these enhanced xdp_frames
> [2019-slide20]. The main blocker for this vision has been the lack of
> hardware metadata in the xdp_frame.
>=20
> This patchset is a small but necessary first step towards that goal. It
> focuses on the concrete XDP_REDIRECT use-case where we can immediately
> benefit for our production use-case. Storing this metadata in the
> xdp_frame is fundamental to the plan. It's no coincidence the fields are
> compatible with the SKB; they need to be.
>=20
> I'm certainly open to debating the bigger picture, but I hope we can
> agree that it shouldn't hold up this first step, which solves an
> immediate need. Perhaps we can evaluate the merits of this specific
> change first, and discuss the overall architecture in parallel?

Considering the XDP_REDIRECT use-case, this series will allow us (in the
future) to avoid recomputing the packet checksum redirecting the frame into
a veth and then into a container, obtaining a significant performance
improvement.

Regarding,
Lorenzo

>=20
> --Jesper
>=20
>=20
> Links:
> ------
> [2019] XDP closer integration with network stack
>  - https://people.netfilter.org/hawk/presentations/KernelRecipes2019/xdp-=
netstack-concert.pdf
>  - https://github.com/xdp-project/xdp-project/blob/main/conference/Kernel=
Recipes2019/xdp-netstack-concert.org#slide-move-skb-allocations-out-of-nic-=
drivers
>  - [2019-slide20] https://github.com/xdp-project/xdp-project/blob/main/co=
nference/KernelRecipes2019/xdp-netstack-concert.org#slide-fun-with-xdp_fram=
e-before-skb-alloc
>=20
> [2018] LPC Networking Track: XDP - challenges and future work
>  - https://people.netfilter.org/hawk/presentations/LinuxPlumbers2018/
>  - https://github.com/xdp-project/xdp-project/blob/main/conference/LinuxP=
lumbers2018/presentation-lpc2018-xdp-future.org#topic-moving-skb-allocation=
-out-of-driver
>=20
> [2016] Network Performance Workshop
>  - https://people.netfilter.org/hawk/presentations/NetDev1.2_2016/net_per=
formance_workshop_netdev1.2.pdf

--8cQoNIRDvDCW5dqT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaHoZ+AAKCRA6cBh0uS2t
rLDFAQCbmijHuCrJlWVOiBF0P7vNUUI/egbAkiNHuJEaxSUMVAD8DyOMQMEtMzwX
1P2Buyv3O3D2WvXpB3UPwcUzFt+KSA4=
=mc7P
-----END PGP SIGNATURE-----

--8cQoNIRDvDCW5dqT--

