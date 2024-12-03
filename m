Return-Path: <bpf+bounces-45993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2279E14A9
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 08:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10A1282858
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 07:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DDF1C2327;
	Tue,  3 Dec 2024 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gd4K4NOr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA67C1ABEBD;
	Tue,  3 Dec 2024 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212387; cv=none; b=oDAmEJz+6eWR1Gqfq/MrsvlGAgVXzykofDOgFWx0zfQS5CNzQ0dEjYyHI0wSP9xneZG5C9j8MLrQoSfLefFQAoyQ4mIHj6hgHoa6Hgirj94qj4kWKmUTW4KhB5T7CtopWyPrx8fmWyXTIAm4hkhHKq2+sW7nweu/+o/mW+gzzSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212387; c=relaxed/simple;
	bh=JWCeZQU11ARclESWh5HV81vL80HyomnYeUCw3g6Nxy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Az5jsTIJIW0J/sidRQAeI43FO4PpHPyEMpNc74ZCDS05092U2Lhq5qBRfUIfX1XJofDd+2/MeiFakLciN8a+ihMrh1AmxZvhSPwesJS3GrSLoY4pPaZWODtd9QG47Uzmq2i4QKg1fcc/gUpB94+3WZnko86NpOUhw5ts/KWiTkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gd4K4NOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F717C4CED8;
	Tue,  3 Dec 2024 07:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733212387;
	bh=JWCeZQU11ARclESWh5HV81vL80HyomnYeUCw3g6Nxy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gd4K4NOrhMpZe6ioTYpFYzP84WJ3CoSZL3qsLGX81ti+LFzoFbQfCbmT2sHgC303h
	 FTLQ1fzKZOZdhqGjJxXbgzvKcOMYH7QGI1AFsH9p6dJndsB5yKxN+r+WN6vne2o/5K
	 apYDjKPSg1mcEHXh9SxU24uBt0OtZ3f6qx4MgofOTTnSZgQjgDpvzgRuBGItA8i2IS
	 xSviofclbAGdXREJzkL2PLdFi7PG7XytDd2UKgIBwYLIEFjR3tq7NUL0jVlE5jf/ms
	 ExNvU0HXP1xiHOKp/BeZ9Nf/LbHMFOMRiJnzE2g9WhvkFrevkC8BARDoWArq85UgEH
	 xQq1Rh51berXw==
Date: Tue, 3 Dec 2024 08:53:04 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>, aleksander.lobakin@intel.com,
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/3] bpf: cpumap: Add gro support
Message-ID: <Z0644Mp3YaWIXcU5@lore-desk>
References: <20241130-cpumap-gro-v1-0-c1180b1b5758@kernel.org>
 <20241130-cpumap-gro-v1-3-c1180b1b5758@kernel.org>
 <20241202145854.6677e5fd@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zwkk46gi7lJGwzsb"
Content-Disposition: inline
In-Reply-To: <20241202145854.6677e5fd@kernel.org>


--zwkk46gi7lJGwzsb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, 30 Nov 2024 00:11:00 +0100 Lorenzo Bianconi wrote:
> > -	struct task_struct *kthread;
> > +	struct napi_struct napi;
>=20
> nack.
> Please wait for the discussion to finish before you send next version.

ack, fine. I was thinking we decided for this approach. Let's revaluate Ole=
k's
solution first.

Regards,
Lorenzo

> --=20
> pw-bot: cr

--zwkk46gi7lJGwzsb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ0644AAKCRA6cBh0uS2t
rIhwAQDuYFbocZLN9+kEjN4KnPMPWreDu90E8onhmFwldkxKygEA1dWuIJiG0C8+
V5cP00dYdzmCmILEXoBV8HMs8JPfag0=
=n0IY
-----END PGP SIGNATURE-----

--zwkk46gi7lJGwzsb--

