Return-Path: <bpf+bounces-60739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CA8ADB733
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 18:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5C8188A33D
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 16:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580B620FAA4;
	Mon, 16 Jun 2025 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEWqZx5l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD6921FF37;
	Mon, 16 Jun 2025 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750092013; cv=none; b=BWHbjF/6HjOzbTYjz8gzQ7eM5YgTKTF2oivUh1k0d052A3Y7zbpEgP3NzAODQIG48unId+rsifVVor1dmOLjdm+opb7sMouowjc8/hw6mOlLgqD/h5WJew6qx7p3b0tD5zl96cbzDib7ZsYN8d3y1SaeuGwpPnmAQJMdXtltpYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750092013; c=relaxed/simple;
	bh=DW/mYNwTouTw10FCu2yR/A/2ODddX0eTePEGQ27HCEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkkKERW6i+JcGbxVZpa6en/EO++PbPeh8Q24Vgy6Cqhpox6jBNwH8V7BmtQ8VmqXVvSboFdekOwyB7V2rB2YDsFVq+1QHaBtThfdMYc/F5fhHP8btIqL0YGTmB0FEAMG2r9K264uE3+hBZhdqPXGrqx1ie3QSsgUqaVIPTArO9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEWqZx5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F052DC4CEEA;
	Mon, 16 Jun 2025 16:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750092013;
	bh=DW/mYNwTouTw10FCu2yR/A/2ODddX0eTePEGQ27HCEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BEWqZx5lIfH8+gakxPxfUHRrDMUg5vM79KBdqR5ODrfT5TytEAZbAifZTI0i5/nA2
	 8AeWFRLIBsqa0pOYYv+URXlYw3LrWz1zwpzuoSpr60tKJvS43jG35iHsMkpowjGMwh
	 4z9q7nuvNthZA4XDqPJia5RbWIzfBYVaIxPjvdWyUqeZRVw5wMD8/y8tIVAxmEAbge
	 FagM1IBgtCgKoN3CqHSsIQrVo7eVBTf1o1uKWq89wEHJAppKgSuprvxfaxY/4erHDU
	 mU37kfV6w7GlXUVET68WRMQ3DM0WjHyHOulZRLvKRec+tW863oWSNnOYZAUgYK1C4B
	 f5zldll0kZ3eA==
Date: Mon, 16 Jun 2025 18:40:10 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <borkmann@iogearbox.net>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
	kernel-team@cloudflare.com, arthur@arthurfabre.com,
	jakub@cloudflare.com, Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH bpf-next V1 7/7] net: xdp: update documentation for
 xdp-rx-metadata.rst
Message-ID: <aFBI6msJQn4-LZsH@lore-desk>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
 <174897279518.1677018.5982630277641723936.stgit@firesoul>
 <aEJWTPdaVmlIYyKC@mini-arch>
 <bf7209aa-8775-448d-a12e-3a30451dad22@iogearbox.net>
 <87plfbcq4m.fsf@toke.dk>
 <aEixEV-nZxb1yjyk@lore-rh-laptop>
 <aEj6nqH85uBe2IlW@mini-arch>
 <aFAQJKQ5wM-htTWN@lore-desk>
 <aFA8BzkbzHDQgDVD@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sDj39uYRsqJWsHZB"
Content-Disposition: inline
In-Reply-To: <aFA8BzkbzHDQgDVD@mini-arch>


--sDj39uYRsqJWsHZB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 06/16, Lorenzo Bianconi wrote:
> > On Jun 10, Stanislav Fomichev wrote:
> > > On 06/11, Lorenzo Bianconi wrote:
> > > > > Daniel Borkmann <daniel@iogearbox.net> writes:
> > > > >=20
> > > > [...]
> > > > > >>=20
> > > > > >> Why not have a new flag for bpf_redirect that transparently st=
ores all
> > > > > >> available metadata? If you care only about the redirect -> skb=
 case.
> > > > > >> Might give us more wiggle room in the future to make it work w=
ith
> > > > > >> traits.
> > > > > >
> > > > > > Also q from my side: If I understand the proposal correctly, in=
 order to fully
> > > > > > populate an skb at some point, you have to call all the bpf_xdp=
_metadata_* kfuncs
> > > > > > to collect the data from the driver descriptors (indirect call)=
, and then yet
> > > > > > again all equivalent bpf_xdp_store_rx_* kfuncs to re-store the =
data in struct
> > > > > > xdp_rx_meta again. This seems rather costly and once you add mo=
re kfuncs with
> > > > > > meta data aren't you better off switching to tc(x) directly so =
the driver can
> > > > > > do all this natively? :/
> > > > >=20
> > > > > I agree that the "one kfunc per metadata item" scales poorly. IIR=
C, the
> > > > > hope was (back when we added the initial HW metadata support) tha=
t we
> > > > > would be able to inline them to avoid the function call overhead.
> > > > >=20
> > > > > That being said, even with half a dozen function calls, that's st=
ill a
> > > > > lot less overhead from going all the way to TC(x). The goal of th=
e use
> > > > > case here is to do as little work as possible on the CPU that ini=
tially
> > > > > receives the packet, instead moving the network stack processing =
(and
> > > > > skb allocation) to a different CPU with cpumap.
> > > > >=20
> > > > > So even if the *total* amount of work being done is a bit higher =
because
> > > > > of the kfunc overhead, that can still be beneficial because it's =
split
> > > > > between two (or more) CPUs.
> > > > >=20
> > > > > I'm sure Jesper has some concrete benchmarks for this lying around
> > > > > somewhere, hopefully he can share those :)
> > > >=20
> > > > Another possible approach would be to have some utility functions (=
not kfuncs)
> > > > used to 'store' the hw metadata in the xdp_frame that are executed =
in each
> > > > driver codebase before performing XDP_REDIRECT. The downside of thi=
s approach
> > > > is we need to parse the hw metadata twice if the eBPF program that =
is bounded
> > > > to the NIC is consuming these info. What do you think?
> > >=20
> > > That's the option I was asking about. I'm assuming we should be able
> > > to reuse existing xmo metadata callbacks for this. We should be able
> > > to hide it from the drivers also hopefully.
> >=20
> > If we move the hw metadata 'store' operations to the driver codebase (r=
unning
> > xmo metadata callbacks before performing XDP_REDIRECT), we will parse t=
he hw
> > metadata twice if we attach to the NIC an AF_XDP program consuming the =
hw
> > metadata, right? One parsing is done by the AF_XDP hw metadata kfunc, a=
nd the
> > second one would be performed by the native driver codebase.
>=20
> The native driver codebase will parse the hw metadata only if the
> bpf_redirect set some flag, so unless I'm missing something, there
> should not be double parsing. (but it's all user controlled, so doesn't
> sound like a problem?)

I do not have a strong opinion about it, I guess it is fine, but I am not
100% sure if it fits in Jesper's use case.
@Jesper: any input on it?

Regards,
Lorenzo

>=20
> > Moreover, this approach seems less flexible. What do you think?
>=20
> Agreed on the flexibility. Just trying to understand whether we really
> need that flexibility. My worry is that we might expose too much of
> the stack's internals with this and introduce some unexpected
> dependencies. The things like Jesper mentioned in another thread:
> set skb->hash before redirect to make GRO go fast... We either have
> to make the stack more robust (my preference), or document these
> cases clearly and have test coverage to avoid breakage in the future.

--sDj39uYRsqJWsHZB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaFBI6gAKCRA6cBh0uS2t
rDluAQDGPIrrlw65wQryPK9+Hj0hrdco/9ylRkdk0KC8Velo3AD/cttF4uhvrYLW
YgYu1SWEYU0DYj7cb3qp5hK26dk6qwI=
=QBjQ
-----END PGP SIGNATURE-----

--sDj39uYRsqJWsHZB--

