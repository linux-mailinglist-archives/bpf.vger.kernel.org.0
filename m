Return-Path: <bpf+bounces-30114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E277B8CAF4A
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 15:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45051C21548
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7A2770F7;
	Tue, 21 May 2024 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ow23eEFc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDE74F8A1;
	Tue, 21 May 2024 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716297592; cv=none; b=Z/SMsL7LMYmYw46ivGHzC9AXIshFXWd1NAx2WH9N0o8kmeKD09bIS/Zp+IehIL/FJ+H3ifq+LWnNApfSxXcIjC0EtR2YQ7OLzSdl6rRkNSgpDuyD9LhbwKHOAj2s7RGkQFLuRZVpcgvt87rGqedu96mtikTY112+n8Xej1gQIkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716297592; c=relaxed/simple;
	bh=Fw44D5ZDxbrWGw8WLCi/dURG/HilOXbuM/gWbouzp2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXB1fW3dwYUnMB5TtDOPRB/pKNo6KPCcX5BuuwLYkqVvBrCOF2bcnbCKbf9Xnq8q9HBEuZ3FZ4qMlxKLWMXn1UHCE/9XySeTu2MDCappFAtd0q5d5g7Gn8wdqCahMwMH/vVnmeWYMUyDz07Kb5OPRb/Dwe4nYkCJEvHLN5D+JrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ow23eEFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B76C32786;
	Tue, 21 May 2024 13:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716297591;
	bh=Fw44D5ZDxbrWGw8WLCi/dURG/HilOXbuM/gWbouzp2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ow23eEFcZk9QNj4O05Dr2gPM8iLaS5yK4X4T+PnwkTjCgyMYdVk4JAFAGOPEcRsCs
	 8jvavdtxmQDr/y8QgEsaz+78m5WCNEniYxkznqN9ApNHUD90j0CV7y6F+ERb7gksE6
	 0MFTxZYCmW3T2M1okaMZkbsq8ejJXFYhGJ62ZL/XdRP+v0UMXv+6G5tdxa4BvcyZ9h
	 QStBVqOoOxdYQs1mso8ZBieR1Eni+fazIZNrv/YgWvRvoWwbmsEaVATX4TfSVzi2xx
	 Y7VkiVCtkWU2KvyRe1k3AxCLSpIcPki4nf4Iqu8SXkn6A0ktcziz1Z/JOD3VDvvJU7
	 Ss/LE1UFF9bUA==
Date: Tue, 21 May 2024 15:19:48 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netfilter-devel <netfilter-devel@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Simon Horman <horms@kernel.org>, donhunte@redhat.com,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] samples/bpf: Add bpf sample to offload
 flowtable traffic to xdp
Message-ID: <ZkyfdIDbElsaILT1@lore-rh-laptop>
References: <cover.1716026761.git.lorenzo@kernel.org>
 <8b9e194a4cb04af838035183694c85242f78e626.1716026761.git.lorenzo@kernel.org>
 <CAADnVQLV4=mQ3+2baLhfJi_m6A72khNxUhcgPuv+sdQqE7skgA@mail.gmail.com>
 <87ttira2na.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LOi/9RCDxpjG24/l"
Content-Disposition: inline
In-Reply-To: <87ttira2na.fsf@toke.dk>


--LOi/9RCDxpjG24/l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>=20
> > On Sat, May 18, 2024 at 3:13=E2=80=AFAM Lorenzo Bianconi <lorenzo@kerne=
l.org> wrote:
> >>
> >> Introduce xdp_flowtable_offload bpf sample to offload sw flowtable log=
ic
> >> in xdp layer if hw flowtable is not available or does not support a
> >> specific kind of traffic.
> >>
> >> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >> ---
> >>  samples/bpf/Makefile                     |   7 +-
> >>  samples/bpf/xdp_flowtable_offload.bpf.c  | 591 +++++++++++++++++++++++
> >>  samples/bpf/xdp_flowtable_offload_user.c | 128 +++++
> >>  3 files changed, 725 insertions(+), 1 deletion(-)
> >>  create mode 100644 samples/bpf/xdp_flowtable_offload.bpf.c
> >>  create mode 100644 samples/bpf/xdp_flowtable_offload_user.c
> >
> > I feel this sample code is dead on arrival.
> > Make selftest more real if you want people to use it as an example,
> > but samples dir is just a dumping ground.
> > We shouldn't be adding anything to it.
>=20
> Agreed. We can integrate a working sample into xdp-tools instead :)

ack fine, I can post a patch for xdp-tools.

Regards,
Lorenzo

>=20
> -Toke
>=20

--LOi/9RCDxpjG24/l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZkyfcAAKCRA6cBh0uS2t
rC2hAP90R0KOfB8EylHLyXDT6ua6eqWWhhV4ItjgF1Ld0VxMywEA8tG2Q5GhCWxx
kyeU0WT+V3+GYLts7EzNSBW+ZUIvwww=
=hWW1
-----END PGP SIGNATURE-----

--LOi/9RCDxpjG24/l--

