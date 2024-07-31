Return-Path: <bpf+bounces-36110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7330A942461
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 04:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F529285EF6
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 02:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E62812E4D;
	Wed, 31 Jul 2024 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngSw1bRc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A27D515;
	Wed, 31 Jul 2024 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722391235; cv=none; b=Rc49Zr68CmyBd4n7iRkcbnd26TnJy0NmsBF0Y0qczz+PrBjuxzzkNMkBad36yLYqsuZRHG6t18skjx7YOFAWQm2Pkd8LvwaY4hN60xgSKl/0qcs3r3K84nUJx1C6dbfH/bmgHPXrJ5C+IfieCrXbJsrz164Xb07EsLhH1Wz+2jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722391235; c=relaxed/simple;
	bh=97/GKw2FAIXCwi9Xu85FktWoHogI8p47el+0ShGO1YU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J1vcVLIKfQ8vrxH97Zuc1tzV8d9WHxCArX28ybYznAu0Pq64zdL055ORyTyX0W09efEwoMGqo1AmveIVOIQGtv4Tgd8jCh5TIWPFxxBojscKEx6Q36mFNZeMEZDysqDBJ/r4TV43xViNRkfyFGIy6xAUKZzfr5VNHxCZ+5H1yZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngSw1bRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 900E1C4AF0C;
	Wed, 31 Jul 2024 02:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722391234;
	bh=97/GKw2FAIXCwi9Xu85FktWoHogI8p47el+0ShGO1YU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ngSw1bRca0Z3udWV4UOXJ5vf2wqLWm7BgqMkx2H/7DlggaLEnKyX9Xe2FxGlb5PR3
	 zNFJ+al2aCTQdjVQ8mMleRUUVyoornUH5x3/KaGwruQhVsVyGechFql/XxZ91gqEnr
	 MBK0T4eQHsawUtrtpJ8Aeq8J9inELwvtbgEAk7KZ8932xDQPsSkFqGGuD3VtpCVgDC
	 1psM7BOzGRVrOkQ22/y0kQzRm8z2JYdcmI3Xjddg9T8Wb1OF0svntnwHbMMtzIvjy4
	 luzk9fIrVNLV03mcwM4fawk+O1F5IGXQS8QgnS0x1r+cRuyKG7YxoTAb5kv807lcm3
	 zGJRNmkbQzT7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B9A7C6E398;
	Wed, 31 Jul 2024 02:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/8][pull request] ice: fix AF_XDP ZC timeout and
 concurrency issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172239123450.15322.12860347838208396251.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jul 2024 02:00:34 +0000
References: <20240729200716.681496-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240729200716.681496-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, aleksander.lobakin@intel.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 29 Jul 2024 13:07:06 -0700 you wrote:
> Maciej Fijalkowski says:
> 
> Changes included in this patchset address an issue that customer has
> been facing when AF_XDP ZC Tx sockets were used in combination with flow
> control and regular Tx traffic.
> 
> After executing:
> ethtool --set-priv-flags $dev link-down-on-close on
> ethtool -A $dev rx on tx on
> 
> [...]

Here is the summary with links:
  - [net,v2,1/8] ice: respect netif readiness in AF_XDP ZC related ndo's
    https://git.kernel.org/netdev/net/c/ec145a18687f
  - [net,v2,2/8] ice: don't busy wait for Rx queue disable in ice_qp_dis()
    https://git.kernel.org/netdev/net/c/1ff72a2f6779
  - [net,v2,3/8] ice: replace synchronize_rcu with synchronize_net
    https://git.kernel.org/netdev/net/c/405d9999aa0b
  - [net,v2,4/8] ice: modify error handling when setting XSK pool in ndo_bpf
    https://git.kernel.org/netdev/net/c/d59227179949
  - [net,v2,5/8] ice: toggle netif_carrier when setting up XSK pool
    https://git.kernel.org/netdev/net/c/9da75a511c55
  - [net,v2,6/8] ice: improve updating ice_{t,r}x_ring::xsk_pool
    https://git.kernel.org/netdev/net/c/ebc33a3f8d0a
  - [net,v2,7/8] ice: add missing WRITE_ONCE when clearing ice_rx_ring::xdp_prog
    https://git.kernel.org/netdev/net/c/6044ca26210b
  - [net,v2,8/8] ice: xsk: fix txq interrupt mapping
    https://git.kernel.org/netdev/net/c/963fb4612295

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



