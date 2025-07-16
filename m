Return-Path: <bpf+bounces-63424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF97B0747C
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 13:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0C93BB1E1
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 11:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EFF2F1FF2;
	Wed, 16 Jul 2025 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4s71lZw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192AB20110B;
	Wed, 16 Jul 2025 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664676; cv=none; b=LzYXbhA6+HTvl5QvJqL0mXNglQCStlQijK+cK8ON6y0+JC4OncMVd3GA7obF3vc0zB3803+D/SmUY7Dz7T7OyS8iwCDcb/vQCvJ5n8bRodvRhuvz6/kz7DvTbf6BeyFa30MsK8U7X2abxHkSKu0dT+rGgBuOjK57XwCv7Q3JS+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664676; c=relaxed/simple;
	bh=/bE9uYvVyUGZ+BhYd7LhdbgHzv2DAr1xtEZ82h/wy/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqqgdVpqmUblWiQ0+eX4F8ROUih6gFqC7OgsE0usjqi3Q56ZZOQTfPpW+mnr9PNXHLMCycWnM4MH5wgSnsNNRPwephePhD7v7Jf7mhhIXFVpOsidUINzyjXUNbPaa80/1FAyMqFgxMqgR7pZobtpf8bhLJBGQrk58m821Baox2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4s71lZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2828BC4CEF0;
	Wed, 16 Jul 2025 11:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752664675;
	bh=/bE9uYvVyUGZ+BhYd7LhdbgHzv2DAr1xtEZ82h/wy/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4s71lZw8hAn0G82NVWmFsRMlGrkKa8FuBY3JK/8q71pg7Efe/M/uN+CjFZSz4nPF
	 /nBEo7Ex0wOk9BvnSkZuBoDPffjXoU129GjY+iy+R3gvnZ4DYqNryCQxA/EOpL2eJM
	 9BrzfAcUO9hrxkMH6m5Bco48am1Lhx1VSkt39R9hqUKJLndppc7wA+n2W5FgXIXGnu
	 m67CfxJCVNRcSNX4dhZbRPGiIkFw9BQeC0KUIPqTSCftc5hxTulXN3v034hPJJll/8
	 qhSYvn+8IcR0aPYz4JcFC2qPGQwKFZGNL+fEY0ozOgZU6KXPhOnQAVRF9A01SK0+CH
	 tftUFDD30t3wA==
Date: Wed, 16 Jul 2025 13:17:53 +0200
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
Message-ID: <aHeKYZY7l2i1xwel@lore-desk>
References: <175146824674.1421237.18351246421763677468.stgit@firesoul>
 <aGVY2MQ18BWOisWa@mini-arch>
 <b1873a92-747d-4f32-91f8-126779947e42@kernel.org>
 <aGvcb53APFXR8eJb@mini-arch>
 <aG427EcHHn9yxaDv@lore-desk>
 <aHE2F1FJlYc37eIz@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uzvVjflaG6r8ZAJ6"
Content-Disposition: inline
In-Reply-To: <aHE2F1FJlYc37eIz@mini-arch>


--uzvVjflaG6r8ZAJ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 11, Stanislav Fomichev wrote:
> On 07/09, Lorenzo Bianconi wrote:
> > On Jul 07, Stanislav Fomichev wrote:
> > > On 07/03, Jesper Dangaard Brouer wrote:
> > > >=20
> > > >=20
> > > > On 02/07/2025 18.05, Stanislav Fomichev wrote:
> > > > > On 07/02, Jesper Dangaard Brouer wrote:
> > > > > > This patch series introduces a mechanism for an XDP program to =
store RX
> > > > > > metadata hints - specifically rx_hash, rx_vlan_tag, and rx_time=
stamp -
> > > > > > into the xdp_frame. These stored hints are then used to populat=
e the
> > > > > > corresponding fields in the SKB that is created from the xdp_fr=
ame
> > > > > > following an XDP_REDIRECT.
> > > > > >=20
> > > > > > The chosen RX metadata hints intentionally map to the existing =
NIC
> > > > > > hardware metadata that can be read via kfuncs [1]. While this d=
esign
> > > > > > allows a BPF program to read and propagate existing hardware hi=
nts, our
> > > > > > primary motivation is to enable setting custom values. This is =
important
> > > > > > for use cases where the hardware-provided information is insuff=
icient or
> > > > > > needs to be calculated based on packet contents unavailable to =
the
> > > > > > hardware.
> > > > > >=20
> > > > > > The primary motivation for this feature is to enable scalable l=
oad
> > > > > > balancing of encapsulated tunnel traffic at the XDP layer. When=
 tunnelled
> > > > > > packets (e.g., IPsec, GRE) are redirected via cpumap or to a ve=
th device,
> > > > > > the networking stack later calculates a software hash based on =
the outer
> > > > > > headers. For a single tunnel, these outer headers are often ide=
ntical,
> > > > > > causing all packets to be assigned the same hash. This collapse=
s all
> > > > > > traffic onto a single RX queue, creating a performance bottlene=
ck and
> > > > > > defeating receive-side scaling (RSS).
> > > > > >=20
> > > > > > Our immediate use case involves load balancing IPsec traffic. F=
or such
> > > > > > tunnelled traffic, any hardware-provided RX hash is calculated =
on the
> > > > > > outer headers and is therefore incorrect for distributing inner=
 flows.
> > > > > > There is no reason to read the existing value, as it must be re=
calculated.
> > > > > > In our XDP program, we perform a partial decryption to access t=
he inner
> > > > > > headers and calculate a new load-balancing hash, which provides=
 better
> > > > > > flow distribution. However, without this patch set, there is no=
 way to
> > > > > > persist this new hash for the network stack to use post-redirec=
t.
> > > > > >=20
> > > > > > This series solves the problem by introducing new BPF kfuncs th=
at allow an
> > > > > > XDP program to write e.g. the hash value into the xdp_frame. The
> > > > > > __xdp_build_skb_from_frame() function is modified to use this s=
tored value
> > > > > > to set skb->hash on the newly created SKB. As a result, the vet=
h driver's
> > > > > > queue selection logic uses the BPF-supplied hash, achieving pro=
per
> > > > > > traffic distribution across multiple CPU cores. This also ensur=
es that
> > > > > > consumers, like the GRO engine, can operate effectively.
> > > > > >=20
> > > > > > We considered XDP traits as an alternative to adding static mem=
bers to
> > > > > > struct xdp_frame. Given the immediate need for this functionali=
ty and the
> > > > > > current development status of traits, we believe this approach =
is a
> > > > > > pragmatic solution. We are open to migrating to a traits-based
> > > > > > implementation if and when they become a generally accepted mec=
hanism for
> > > > > > such extensions.
> > > > > >=20
> > > > > > [1] https://docs.kernel.org/networking/xdp-rx-metadata.html
> > > > > > ---
> > > > > > V1: https://lore.kernel.org/all/174897271826.1677018.9096866882=
347745168.stgit@firesoul/
> > > > >=20
> > > > > No change log?
> > > >=20
> > > > We have fixed selftest as requested by Alexie.
> > > > And we have updated cover-letter and doc as you Stanislav requested.
> > > >=20
> > > > >=20
> > > > > Btw, any feedback on the following from v1?
> > > > > - https://lore.kernel.org/netdev/aFHUd98juIU4Rr9J@mini-arch/
> > > >=20
> > > > Addressed as updated cover-letter and documentation. I hope this he=
lps
> > > > reviewers understand the use-case, as the discussion turn into "how=
 do we
> > > > transfer all HW metadata", which is NOT what we want (and a waste of
> > > > precious cycles).
> > > >=20
> > > > For our use-case, it doesn't make sense to "transfer all HW metadat=
a".
> > > > In fact we don't even want to read the hardware RH-hash, because we=
 already
> > > > know it is wrong (for tunnels), we just want to override the RX-has=
h used at
> > > > SKB creation.  We do want the BPF programmers flexibility to call t=
hese
> > > > kfuncs individually (when relevant).
> > > >=20
> > > > > - https://lore.kernel.org/netdev/20250616145523.63bd2577@kernel.o=
rg/
> > > >=20
> > > > I feel pressured into critiquing Jakub's suggestion, hope this is n=
ot too
> > > > harsh.  First of all it is not relevant to our this patchset use-ca=
se, as it
> > > > focus on all HW metadata.
> > >=20
> > > [..]
> > >=20
> > > > Second, I disagree with the idea/mental model of storing in a
> > > > "driver-specific format". The current implementation of driver-spec=
ific
> > > > kfunc helpers that "get the metadata" is already doing a conversion=
 to a
> > > > common format, because the BPF-programmer naturally needs this to b=
e the
> > > > same across drivers.  Thus, it doesn't make sense to store it back =
in a
> > > > "driver-specific format", as that just complicate things.  My menta=
l model
> > > > is thus, that after the driver-specific "get" operation to result i=
s in a
> > > > common format, that is simply defined by the struct type of the kfu=
nc, which
> > > > is both known by the kernel and BPF-prog.
> > >=20
> > > Having get/set model seems a bit more generic, no? Potentially giving=
 us the
> > > ability to "correct" HW metadata for the non-redirected cases as well.
> > > Plus we don't hard-code the (internal) layout. Solving only xdp_redir=
ect
> > > seems a bit too narrow, idk..
> >=20
> > I can't see what the non-redirected use-case could be. Can you please p=
rovide
> > more details?
> > Moreover, can it be solved without storing the rx_hash (or the other
> > hw-metadata) in a non-driver specific format?
>=20
> Having setters feels more generic than narrowly solving only the redirect,
> but I don't have a good use-case in mind.
>=20
> > Storing the hw-metadata in some of hw-specific format in xdp_frame will=
 not
> > allow to consume them directly building the skb and we will require to =
decode
> > them again. What is the upside/use-case of this approach? (not consider=
ing the
> > orthogonality with the get method).
>=20
> If we add the store kfuncs to regular drivers, the metadata  won't be sto=
red
> in the xdp_frame; it will go into the rx descriptors so regular path that
> builds skbs will use it.

IIUC, the described use-case would be to modify the hw metadata via a
'setter' kfunc executed by an eBPF program bounded to the NIC and to store
the new metadata in the DMA descriptor in order to be consumed by the driver
codebase building the skb, right?
If so:
- we can get the same result just storing (running a kfunc) the modified hw
  metadata in the xdp_buff struct using a well-known/generic layout and
  consume it in the driver codebase (e.g. if the bounded eBPF program
  returns XDP_PASS) using a generic xdp utility routine. This part is not in
  the current series.
- Using this approach we are still not preserving the hw metadata if we pass
  the xdp_frame to a remote CPU returning XDP_REDIRCT (we need to add more
  code)
- I am not completely sure if can always modify the DMA descriptor directly
  since it is DMA mapped.

What do you think?

Regards,
Lorenzo


--uzvVjflaG6r8ZAJ6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaHeKYQAKCRA6cBh0uS2t
rOQOAP9eos9MRK3D5uQLDkRk3+dOyQTPF61wyTMJ8CW8UjxGywD/WBA0HQruFktE
e39NatZ5jRUrkloQF1lX+2v3Owbraws=
=hD2Q
-----END PGP SIGNATURE-----

--uzvVjflaG6r8ZAJ6--

