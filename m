Return-Path: <bpf+bounces-17318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1776780B608
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 20:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32421F211A2
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 19:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25BB1A585;
	Sat,  9 Dec 2023 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSD/2mdz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255DC17752;
	Sat,  9 Dec 2023 19:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31355C433C8;
	Sat,  9 Dec 2023 19:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702149793;
	bh=TzPlrmkILUz/bN6CJlB6+wiIJavVeiqXGYxgCJQNAow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HSD/2mdzX4CzPAseZG5ABZdKyVeOpNkKf6QYOmhfUOMRncML2X+PT0IuDt7fAQX5D
	 PK+DiskA6ZFrHpfXiPts0gpXe2MV4gN8M10KqJ4z8sirLlSJoGkMM+H26lfpZs2C5p
	 xt+3fSzZqYT1xaVXH/TKNGZK7x+DeOtCaxTs8lrObHCW6qwyJJNwQvGS+EgCKlPk83
	 dbyYLijdfNokS8tCL9IGqgNByNMoQz6ozn9a2IIenWJTr1z5O07JrVakPGYe+/qrbr
	 6V/s6m86j8nNcpfb2B56f8C/y+aPhw0g/UazvdtvJ8SNMl+xj2MYYMUEmHBJtZKo5T
	 8QB811M68IPYg==
Date: Sat, 9 Dec 2023 20:23:09 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, aleksander.lobakin@intel.com,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, lorenzo.bianconi@redhat.com, bpf@vger.kernel.org,
	toke@redhat.com, willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com, sdf@google.com
Subject: Re: [PATCH v3 net-next 2/2] xdp: add multi-buff support for xdp
 running in generic mode
Message-ID: <ZXS-naeBjoVrGTY9@lore-desk>
References: <cover.1701437961.git.lorenzo@kernel.org>
 <c9ee1db92c8baa7806f8949186b43ffc13fa01ca.1701437962.git.lorenzo@kernel.org>
 <20231201194829.428a96da@kernel.org>
 <ZW3zvEbI6o4ydM_N@lore-desk>
 <20231204120153.0d51729a@kernel.org>
 <ZW-tX9EAnbw9a2lF@lore-desk>
 <20231205155849.49af176c@kernel.org>
 <4b9804e2-42f0-4aed-b191-2abe24390e37@kernel.org>
 <20231206080333.0aa23754@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t1YGrjY7i9Wn6Bc/"
Content-Disposition: inline
In-Reply-To: <20231206080333.0aa23754@kernel.org>


--t1YGrjY7i9Wn6Bc/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, 6 Dec 2023 13:41:49 +0100 Jesper Dangaard Brouer wrote:
> > BUT then I realized that PP have a weakness, which is the return/free
> > path that need to take a normal spin_lock, as that can be called from
> > any CPU (unlike the RX/alloc case).  Thus, I fear that making multiple
> > devices share a page_pool via softnet_data, increase the chance of lock
> > contention when packets are "freed" returned/recycled.
>=20
> I was thinking we can add a pcpu CPU ID to page pool so that
> napi_pp_put_page() has a chance to realize that its on the "right CPU"
> and feed the cache directly.

Are we going to use these page_pools just for virtual devices (e.g. veth) or
even for hw NICs? If we do not bound the page_pool to a netdevice I think we
can't rely on it to DMA map/unmap the buffer, right?
Moreover, are we going to rework page_pool stats first? It seems a bit weir=
d to
have a percpu struct with a percpu pointer in it, right?

Regards,
Lorenzo

--t1YGrjY7i9Wn6Bc/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZXS+nQAKCRA6cBh0uS2t
rI8AAQCR4gFHiOVzM3Ez3mjKM2D/21voIJc7XVBmCEWr2M1ziQEAh0uSclRxJvIg
4PLXdEMjzDB1I4Pq41I8zLChgH2WWgU=
=ett7
-----END PGP SIGNATURE-----

--t1YGrjY7i9Wn6Bc/--

