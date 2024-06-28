Return-Path: <bpf+bounces-33374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F89691C6FB
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 21:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A791284938
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 19:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123EB77106;
	Fri, 28 Jun 2024 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1QRP4qY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836FB757ED;
	Fri, 28 Jun 2024 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604590; cv=none; b=ouypSpzH/jUax3m/wmk11IsBz4r3P5FKl6PW3xjLvyky8CMt37d6vwT64WTql/Ek0hyDrrXNStRLMPPVVW3Ta8Ci+p5td+H5bBvuCvcfOmc45N+Go3GiSiWc5HvVLqPMCh+Mp57+HGK8L5UMJGAlK3SV5rmytjycSLv7L9AoerI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604590; c=relaxed/simple;
	bh=WNUsqrf9kKLdBDbBg1Et4QrK1ya69jP1HTBag2z+Xpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WA0sUMzcva4Dd2o8gkWnPuCnrQvrLk7nRfqpOTYU7DHSanHwxcMtVzd5zOw+F6E6fuAyVhAPaGO470PRbAU/N9ql2VnpkFkEbzcbGtjfBx9mBfe5Mu8G5GO3aUxrKDiKD63TaovQd7kA0hwrcli2GKepwIq629/Alt4ob32Gw98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1QRP4qY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9BEC116B1;
	Fri, 28 Jun 2024 19:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719604590;
	bh=WNUsqrf9kKLdBDbBg1Et4QrK1ya69jP1HTBag2z+Xpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1QRP4qYd1WbW1tuV0xygCBDeoKHICeiHRCMdM28f1vu8owfw4ukbdo3ouUNhcgm9
	 UEBM2ChkN3tEKn/Mc3AdaLQRmF5HY+4OK1XfCBqk8LelXIOvniF0Vi+abqrGPgDO8S
	 Pj64lWVTJm47/VXfYVZOBSL7avAB49ZGUYh0dtn+nDmJrW3u7v1lZfR+Dy2AgrywJ9
	 A90M+/hEKBFDtDQkGe3e31VqEOWDIJgTEKRa6RfJ+RxXG3eZQUsAV6niPMTRZRvloM
	 6nYTcpgpWbPNbuZXkPAqTwvwcnzo08nsT6C3L8MfFEhkjuv/OpFrmFKsm8NyZ11OiS
	 S2Rx3966PrX+g==
Date: Fri, 28 Jun 2024 21:56:26 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: bpf@vger.kernel.org
Cc: pablo@netfilter.org, kadlec@netfilter.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com,
	lorenzo.bianconi@redhat.com, toke@redhat.com, fw@strlen.de,
	hawk@kernel.org, horms@kernel.org, donhunte@redhat.com,
	memxor@gmail.com
Subject: Re: [PATCH v5 bpf-next 0/3] netfilter: Add the capability to offload
 flowtable in XDP layer
Message-ID: <Zn8VauqdzVbiw8mn@lore-desk>
References: <cover.1718379122.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rhKzGA7qyMpLbX45"
Content-Disposition: inline
In-Reply-To: <cover.1718379122.git.lorenzo@kernel.org>


--rhKzGA7qyMpLbX45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Introduce bpf_xdp_flow_lookup kfunc in order to perform the lookup of
> a given flowtable entry based on the fib tuple of incoming traffic.
> bpf_xdp_flow_lookup can be used as building block to offload in XDP
> the sw flowtable processing when the hw support is not available.
>=20
> This series has been tested running the xdp_flowtable_offload eBPF program
> on an ixgbe 10Gbps NIC (eno2) in order to XDP_REDIRECT the TCP traffic to
> a veth pair (veth0-veth1) based on the content of the nf_flowtable as soon
> as the TCP connection is in the established state:
>=20
> [tcp client] (eno1) =3D=3D LAN =3D=3D (eno2) xdp_flowtable_offload [XDP_R=
EDIRECT] --> veth0 =3D=3D veth1 [tcp server]
>=20
> table inet filter {
> 	flowtable ft {
> 		hook ingress priority filter
> 		devices =3D { eno2, veth0 }
> 	}
> 	chain forward {
> 		type filter hook forward priority filter
> 		meta l4proto { tcp, udp } flow add @ft
> 	}
> }
>=20
> -  sw flowtable [1 TCP stream, T =3D 300s]: ~ 6.2 Gbps
> - xdp flowtable [1 TCP stream, T =3D 300s]: ~ 7.6 Gbps
>=20
> -  sw flowtable [3 TCP stream, T =3D 300s]: ~ 7.7 Gbps
> - xdp flowtable [3 TCP stream, T =3D 300s]: ~ 8.8 Gbps
>=20
> Changes since v4:
> - add missing BPF_NO_KFUNC_PROTOTYPES macro to selftest
> Changes since v3:
> - move flowtable map utilities in nf_flow_table_xdp.c
> Changes since v2:
> - introduce bpf_flowtable_opts struct in bpf_xdp_flow_lookup signature
> - get rid of xdp_flowtable_offload bpf sample
> - get rid of test_xdp_flowtable.sh for selftest and rely on prog_tests in=
stead
> - rename bpf_xdp_flow_offload_lookup in bpf_xdp_flow_lookup
> Changes since v1:
> - return NULL in bpf_xdp_flow_offload_lookup kfunc in case of error
> - take into account kfunc registration possible failures
> Changes since RFC:
> - fix compilation error if BTF is not enabled

Hi all,

Looking at patchwork this series is marked as 'Archived' even if the eBPF b=
its
have been acked by Alexei while netfilter ones have been acked by Pablo.
Am I missing something? Do I need to repost?

Regards,
Lorenzo

>=20
> Akced-by: Pablo Neira Ayuso <pablo@netfilter.org>
>=20
> Florian Westphal (1):
>   netfilter: nf_tables: add flowtable map for xdp offload
>=20
> Lorenzo Bianconi (2):
>   netfilter: add bpf_xdp_flow_lookup kfunc
>   selftests/bpf: Add selftest for bpf_xdp_flow_lookup kfunc
>=20
>  include/net/netfilter/nf_flow_table.h         |  18 ++
>  net/netfilter/Makefile                        |   7 +-
>  net/netfilter/nf_flow_table_bpf.c             | 117 ++++++++++++
>  net/netfilter/nf_flow_table_inet.c            |   2 +-
>  net/netfilter/nf_flow_table_offload.c         |   6 +-
>  net/netfilter/nf_flow_table_xdp.c             | 163 +++++++++++++++++
>  tools/testing/selftests/bpf/config            |  13 ++
>  .../selftests/bpf/prog_tests/xdp_flowtable.c  | 168 ++++++++++++++++++
>  .../selftests/bpf/progs/xdp_flowtable.c       | 146 +++++++++++++++
>  9 files changed, 636 insertions(+), 4 deletions(-)
>  create mode 100644 net/netfilter/nf_flow_table_bpf.c
>  create mode 100644 net/netfilter/nf_flow_table_xdp.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_flowtable.c
>  create mode 100644 tools/testing/selftests/bpf/progs/xdp_flowtable.c
>=20
> --=20
> 2.45.1
>=20

--rhKzGA7qyMpLbX45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZn8VagAKCRA6cBh0uS2t
rKjVAP9T8l8M3R0UyvBSMH+HJsOO9xHw1NoSjC7aVM6BaR2gDQEAyfg4KFUMWnwH
YiM/VNHLGewcnfDIO7SHVodd75CAMg4=
=0igS
-----END PGP SIGNATURE-----

--rhKzGA7qyMpLbX45--

