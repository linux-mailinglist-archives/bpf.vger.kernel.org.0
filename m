Return-Path: <bpf+bounces-20946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7D4845650
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 12:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F88A1F239E3
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 11:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E404B15D5BB;
	Thu,  1 Feb 2024 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebaZ4DYU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B1515CD7B;
	Thu,  1 Feb 2024 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706787270; cv=none; b=Ur8GBLNCzYwvSjDmLV3kFhtRCbBF13zoYWvjIhCLYzqZo2uYYkjGrpnYlgN6IU5moKgzO7Xx2oE5fv3ha5pztMpDf7jMoOxiZ9KE7eF71thG6dKjkjm+l3BCHzzNM3cGeZj4oKcWwOYRklSnj5QxNFygsPJC6YPmVxe/8CGq9qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706787270; c=relaxed/simple;
	bh=9ZCCOKPGxEzUZNZc/4uHPujycJlNTkthigBIIk/Pm6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpBzTYpnJkfbDB+sT1i4iXtRktsQYRdtAg82ebnG9o8rxrBVvuhjtmsKCVaiVBLaAuKXw3XbgCSED8cxSCs3H4yOdZ5Jb+y3q0UcuTZLV1cGIpY4efHEkbF1U8FxXehqbYingywFRRZx8y1sellbyGG5gWrIMCyXJd2kkKKt5+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebaZ4DYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E59FC43390;
	Thu,  1 Feb 2024 11:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706787269;
	bh=9ZCCOKPGxEzUZNZc/4uHPujycJlNTkthigBIIk/Pm6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ebaZ4DYU4Kb49Co8GTZkKZ4sfVJJGDPbjmj7Of6QHOOVlDB25SCaPH/Z9yA1X+bQz
	 6K2k5dYPYgTl18Zn4is2MhhaCCPJJLGGklPMZVTFs8hKS0t2MUW1JL6gY6pYK0IJ3q
	 006xY+0hwmx6AMiw/Yxzaf+UTe6eWeyRRlY3TqveGq3jXsWBg0SkNbgiz1JsjYJMyG
	 RPCT5lxiylmA6pY/k1mM4eeOlPg5GyGvhk90p7a5cTNIx6GftE+oKthZqcIooeKTxm
	 SDrmn89bdxlRIOgQAYfS5VVqxJX0Tb1gFKkxzsEwrmN9JfUQ0F7iMe6CExfoE+Ejcj
	 NXfKVTXS2+6nA==
Date: Thu, 1 Feb 2024 12:34:26 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	bpf@vger.kernel.org, toke@redhat.com,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	sdf@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 3/5] xdp: add multi-buff support for xdp
 running in generic mode
Message-ID: <ZbuBwvCa4diMHNhk@lore-desk>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <c93dce1f78bd383c117311e4d53e2766264f6759.1706451150.git.lorenzo@kernel.org>
 <20240131154740.615966a9@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ik4lBDwIl4QAhfvR"
Content-Disposition: inline
In-Reply-To: <20240131154740.615966a9@kernel.org>


--Ik4lBDwIl4QAhfvR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, 28 Jan 2024 15:20:39 +0100 Lorenzo Bianconi wrote:
> > +#if IS_ENABLED(CONFIG_PAGE_POOL)
> > +static int
> > +netif_skb_segment_for_xdp(struct page_pool *pool, struct sk_buff **psk=
b,
> > +			  struct bpf_prog *prog)
>=20
> nit: doesn't look all that related to a netif, I'd put it in skbuff.c

ack, fine. skb_segment_for_xdp() in this case?

Regards,
Lorenzo

--Ik4lBDwIl4QAhfvR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZbuBwQAKCRA6cBh0uS2t
rPmBAQCX724LrFSO4i+EEQIW1bPM9Vl0RN8YOHdup9NC5Gb1vQD9E1x0KJqLujwL
5EPVzcZtHR6BjoFFSgk4DgsQl2T3hAs=
=+Pvh
-----END PGP SIGNATURE-----

--Ik4lBDwIl4QAhfvR--

