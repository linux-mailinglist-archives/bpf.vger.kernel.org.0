Return-Path: <bpf+bounces-16595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD76C803912
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 16:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C0F1F21122
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219272CCB0;
	Mon,  4 Dec 2023 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLY/ia1B"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5432C18A;
	Mon,  4 Dec 2023 15:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95717C433C8;
	Mon,  4 Dec 2023 15:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701704639;
	bh=+bUZf8rVCfVK5yANslGgpP3eCbI+vGH9xXKiWOnKl/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VLY/ia1BhOvwA775qRJzgSHkGyGQ5pl+nUKZO65EnTg0NUqG8kM8O7PrMYXcOYwTW
	 rB0vs/d41qJRxENy1X/nKYIxQfbHC8k9OeiWpZwoTCeXU79da/Km34Fzox5/iVNED9
	 JW8s9sagr3MvUm/iatPxQrT8gWDp7/8P/JxH2J5k1EJ5ifQLjkoEhuyntMYtEegcaQ
	 30ecLpKL5EPlF5SSCnFb8jjgHaTF0dCqhh5cCZF3NYOaZcGQ7Xk3VEE2hPGK83uEsC
	 Zg7YKPUGJg32QMsk3PaFUXsq6WzGQjj+MZTyw4160amjISuKRlCbzgMo/e/lcyMbca
	 In8dWSd2d2WEg==
Date: Mon, 4 Dec 2023 16:43:56 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: aleksander.lobakin@intel.com, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	lorenzo.bianconi@redhat.com, bpf@vger.kernel.org, hawk@kernel.org,
	toke@redhat.com, willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com, sdf@google.com
Subject: Re: [PATCH v3 net-next 2/2] xdp: add multi-buff support for xdp
 running in generic mode
Message-ID: <ZW3zvEbI6o4ydM_N@lore-desk>
References: <cover.1701437961.git.lorenzo@kernel.org>
 <c9ee1db92c8baa7806f8949186b43ffc13fa01ca.1701437962.git.lorenzo@kernel.org>
 <20231201194829.428a96da@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VLb7/0QUzRFCtFMt"
Content-Disposition: inline
In-Reply-To: <20231201194829.428a96da@kernel.org>


--VLb7/0QUzRFCtFMt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri,  1 Dec 2023 14:48:26 +0100 Lorenzo Bianconi wrote:
> > Similar to native xdp, do not always linearize the skb in
> > netif_receive_generic_xdp routine but create a non-linear xdp_buff to be
> > processed by the eBPF program. This allow to add  multi-buffer support
> > for xdp running in generic mode.
>=20
> Hm. How close is the xdp generic code to veth?

Actually they are quite close, the only difference is the use of page_pool =
vs
page_frag_cache APIs.

> I wonder if it'd make sense to create a page pool instance for each
> core, we could then pass it into a common "reallocate skb into a
> page-pool backed, fragged form" helper. Common between this code
> and veth? Perhaps we could even get rid of the veth page pools
> and use the per cpu pools there?

yes, I was thinking about it actually.
I run some preliminary tests to check if we are introducing any performance
penalties or so.
My setup relies on a couple of veth pairs and an eBPF program to perform
XDP_REDIRECT from one pair to another one. I am running the program in xdp
driver mode (not generic one).

v00 (NS:ns0 - 192.168.0.1/24) <---> (NS:ns1 - 192.168.0.2/24) v01    v10 (N=
S:ns1 - 192.168.1.1/24) <---> (NS:ns2 - 192.168.1.2/24) v11

v00: iperf3 client
v11: iperf3 server

I am run the test with different MTU valeus (1500B, 8KB, 64KB)

net-next veth codebase:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- MTU  1500: iperf3 ~  4.37Gbps
- MTU  8000: iperf3 ~  9.75Gbps
- MTU 64000: iperf3 ~ 11.24Gbps

net-next veth codebase + page_frag_cache instead of page_pool:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- MTU  1500: iperf3 ~  4.99Gbps (+14%)
- MTU  8000: iperf3 ~  8.5Gbps  (-12%)
- MTU 64000: iperf3 ~ 11.9Gbps  ( +6%)

It seems there is no a clear win situation of using page_pool or
page_frag_cache. What do you think?

Regards,
Lorenzo

--VLb7/0QUzRFCtFMt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZW3zvAAKCRA6cBh0uS2t
rFIvAP4nYjCMMqWQC9vkoZnt793M2BuEegfoFpmWmign5osbuQD/dUdaQIVvQ2rA
6E4tQEdNCbSgAmspwK5HjJ5ntH2dcwA=
=eOT0
-----END PGP SIGNATURE-----

--VLb7/0QUzRFCtFMt--

