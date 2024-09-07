Return-Path: <bpf+bounces-39192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEA8970260
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 15:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1747DB22637
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 13:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5C015C151;
	Sat,  7 Sep 2024 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V07Huikd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154D915ADA7;
	Sat,  7 Sep 2024 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725715372; cv=none; b=M4jm1WG0FLEjAz+6WYiWTjME7HhMaR828gblmP2T8wkh8rainNSVvmrJvjE5hxAoCR3rck+ZyGNTCQxVzkuvSFypPrAOKWqdOtCHbJB1yCMTltCMOQIhbYfrg1rGi4BIi29WVLdbSGD69tUndy1W3LQCvRajMHG89lrL/Ci6mXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725715372; c=relaxed/simple;
	bh=y6YKFlhPCQu78jAO0iC8jYVC1hWLcBjxxOdZP1rzmYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qi5oiPL34saFwaKRZ3GO6PVyyjne/lv5tcwidtqEo4ffafdGU50Ar7V417GCS/PgadoX8+Po6l8vXDtBjYfTYVTTAOv34YLNSp2m3vGqCMc1Pvre1yNgxETk28jfimSw1PJ43VIMqopw54SX8/avoW13hZrcZFtMq9MQoXlYMek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V07Huikd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B322C4CEC2;
	Sat,  7 Sep 2024 13:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725715371;
	bh=y6YKFlhPCQu78jAO0iC8jYVC1hWLcBjxxOdZP1rzmYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V07HuikdAcbrcGIzsucwlYA/+RGJuhvOlJngLr590qYs+K7Od4QTJSbzdbmFqaZ1u
	 Hbu/Z0iFXjvhAa7suS3a6bXuUtI1RDpRHhVbaNXEgbD0rNbWoapbLHq6DwATbUbqkQ
	 r4Sf4oz8uY8IuIlODGcRH0Qxqk9UFOBG+8oxdA5BIPM8D6+et/ojkXw9FVZJY633GY
	 M7pOtT+qYVpibMb1d748GmL6WEs8THD8tc8wdHHZRsbQjVu8hHBlrszHSqCa6BkjgC
	 +AkIEk/z39+7qjTmWdVkTt8bqZAQaIDb46qoaL3d0xO34fIrtDPhk6j1/bIwN46hSr
	 nX/pUqZO9+r1A==
Date: Sat, 7 Sep 2024 15:22:48 +0200
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
Message-ID: <ZtxTqNLZ2kbb-esH@lore-desk>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
 <20240903135158.7031a3ab@kernel.org>
 <ZteAuB-QjYU6PIf7@lore-desk>
 <Ztnj9ujDg4NLZFDm@lore-desk>
 <20240905172029.5e9ca520@kernel.org>
 <Ztq6KAWXwjBcGci0@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z8728SGFsNxd48Un"
Content-Disposition: inline
In-Reply-To: <Ztq6KAWXwjBcGci0@lore-desk>


--z8728SGFsNxd48Un
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > On Thu, 5 Sep 2024 19:01:42 +0200 Lorenzo Bianconi wrote:
> > > In particular, the cpumap kthread pinned on cpu 'n' can schedule the
> > > backlog NAPI associated to cpu 'n'. However according to my understan=
ding
> > > it seems the backlog NAPI APIs (in process_backlog()) do not support =
GRO,
> > > right? Am I missing something?
> >=20
> > I meant to use the struct directly, not to schedule it. All you need
> > is GRO - feed it packets, flush it.=20
>=20
> ack, thx for pointing this out.
>=20
> > But maybe you can avoid the netdev allocation and patch 3 in other ways.
> > Using backlog NAPI was just the first thing that came to mind.
>=20
> ack, I will look into it.
>=20
> Regards,
> Lorenzo

Hi all,

I reworked my previous implementation to add GRO support to cpumap codebase=
, removing
the dummy netdev dependency and keeping most of the other logic. You can fi=
nd
the codebase here:
- https://github.com/LorenzoBianconi/bpf-next/commit/e152cf8c212196fccece0b=
516190827430c0f5f8
I added to the two patches below in order to reuse some NAPI generic code:
- https://github.com/LorenzoBianconi/bpf-next/commit/3c73e9c2f07486590749e9=
b3bfb8a4b3df4cb5e0
- https://github.com/LorenzoBianconi/bpf-next/commit/d435ce2e1b6a991a6264a5=
aad4a0374a3ca86a51
I have not run any performance test yet, just functional one.

Regards,
Lorenzo

--z8728SGFsNxd48Un
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZtxTqAAKCRA6cBh0uS2t
rA1HAQDexOv6I+cjqBzVYgUS+y0Xn1LJ6hmUxSvpTHYqX2R+DQD/R9oiZLSX4JOy
XFYnQsY4J2O8rgDbMEquWg0l1Uq3qQ8=
=poHJ
-----END PGP SIGNATURE-----

--z8728SGFsNxd48Un--

