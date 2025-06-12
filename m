Return-Path: <bpf+bounces-60466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C834AAD733F
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 16:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ACEE16B3C3
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 14:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2683248884;
	Thu, 12 Jun 2025 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eR0aFfUm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE6718A6AD;
	Thu, 12 Jun 2025 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737121; cv=none; b=X1fPIwmbwCHLHubxJqhYXOMK3g01Y1ebIEODFJMcf35SRxvo24WrqQzoNxX71RSoyhJkye/qWupSkZAqXR2BQEqVbuKaTeuCZAxom7FBDeAwUmSEmnH7mC9zne+Z+/yBNVgfAgu2Gugu+hNuerO67YtDS6vRxQnkmzU9EvFb+80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737121; c=relaxed/simple;
	bh=D+ukWm9CNFxSBTlUZVNF0wIvs0CoEpG0xs9KpKTy9KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5Nj3Qziibs1y6av02eUWrOeNPJ/iiRZkKro0jNPBYgizioXuvcc9UWH9hYKHqm4g007vKnEiL2xsX7O++i/VcR/6zwakCEX0VrKFKnahwmTjbZnog/+bKK+RZaFfusBm/YVrqJnVklEZxKaimX5FNbG0D5z0ljN76D0AKRj1WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eR0aFfUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9944C4CEEA;
	Thu, 12 Jun 2025 14:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749737120;
	bh=D+ukWm9CNFxSBTlUZVNF0wIvs0CoEpG0xs9KpKTy9KQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eR0aFfUmKoD4JNmSHuMj1DvfwBcFXu/5Z4iuX40Ipfj8dYXLNenDqefB817WtDBP1
	 6Zuz9ZSoXj4rEgsclqUroR719YMhkU8qsbgEh6Ahm9Rzr2clvbgLx+xWfYHZOZV4Vs
	 hmAl+GEvwQzjAllL4RIKmkQL3loC1NaBuCPEeCdLn7ODLwmeSPO2Ba6flhTrEmPBsB
	 edQ8WWcbnYIpARAvJYeM7FBUlA2X8NaURP07au1QmIoEScIRix8pmermR4DxRl0KZ1
	 8Fgv3snc4AR645TjgAUFLaOgzoawBqkegM3IMixd+/J3hHTU1E8FOC555K0KbeEUXj
	 sPEIz7GNsHTGw==
Date: Thu, 12 Jun 2025 07:05:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Jesper Dangaard Brouer <hawk@kernel.org>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric
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
Message-ID: <20250612070518.69518466@kernel.org>
In-Reply-To: <87jz5hbevp.fsf@toke.dk>
References: <20250409-page-pool-track-dma-v9-0-6a9ef2e0cba8@redhat.com>
	<20250409-page-pool-track-dma-v9-2-6a9ef2e0cba8@redhat.com>
	<aEmwYU/V/9/Ul04P@gmail.com>
	<20250611131241.6ff7cf5d@kernel.org>
	<87jz5hbevp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Jun 2025 09:25:30 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Hmm, okay, guess we should ask Sasha to drop these, then?
>=20
> https://lore.kernel.org/r/20250610122811.1567780-1-sashal@kernel.org
> https://lore.kernel.org/r/20250610120306.1543986-1-sashal@kernel.org

These links don't work for me?

