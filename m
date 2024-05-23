Return-Path: <bpf+bounces-30407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C83B8CD8F7
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 19:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D811F23273
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 17:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2D276034;
	Thu, 23 May 2024 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJDQL6Jy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8125BAD2C;
	Thu, 23 May 2024 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716484001; cv=none; b=Ll1oNsnxpjZUbOh7CZsTVI0DuZS+t9NC46WVsy8vk2QA193IHTO3uQgQtXX2d/7aQG8Cq7qIPQFUOktKQuvBSlyLJqyEA1lVlGeNkQGjXPwg9cq85Pk1LxMjX5gazFS1FNgiFxWn9qOQ8zTlREiIkVZf0XU30z5j1xBT3UTu7ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716484001; c=relaxed/simple;
	bh=aFq6+NRWbFnR4Chabf4DjhwoXgN0KJ7rz+7Lp933T0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEWr/GU21ZKWSf1vyV7vMbUr58nb/2nRQcC3Xg0EXFhAODb9cxyjOpyskoCUgE0azF92dXD5d2j/o7Bba9sGPghwOHqJ5Z1agT+xLyhi5VbVz60EBF2clKELMmwgwnt6BXTDxPBJls0dRH9Ag+bxFImIzwDSKINLeC6duOrDwPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJDQL6Jy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B5CC2BD10;
	Thu, 23 May 2024 17:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716484001;
	bh=aFq6+NRWbFnR4Chabf4DjhwoXgN0KJ7rz+7Lp933T0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJDQL6JyTvs2vqBccgKxTSyJrDn2STDoAFs6hrNwRvgDFJIB4MPdit9gDsSrPbHF6
	 jyyS0nsSO3WT/Lwv3l1xiu/PIEK2nBvgS7JH3AoGcuIWTt/CSJtSfUeaaJ7RL5gxaz
	 DrTgOgCEwUmvk051ov/nZ0BxjWEhZiudv99Q/78pEoy9H77j4usL+XDIJFEasF83S2
	 BwGOMQZTSK0Ui7slLVIs7X2GyNAubLQF5cWFmD/dm9aXZPICYmfygF40dep7wS5N28
	 +t6UJfaEWxLg9MnBaadc17LArPabq4+JsmhmxLH4Jz/l1X0wBfUFmklUc73drVqFWf
	 1qkCukvv/xuLA==
Date: Thu, 23 May 2024 19:06:37 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: bpf@vger.kernel.org, kadlec@netfilter.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com,
	lorenzo.bianconi@redhat.com, toke@redhat.com, fw@strlen.de,
	hawk@kernel.org, horms@kernel.org, donhunte@redhat.com,
	memxor@gmail.com
Subject: Re: [PATCH v3 bpf-next 1/3] netfilter: nf_tables: add flowtable map
 for xdp offload
Message-ID: <Zk93nVYfv09t6gLJ@lore-desk>
References: <cover.1716465377.git.lorenzo@kernel.org>
 <1925643414ddbea91659007826fd829f8aa56864.1716465377.git.lorenzo@kernel.org>
 <Zk9mCJIqMoWopQaA@calendula>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+QLTDrDmMdxPV0GQ"
Content-Disposition: inline
In-Reply-To: <Zk9mCJIqMoWopQaA@calendula>


--+QLTDrDmMdxPV0GQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,
>=20
> On Thu, May 23, 2024 at 02:06:16PM +0200, Lorenzo Bianconi wrote:
> > From: Florian Westphal <fw@strlen.de>
> >=20
> > This adds a small internal mapping table so that a new bpf (xdp) kfunc
> > can perform lookups in a flowtable.
> >=20
> > As-is, xdp program has access to the device pointer, but no way to do a
> > lookup in a flowtable -- there is no way to obtain the needed struct
> > without questionable stunts.
> >=20
> > This allows to obtain an nf_flowtable pointer given a net_device
> > structure.
> >=20
> > In order to keep backward compatibility, the infrastructure allows the
> > user to add a given device to multiple flowtables, but it will always
> > return the first added mapping performing the lookup since it assumes
> > the right configuration is 1:1 mapping between flowtables and net_devic=
es.
>=20
> Would it be possible to move this new code in _offload.c to
> nf_flow_table_xdp.c?

ack, I will do in v4.

Regards,
Lorenzo

>=20
> The flowtable offload code is already a bit convoluted, the hardware
> offload API for payload matching results in chatty with many sparse
> warnings (unless I adds casting everywhere), but I remember I failed
> to provide a convincing improvements on that front without requiring
> changes to drivers at the time. This is of course no related to this
> series.

--+QLTDrDmMdxPV0GQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZk93nQAKCRA6cBh0uS2t
rDJjAQCdP7SyEpHHjTb/gA3YXxC40XjL87kHX4+NvaBwp4O35QEA2jcw7VjCBkRW
96iKq6LHPG1o8WOyTGVGs+86OoBJtgw=
=+W5Y
-----END PGP SIGNATURE-----

--+QLTDrDmMdxPV0GQ--

