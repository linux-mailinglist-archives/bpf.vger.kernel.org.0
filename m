Return-Path: <bpf+bounces-60383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 376D7AD5FEC
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 22:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B751BC2523
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 20:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950EB2BDC2F;
	Wed, 11 Jun 2025 20:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9NRsVwW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7C5227EBE;
	Wed, 11 Jun 2025 20:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672765; cv=none; b=n1Gp1ewjMb2sMTHuEaFFyJ5jdhX7imkAW0vtwqC7tt0ALme6LO3U4TCZEnFlnGkobYP182pto8ijjjW6m0ahmB96CJwWA9agAjD05RaHK/8uecRZnTFEvraIa4j6Yt/7PhcIrX48X/k6B7BtYAD5no0WE1Nq2WTPDUxLcGQJ3Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672765; c=relaxed/simple;
	bh=9nqEVQIyWQTeicPrYQ8dyh53cOsm4dE21OOdaNKHwg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmFVdqI8k4pVRNGjYMK/S0rjNHWKgHmDZ76KW9pF0pzcjclG/6wpJ7DJ2OLKTtmQqmSTHztOSSc2r8vNocuYoejEObQ+BkmNeo6sSLGSvEBS1XkFMPDbkzyDKCfubsE+rS/i98zUIhKMya2Wdr7JkoJBmn7a/sepuxRhVGxgihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9NRsVwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A800FC4CEE3;
	Wed, 11 Jun 2025 20:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749672763;
	bh=9nqEVQIyWQTeicPrYQ8dyh53cOsm4dE21OOdaNKHwg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H9NRsVwWkvxvvOb9bv5M0NgcZdQNSfhNtB0xlSTYczSU3Syd1gbLQpCqVrRSuhusN
	 hTNsGJCEeuM6WbYbBpQ0WikcQqPaoWnjLLPSq7Z9cDRgIPcXxNPC/nZitazvhZPjdF
	 iDVOUPB0XFtMMjVZGvz5V5JrhTMctPvEVwOq2A0G2HC4ozMFFAOQXnAWp7mE4NY0jh
	 SkUE/hZUdZy3MZ/cuUnIc3HbwVluIG4KsoB9VMnD4pFmyWOobTlWO9YB2yGrpWQMTN
	 A2BjGfeDUVnEzlGokFMt9hV5jrp0LJHc9SeehVvzK4g0qFSL3iTQHxcyHN+Aew/lYT
	 VtLMDJeuYgwcA==
Date: Wed, 11 Jun 2025 13:12:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, "David
 S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mina Almasry
 <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>, Yunsheng
 Lin <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org,
 Qiuling Ren <qren@redhat.com>, Yuying Ma <yuma@redhat.com>,
 gregkh@linuxfoundation.org, sashal@kernel.org
Subject: Re: [PATCH net-next v9 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
Message-ID: <20250611131241.6ff7cf5d@kernel.org>
In-Reply-To: <aEmwYU/V/9/Ul04P@gmail.com>
References: <20250409-page-pool-track-dma-v9-0-6a9ef2e0cba8@redhat.com>
	<20250409-page-pool-track-dma-v9-2-6a9ef2e0cba8@redhat.com>
	<aEmwYU/V/9/Ul04P@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Jun 2025 09:35:45 -0700 Breno Leitao wrote:
> On Wed, Apr 09, 2025 at 12:41:37PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
> > Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code") =
=20
>=20
> Do you have plan to backport this fix to LTS kernels? I am getting some
> of these crashes on older kernel, and I am curious if there are plans to
> backport this to LTS kernels.

I think it's worth disclosing that the crashes we see are in error
recovery on unstable HW. My vote would be to keep this out of stable
until it reaches at least one final release.

