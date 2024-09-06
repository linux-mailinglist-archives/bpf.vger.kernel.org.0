Return-Path: <bpf+bounces-39105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0375D96ED78
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 10:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A02284390
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 08:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0201D156967;
	Fri,  6 Sep 2024 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ht/xQM+g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708C064A;
	Fri,  6 Sep 2024 08:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610539; cv=none; b=dYCDeWF+ebN37t1Pd0KYITv5DEGHxMy4xOjsKFuydigPBbYMjNDT2vgQ6GDgroZ3hhUAaQvauMxZgINJVymmTyfGlijV6UaUhJU9rhohxO0goBRIHU5VVycUqM4XS7Ft6XnL/SsuRERT2XdnvH+s1LOthPsteHgsX152sbdRKA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610539; c=relaxed/simple;
	bh=hsfrynjom+Fv8VFuD0jI6kvDRfTbVwwA1gLQLzU7XmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0DyqJ7EdBKXNc817htUxfLTERdELUjhwrAEAulbIPskOuZHKn5Kbra+xr2fb+34ak4LzvHqFlmQxbaGAblJS/iuqX1GP31cDh3YGpu7fLAE+bNeIV/A6950FeYcrJRe3Y8ebTTY4kM4e0S7ED/AZ05cZiKno5/1U/RyDSJ5PHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ht/xQM+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA493C4CEC4;
	Fri,  6 Sep 2024 08:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725610539;
	bh=hsfrynjom+Fv8VFuD0jI6kvDRfTbVwwA1gLQLzU7XmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ht/xQM+gp1Vx5NBd+naDBytKOzOanV/UfsbSh5tcc5M5Pvuagb6BRT28sL6I/wa/g
	 f/rEKu/BvG5qC9oUpUZz6+XBqF8e21fl6XfSkoOWsSMHvZ/z4yr+Qj03mGBpddfGxl
	 DIieFDrAQ7ngh8NMprWywNyJvg6YgEqiJkLxaUPs9k23mYPWNc3CeXQfaIolldX842
	 5hEGERMvCLlxguoEmGyzikwrl7YNStvtFscBUh8cUlrDNM/UdUEDPilGkra5uoaAPR
	 lhr23bg1vv5g3NXqYdsM2vMb/mkHB6e+yPJHiJfi/OHrBLzJwQ2basZgSOfaCNGGEy
	 3oswuFOW7u4dA==
Date: Fri, 6 Sep 2024 10:15:36 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/9] bpf: cpumap: enable GRO for XDP_PASS frames
Message-ID: <Ztq6KAWXwjBcGci0@lore-desk>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
 <20240903135158.7031a3ab@kernel.org>
 <ZteAuB-QjYU6PIf7@lore-desk>
 <Ztnj9ujDg4NLZFDm@lore-desk>
 <20240905172029.5e9ca520@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MhfVJSi/k6SMcMcE"
Content-Disposition: inline
In-Reply-To: <20240905172029.5e9ca520@kernel.org>


--MhfVJSi/k6SMcMcE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 5 Sep 2024 19:01:42 +0200 Lorenzo Bianconi wrote:
> > In particular, the cpumap kthread pinned on cpu 'n' can schedule the
> > backlog NAPI associated to cpu 'n'. However according to my understandi=
ng
> > it seems the backlog NAPI APIs (in process_backlog()) do not support GR=
O,
> > right? Am I missing something?
>=20
> I meant to use the struct directly, not to schedule it. All you need
> is GRO - feed it packets, flush it.=20

ack, thx for pointing this out.

> But maybe you can avoid the netdev allocation and patch 3 in other ways.
> Using backlog NAPI was just the first thing that came to mind.

ack, I will look into it.

Regards,
Lorenzo

--MhfVJSi/k6SMcMcE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZtq6KAAKCRA6cBh0uS2t
rGXUAP99N9lhIKXp5CPoswzyPZl0OlpKDJfm3TJ37lm/iT8nCAD+N5Ia91Ebwwxb
SVQKLVHUOm9xHlCsdll3d0URcGa5zAo=
=S+I7
-----END PGP SIGNATURE-----

--MhfVJSi/k6SMcMcE--

