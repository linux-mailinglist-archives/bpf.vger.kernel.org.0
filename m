Return-Path: <bpf+bounces-54295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D2DA67226
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 12:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9FCB3B022C
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 11:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF06208978;
	Tue, 18 Mar 2025 11:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZYeGP3C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AEE20967A;
	Tue, 18 Mar 2025 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295965; cv=none; b=jgUYEmmapO+MiJmVXiC1GuCL1jhCgidIKaA2aEPq69jfBRhlniBa3R+BUpR8hYLxbJEE5bsETKDaAJmmGvkV+6o4zWtZgtH70dASh8jkg6LpiahWvUBV+KK+lSSEY0Lrzzwz1TpNDhzHInTMbPf9HZ83ZKYEGQHAIYmG3sTwZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295965; c=relaxed/simple;
	bh=+6eRMsycQCwnvUIb7YBuRBaRFSAMCS6WfElJU0fnob0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CB87L5QwBXwc8MwdcalIaFr3wE9Hg0Xd7qiIxLtT1pLh8Gc3JsTTnWx5jSlM2V/XPLzXmuqELb3DVq151pUqpyN/nVq+4tOXLAiaj0S0f/eLcR+kJMFPFGg9RxhT4kfXiRHCrTFccVvnt3kaXxueYtYtF3C5PmcJY8Nl60X51ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZYeGP3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9C8C4CEDD;
	Tue, 18 Mar 2025 11:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742295964;
	bh=+6eRMsycQCwnvUIb7YBuRBaRFSAMCS6WfElJU0fnob0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZYeGP3ChLjFgxxPhXwyrzj+8hdudeUK9TYlMtJjGSLAVE9l7b23fy6AlOGY3cXco
	 JxmfMzVCnaC8910yJDVJNyWc9cVokzjiSUhLJ9Nwbn3O0bxJNoUovv6P8rxYZkGqUW
	 8vxI26ywb35jSaW/zqOold5OFSPC3VgWsJPF46QKs3hueJrNGXj/MHgxylHyWs/90j
	 gcF0O9bB1CgoEohptMg4SEViZ5T3Sa50+WsOO+APy9ZU2ApxdGL0RC3xjifQ7u/F5s
	 60UVEROqpuCVkYO1fQXx5oetwtG8O03iJJf3018VZ4xMcN/cI+pX2Ms/28vDZz3R1V
	 2DKF4AiY4dA2A==
Date: Tue, 18 Mar 2025 12:06:01 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-hyperv@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] net: xdp: Add missing metadata support for
 some xdp drvs
Message-ID: <Z9lTmfyUsY3lqr1m@lore-desk>
References: <20250311-mvneta-xdp-meta-v1-0-36cf1c99790e@kernel.org>
 <6259af5f-f518-4f88-ada9-31c3425ce6ed@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7FKbPnYNhz7Z7bep"
Content-Disposition: inline
In-Reply-To: <6259af5f-f518-4f88-ada9-31c3425ce6ed@redhat.com>


--7FKbPnYNhz7Z7bep
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 3/11/25 1:18 PM, Lorenzo Bianconi wrote:
> > Introduce missing metadata support for some xdp drivers setting metadata
> > size building the skb from xdp_buff.
> > Please note most of the drivers are just compile tested.
>=20
> I'm sorry, but you should at very least report explicitly on per patch
> basis which ones have been compile tested.
>=20
> Even better, please additionally document in each patch why/how the
> current headroom is large enough.

ack, I will do in v2.

Regards,
Lorenzo

>=20
> Thanks,
>=20
> Paolo
>=20

--7FKbPnYNhz7Z7bep
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ9lTmQAKCRA6cBh0uS2t
rDqfAQDOJNpxheA0LSnvOCTN+kPvwHBu5AGV2ArPeTAp70kJ3QD/apFRSAbfIcY1
1f9jJDVDMRYLq6bmd+WcgF6DA0c7JwE=
=n3M4
-----END PGP SIGNATURE-----

--7FKbPnYNhz7Z7bep--

