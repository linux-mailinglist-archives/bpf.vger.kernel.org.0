Return-Path: <bpf+bounces-33436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 656D591CEFC
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 22:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3BC1C20BDA
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 20:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C5D13F439;
	Sat, 29 Jun 2024 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZ890xYj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF21B13D89D;
	Sat, 29 Jun 2024 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719691918; cv=none; b=f4/92C19VH7ys+BLyYPqYaqUhuTZ74hac8AZLrcXD47Kyx3JtX+UzgXono0f0LoF+jTo+NS/Jk9g/9RGfsv5gTheD180PV2EXddftv/KNxhmzxOoml1LS5qrynskZsExbvekd9BUYHgQ7sR+aJ+WVWIsMaD0IK6OI3QOgQFNlu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719691918; c=relaxed/simple;
	bh=lwGZaQ8Oru/JaRSS4R1MNCRV5vs8V7Cd+olRnxdeCfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDfvDXT71F65ELzO+4M+rGLMD7TYhZDCDlt5P5KpEu89dhckGxaHlk43Wn0vuX+zbJ/mPWYopnUs6hkqOs04cEH7l3zxirQqNrGJqdnUlrKRVPi4HBrwcShnBv0se0+ROqFKi6hBIp34CKB1em4Z+4urDRB/Cj0yrXa3OJMfWOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZ890xYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6AB0C32789;
	Sat, 29 Jun 2024 20:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719691918;
	bh=lwGZaQ8Oru/JaRSS4R1MNCRV5vs8V7Cd+olRnxdeCfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KZ890xYj58rJz5FhwYR1LihK/YaUNIgfSAN3JeOHlRbCVR9OZAZKkq5UKX5Apnuob
	 aLcYy+e78hcTk7gSZuSVuulifQ4QCKy/FJ+vZ1QgE1d/SdfyiUQhfTlLw0p3M87g6D
	 6wWEMiT/TrWfiK/QsF4n7tI9qLqjwDxkFF+bWbSzu6QCXyGoYZU9cGNKQn7LExAUMI
	 PyehRW4kMSx98vmcoIf4cIlu+u32POaxloub7RGs3jz7GKGmOyX6EMvqGPUjjA7XFE
	 fxG4aB56O/TVbptkI3o8NwFEERzglTfbs7ZMQKyX8CbQCCoNBMxHTA0ZhgMlTEhNJ5
	 6qvKrB3g4ROkw==
Date: Sat, 29 Jun 2024 22:11:54 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com,
	lorenzo.bianconi@redhat.com, toke@redhat.com, fw@strlen.de,
	hawk@kernel.org, horms@kernel.org, donhunte@redhat.com,
	memxor@gmail.com
Subject: Re: [PATCH v5 bpf-next 3/3] selftests/bpf: Add selftest for
 bpf_xdp_flow_lookup kfunc
Message-ID: <ZoBqijOJi2JVcHDB@lore-desk>
References: <cover.1718379122.git.lorenzo@kernel.org>
 <6472c7a775f6a329d16352092071fda8676c2809.1718379122.git.lorenzo@kernel.org>
 <89bd0cd7-ed01-a343-d873-dc0c6d2810f2@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q4oRn06QvfzdRUrS"
Content-Disposition: inline
In-Reply-To: <89bd0cd7-ed01-a343-d873-dc0c6d2810f2@iogearbox.net>


--Q4oRn06QvfzdRUrS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 6/14/24 5:40 PM, Lorenzo Bianconi wrote:
> [...]
> > +void test_xdp_flowtable(void)
> > +{
> > +	struct xdp_flowtable *skel =3D NULL;
> > +	struct nstoken *tok =3D NULL;
> > +	int iifindex, stats_fd;
> > +	__u32 value, key =3D 0;
> > +	struct bpf_link *link;
> > +
> > +	if (SYS_NOFAIL("nft -v")) {
> > +		fprintf(stdout, "Missing required nft tool\n");
> > +		test__skip();
> > +		return;
>=20
> Bit unfortunate that upstream CI skips the test case at the moment:

yep, we are missing nft utility there.

>=20
>   #542/2   xdp_devmap_attach/DEVMAP with frags programs in entries:OK
>   #542/3   xdp_devmap_attach/Verifier check of DEVMAP programs:OK
>   #542     xdp_devmap_attach:OK
>   #543     xdp_do_redirect:OK
>   #544     xdp_flowtable:SKIP
> [...]
>=20
> > +out:
> > +	xdp_flowtable__destroy(skel);
> > +	if (tok)
> > +		close_netns(tok);
> > +	SYS_NOFAIL("ip netns del " TX_NETNS_NAME);
> > +	SYS_NOFAIL("ip netns del " RX_NETNS_NAME);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/xdp_flowtable.c b/tools/=
testing/selftests/bpf/progs/xdp_flowtable.c
> > new file mode 100644
> > index 0000000000000..8297b30b0764b
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/xdp_flowtable.c
> > @@ -0,0 +1,146 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#define BPF_NO_KFUNC_PROTOTYPES
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_endian.h>
> > +
> > +#define MAX_ERRNO	4095
>=20
> nit: unused?

ack, I will remove it in v6.

Regards,
Lorenzo

>=20
> > +#define ETH_P_IP	0x0800
> > +#define ETH_P_IPV6	0x86dd
> > +#define IP_MF		0x2000	/* "More Fragments" */
> > +#define IP_OFFSET	0x1fff	/* "Fragment Offset" */
> > +#define AF_INET		2
> > +#define AF_INET6	10
> > +
> > +struct bpf_flowtable_opts___local {
> > +	s32 error;
> > +};
> > +
> > +struct flow_offload_tuple_rhash *
> > +bpf_xdp_flow_lookup(struct xdp_md *, struct bpf_fib_lookup *,
> > +		    struct bpf_flowtable_opts___local *, u32) __ksym;
> > +
> > +struct {
> > +	__uint(type, BPF_MAP_TYPE_ARRAY);
> > +	__type(key, __u32);
> > +	__type(value, __u32);
> > +	__uint(max_entries, 1);
> > +} stats SEC(".maps");
> > +
> [...]

--Q4oRn06QvfzdRUrS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZoBqigAKCRA6cBh0uS2t
rNX9AP9qv4mvD/pZtgSxXlDRH1GkN00+nRFb/tNHYyaWOsrSYgD/d+m3IrocXYZo
hhPe0jQUqdcLdDVYjHTZ1z35eERUhQc=
=NeGB
-----END PGP SIGNATURE-----

--Q4oRn06QvfzdRUrS--

