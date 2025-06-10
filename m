Return-Path: <bpf+bounces-60246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA9AAD45F3
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 00:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22DF189CAB2
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 22:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA45528BAA8;
	Tue, 10 Jun 2025 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjp088z+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3782B27FD73;
	Tue, 10 Jun 2025 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749594390; cv=none; b=g0CYj6KoYZMUzmDcJyHHGAbHYNtA8Z+fSCxhx7jnNWYhOdSF6+VnPxkzaO2aOfVHMu8AmiRZyxAcHbOKymF9Vd1C3MQ1CO08GpJOa1ysdUdhv0IZsxdX1CwY7q74Q6ptsyR/cTBiIkCKbf2hczGnNuv5gg55c57L42ZtjMk3dT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749594390; c=relaxed/simple;
	bh=6wPcP7bMx/JJAoXO55SI+6bSUFw7itbX7Ix25yYf7i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFuy29w57T0D9wKqdSJMwdlhP1Y5MxmS7Whxx0bO3FVTZcVqTcDjOG2JnSgsWEfrjcqTQPf3sGhMa8e6JlH/4eDGrWtCu26afP4NcXBDCi6uD09CDFoMkX6Y+E74oHzy9E/aw6kybv/ARCbaLIZUP22xRhPyvTXi+qO2SvgwQ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjp088z+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D10FC4CEED;
	Tue, 10 Jun 2025 22:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749594389;
	bh=6wPcP7bMx/JJAoXO55SI+6bSUFw7itbX7Ix25yYf7i8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pjp088z+6v3jKwmVkIVs16nHmHSXtUL7cmDG+iCRKMiOwlOBuLlElc2Y5AuQycJs6
	 KmQUCdg5oQ1xnpCIyAG5WCgxbfJ6xvcUPzaAy8ftKsVd0Myu6OoU//9UJ6u9wmWS6t
	 e8SqjcIHTLTPiHW6ZSJAh+7mrx1fll75HFz8/W7E0hnRu35Ug9Pho5FH6ZoZT1iRjX
	 J2QYJXek3EQjoUO0yHHZLPjYGC9UGBCiQMbdPXwHzxBJUWtuXXtYm6Z8SmT7MQaKRP
	 8Vrs/Yt7un7OrvOXw5SUfLE3eS7jDhPso4Zv2k5IBl+NSMczJxWqo1qqlx/slPwb1L
	 u/JKZmmzOikwA==
Date: Wed, 11 Jun 2025 00:26:25 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Stanislav Fomichev <stfomichev@gmail.com>,
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
Message-ID: <aEixEV-nZxb1yjyk@lore-rh-laptop>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
 <174897279518.1677018.5982630277641723936.stgit@firesoul>
 <aEJWTPdaVmlIYyKC@mini-arch>
 <bf7209aa-8775-448d-a12e-3a30451dad22@iogearbox.net>
 <87plfbcq4m.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rQvr/Q3jiYP0UDkh"
Content-Disposition: inline
In-Reply-To: <87plfbcq4m.fsf@toke.dk>


--rQvr/Q3jiYP0UDkh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Daniel Borkmann <daniel@iogearbox.net> writes:
>=20
[...]
> >>=20
> >> Why not have a new flag for bpf_redirect that transparently stores all
> >> available metadata? If you care only about the redirect -> skb case.
> >> Might give us more wiggle room in the future to make it work with
> >> traits.
> >
> > Also q from my side: If I understand the proposal correctly, in order t=
o fully
> > populate an skb at some point, you have to call all the bpf_xdp_metadat=
a_* kfuncs
> > to collect the data from the driver descriptors (indirect call), and th=
en yet
> > again all equivalent bpf_xdp_store_rx_* kfuncs to re-store the data in =
struct
> > xdp_rx_meta again. This seems rather costly and once you add more kfunc=
s with
> > meta data aren't you better off switching to tc(x) directly so the driv=
er can
> > do all this natively? :/
>=20
> I agree that the "one kfunc per metadata item" scales poorly. IIRC, the
> hope was (back when we added the initial HW metadata support) that we
> would be able to inline them to avoid the function call overhead.
>=20
> That being said, even with half a dozen function calls, that's still a
> lot less overhead from going all the way to TC(x). The goal of the use
> case here is to do as little work as possible on the CPU that initially
> receives the packet, instead moving the network stack processing (and
> skb allocation) to a different CPU with cpumap.
>=20
> So even if the *total* amount of work being done is a bit higher because
> of the kfunc overhead, that can still be beneficial because it's split
> between two (or more) CPUs.
>=20
> I'm sure Jesper has some concrete benchmarks for this lying around
> somewhere, hopefully he can share those :)

Another possible approach would be to have some utility functions (not kfun=
cs)
used to 'store' the hw metadata in the xdp_frame that are executed in each
driver codebase before performing XDP_REDIRECT. The downside of this approa=
ch
is we need to parse the hw metadata twice if the eBPF program that is bound=
ed
to the NIC is consuming these info. What do you think?

Regards,
Lorenzo

>=20
> > Also, have you thought about taking the opportunity to generalize the e=
xisting
> > struct xsk_tx_metadata? It would be nice to actually use the same/simil=
ar struct
> > for RX and TX, similarly as done in struct virtio_net_hdr. Such that we=
 have
> > XDP_{RX,TX}_METADATA and XDP_{RX,TX}MD_FLAGS_* to describe what meta da=
ta we
> > have and from a developer PoV this will be a nicely consistent API in X=
DP. Then
> > you could store at the right location in the meta data region just with
> > bpf_xdp_metadata_* kfuncs (and/or plain BPF code) and finally set XDP_R=
X_METADATA
> > indicator bit.
>=20
> Wouldn't this make the whole thing (effectively) UAPI?
>=20
> -Toke
>=20

--rQvr/Q3jiYP0UDkh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaEixDwAKCRA6cBh0uS2t
rJ/+AQCU4KqKc4HlNK1xWh72nioKOj93PVApUchVG/suCzEVQAEA2dXHsUhz6N80
EQaT0viqZObt97Zje4q4B/J4MdOmlA0=
=/t4b
-----END PGP SIGNATURE-----

--rQvr/Q3jiYP0UDkh--

