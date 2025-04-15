Return-Path: <bpf+bounces-55913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C59CA890A9
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 02:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1873B70CD
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 00:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04355C603;
	Tue, 15 Apr 2025 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qj1wBfQI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381BD15B0EC;
	Tue, 15 Apr 2025 00:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744677003; cv=none; b=HIWZr8WViCKaDn6hnx9ebWfgIqiBsaAdw20OQHNGfwZQhNG4Ddwo2g2B1ntPXtofusKppqvFyiXclVXvSskwtKJOOvx/jSA8R5DqLwXZ0bAWGNVoJATxAPI+4dTqZ8Cx9F4bcnu9yjuxQfQR9G/5SMU/tVP6uko5YxiyRTgo4NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744677003; c=relaxed/simple;
	bh=0oPDaEmyb/WuLrJv9s3KJnIn+Cx28n2/ul2slgmjxZQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FyW62ckkcTd8GngNHKXZHSxMYQLquqz/70ETzrP9THED9fBcwcMsExvvHbBSjCrmTmNPS7BThIXlR3PE3tpIFmYUPDqUdjnNAbGJwXNGDe1rMCX4FtRte0RxfFkjWC0hQvsvnnSzHBYyoQt19uVajz3XW3HLmUgkOZ47gemJefE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qj1wBfQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBA0C4CEEC;
	Tue, 15 Apr 2025 00:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744677002;
	bh=0oPDaEmyb/WuLrJv9s3KJnIn+Cx28n2/ul2slgmjxZQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qj1wBfQIyitI7hxvb1Qo521IfMwFI0VeaIBV/zt6uCgxj+NRnAzq24lQik9pDMKzQ
	 eJr2TedueP/ttgY+cs1jnmHSVneDS0j2wBDqk9j4xA417f2r5pTF6qiN/Z13jq23X7
	 dANHpqov8hebemGjPcF0eIVge4adRQcAaxjjkW9Xh4TeuVEeJZoh4Ig7uUUJAAjtpX
	 1Mb1uMBF3wGJNcskmeUtQxYz6mDLlQ6OImS5+2j02r1tMpJU+Kps004v9ioef8F6r3
	 j491MsjnF8o564h+nWDetCHUtHkVcTyD40ybP7BTgdNomrPiXwL+fW1aVfEzt5p2MO
	 F2y9xw2lZJ+Fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0D83822D1A;
	Tue, 15 Apr 2025 00:30:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/2] Fix late DMA unmap crash for page pool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174467704049.2083973.15012533617497766841.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 00:30:40 +0000
References: <20250409-page-pool-track-dma-v9-0-6a9ef2e0cba8@redhat.com>
In-Reply-To: <20250409-page-pool-track-dma-v9-0-6a9ef2e0cba8@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch,
 edumazet@google.com, pabeni@redhat.com, ilias.apalodimas@linaro.org,
 horms@kernel.org, akpm@linux-foundation.org, almasrymina@google.com,
 liuyonglong@huawei.com, linyunsheng@huawei.com, asml.silence@gmail.com,
 willy@infradead.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-mm@kvack.org, qren@redhat.com,
 yuma@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 09 Apr 2025 12:41:35 +0200 you wrote:
> This series fixes the late dma_unmap crash for page pool first reported
> by Yonglong Liu in [0]. It is an alternative approach to the one
> submitted by Yunsheng Lin, most recently in [1]. The first commit just
> wraps some tests in a helper function, in preparation of the main change
> in patch 2. See the commit message of patch 2 for the details.
> 
> -Toke
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/2] page_pool: Move pp_magic check into helper functions
    https://git.kernel.org/netdev/net-next/c/cd3c93167da0
  - [net-next,v9,2/2] page_pool: Track DMA-mapped pages and unmap them when destroying the pool
    https://git.kernel.org/netdev/net-next/c/ee62ce7a1d90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



