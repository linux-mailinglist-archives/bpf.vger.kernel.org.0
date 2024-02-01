Return-Path: <bpf+bounces-20940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AED8455CB
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 11:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6801F25143
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 10:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D78515B982;
	Thu,  1 Feb 2024 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQMKHtXj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68A615B11D;
	Thu,  1 Feb 2024 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784861; cv=none; b=fb/uK3g6d9YmaL7PdybNwlaBrNnbS8sKcQT8VBpXD7bt5G2O2I9AXu9GeneBLmqsv5oPJSK9pE3myTHDbXQAuObPv2+aXfB/MM2b2fdjhB/Ddrq2XW4r/zzzdww0ZK/NwGSenjS/sRT3sSBpZNv63p3VvauiloYFAPymc8aaLgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784861; c=relaxed/simple;
	bh=ypj2H9PBoLChj6CBmaG1s79FeoLLtNfrPtm9uAbx3pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phuWQBKUk3i7UvNGCfKyAdj34kGWVwjasQhzGJ2CZpa6xH45qnxyMfzK9w8Wjd3Mrsm1qxpX0mGkNbViqFRaOWsf7N9PuBOb7087NqI0yoQ9cxI2iOy5eA8LZXZCtF0Uh632h4QK87uxLIwh8t/aVK5uBlGqEVtvWeXVY6VUpfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQMKHtXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D2AC433C7;
	Thu,  1 Feb 2024 10:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706784861;
	bh=ypj2H9PBoLChj6CBmaG1s79FeoLLtNfrPtm9uAbx3pE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OQMKHtXjw87cmimrF9k8lLjgZmdTR113UJyYaxtllS+8KtN8XRxjfG34gOKnPAxrY
	 XLy2GoreO/jgr6T1Y18ZEi+jYS9/ikydhNsMuZzIke1CMhf5YwwKQccJOqXcRdq6T0
	 fPgbMt6gvDm/mBQ2/6vVFAXbmZZFeX0gjo4bvw2PvdKWwdkaOeLipELcSXSpYDUUrC
	 nMwy2Y7ddycCGe2P9vqFNKAD1ee0FoYzp1iLpsELcHJSfWGfkrvD97EWTFiZtxuEVu
	 J6AUc2UmkZ91uTnMkuElbTXtR0/KiEEYXn7cXcFtTBFy2l93L+bwohNMMli1Z5qYrb
	 3cqBXhAqFXmfg==
Date: Thu, 1 Feb 2024 11:54:17 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	bpf@vger.kernel.org, willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com, sdf@google.com, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 4/5] net: page_pool: make stats available
 just for global pools
Message-ID: <Zbt4WaZ7jxjKKuy-@lore-desk>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <9f0a571c1f322ff6c4e6facfd7d6d508e73a8f2f.1706451150.git.lorenzo@kernel.org>
 <bc5dc202-de63-4dee-5eb4-efd63dcb162b@huawei.com>
 <ZbejGhc8K4J4dLbL@lore-desk>
 <ef59f9ac-b622-315a-4892-6c7723a2986a@huawei.com>
 <Zbj_Cb9oHRseTa3u@lore-desk>
 <fcf8678b-b373-49a8-8268-0a8b1a49f739@kernel.org>
 <ZbkdblTwF19lBYbf@lore-desk>
 <877cjpzfgv.fsf@toke.dk>
 <20240131155251.5d22477f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Gf9XTJnSbqEvXmIw"
Content-Disposition: inline
In-Reply-To: <20240131155251.5d22477f@kernel.org>


--Gf9XTJnSbqEvXmIw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, 31 Jan 2024 16:32:00 +0100 Toke H=F8iland-J=F8rgensen wrote:
> > > ack from my side if you have some use-cases in mind.
> > > Some questions below:
> > > - can we assume ethtool will be used to report stats just for 'global'
> > >   page_pool (not per-cpu page_pool)?
> > > - can we assume netlink/yaml will be used to report per-cpu page_pool=
 stats?
> > >
> > > I think in the current series we can fix the accounting part (in part=
icular
> > > avoiding memory wasting) and then we will figure out how to report pe=
rcpu
> > > page_pool stats through netlink/yaml. Agree? =20
> >=20
> > Deferring the export API to a separate series after this is merged is
> > fine with me.
>=20
> +1
>=20
> > In which case the *gathering* of statistics could also be
> > deferred (it's not really useful if it can't be exported).
>=20
> What do you mean by "gather" here? If we plan to expose them later on=20
> I reckon there's no point having this patch which actively optimizes
> them away, no? IOW we should just drop this patch from v7?

ack, I will get rid of it in v7.

Regards,
Lorenzo

--Gf9XTJnSbqEvXmIw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZbt4WQAKCRA6cBh0uS2t
rOfjAP4icZlgW2jHSbiv9jM9zcyK8j+gVdvzFZ+BrmhSQChnuwEAzf2i5+idut+G
SBm5JVyugJ6LEnNRC7aeNCOwr+2AkQ0=
=3m7x
-----END PGP SIGNATURE-----

--Gf9XTJnSbqEvXmIw--

