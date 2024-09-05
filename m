Return-Path: <bpf+bounces-39045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5F596E0B7
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 19:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD88D28948E
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 17:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D0D1A2566;
	Thu,  5 Sep 2024 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6UXDToR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922A4152166;
	Thu,  5 Sep 2024 17:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555705; cv=none; b=dMp7L54uWaXhGmUZQypxeMKsHcnQVhGopiEGHJqQj2GfEdGhz1Ky2EttXiKCCGuFKM71wMieouFz3iIVtHTd7cbov5nzURovf4K3SMmcEphtiH4OvQMSYmXhDzhSDBhOREnj/SXSwDdhA9QMQ35JP7hl8Mf0DbeuOkOWLaMegJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555705; c=relaxed/simple;
	bh=I2aLsGM4UA8tXVU8NUIgkVmGUKqzg6oLq0e+na0fwaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPEXUP8065pSUIp+WDFYwbnwEly9+HeNOh/R4wgOWcJmYSOxusbQK5KVXqrrTHe/YtVeTzytZNOehxiOrfO09igpckR8lL3b4unfChiSAw5nKvj9MKwue+kYC8meLQxocMJfZxa5oKDTVds9xxP8aT8MWHuO5jSZoqQYaypenOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6UXDToR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBEAC4CEC7;
	Thu,  5 Sep 2024 17:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725555705;
	bh=I2aLsGM4UA8tXVU8NUIgkVmGUKqzg6oLq0e+na0fwaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t6UXDToRx19DeweM+gELpbq7G4BaiDgIqaJt+PUVa6pTkQVLBGqGEl1b/5ufsa/Pz
	 WYprHY7gXzGZZcq+24is6naQgZ/kCaAy4A9QCd/ICCJi7LdwRLtZJDeRhtYh0+LNXA
	 6ii6cqywnwvFnNeJFrZ4jI6t/QiTnl8h4PVBQzfcXbpxKJzw8NbBXe5JKtcl1gjEyc
	 wJnG369qQXfIoGUKxdxxFHvevJgNGaQTWOvP6mA68264T8z63mYP72gyG9PUcWpaB1
	 gPsEC3fDnsZxytSBKLiScdpXni/YZ8rvotyZxC84Oy2fdHzqcseF9KqGjz5G0MDAXT
	 MaF7pBkN1PL+g==
Date: Thu, 5 Sep 2024 19:01:42 +0200
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
Message-ID: <Ztnj9ujDg4NLZFDm@lore-desk>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
 <20240903135158.7031a3ab@kernel.org>
 <ZteAuB-QjYU6PIf7@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l9MehyyWogdUZuSk"
Content-Disposition: inline
In-Reply-To: <ZteAuB-QjYU6PIf7@lore-desk>


--l9MehyyWogdUZuSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > On Fri, 30 Aug 2024 18:24:59 +0200 Alexander Lobakin wrote:
> > > * patch 4: switch cpumap from a custom kthread to a CPU-pinned
> > >   threaded NAPI;
> >=20
> > Could you try to use the backlog NAPI? Allocating a fake netdev and
> > using NAPI as a threading abstraction feels like an abuse. Maybe try
> > to factor out the necessary bits? What we want is using the per-cpu=20
> > caches, and feeding GRO. None of the IRQ related NAPI functionality
> > fits in here.
>=20
> I was thinking allocating a fake netdev to use NAPI APIs is quite a common
> approach, but sure, I will looking into it.

=46rom a first glance I think we could use the backlog NAPI APIs here in
order to avoid allocating a dummy netdev. We could implement a similar
approach I used for the cpumap + gro_cell here [0].
In particular, the cpumap kthread pinned on cpu 'n' can schedule the
backlog NAPI associated to cpu 'n'. However according to my understanding
it seems the backlog NAPI APIs (in process_backlog()) do not support GRO,
right? Am I missing something?

Regards,
Lorenzo

[0] https://github.com/LorenzoBianconi/bpf-next/commit/a4b8264d5000ecf016da=
5a2dd9ac302deaf38b3e

>=20
> Regards,
> Lorenzo



--l9MehyyWogdUZuSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZtnj9gAKCRA6cBh0uS2t
rPhvAQCcJlALWoAIGD5Ieeph+OGf2ZgYDMnLIXI9vU3124la1AEAnSfznUtaico9
o6d3QTXyboMYq1+K+m8Y/oCM3w/9OQE=
=SQw9
-----END PGP SIGNATURE-----

--l9MehyyWogdUZuSk--

