Return-Path: <bpf+bounces-62777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC18AFE41E
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 11:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58B7F7AE7CE
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 09:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89542868B0;
	Wed,  9 Jul 2025 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0bPMBJ4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFB72857C2;
	Wed,  9 Jul 2025 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053487; cv=none; b=oUt3+5awrJ5Tkm+MzTNMNFy3sbrHFL8qVkYQSW/g+704UeiLjU7KL62MfosewzQswDuvTf5w23s3j9/3p9FRua9YDk16iAfaSz/RomTPQx1WIpnbwlr9rGQBg7jOMBzXC04TR5qjx9FhV1W2Vr2htfl+Lp4+jZyryrrGxCqdc5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053487; c=relaxed/simple;
	bh=6bCaEWlquqSVy80hQfPmqopeZKFXCGw6/vXAqZZ5ixA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQOVH5/dmG16SUj1LsETK9TQ2ktXUJKWG/Vw+7phobELL1qUFs2H02MIXtYhDgzxu3/VyjkBSw0H5x7cGSF38oIlK7vF+FpYh5XaPO0sGoMY/tIacwnPPCMjkzFOfSrKMLqv75xyr1VqFsr1Uu8xc7O/bNzt5PIhzePQDYEMpg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0bPMBJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C26C4CEEF;
	Wed,  9 Jul 2025 09:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752053486;
	bh=6bCaEWlquqSVy80hQfPmqopeZKFXCGw6/vXAqZZ5ixA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0bPMBJ4hj5+WcujsKgq213XVnBF/G9zvAT6mRl9IxpwfFami6dYz1yvsCYPkFY0j
	 p4NYoA5OsSdDxhS3SlDy1CiNyh2s8dXkH/vo9dC1FBFUd6j92TYLv4nNnqEEvjRIfZ
	 m/7JvA94X3uDCuaLEHlBXzYVWwINFzdQ4V1yr286qeiLLFoN3jYwPYiWHQXNLTGyci
	 PNb7gvMIGv2CMo+PrBMZwA1O13OjZW17uKOvBxW52pKBM0qcJbDfy1/YD388/4DpGN
	 k0yMPOstB2H6ZUF0H3OgIzLOWTk0MNAjdlHZxnAEyMNn3/zDIaKfLT74rhY370WOsj
	 6SKFlNzkjldvw==
Date: Wed, 9 Jul 2025 11:31:24 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <borkmann@iogearbox.net>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
	kernel-team@cloudflare.com, arthur@arthurfabre.com,
	jakub@cloudflare.com
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
Message-ID: <aG427EcHHn9yxaDv@lore-desk>
References: <175146824674.1421237.18351246421763677468.stgit@firesoul>
 <aGVY2MQ18BWOisWa@mini-arch>
 <b1873a92-747d-4f32-91f8-126779947e42@kernel.org>
 <aGvcb53APFXR8eJb@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2NjCwQwetG8bXFrO"
Content-Disposition: inline
In-Reply-To: <aGvcb53APFXR8eJb@mini-arch>


--2NjCwQwetG8bXFrO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 07, Stanislav Fomichev wrote:
> On 07/03, Jesper Dangaard Brouer wrote:
> >=20
> >=20
> > On 02/07/2025 18.05, Stanislav Fomichev wrote:
> > > On 07/02, Jesper Dangaard Brouer wrote:
> > > > This patch series introduces a mechanism for an XDP program to stor=
e RX
> > > > metadata hints - specifically rx_hash, rx_vlan_tag, and rx_timestam=
p -
> > > > into the xdp_frame. These stored hints are then used to populate the
> > > > corresponding fields in the SKB that is created from the xdp_frame
> > > > following an XDP_REDIRECT.
> > > >=20
> > > > The chosen RX metadata hints intentionally map to the existing NIC
> > > > hardware metadata that can be read via kfuncs [1]. While this design
> > > > allows a BPF program to read and propagate existing hardware hints,=
 our
> > > > primary motivation is to enable setting custom values. This is impo=
rtant
> > > > for use cases where the hardware-provided information is insufficie=
nt or
> > > > needs to be calculated based on packet contents unavailable to the
> > > > hardware.
> > > >=20
> > > > The primary motivation for this feature is to enable scalable load
> > > > balancing of encapsulated tunnel traffic at the XDP layer. When tun=
nelled
> > > > packets (e.g., IPsec, GRE) are redirected via cpumap or to a veth d=
evice,
> > > > the networking stack later calculates a software hash based on the =
outer
> > > > headers. For a single tunnel, these outer headers are often identic=
al,
> > > > causing all packets to be assigned the same hash. This collapses all
> > > > traffic onto a single RX queue, creating a performance bottleneck a=
nd
> > > > defeating receive-side scaling (RSS).
> > > >=20
> > > > Our immediate use case involves load balancing IPsec traffic. For s=
uch
> > > > tunnelled traffic, any hardware-provided RX hash is calculated on t=
he
> > > > outer headers and is therefore incorrect for distributing inner flo=
ws.
> > > > There is no reason to read the existing value, as it must be recalc=
ulated.
> > > > In our XDP program, we perform a partial decryption to access the i=
nner
> > > > headers and calculate a new load-balancing hash, which provides bet=
ter
> > > > flow distribution. However, without this patch set, there is no way=
 to
> > > > persist this new hash for the network stack to use post-redirect.
> > > >=20
> > > > This series solves the problem by introducing new BPF kfuncs that a=
llow an
> > > > XDP program to write e.g. the hash value into the xdp_frame. The
> > > > __xdp_build_skb_from_frame() function is modified to use this store=
d value
> > > > to set skb->hash on the newly created SKB. As a result, the veth dr=
iver's
> > > > queue selection logic uses the BPF-supplied hash, achieving proper
> > > > traffic distribution across multiple CPU cores. This also ensures t=
hat
> > > > consumers, like the GRO engine, can operate effectively.
> > > >=20
> > > > We considered XDP traits as an alternative to adding static members=
 to
> > > > struct xdp_frame. Given the immediate need for this functionality a=
nd the
> > > > current development status of traits, we believe this approach is a
> > > > pragmatic solution. We are open to migrating to a traits-based
> > > > implementation if and when they become a generally accepted mechani=
sm for
> > > > such extensions.
> > > >=20
> > > > [1] https://docs.kernel.org/networking/xdp-rx-metadata.html
> > > > ---
> > > > V1: https://lore.kernel.org/all/174897271826.1677018.90968668823477=
45168.stgit@firesoul/
> > >=20
> > > No change log?
> >=20
> > We have fixed selftest as requested by Alexie.
> > And we have updated cover-letter and doc as you Stanislav requested.
> >=20
> > >=20
> > > Btw, any feedback on the following from v1?
> > > - https://lore.kernel.org/netdev/aFHUd98juIU4Rr9J@mini-arch/
> >=20
> > Addressed as updated cover-letter and documentation. I hope this helps
> > reviewers understand the use-case, as the discussion turn into "how do =
we
> > transfer all HW metadata", which is NOT what we want (and a waste of
> > precious cycles).
> >=20
> > For our use-case, it doesn't make sense to "transfer all HW metadata".
> > In fact we don't even want to read the hardware RH-hash, because we alr=
eady
> > know it is wrong (for tunnels), we just want to override the RX-hash us=
ed at
> > SKB creation.  We do want the BPF programmers flexibility to call these
> > kfuncs individually (when relevant).
> >=20
> > > - https://lore.kernel.org/netdev/20250616145523.63bd2577@kernel.org/
> >=20
> > I feel pressured into critiquing Jakub's suggestion, hope this is not t=
oo
> > harsh.  First of all it is not relevant to our this patchset use-case, =
as it
> > focus on all HW metadata.
>=20
> [..]
>=20
> > Second, I disagree with the idea/mental model of storing in a
> > "driver-specific format". The current implementation of driver-specific
> > kfunc helpers that "get the metadata" is already doing a conversion to a
> > common format, because the BPF-programmer naturally needs this to be the
> > same across drivers.  Thus, it doesn't make sense to store it back in a
> > "driver-specific format", as that just complicate things.  My mental mo=
del
> > is thus, that after the driver-specific "get" operation to result is in=
 a
> > common format, that is simply defined by the struct type of the kfunc, =
which
> > is both known by the kernel and BPF-prog.
>=20
> Having get/set model seems a bit more generic, no? Potentially giving us =
the
> ability to "correct" HW metadata for the non-redirected cases as well.
> Plus we don't hard-code the (internal) layout. Solving only xdp_redirect
> seems a bit too narrow, idk..

I can't see what the non-redirected use-case could be. Can you please provi=
de
more details?
Moreover, can it be solved without storing the rx_hash (or the other
hw-metadata) in a non-driver specific format?
Storing the hw-metadata in some of hw-specific format in xdp_frame will not
allow to consume them directly building the skb and we will require to deco=
de
them again. What is the upside/use-case of this approach? (not considering =
the
orthogonality with the get method).

Regards,
Lorenzo


--2NjCwQwetG8bXFrO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaG427AAKCRA6cBh0uS2t
rPzZAP9a0BdVfHi9Ys3D+2pq9H3xdCKH/DpQnVi+pwh54aDggwD9Fu7aCxEcWn+n
w5u226RfaVuGnGuOv6YNLX1F66EvIgk=
=lAh1
-----END PGP SIGNATURE-----

--2NjCwQwetG8bXFrO--

