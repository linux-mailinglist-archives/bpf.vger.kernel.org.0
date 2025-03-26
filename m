Return-Path: <bpf+bounces-54743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6750A715AB
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 12:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0011188EB26
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 11:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282821DCB09;
	Wed, 26 Mar 2025 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHyDTT3h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D83A15278E;
	Wed, 26 Mar 2025 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988229; cv=none; b=YEAGzb+uECaPlMy0okmm26hsV4v90Rg38UwjeDMjcqFA8Ajnzx7Tj9zMGg+V4wO1EmuYaxTcHncX3j66oCkIMDub4ZTLmy2v981rSc818x5Sz3wGgvt9P92+uYqk/Yf7EafktgT3m2ze9zmg5gfz6CgCE04e+xZnnov+lkLz6tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988229; c=relaxed/simple;
	bh=R4BP1NptH+VhMdTtTgYwlNby7+SvfPrG7xuFOaIwVAU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsR4O6xHecz3se9xm9+/b6Lkf+fZMohqh9xgyx5OphTvsSQbpTxApY7h+kWF28uNWHed0CENNmWAIO5DpTYHDX6H6YncGPWQXYkSJ+z6NzcisNz3GupdU6GjfVIy/6LhCumsYnuZb9I8BhJmvEGNduvdG4oM/F59K3RcNRh7jPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHyDTT3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284B8C4CEE2;
	Wed, 26 Mar 2025 11:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742988229;
	bh=R4BP1NptH+VhMdTtTgYwlNby7+SvfPrG7xuFOaIwVAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fHyDTT3hVuxBqyIU4oEseOMTj+c0VSHxKcZed0NNYmA8OSwZEWAgc0czFUZrjfiIh
	 7qgJWSXwRu1JFezkFTqyOMeCVvRlWfo3MOM2LQ6FZLD8kG9CMmdARLvg5K3HiM1EXM
	 qH7tsj6QIkVsJjz2p9vc2e0qp2DD2cRUB7hv5mlr3HXcC9MIczwjX6a5ZdEajSspI/
	 KFSrtIwBx9RWXPKmVhZhdGTvbN58YkxQg11qW01Osi4T970lrdfdXamK8IDzLIQCRU
	 evjIsSfOL5Po/jcZAKEqGd61AINteKB77XKZIxImWA2MlHI7tu66UeQ/5jW94bRPIN
	 IPovHEz+vMqWw==
Date: Wed, 26 Mar 2025 04:23:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH net-next v2 2/3] page_pool: Turn dma_sync and
 dma_sync_cpu fields into a bitmap
Message-ID: <20250326042347.279f23a8@kernel.org>
In-Reply-To: <87cye4qkgd.fsf@toke.dk>
References: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
	<20250325-page-pool-track-dma-v2-2-113ebc1946f3@redhat.com>
	<20250325151743.7ae425c3@kernel.org>
	<87cye4qkgd.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Mar 2025 09:12:34 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > I don't see why we'd need to wipe them atomically.
> > In fact I don't see why we're touching dma_sync_cpu, at all,
> > it's driver-facing and the driver is gone in the problematic
> > scenario. =20
>=20
> No you're right, but it felt weird to change just one of them, so
> figured I'd go with both. But keeping them both as bool, and just making
> dma_sync a full-width bool works, so I'll respin with that and leave
> dma_sync_cpu as-is.

Opinion on dma_sync_cpu clearing probably depends on mental model.
No strong feelings but perhaps add a comment next to clearing it
for the likes of myself saying that this technically shouldn't be
needed as we only expect drivers to ask for CPU sync?

