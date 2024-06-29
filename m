Return-Path: <bpf+bounces-33435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFB591CEEB
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 21:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B24B28268E
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 19:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B8413C3F2;
	Sat, 29 Jun 2024 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYoekVsf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554EE80046;
	Sat, 29 Jun 2024 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719691077; cv=none; b=fE1WoRhLfkBewxZ2V7z8yjTtchpDFjr0CkaseGd6XrgOJTgljYLIGQ4s6GIyi10/3wCwqonGyztWqeLK6ychtcA/JR8oqSIyfhTgYs3Fy+TNYVxniGpgyNv+xHtmFwE3kNTB/xvpGFxU7BHPTFBeEWjknNgfby6G79JTbWbPdLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719691077; c=relaxed/simple;
	bh=tk6AQGUGO2A5I3v/1p0THsa0yZeeDkzV2SH2rgDD4nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qE7h7b/cC5n9g3xj2DpKznxMmbX6mQqkc1XVWqUeUdNww0plIxnszBkLJrKwrIltA8sJKMbPCeN38eZCN9dCWY0vILiZfUSEOcWffDigfOYP+nzQmetzOt2D/1EbnEsoMkhUYDbfhRtYV2IwqbsmaFUQoisiA9YEqfeFHlFfL8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYoekVsf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814B4C2BBFC;
	Sat, 29 Jun 2024 19:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719691076;
	bh=tk6AQGUGO2A5I3v/1p0THsa0yZeeDkzV2SH2rgDD4nY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iYoekVsfsZ3S+Rk0Ky3YuMFfW9bB27gHuaTHUzMGkMzthr032H5shRuUrIqNu5kfO
	 trG4NGAZYHNB1v7o4jLNtnY4xSkRiAVO0x+XUkeq/ohNwEAAmie74123z2hvG7+2y+
	 wEl6CDMlnhI2UZATcJNXkZALjoCCcujZ1eE/n45/E4+K4qTY5QHrweumZQn2ePOZ9D
	 3az3hX9U/J6WXy+m70E8eWJhZuYHjYlP4LsbNtb636Msna/YneY692kufKcfET13Yw
	 wvQ30B3bM9CxsZ9w1r0G9BYnPVoRj0GW8yJFOHr/vflCkhFDcub2jcHPm3gR/Uosfu
	 91oS6NALR1yNA==
Date: Sat, 29 Jun 2024 21:57:53 +0200
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
Subject: Re: [PATCH v5 bpf-next 2/3] netfilter: add bpf_xdp_flow_lookup kfunc
Message-ID: <ZoBnQZPfyCuyn1tG@lore-desk>
References: <cover.1718379122.git.lorenzo@kernel.org>
 <101e390e62edf8199db8f7cc4df79817b6741f59.1718379122.git.lorenzo@kernel.org>
 <48b18dc0-19bd-441e-5054-4bd545cd1561@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d8t7omf+zI8JIQ7G"
Content-Disposition: inline
In-Reply-To: <48b18dc0-19bd-441e-5054-4bd545cd1561@iogearbox.net>


--d8t7omf+zI8JIQ7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 6/14/24 5:40 PM, Lorenzo Bianconi wrote:
> [...]
> > +enum {
> > +	NF_BPF_FLOWTABLE_OPTS_SZ =3D 4,
> > +};
> > +
> > +__diag_push();
> > +__diag_ignore_all("-Wmissing-prototypes",
> > +		  "Global functions as their definitions will be in nf_flow_table BT=
F");
>=20
> nit: __bpf_kfunc_start_defs();

ack, I will fix it in v6.

>=20
> > +static struct flow_offload_tuple_rhash *
> > +bpf_xdp_flow_tuple_lookup(struct net_device *dev,
> > +			  struct flow_offload_tuple *tuple, __be16 proto)
> > +{
> > +	struct flow_offload_tuple_rhash *tuplehash;
> > +	struct nf_flowtable *nf_flow_table;
> > +	struct flow_offload *nf_flow;
> > +
> > +	nf_flow_table =3D nf_flowtable_by_dev(dev);
> > +	if (!nf_flow_table)
> > +		return ERR_PTR(-ENOENT);
> > +
> > +	tuplehash =3D flow_offload_lookup(nf_flow_table, tuple);
> > +	if (!tuplehash)
> > +		return ERR_PTR(-ENOENT);
> > +
> > +	nf_flow =3D container_of(tuplehash, struct flow_offload,
> > +			       tuplehash[tuplehash->tuple.dir]);
> > +	flow_offload_refresh(nf_flow_table, nf_flow, false);
> > +
> > +	return tuplehash;
> > +}
> > +
> > +__bpf_kfunc struct flow_offload_tuple_rhash *
> > +bpf_xdp_flow_lookup(struct xdp_md *ctx, struct bpf_fib_lookup *fib_tup=
le,
> > +		    struct bpf_flowtable_opts *opts, u32 opts_len)
> > +{
> > +	struct xdp_buff *xdp =3D (struct xdp_buff *)ctx;
> > +	struct flow_offload_tuple tuple =3D {
> > +		.iifidx =3D fib_tuple->ifindex,
> > +		.l3proto =3D fib_tuple->family,
> > +		.l4proto =3D fib_tuple->l4_protocol,
> > +		.src_port =3D fib_tuple->sport,
> > +		.dst_port =3D fib_tuple->dport,
> > +	};
> > +	struct flow_offload_tuple_rhash *tuplehash;
> > +	__be16 proto;
> > +
> > +	if (opts_len !=3D NF_BPF_FLOWTABLE_OPTS_SZ) {
> > +		opts->error =3D -EINVAL;
> > +		return NULL;
> > +	}
> > +
> > +	switch (fib_tuple->family) {
> > +	case AF_INET:
> > +		tuple.src_v4.s_addr =3D fib_tuple->ipv4_src;
> > +		tuple.dst_v4.s_addr =3D fib_tuple->ipv4_dst;
> > +		proto =3D htons(ETH_P_IP);
> > +		break;
> > +	case AF_INET6:
> > +		tuple.src_v6 =3D *(struct in6_addr *)&fib_tuple->ipv6_src;
> > +		tuple.dst_v6 =3D *(struct in6_addr *)&fib_tuple->ipv6_dst;
> > +		proto =3D htons(ETH_P_IPV6);
> > +		break;
> > +	default:
> > +		opts->error =3D -EAFNOSUPPORT;
> > +		return NULL;
> > +	}
> > +
> > +	tuplehash =3D bpf_xdp_flow_tuple_lookup(xdp->rxq->dev, &tuple, proto);
> > +	if (IS_ERR(tuplehash)) {
> > +		opts->error =3D PTR_ERR(tuplehash);
> > +		return NULL;
> > +	}
> > +
> > +	return tuplehash;
> > +}
> > +
> > +__diag_pop()
>=20
> __bpf_kfunc_end_defs();

ack, I will fix it in v6.

Regards,
Lorenzo

>=20
> Otherwise LGTM!

--d8t7omf+zI8JIQ7G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZoBnQQAKCRA6cBh0uS2t
rA02AQD8HNziBYwq2G8qQrHmhgRF4NAWUrRSQzqdKBYjdMsXHgD/UBDEQacX5kwR
NkPYcgEnZHcZacv0TwROec79cRTXbgU=
=Wn5k
-----END PGP SIGNATURE-----

--d8t7omf+zI8JIQ7G--

